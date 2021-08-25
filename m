Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51463F7A06
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbhHYQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:18:14 -0400
Received: from foss.arm.com ([217.140.110.172]:54672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240073AbhHYQSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:18:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD86101E;
        Wed, 25 Aug 2021 09:17:21 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BB583F66F;
        Wed, 25 Aug 2021 09:17:20 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 06/39] KVM: arm64: Delay tag scrubbing for locked memslots until a VCPU runs
Date:   Wed, 25 Aug 2021 17:17:42 +0100
Message-Id: <20210825161815.266051-7-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an MTE-enabled guest first accesses a physical page, that page must be
scrubbed for tags. This is normally done by KVM on a translation fault, but
with locked memslots we will not get translation faults. So far, this has
been handled by forbidding userspace to enable the MTE capability after
locking a memslot.

Remove this constraint by deferring tag cleaning until the first VCPU is
run, similar to how KVM handles cache maintenance operations.

When userspace resets a VCPU, KVM again performs cache maintenance
operations on locked memslots because userspace might have modified the
guest memory. Clean the tags the next time a VCPU is run for the same
reason.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  7 ++-
 arch/arm64/include/asm/kvm_mmu.h  |  2 +-
 arch/arm64/kvm/arm.c              | 29 ++--------
 arch/arm64/kvm/mmu.c              | 92 ++++++++++++++++++++++++++-----
 4 files changed, 87 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 68905bd47f85..a57f33368a3e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -113,9 +113,10 @@ struct kvm_arch_memory_slot {
 };
 
 /* kvm->arch.mmu_pending_ops flags */
-#define KVM_LOCKED_MEMSLOT_FLUSH_DCACHE	0
-#define KVM_LOCKED_MEMSLOT_INVAL_ICACHE	1
-#define KVM_MAX_MMU_PENDING_OPS		2
+#define KVM_LOCKED_MEMSLOT_FLUSH_DCACHE		0
+#define KVM_LOCKED_MEMSLOT_INVAL_ICACHE		1
+#define KVM_LOCKED_MEMSLOT_SANITISE_TAGS	2
+#define KVM_MAX_MMU_PENDING_OPS			3
 
 struct kvm_arch {
 	struct kvm_s2_mmu mmu;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 525c223e769f..9fcdd2580f6e 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -222,7 +222,7 @@ int kvm_mmu_unlock_memslot(struct kvm *kvm, u64 slot, u64 flags);
 #define kvm_mmu_has_pending_ops(kvm)	\
 	(!bitmap_empty(&(kvm)->arch.mmu_pending_ops, KVM_MAX_MMU_PENDING_OPS))
 
-void kvm_mmu_perform_pending_ops(struct kvm *kvm);
+int kvm_mmu_perform_pending_ops(struct kvm *kvm);
 
 static inline unsigned int kvm_get_vmid_bits(void)
 {
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 144c982912d8..c47e96ae4f7c 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -108,25 +108,6 @@ static int kvm_lock_user_memory_region_ioctl(struct kvm *kvm,
 	}
 }
 
-static bool kvm_arm_has_locked_memslots(struct kvm *kvm)
-{
-	struct kvm_memslots *slots = kvm_memslots(kvm);
-	struct kvm_memory_slot *memslot;
-	bool has_locked_memslots = false;
-	int idx;
-
-	idx = srcu_read_lock(&kvm->srcu);
-	kvm_for_each_memslot(memslot, slots) {
-		if (memslot->arch.flags & KVM_MEMSLOT_LOCK_MASK) {
-			has_locked_memslots = true;
-			break;
-		}
-	}
-	srcu_read_unlock(&kvm->srcu, idx);
-
-	return has_locked_memslots;
-}
-
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			    struct kvm_enable_cap *cap)
 {
@@ -142,9 +123,6 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 	case KVM_CAP_ARM_MTE:
 		if (!system_supports_mte() || kvm->created_vcpus)
 			return -EINVAL;
-		if (kvm_arm_lock_memslot_supported() &&
-		    kvm_arm_has_locked_memslots(kvm))
-			return -EPERM;
 		r = 0;
 		kvm->arch.mte_enabled = true;
 		break;
@@ -829,8 +807,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
-	if (unlikely(kvm_mmu_has_pending_ops(vcpu->kvm)))
-		kvm_mmu_perform_pending_ops(vcpu->kvm);
+	if (unlikely(kvm_mmu_has_pending_ops(vcpu->kvm))) {
+		ret = kvm_mmu_perform_pending_ops(vcpu->kvm);
+		if (ret)
+			return ret;
+	}
 
 	ret = kvm_vcpu_first_run_init(vcpu);
 	if (ret)
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index f1f8a87550d1..cd44b6f2c53e 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -566,6 +566,10 @@ void stage2_unmap_vm(struct kvm *kvm)
 				&kvm->arch.mmu_pending_ops);
 			set_bit(KVM_LOCKED_MEMSLOT_INVAL_ICACHE,
 				&kvm->arch.mmu_pending_ops);
+			if (kvm_has_mte(kvm)) {
+				set_bit(KVM_LOCKED_MEMSLOT_SANITISE_TAGS,
+					&kvm->arch.mmu_pending_ops);
+			}
 			continue;
 		}
 		stage2_unmap_memslot(kvm, memslot);
@@ -909,6 +913,58 @@ static int sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 	return 0;
 }
 
+static int sanitise_mte_tags_memslot(struct kvm *kvm,
+				     struct kvm_memory_slot *memslot)
+{
+	unsigned long hva, slot_size, slot_end;
+	struct kvm_memory_slot_page *entry;
+	struct page *page;
+	int ret = 0;
+
+	if (!kvm_has_mte(kvm))
+		return 0;
+
+	hva = memslot->userspace_addr;
+	slot_size = memslot->npages << PAGE_SHIFT;
+	slot_end = hva + slot_size;
+
+	/* First check that the VMAs spanning the memslot are not shared... */
+	do {
+		struct vm_area_struct *vma;
+
+		vma = find_vma_intersection(current->mm, hva, slot_end);
+		/* The VMAs spanning the memslot must be contiguous. */
+		if (!vma) {
+			ret = -EFAULT;
+			goto out;
+		}
+		/*
+		 * VM_SHARED mappings are not allowed with MTE to avoid races
+		 * when updating the PG_mte_tagged page flag, see
+		 * sanitise_mte_tags for more details.
+		 */
+		if (kvm_has_mte(kvm) && vma->vm_flags & VM_SHARED) {
+			ret = -EFAULT;
+			goto out;
+		}
+		hva = min(slot_end, vma->vm_end);
+	} while (hva < slot_end);
+
+	/* ... then clear the tags. */
+	list_for_each_entry(entry, &memslot->arch.pages.list, list) {
+		page = entry->page;
+		if (!test_bit(PG_mte_tagged, &page->flags)) {
+			mte_clear_page_tags(page_address(page));
+			set_bit(PG_mte_tagged, &page->flags);
+		}
+	}
+
+out:
+	mmap_read_unlock(current->mm);
+
+	return ret;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -1273,14 +1329,28 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
  * - Stage 2 tables cannot be freed from under us as long as at least one VCPU
  *   is live, which means that the VM will be live.
  */
-void kvm_mmu_perform_pending_ops(struct kvm *kvm)
+int kvm_mmu_perform_pending_ops(struct kvm *kvm)
 {
 	struct kvm_memory_slot *memslot;
+	int ret = 0;
 
 	mutex_lock(&kvm->slots_lock);
 	if (!kvm_mmu_has_pending_ops(kvm))
 		goto out_unlock;
 
+	if (test_bit(KVM_LOCKED_MEMSLOT_SANITISE_TAGS, &kvm->arch.mmu_pending_ops) &&
+	    kvm_has_mte(kvm)) {
+		kvm_for_each_memslot(memslot, kvm_memslots(kvm)) {
+			if (!memslot_is_locked(memslot))
+				continue;
+			mmap_read_lock(current->mm);
+			ret = sanitise_mte_tags_memslot(kvm, memslot);
+			mmap_read_unlock(current->mm);
+			if (ret)
+				goto out_unlock;
+		}
+	}
+
 	if (test_bit(KVM_LOCKED_MEMSLOT_FLUSH_DCACHE, &kvm->arch.mmu_pending_ops)) {
 		kvm_for_each_memslot(memslot, kvm_memslots(kvm)) {
 			if (!memslot_is_locked(memslot))
@@ -1296,7 +1366,7 @@ void kvm_mmu_perform_pending_ops(struct kvm *kvm)
 
 out_unlock:
 	mutex_unlock(&kvm->slots_lock);
-	return;
+	return ret;
 }
 
 static int try_rlimit_memlock(unsigned long npages)
@@ -1390,19 +1460,6 @@ static int lock_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			ret = -ENOMEM;
 			goto out_err;
 		}
-		if (kvm_has_mte(kvm)) {
-			if (vma->vm_flags & VM_SHARED) {
-				ret = -EFAULT;
-			} else {
-				ret = sanitise_mte_tags(kvm,
-					page_to_pfn(page_entry->page),
-					PAGE_SIZE);
-			}
-			if (ret) {
-				mmap_read_unlock(current->mm);
-				goto out_err;
-			}
-		}
 		mmap_read_unlock(current->mm);
 
 		ret = kvm_mmu_topup_memory_cache(&cache, kvm_mmu_cache_min_pages(kvm));
@@ -1455,6 +1512,11 @@ static int lock_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		memslot->arch.flags |= KVM_MEMSLOT_LOCK_WRITE;
 
 	set_bit(KVM_LOCKED_MEMSLOT_FLUSH_DCACHE, &kvm->arch.mmu_pending_ops);
+	/*
+	 * MTE might be enabled after we lock the memslot, set it here
+	 * unconditionally.
+	 */
+	set_bit(KVM_LOCKED_MEMSLOT_SANITISE_TAGS, &kvm->arch.mmu_pending_ops);
 
 	kvm_mmu_free_memory_cache(&cache);
 
-- 
2.33.0


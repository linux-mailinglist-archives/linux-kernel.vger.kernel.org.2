Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C5938E480
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhEXKrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:47:46 -0400
Received: from foss.arm.com ([217.140.110.172]:40894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232720AbhEXKrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:47:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3251F139F;
        Mon, 24 May 2021 03:45:43 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 761AE3F719;
        Mon, 24 May 2021 03:45:40 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v13 7/8] KVM: arm64: ioctl to fetch/store tags in a guest
Date:   Mon, 24 May 2021 11:45:12 +0100
Message-Id: <20210524104513.13258-8-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524104513.13258-1-steven.price@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VMM may not wish to have it's own mapping of guest memory mapped
with PROT_MTE because this causes problems if the VMM has tag checking
enabled (the guest controls the tags in physical RAM and it's unlikely
the tags are correct for the VMM).

Instead add a new ioctl which allows the VMM to easily read/write the
tags from guest memory, allowing the VMM's mapping to be non-PROT_MTE
while the VMM can still read/write the tags for the purpose of
migration.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 ++
 arch/arm64/include/asm/mte-def.h  |  1 +
 arch/arm64/include/uapi/asm/kvm.h | 11 +++++
 arch/arm64/kvm/arm.c              |  7 +++
 arch/arm64/kvm/guest.c            | 79 +++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |  1 +
 6 files changed, 102 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 309e36cc1b42..66b6339df949 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -729,6 +729,9 @@ int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
 int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 			       struct kvm_device_attr *attr);
 
+int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
+			       struct kvm_arm_copy_mte_tags *copy_tags);
+
 /* Guest/host FPSIMD coordination helpers */
 int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/include/asm/mte-def.h b/arch/arm64/include/asm/mte-def.h
index cf241b0f0a42..626d359b396e 100644
--- a/arch/arm64/include/asm/mte-def.h
+++ b/arch/arm64/include/asm/mte-def.h
@@ -7,6 +7,7 @@
 
 #define MTE_GRANULE_SIZE	UL(16)
 #define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
+#define MTE_GRANULES_PER_PAGE	(PAGE_SIZE / MTE_GRANULE_SIZE)
 #define MTE_TAG_SHIFT		56
 #define MTE_TAG_SIZE		4
 #define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 24223adae150..b3edde68bc3e 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -184,6 +184,17 @@ struct kvm_vcpu_events {
 	__u32 reserved[12];
 };
 
+struct kvm_arm_copy_mte_tags {
+	__u64 guest_ipa;
+	__u64 length;
+	void __user *addr;
+	__u64 flags;
+	__u64 reserved[2];
+};
+
+#define KVM_ARM_TAGS_TO_GUEST		0
+#define KVM_ARM_TAGS_FROM_GUEST		1
+
 /* If you need to interpret the index values, here is the key: */
 #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
 #define KVM_REG_ARM_COPROC_SHIFT	16
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e89a5e275e25..baa33359e477 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1345,6 +1345,13 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
 		return 0;
 	}
+	case KVM_ARM_MTE_COPY_TAGS: {
+		struct kvm_arm_copy_mte_tags copy_tags;
+
+		if (copy_from_user(&copy_tags, argp, sizeof(copy_tags)))
+			return -EFAULT;
+		return kvm_vm_ioctl_mte_copy_tags(kvm, &copy_tags);
+	}
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 5cb4a1cd5603..7a1e181eb463 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -995,3 +995,82 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 
 	return ret;
 }
+
+int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
+			       struct kvm_arm_copy_mte_tags *copy_tags)
+{
+	gpa_t guest_ipa = copy_tags->guest_ipa;
+	size_t length = copy_tags->length;
+	void __user *tags = copy_tags->addr;
+	gpa_t gfn;
+	bool write = !(copy_tags->flags & KVM_ARM_TAGS_FROM_GUEST);
+	int ret = 0;
+
+	if (!kvm_has_mte(kvm))
+		return -EINVAL;
+
+	if (copy_tags->reserved[0] || copy_tags->reserved[1])
+		return -EINVAL;
+
+	if (copy_tags->flags & ~KVM_ARM_TAGS_FROM_GUEST)
+		return -EINVAL;
+
+	if (length & ~PAGE_MASK || guest_ipa & ~PAGE_MASK)
+		return -EINVAL;
+
+	gfn = gpa_to_gfn(guest_ipa);
+
+	mutex_lock(&kvm->slots_lock);
+
+	while (length > 0) {
+		kvm_pfn_t pfn = gfn_to_pfn_prot(kvm, gfn, write, NULL);
+		void *maddr;
+		unsigned long num_tags;
+		struct page *page;
+
+		if (is_error_noslot_pfn(pfn)) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		page = pfn_to_online_page(pfn);
+		if (!page) {
+			/* Reject ZONE_DEVICE memory */
+			ret = -EFAULT;
+			goto out;
+		}
+		maddr = page_address(page);
+
+		if (!write) {
+			if (test_bit(PG_mte_tagged, &page->flags))
+				num_tags = mte_copy_tags_to_user(tags, maddr,
+							MTE_GRANULES_PER_PAGE);
+			else
+				/* No tags in memory, so write zeros */
+				num_tags = MTE_GRANULES_PER_PAGE -
+					clear_user(tags, MTE_GRANULES_PER_PAGE);
+			kvm_release_pfn_clean(pfn);
+		} else {
+			num_tags = mte_copy_tags_from_user(maddr, tags,
+							MTE_GRANULES_PER_PAGE);
+			kvm_release_pfn_dirty(pfn);
+		}
+
+		if (num_tags != MTE_GRANULES_PER_PAGE) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		/* Set the flag after checking the write completed fully */
+		if (write)
+			set_bit(PG_mte_tagged, &page->flags);
+
+		gfn++;
+		tags += num_tags;
+		length -= PAGE_SIZE;
+	}
+
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return ret;
+}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8c95ba0fadda..4c011c60d468 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1428,6 +1428,7 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_PMU_EVENT_FILTER */
 #define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_event_filter)
 #define KVM_PPC_SVM_OFF		  _IO(KVMIO,  0xb3)
+#define KVM_ARM_MTE_COPY_TAGS	  _IOR(KVMIO,  0xb4, struct kvm_arm_copy_mte_tags)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.20.1


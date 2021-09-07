Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29F34028D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbhIGMe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:34:29 -0400
Received: from foss.arm.com ([217.140.110.172]:35508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344183AbhIGMeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:34:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E2CE101E;
        Tue,  7 Sep 2021 05:33:16 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E60F93F766;
        Tue,  7 Sep 2021 05:33:10 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH v2 1/2] KVM: arm64: vgic: Add memcg accounting to vgic allocations
Date:   Tue,  7 Sep 2021 20:31:11 +0800
Message-Id: <20210907123112.10232-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210907123112.10232-1-justin.he@arm.com>
References: <20210907123112.10232-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by commit 254272ce6505 ("kvm: x86: Add memcg accounting to KVM
allocations"), it would be better to make arm64 vgic consistent with
common kvm codes.

The memory allocations of VM scope should be charged into VM process
cgroup, hence change GFP_KERNEL to GFP_KERNEL_ACCOUNT.

There remain a few cases since these allocations are global, not in VM
scope.

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/kvm/vgic/vgic-init.c    |  2 +-
 arch/arm64/kvm/vgic/vgic-irqfd.c   |  2 +-
 arch/arm64/kvm/vgic/vgic-its.c     | 14 +++++++-------
 arch/arm64/kvm/vgic/vgic-mmio-v3.c |  2 +-
 arch/arm64/kvm/vgic/vgic-v4.c      |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 340c51d87677..0a06d0648970 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -134,7 +134,7 @@ static int kvm_vgic_dist_init(struct kvm *kvm, unsigned int nr_spis)
 	struct kvm_vcpu *vcpu0 = kvm_get_vcpu(kvm, 0);
 	int i;
 
-	dist->spis = kcalloc(nr_spis, sizeof(struct vgic_irq), GFP_KERNEL);
+	dist->spis = kcalloc(nr_spis, sizeof(struct vgic_irq), GFP_KERNEL_ACCOUNT);
 	if (!dist->spis)
 		return  -ENOMEM;
 
diff --git a/arch/arm64/kvm/vgic/vgic-irqfd.c b/arch/arm64/kvm/vgic/vgic-irqfd.c
index 79f8899b234c..475059bacedf 100644
--- a/arch/arm64/kvm/vgic/vgic-irqfd.c
+++ b/arch/arm64/kvm/vgic/vgic-irqfd.c
@@ -139,7 +139,7 @@ int kvm_vgic_setup_default_irq_routing(struct kvm *kvm)
 	u32 nr = dist->nr_spis;
 	int i, ret;
 
-	entries = kcalloc(nr, sizeof(*entries), GFP_KERNEL);
+	entries = kcalloc(nr, sizeof(*entries), GFP_KERNEL_ACCOUNT);
 	if (!entries)
 		return -ENOMEM;
 
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 61728c543eb9..b99f47103056 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -48,7 +48,7 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 	if (irq)
 		return irq;
 
-	irq = kzalloc(sizeof(struct vgic_irq), GFP_KERNEL);
+	irq = kzalloc(sizeof(struct vgic_irq), GFP_KERNEL_ACCOUNT);
 	if (!irq)
 		return ERR_PTR(-ENOMEM);
 
@@ -332,7 +332,7 @@ int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr)
 	 * we must be careful not to overrun the array.
 	 */
 	irq_count = READ_ONCE(dist->lpi_list_count);
-	intids = kmalloc_array(irq_count, sizeof(intids[0]), GFP_KERNEL);
+	intids = kmalloc_array(irq_count, sizeof(intids[0]), GFP_KERNEL_ACCOUNT);
 	if (!intids)
 		return -ENOMEM;
 
@@ -985,7 +985,7 @@ static int vgic_its_alloc_collection(struct vgic_its *its,
 	if (!vgic_its_check_id(its, its->baser_coll_table, coll_id, NULL))
 		return E_ITS_MAPC_COLLECTION_OOR;
 
-	collection = kzalloc(sizeof(*collection), GFP_KERNEL);
+	collection = kzalloc(sizeof(*collection), GFP_KERNEL_ACCOUNT);
 	if (!collection)
 		return -ENOMEM;
 
@@ -1029,7 +1029,7 @@ static struct its_ite *vgic_its_alloc_ite(struct its_device *device,
 {
 	struct its_ite *ite;
 
-	ite = kzalloc(sizeof(*ite), GFP_KERNEL);
+	ite = kzalloc(sizeof(*ite), GFP_KERNEL_ACCOUNT);
 	if (!ite)
 		return ERR_PTR(-ENOMEM);
 
@@ -1150,7 +1150,7 @@ static struct its_device *vgic_its_alloc_device(struct vgic_its *its,
 {
 	struct its_device *device;
 
-	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	device = kzalloc(sizeof(*device), GFP_KERNEL_ACCOUNT);
 	if (!device)
 		return ERR_PTR(-ENOMEM);
 
@@ -1847,7 +1847,7 @@ void vgic_lpi_translation_cache_init(struct kvm *kvm)
 		struct vgic_translation_cache_entry *cte;
 
 		/* An allocation failure is not fatal */
-		cte = kzalloc(sizeof(*cte), GFP_KERNEL);
+		cte = kzalloc(sizeof(*cte), GFP_KERNEL_ACCOUNT);
 		if (WARN_ON(!cte))
 			break;
 
@@ -1888,7 +1888,7 @@ static int vgic_its_create(struct kvm_device *dev, u32 type)
 	if (type != KVM_DEV_TYPE_ARM_VGIC_ITS)
 		return -ENODEV;
 
-	its = kzalloc(sizeof(struct vgic_its), GFP_KERNEL);
+	its = kzalloc(sizeof(struct vgic_its), GFP_KERNEL_ACCOUNT);
 	if (!its)
 		return -ENOMEM;
 
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index a09cdc0b953c..d3fd8a6c0c9a 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -834,7 +834,7 @@ static int vgic_v3_alloc_redist_region(struct kvm *kvm, uint32_t index,
 	if (vgic_v3_rdist_overlap(kvm, base, size))
 		return -EINVAL;
 
-	rdreg = kzalloc(sizeof(*rdreg), GFP_KERNEL);
+	rdreg = kzalloc(sizeof(*rdreg), GFP_KERNEL_ACCOUNT);
 	if (!rdreg)
 		return -ENOMEM;
 
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index c1845d8f5f7e..772dd15a22c7 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -246,7 +246,7 @@ int vgic_v4_init(struct kvm *kvm)
 	nr_vcpus = atomic_read(&kvm->online_vcpus);
 
 	dist->its_vm.vpes = kcalloc(nr_vcpus, sizeof(*dist->its_vm.vpes),
-				    GFP_KERNEL);
+				    GFP_KERNEL_ACCOUNT);
 	if (!dist->its_vm.vpes)
 		return -ENOMEM;
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A1E3E1495
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbhHEMTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:19:00 -0400
Received: from foss.arm.com ([217.140.110.172]:43910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241268AbhHEMS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:18:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E58C51042;
        Thu,  5 Aug 2021 05:18:44 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EE4C3F719;
        Thu,  5 Aug 2021 05:18:43 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
From:   Robin Murphy <robin.murphy@arm.com>
To:     John Garry <john.garry@huawei.com>, will@kernel.org
Cc:     joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
Message-ID: <b1f8e29d-13a1-a564-42ec-02fcb0160dd1@arm.com>
Date:   Thu, 5 Aug 2021 13:18:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05 12:24, Robin Murphy wrote:
> On 2021-06-21 17:36, John Garry wrote:
>> Members of struct "llq" will be zero-inited, apart from member 
>> max_n_shift.
>> But we write llq.val straight after the init, so it was pointless to zero
>> init those other members. As such, separately init member max_n_shift
>> only.
>>
>> In addition, struct "head" is initialised to "llq" only so that member
>> max_n_shift is set. But that member is never referenced for "head", so
>> remove any init there.
>>
>> Removing these initializations is seen as a small performance 
>> optimisation,
>> as this code is (very) hot path.
> 
> I looked at this and immediately thought "surely the compiler can see 
> that all the prod/cons/val fields are written anyway and elide the 
> initialisation?", so I dumped the before and after disassembly, and... oh.
> 
> You should probably clarify that it's zero-initialising all the 
> cacheline padding which is both pointless and painful. With that,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> However, having looked this closely I'm now tangentially wondering why 
> max_n_shift isn't inside the padded union? It's read at the same time as 
> both prod and cons by queue_has_space(), and never updated, so there 
> doesn't appear to be any benefit to it being in a separate cacheline all 
> by itself, and llq is already twice as big as it needs to be. Sorting 
> that would also be a good opportunity to store the value of interest in 
> its appropriate form so we're not needlessly recalculating 1 << shift 
> every flippin' time...

...on which note, how about something like this on top?

(untested since I don't have any SMMUv3 hardware to hand)

Robin.

----->8-----
Subject: [PATCH] iommu/arm-smmu-v3: Improve arm_smmu_ll_queue efficiency

Once initialised, max_n_shift is only ever read at the same time as
accessing prod or cons, thus should not have any impact on contention
to justify keeping it in its own separate cacheline. Move it inside the
padding union to halve the size of struct arm_smmu_ll_queue. Even then,
though, there are a couple more spots in the command issuing path where
we could do without the overhead of zeroing even one cache line worth of
padding, so avoid implicit initialisation of those temporary structures
as was done at the top level in arm_smmu_cmdq_issue_cmdlist().

Furthermore, the shift value is only directly relevant for initially
setting up the relevant queue base register; all we care about after
that is the number of entries, so store that value instead once a
queue is initialised and avoid needlessly recalculating it everywhere.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++----------
  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 29 ++++++++++-------
  2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 47610dc5d920..bc55217d6d61 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -111,7 +111,7 @@ static bool queue_has_space(struct arm_smmu_ll_queue 
*q, u32 n)
  	cons = Q_IDX(q, q->cons);

  	if (Q_WRP(q, q->prod) == Q_WRP(q, q->cons))
-		space = (1 << q->max_n_shift) - (prod - cons);
+		space = q->nents - (prod - cons);
  	else
  		space = cons - prod;

@@ -517,10 +517,11 @@ static void 
__arm_smmu_cmdq_poll_set_valid_map(struct arm_smmu_cmdq *cmdq,
  					       u32 sprod, u32 eprod, bool set)
  {
  	u32 swidx, sbidx, ewidx, ebidx;
-	struct arm_smmu_ll_queue llq = {
-		.max_n_shift	= cmdq->q.llq.max_n_shift,
-		.prod		= sprod,
-	};
+	struct arm_smmu_ll_queue llq;
+
+	/* Avoid zero-initialising all the padding */;
+	llq.nents = cmdq->q.llq.nents;
+	llq.prod = sprod;

  	ewidx = BIT_WORD(Q_IDX(&llq, eprod));
  	ebidx = Q_IDX(&llq, eprod) % BITS_PER_LONG;
@@ -696,10 +697,11 @@ static void arm_smmu_cmdq_write_entries(struct 
arm_smmu_cmdq *cmdq, u64 *cmds,
  					u32 prod, int n)
  {
  	int i;
-	struct arm_smmu_ll_queue llq = {
-		.max_n_shift	= cmdq->q.llq.max_n_shift,
-		.prod		= prod,
-	};
+	struct arm_smmu_ll_queue llq;
+
+	/* Avoid zero-initialising all the padding */;
+	llq.nents = cmdq->q.llq.nents;
+	llq.prod = prod;

  	for (i = 0; i < n; ++i) {
  		u64 *cmd = &cmds[i * CMDQ_ENT_DWORDS];
@@ -736,7 +738,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct 
arm_smmu_device *smmu,
  	struct arm_smmu_ll_queue llq, head;
  	int ret = 0;

-	llq.max_n_shift = cmdq->q.llq.max_n_shift;
+	llq.nents = cmdq->q.llq.nents;

  	/* 1. Allocate some space in the queue */
  	local_irq_save(flags);
@@ -2845,16 +2847,18 @@ static int arm_smmu_init_one_queue(struct 
arm_smmu_device *smmu,
  				   unsigned long cons_off,
  				   size_t dwords, const char *name)
  {
+	u32 max_n_shift = q->llq.max_n_shift;
  	size_t qsz;

  	do {
-		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
+		q->llq.nents = 1 << max_n_shift;
+		qsz = q->llq.nents * dwords * sizeof(u64);
  		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
  					      GFP_KERNEL);
  		if (q->base || qsz < PAGE_SIZE)
  			break;

-		q->llq.max_n_shift--;
+		max_n_shift--;
  	} while (1);

  	if (!q->base) {
@@ -2866,7 +2870,7 @@ static int arm_smmu_init_one_queue(struct 
arm_smmu_device *smmu,

  	if (!WARN_ON(q->base_dma & (qsz - 1))) {
  		dev_info(smmu->dev, "allocated %u entries for %s\n",
-			 1 << q->llq.max_n_shift, name);
+			 q->llq.nents, name);
  	}

  	q->prod_reg	= page + prod_off;
@@ -2875,7 +2879,7 @@ static int arm_smmu_init_one_queue(struct 
arm_smmu_device *smmu,

  	q->q_base  = Q_BASE_RWA;
  	q->q_base |= q->base_dma & Q_BASE_ADDR_MASK;
-	q->q_base |= FIELD_PREP(Q_BASE_LOG2SIZE, q->llq.max_n_shift);
+	q->q_base |= FIELD_PREP(Q_BASE_LOG2SIZE, max_n_shift);

  	q->llq.prod = q->llq.cons = 0;
  	return 0;
@@ -2891,13 +2895,12 @@ static int arm_smmu_cmdq_init(struct 
arm_smmu_device *smmu)
  {
  	int ret = 0;
  	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
-	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
  	atomic_long_t *bitmap;

  	atomic_set(&cmdq->owner_prod, 0);
  	atomic_set(&cmdq->lock, 0);

-	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
+	bitmap = (atomic_long_t *)bitmap_zalloc(cmdq->q.llq.nents, GFP_KERNEL);
  	if (!bitmap) {
  		dev_err(smmu->dev, "failed to allocate cmdq bitmap\n");
  		ret = -ENOMEM;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4cb136f07914..bc13952ad445 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -166,8 +166,8 @@
  #define ARM_SMMU_MEMATTR_DEVICE_nGnRE	0x1
  #define ARM_SMMU_MEMATTR_OIWB		0xf

-#define Q_IDX(llq, p)			((p) & ((1 << (llq)->max_n_shift) - 1))
-#define Q_WRP(llq, p)			((p) & (1 << (llq)->max_n_shift))
+#define Q_IDX(llq, p)			((p) & ((llq)->nents - 1))
+#define Q_WRP(llq, p)			((p) & (llq)->nents)
  #define Q_OVERFLOW_FLAG			(1U << 31)
  #define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
  #define Q_ENT(q, p)			((q)->base +			\
@@ -505,18 +505,25 @@ struct arm_smmu_cmdq_ent {

  struct arm_smmu_ll_queue {
  	union {
-		u64			val;
-		struct {
-			u32		prod;
-			u32		cons;
+		struct{
+			union {
+				u64	val;
+				struct {
+					u32 prod;
+					u32 cons;
+				};
+				struct {
+					atomic_t prod;
+					atomic_t cons;
+				} atomic;
+			};
+			union {
+				u32	max_n_shift;
+				u32	nents;
+			};
  		};
-		struct {
-			atomic_t	prod;
-			atomic_t	cons;
-		} atomic;
  		u8			__pad[SMP_CACHE_BYTES];
  	} ____cacheline_aligned_in_smp;
-	u32				max_n_shift;
  };

  struct arm_smmu_queue {
-- 
2.25.1

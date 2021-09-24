Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B23416FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245601AbhIXKIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:08:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3871 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245587AbhIXKIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:08:46 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HG71H6qRPz67YYY;
        Fri, 24 Sep 2021 18:04:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 12:07:12 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 11:07:08 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <mst@redhat.com>,
        <jasowang@redhat.com>, <robin.murphy@arm.com>
CC:     <xieyongji@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <virtualization@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thunder.leizhen@huawei.com>, <baolu.lu@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/5] iommu: Move IOVA flush queue code to dma-iommu
Date:   Fri, 24 Sep 2021 18:01:55 +0800
Message-ID: <1632477717-5254-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only dma-iommu.c uses the FQ code, so relocate it there.

There is nothing really IOVA specific in the FQ code anyway.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/dma-iommu.c | 258 +++++++++++++++++++++++++++++++++++++-
 drivers/iommu/iova.c      | 198 -----------------------------
 include/linux/iova.h      |  74 -----------
 3 files changed, 252 insertions(+), 278 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 279ee13bceb2..fd669bad96e1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -37,6 +37,56 @@ enum iommu_dma_cookie_type {
 	IOMMU_DMA_MSI_COOKIE,
 };
 
+struct fq_domain;
+
+/* Timeout (in ms) after which entries are flushed from the Flush-Queue */
+#define FQ_TIMEOUT	10
+
+/* Number of entries per Flush Queue */
+#define FQ_SIZE	256
+
+/* Call-Back from IOVA code into IOMMU drivers */
+typedef void (*flush_cb)(struct fq_domain *fq_domain);
+
+/* Destructor for per-entry data */
+typedef void (*entry_dtor)(unsigned long data);
+
+/* Flush Queue entry for defered flushing */
+struct fq_entry {
+	unsigned long iova_pfn;
+	unsigned long pages;
+	unsigned long data;
+	u64 counter; /* Flush counter when this entrie was added */
+};
+
+/* Per-CPU Flush Queue structure */
+struct fq {
+	struct fq_entry entries[FQ_SIZE];
+	unsigned head, tail;
+	spinlock_t lock;
+};
+
+struct fq_domain {
+	struct fq __percpu *fq;	/* Flush Queue */
+
+	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes that
+						   have been started */
+
+	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes that
+						   have been finished */
+
+	flush_cb	flush_cb;		/* Call-Back function to flush IOMMU
+						   TLBs */
+
+	entry_dtor entry_dtor;			/* IOMMU driver specific destructor for
+						   iova entry */
+
+	struct timer_list fq_timer;		/* Timer to regularily empty the
+						   flush-queues */
+	atomic_t fq_timer_on;			/* 1 when timer is active, 0
+						   when not */
+};
+
 struct iommu_dma_cookie {
 	enum iommu_dma_cookie_type	type;
 	union {
@@ -79,6 +129,204 @@ static void iommu_dma_entry_dtor(unsigned long data)
 	}
 }
 
+static bool has_flush_queue(struct fq_domain *fq_domain)
+{
+	return !!fq_domain->fq;
+}
+
+#define fq_ring_for_each(i, fq) \
+	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % FQ_SIZE)
+
+static void fq_destroy_all_entries(struct fq_domain *fq_domain)
+{
+	int cpu;
+
+	/*
+	 * This code runs when the iova_domain is being destroyed, so don't
+	 * bother to free iovas, just call the entry_dtor on all remaining
+	 * entries.
+	 */
+	if (!fq_domain->entry_dtor)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct fq *fq = per_cpu_ptr(fq_domain->fq, cpu);
+		int idx;
+
+		fq_ring_for_each(idx, fq)
+			fq_domain->entry_dtor(fq->entries[idx].data);
+	}
+}
+
+static void free_flush_queue(struct fq_domain *fq_domain)
+{
+	if (!has_flush_queue(fq_domain))
+		return;
+
+	if (timer_pending(&fq_domain->fq_timer))
+		del_timer(&fq_domain->fq_timer);
+
+	fq_destroy_all_entries(fq_domain);
+
+	free_percpu(fq_domain->fq);
+
+	fq_domain->fq         = NULL;
+	fq_domain->flush_cb   = NULL;
+	fq_domain->entry_dtor = NULL;
+}
+
+static inline bool fq_full(struct fq *fq)
+{
+	assert_spin_locked(&fq->lock);
+	return (((fq->tail + 1) % FQ_SIZE) == fq->head);
+}
+
+static inline unsigned fq_ring_add(struct fq *fq)
+{
+	unsigned idx = fq->tail;
+
+	assert_spin_locked(&fq->lock);
+
+	fq->tail = (idx + 1) % FQ_SIZE;
+
+	return idx;
+}
+
+static void fq_ring_free(struct fq_domain *fq_domain, struct fq *fq)
+{
+	struct iommu_dma_cookie *cookie = container_of(fq_domain,
+						       struct iommu_dma_cookie,
+						       fq);
+	struct iova_domain *iovad = &cookie->iovad;
+	u64 counter = atomic64_read(&fq_domain->fq_flush_finish_cnt);
+	unsigned idx;
+
+	assert_spin_locked(&fq->lock);
+
+	fq_ring_for_each(idx, fq) {
+
+		if (fq->entries[idx].counter >= counter)
+			break;
+
+		if (fq_domain->entry_dtor)
+			fq_domain->entry_dtor(fq->entries[idx].data);
+
+		free_iova_fast(iovad,
+			       fq->entries[idx].iova_pfn,
+			       fq->entries[idx].pages);
+
+		fq->head = (fq->head + 1) % FQ_SIZE;
+	}
+}
+
+static void domain_flush(struct fq_domain *fq_domain)
+{
+	atomic64_inc(&fq_domain->fq_flush_start_cnt);
+	fq_domain->flush_cb(fq_domain);
+	atomic64_inc(&fq_domain->fq_flush_finish_cnt);
+}
+
+static void queue_iova(struct fq_domain *fq_domain,
+		unsigned long pfn, unsigned long pages,
+		unsigned long data)
+{
+	struct fq *fq;
+	unsigned long flags;
+	unsigned idx;
+
+	/*
+	 * Order against the IOMMU driver's pagetable update from unmapping
+	 * @pte, to guarantee that iova_domain_flush() observes that if called
+	 * from a different CPU before we release the lock below. Full barrier
+	 * so it also pairs with iommu_dma_init_fq() to avoid seeing partially
+	 * written fq state here.
+	 */
+	smp_mb();
+
+	fq = raw_cpu_ptr(fq_domain->fq);
+	spin_lock_irqsave(&fq->lock, flags);
+
+	/*
+	 * First remove all entries from the flush queue that have already been
+	 * flushed out on another CPU. This makes the fq_full() check below less
+	 * likely to be true.
+	 */
+	fq_ring_free(fq_domain, fq);
+
+	if (fq_full(fq)) {
+		domain_flush(fq_domain);
+		fq_ring_free(fq_domain, fq);
+	}
+
+	idx = fq_ring_add(fq);
+
+	fq->entries[idx].iova_pfn = pfn;
+	fq->entries[idx].pages    = pages;
+	fq->entries[idx].data     = data;
+	fq->entries[idx].counter  = atomic64_read(&fq_domain->fq_flush_start_cnt);
+
+	spin_unlock_irqrestore(&fq->lock, flags);
+
+	/* Avoid false sharing as much as possible. */
+	if (!atomic_read(&fq_domain->fq_timer_on) &&
+	    !atomic_xchg(&fq_domain->fq_timer_on, 1))
+		mod_timer(&fq_domain->fq_timer,
+			  jiffies + msecs_to_jiffies(FQ_TIMEOUT));
+}
+
+static void fq_flush_timeout(struct timer_list *t)
+{
+	struct fq_domain *fq_domain = from_timer(fq_domain, t, fq_timer);
+	int cpu;
+
+	atomic_set(&fq_domain->fq_timer_on, 0);
+	domain_flush(fq_domain);
+
+	for_each_possible_cpu(cpu) {
+		unsigned long flags;
+		struct fq *fq;
+
+		fq = per_cpu_ptr(fq_domain->fq, cpu);
+		spin_lock_irqsave(&fq->lock, flags);
+		fq_ring_free(fq_domain, fq);
+		spin_unlock_irqrestore(&fq->lock, flags);
+	}
+}
+
+static int init_flush_queue(struct fq_domain *fq_domain,
+			    flush_cb flush_cb, entry_dtor entry_dtor)
+{
+	struct fq __percpu *queue;
+	int cpu;
+
+	atomic64_set(&fq_domain->fq_flush_start_cnt,  0);
+	atomic64_set(&fq_domain->fq_flush_finish_cnt, 0);
+
+	queue = alloc_percpu(struct fq);
+	if (!queue)
+		return -ENOMEM;
+
+	fq_domain->flush_cb   = flush_cb;
+	fq_domain->entry_dtor = entry_dtor;
+
+	for_each_possible_cpu(cpu) {
+		struct fq *fq;
+
+		fq = per_cpu_ptr(queue, cpu);
+		fq->head = 0;
+		fq->tail = 0;
+
+		spin_lock_init(&fq->lock);
+	}
+
+	fq_domain->fq = queue;
+
+	timer_setup(&fq_domain->fq_timer, fq_flush_timeout, 0);
+	atomic_set(&fq_domain->fq_timer_on, 0);
+
+	return 0;
+}
+
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 {
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
@@ -166,7 +414,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 		return;
 
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule) {
-		iova_free_flush_queue(&cookie->fq);
+		free_flush_queue(&cookie->fq);
 		put_iova_domain(&cookie->iovad);
 	}
 
@@ -332,15 +580,13 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	if (cookie->fq_domain)
 		return 0;
 
-	ret = init_iova_flush_queue(fq, iommu_dma_flush_iotlb_all,
-				    iommu_dma_entry_dtor);
+	ret = init_flush_queue(fq, iommu_dma_flush_iotlb_all,
+			       iommu_dma_entry_dtor);
 	if (ret) {
-		pr_warn("iova flush queue initialization failed\n");
+		pr_warn("dma-iommu flush queue initialization failed\n");
 		return ret;
 	}
 
-	fq->iovad = &cookie->iovad;
-
 	/*
 	 * Prevent incomplete iovad->fq being observable. Pairs with path from
 	 * __iommu_dma_unmap() through iommu_dma_free_iova() to queue_iova()
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 262a08eb547f..104fdc9d6c6a 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -24,8 +24,6 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 static void init_iova_rcaches(struct iova_domain *iovad);
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
-static void fq_destroy_all_entries(struct fq_domain *fq_domain);
-static void fq_flush_timeout(struct timer_list *t);
 
 static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
 {
@@ -71,63 +69,6 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
-static bool has_iova_flush_queue(struct fq_domain *fq_domain)
-{
-	return !!fq_domain->fq;
-}
-
-void iova_free_flush_queue(struct fq_domain *fq_domain)
-{
-	if (!has_iova_flush_queue(fq_domain))
-		return;
-
-	if (timer_pending(&fq_domain->fq_timer))
-		del_timer(&fq_domain->fq_timer);
-
-	fq_destroy_all_entries(fq_domain);
-
-	free_percpu(fq_domain->fq);
-
-	fq_domain->fq         = NULL;
-	fq_domain->flush_cb   = NULL;
-	fq_domain->entry_dtor = NULL;
-	fq_domain->iovad      = NULL;
-}
-
-int init_iova_flush_queue(struct fq_domain *fq_domain,
-			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor)
-{
-	struct iova_fq __percpu *queue;
-	int cpu;
-
-	atomic64_set(&fq_domain->fq_flush_start_cnt,  0);
-	atomic64_set(&fq_domain->fq_flush_finish_cnt, 0);
-
-	queue = alloc_percpu(struct iova_fq);
-	if (!queue)
-		return -ENOMEM;
-
-	fq_domain->flush_cb   = flush_cb;
-	fq_domain->entry_dtor = entry_dtor;
-
-	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq;
-
-		fq = per_cpu_ptr(queue, cpu);
-		fq->head = 0;
-		fq->tail = 0;
-
-		spin_lock_init(&fq->lock);
-	}
-
-	fq_domain->fq = queue;
-
-	timer_setup(&fq_domain->fq_timer, fq_flush_timeout, 0);
-	atomic_set(&fq_domain->fq_timer_on, 0);
-
-	return 0;
-}
-
 static struct rb_node *
 __get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
 {
@@ -546,145 +487,6 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 	free_iova(iovad, pfn);
 }
 EXPORT_SYMBOL_GPL(free_iova_fast);
-
-#define fq_ring_for_each(i, fq) \
-	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
-
-static inline bool fq_full(struct iova_fq *fq)
-{
-	assert_spin_locked(&fq->lock);
-	return (((fq->tail + 1) % IOVA_FQ_SIZE) == fq->head);
-}
-
-static inline unsigned fq_ring_add(struct iova_fq *fq)
-{
-	unsigned idx = fq->tail;
-
-	assert_spin_locked(&fq->lock);
-
-	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
-
-	return idx;
-}
-
-static void fq_ring_free(struct fq_domain *fq_domain, struct iova_fq *fq)
-{
-	u64 counter = atomic64_read(&fq_domain->fq_flush_finish_cnt);
-	unsigned idx;
-
-	assert_spin_locked(&fq->lock);
-
-	fq_ring_for_each(idx, fq) {
-
-		if (fq->entries[idx].counter >= counter)
-			break;
-
-		if (fq_domain->entry_dtor)
-			fq_domain->entry_dtor(fq->entries[idx].data);
-
-		free_iova_fast(fq_domain->iovad,
-			       fq->entries[idx].iova_pfn,
-			       fq->entries[idx].pages);
-
-		fq->head = (fq->head + 1) % IOVA_FQ_SIZE;
-	}
-}
-
-static void iova_domain_flush(struct fq_domain *fq_domain)
-{
-	atomic64_inc(&fq_domain->fq_flush_start_cnt);
-	fq_domain->flush_cb(fq_domain);
-	atomic64_inc(&fq_domain->fq_flush_finish_cnt);
-}
-
-static void fq_destroy_all_entries(struct fq_domain *fq_domain)
-{
-	int cpu;
-
-	/*
-	 * This code runs when the iova_domain is being detroyed, so don't
-	 * bother to free iovas, just call the entry_dtor on all remaining
-	 * entries.
-	 */
-	if (!fq_domain->entry_dtor)
-		return;
-
-	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(fq_domain->fq, cpu);
-		int idx;
-
-		fq_ring_for_each(idx, fq)
-			fq_domain->entry_dtor(fq->entries[idx].data);
-	}
-}
-
-static void fq_flush_timeout(struct timer_list *t)
-{
-	struct fq_domain *fq_domain = from_timer(fq_domain, t, fq_timer);
-	int cpu;
-
-	atomic_set(&fq_domain->fq_timer_on, 0);
-	iova_domain_flush(fq_domain);
-
-	for_each_possible_cpu(cpu) {
-		unsigned long flags;
-		struct iova_fq *fq;
-
-		fq = per_cpu_ptr(fq_domain->fq, cpu);
-		spin_lock_irqsave(&fq->lock, flags);
-		fq_ring_free(fq_domain, fq);
-		spin_unlock_irqrestore(&fq->lock, flags);
-	}
-}
-
-void queue_iova(struct fq_domain *fq_domain,
-		unsigned long pfn, unsigned long pages,
-		unsigned long data)
-{
-	struct iova_fq *fq;
-	unsigned long flags;
-	unsigned idx;
-
-	/*
-	 * Order against the IOMMU driver's pagetable update from unmapping
-	 * @pte, to guarantee that iova_domain_flush() observes that if called
-	 * from a different CPU before we release the lock below. Full barrier
-	 * so it also pairs with iommu_dma_init_fq() to avoid seeing partially
-	 * written fq state here.
-	 */
-	smp_mb();
-
-	fq = raw_cpu_ptr(fq_domain->fq);
-	spin_lock_irqsave(&fq->lock, flags);
-
-	/*
-	 * First remove all entries from the flush queue that have already been
-	 * flushed out on another CPU. This makes the fq_full() check below less
-	 * likely to be true.
-	 */
-	fq_ring_free(fq_domain, fq);
-
-	if (fq_full(fq)) {
-		iova_domain_flush(fq_domain);
-		fq_ring_free(fq_domain, fq);
-	}
-
-	idx = fq_ring_add(fq);
-
-	fq->entries[idx].iova_pfn = pfn;
-	fq->entries[idx].pages    = pages;
-	fq->entries[idx].data     = data;
-	fq->entries[idx].counter  = atomic64_read(&fq_domain->fq_flush_start_cnt);
-
-	spin_unlock_irqrestore(&fq->lock, flags);
-
-	/* Avoid false sharing as much as possible. */
-	if (!atomic_read(&fq_domain->fq_timer_on) &&
-	    !atomic_xchg(&fq_domain->fq_timer_on, 1))
-		mod_timer(&fq_domain->fq_timer,
-			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
-}
-
 /**
  * put_iova_domain - destroys the iova domain
  * @iovad: - iova domain in question.
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 4975b65ab810..ef3b0f8f8a31 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -36,34 +36,6 @@ struct iova_rcache {
 };
 
 struct iova_domain;
-struct fq_domain;
-
-/* Call-Back from IOVA code into IOMMU drivers */
-typedef void (*iova_flush_cb)(struct fq_domain *fq_domain);
-
-/* Destructor for per-entry data */
-typedef void (*iova_entry_dtor)(unsigned long data);
-
-/* Number of entries per Flush Queue */
-#define IOVA_FQ_SIZE	256
-
-/* Timeout (in ms) after which entries are flushed from the Flush-Queue */
-#define IOVA_FQ_TIMEOUT	10
-
-/* Flush Queue entry for defered flushing */
-struct iova_fq_entry {
-	unsigned long iova_pfn;
-	unsigned long pages;
-	unsigned long data;
-	u64 counter; /* Flush counter when this entrie was added */
-};
-
-/* Per-CPU Flush Queue structure */
-struct iova_fq {
-	struct iova_fq_entry entries[IOVA_FQ_SIZE];
-	unsigned head, tail;
-	spinlock_t lock;
-};
 
 /* holds all the iova translations for a domain */
 struct iova_domain {
@@ -80,28 +52,6 @@ struct iova_domain {
 	struct hlist_node	cpuhp_dead;
 };
 
-struct fq_domain {
-	struct iova_fq __percpu *fq;	/* Flush Queue */
-
-	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes that
-						   have been started */
-
-	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes that
-						   have been finished */
-
-	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
-					   TLBs */
-
-	iova_entry_dtor entry_dtor;	/* IOMMU driver specific destructor for
-					   iova entry */
-
-	struct timer_list fq_timer;		/* Timer to regularily empty the
-						   flush-queues */
-	atomic_t fq_timer_on;			/* 1 when timer is active, 0
-						   when not */
-	struct iova_domain *iovad;
-};
-
 static inline unsigned long iova_size(struct iova *iova)
 {
 	return iova->pfn_hi - iova->pfn_lo + 1;
@@ -148,19 +98,12 @@ struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
 	bool size_aligned);
 void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
 		    unsigned long size);
-void queue_iova(struct fq_domain *fq_domain,
-		unsigned long pfn, unsigned long pages,
-		unsigned long data);
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 			      unsigned long limit_pfn, bool flush_rcache);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
-int init_iova_flush_queue(struct fq_domain *fq_domain,
-			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
-void iova_free_flush_queue(struct fq_domain *fq_domain);
-
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 #else
@@ -195,12 +138,6 @@ static inline void free_iova_fast(struct iova_domain *iovad,
 {
 }
 
-static inline void queue_iova(struct fq_domain *fq_domain,
-			      unsigned long pfn, unsigned long pages,
-			      unsigned long data)
-{
-}
-
 static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
 					    unsigned long size,
 					    unsigned long limit_pfn,
@@ -222,17 +159,6 @@ static inline void init_iova_domain(struct iova_domain *iovad,
 {
 }
 
-static inline int init_iova_flush_queue(struct fq_domain *fq_domain,
-					iova_flush_cb flush_cb,
-					iova_entry_dtor entry_dtor)
-{
-	return -ENODEV;
-}
-
-static inline void iova_free_flush_queue(struct fq_domain *fq_domain)
-{
-}
-
 static inline struct iova *find_iova(struct iova_domain *iovad,
 				     unsigned long pfn)
 {
-- 
2.26.2


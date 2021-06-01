Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABE0396D97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhFAGx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:53:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230326AbhFAGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:53:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1516j77U166123;
        Tue, 1 Jun 2021 02:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DgncIJq9zew5EYu13Nia/yGtk4R0YZADoVYqPGEbxHw=;
 b=IbjfQFNsXXjTc7tgoNWpoC4Dgl39Mc+ezmCryj77HJ2oAgn93YYHivd1rBj3inDhKBFV
 EUXq9snof3W6Ei9Eahv62eDR8s7bYcQxKmMVSSUssVbILwMrG+JbnbQJPYNU4y1G6fCb
 J8p8Z74vtq4i8FLHhLnd2L3o1QKEDLZvWVcXMmErVvITb+zJgC7HBK3AFxJWuZT3f3Xw
 6Vybv7YjQitrRIW9WbanIlUamEiqYCJWvHIfeF/PKILyqzY3ABI7VMeg6Yv0t6dBAOX5
 bciKEM1WvzpNnXCsUN8ZHA+nC1aa1DT5mPCu/fOLBOMrfdOeX3+BV3b8Sn+68R+5iyq0 eg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38wfw284sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 02:52:05 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1516mEdp003489;
        Tue, 1 Jun 2021 06:52:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 38ud880sye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:52:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1516pRGp29622572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 06:51:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC6A511C05C;
        Tue,  1 Jun 2021 06:51:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B60211C04C;
        Tue,  1 Jun 2021 06:51:57 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.77.195.136])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jun 2021 06:51:57 +0000 (GMT)
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, aneesh.kumar@linux.ibm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        amakhalov@vmware.com, guro@fb.com, vbabka@suse.cz,
        srikar@linux.vnet.ibm.com, psampat@linux.ibm.com,
        ego@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.ibm.com>
Subject: [RFC PATCH v0 1/3] percpu: CPU hotplug support for alloc_percpu()
Date:   Tue,  1 Jun 2021 12:21:45 +0530
Message-Id: <20210601065147.53735-2-bharata@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601065147.53735-1-bharata@linux.ibm.com>
References: <20210601065147.53735-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s6J7gmAiOTZGAc2PlHXlhpjm4C11wA1m
X-Proofpoint-ORIG-GUID: s6J7gmAiOTZGAc2PlHXlhpjm4C11wA1m
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_03:2021-05-31,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu allocator allocates memory for all the possible CPUs.
This can lead to wastage of memory when possible number of CPUs
is significantly higher than the number of online CPUs. This can
be avoided if the percpu allocator were to allocate only for the
online CPUs and extend the allocation for other CPUs as and they
become online. Essentially the population of the chunk which
involves allocating the pages for the chunk unit that corresponding
to the CPU and mapping them to the vmalloc range can be delayed to
the CPU hotplug time.

To achieve this, add CPU hotplug callback support to the percpu
allocator and let it setup the percpu allocation corresponding to
the newly coming up CPU at hotplug time. The vmalloc range is
allocated for all the possible CPUs upfront, but during hotplug
time, only the populated pages from the chunk are setup (allocated
and mapped) for the unit that corresponds to the new CPUs.
The same is undone (unit pages unmapped and freed) at unplug
time.

This itself isn't sufficient because some callers of alloc_percpu()
would expect the percpu variables/pointers for all the possible
CPUs to have been initialized at allocation time itself. Hence
allow them to register a callback via alloc_percpu() variants that
would be called back during hotpug time for any necessary
initialization of percpu variables.

This is very much an experimental patch with major unsolved
and unaddressed aspects listed below:

- Memcg charging has been changed to account for online CPUs,
  however the growing and removing of charge corresponding
  to the hotplugged CPU hasn't been done yet.
- The CPU hotplug support has been added only to vmalloc based
  percpu allocator.
- All the callers of alloc_percpu() who need initialization
  callbacks haven't been changed to use the new variants. I
  have changed only those callers whom I ran into when booting
  a minimal powerpc KVM guest in my environment.
- Yet to audit all the callers of alloc_percpu() and verify
  if the approach taken here would fit their use of percpu
  memory and if they are in a position to handle the required
  initialization during CPU hotplug time.
- The patches may break git blame, the intention right now is
  just to make it easy to illustrate the approach taken.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 include/linux/cpuhotplug.h |   2 +
 include/linux/percpu.h     |  15 +++
 mm/percpu-internal.h       |   9 ++
 mm/percpu-vm.c             | 199 +++++++++++++++++++++++++++++++++++
 mm/percpu.c                | 209 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 430 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 4a62b3980642..ae20a14967eb 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -36,6 +36,8 @@ enum cpuhp_state {
 	CPUHP_X86_MCE_DEAD,
 	CPUHP_VIRT_NET_DEAD,
 	CPUHP_SLUB_DEAD,
+	CPUHP_PERCPU_SETUP,
+	CPUHP_PERCPU_ALLOC,
 	CPUHP_DEBUG_OBJ_DEAD,
 	CPUHP_MM_WRITEBACK_DEAD,
 	CPUHP_MM_VMSTAT_DEAD,
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 5e76af742c80..145fdb9318d1 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -100,6 +100,7 @@ typedef void * (*pcpu_fc_alloc_fn_t)(unsigned int cpu, size_t size,
 typedef void (*pcpu_fc_free_fn_t)(void *ptr, size_t size);
 typedef void (*pcpu_fc_populate_pte_fn_t)(unsigned long addr);
 typedef int (pcpu_fc_cpu_distance_fn_t)(unsigned int from, unsigned int to);
+typedef int (*pcpu_cpuhp_fn_t)(void __percpu *ptr, unsigned int cpu, void *data);
 
 extern struct pcpu_alloc_info * __init pcpu_alloc_alloc_info(int nr_groups,
 							     int nr_units);
@@ -133,6 +134,11 @@ extern void __init setup_per_cpu_areas(void);
 
 extern void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp);
 extern void __percpu *__alloc_percpu(size_t size, size_t align);
+extern void __percpu *__alloc_percpu_gfp_cb(size_t size, size_t align,
+					    gfp_t gfp, pcpu_cpuhp_fn_t fn,
+					    void *data);
+extern void __percpu *__alloc_percpu_cb(size_t size, size_t align,
+					pcpu_cpuhp_fn_t fn, void *data);
 extern void free_percpu(void __percpu *__pdata);
 extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 
@@ -143,6 +149,15 @@ extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 	(typeof(type) __percpu *)__alloc_percpu(sizeof(type),		\
 						__alignof__(type))
 
+#define alloc_percpu_gfp_cb(type, gfp, fn, data)			\
+	(typeof(type) __percpu *)__alloc_percpu_gfp_cb(sizeof(type),	\
+						__alignof__(type), gfp,	\
+						fn, data)
+#define alloc_percpu_cb(type, fn, data)					\
+	(typeof(type) __percpu *)__alloc_percpu_cb(sizeof(type),	\
+						__alignof__(type),	\
+						fn, data)
+
 extern unsigned long pcpu_nr_pages(void);
 
 #endif /* __LINUX_PERCPU_H */
diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index ae26b118e246..8064e7c43b9f 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -57,6 +57,8 @@ struct pcpu_chunk {
 #endif
 
 	struct list_head	list;		/* linked to pcpu_slot lists */
+	struct list_head	cpuhp;		/* list of registered cpu hotplug
+						   notifiers */
 	int			free_bytes;	/* free bytes in the chunk */
 	struct pcpu_block_md	chunk_md;
 	void			*base_addr;	/* base address of this chunk */
@@ -282,4 +284,11 @@ static inline void pcpu_stats_chunk_dealloc(void)
 
 #endif /* !CONFIG_PERCPU_STATS */
 
+struct percpu_cpuhp_notifier {
+	void __percpu *ptr;
+	void *data;
+	pcpu_cpuhp_fn_t cb;
+	struct list_head list;
+};
+
 #endif
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 8d3844bc0c7c..3250e1c9aeaf 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -41,6 +41,67 @@ static struct page **pcpu_get_pages(void)
 	return pages;
 }
 
+/**
+ * pcpu_alloc_pages_cpu - allocates pages for @chunk for a given cpu
+ * @cpu: target cpu
+ * @chunk: target chunk
+ * @pages: array to put the allocated pages into, indexed by pcpu_page_idx()
+ * @page_start: page index of the first page to be allocated
+ * @page_end: page index of the last page to be allocated + 1
+ * @gfp: allocation flags passed to the underlying allocator
+ *
+ * Allocate pages [@page_start,@page_end) into @pages for the given cpu.
+ * The allocation is for @chunk.  Percpu core doesn't care about the
+ * content of @pages and will pass it verbatim to pcpu_map_pages().
+ */
+static int pcpu_alloc_pages_cpu(unsigned int cpu, struct pcpu_chunk *chunk,
+				struct page **pages, int page_start, int page_end,
+				gfp_t gfp)
+{
+	int i;
+
+	gfp |= __GFP_HIGHMEM;
+
+	for (i = page_start; i < page_end; i++) {
+		struct page **pagep = &pages[pcpu_page_idx(cpu, i)];
+
+		*pagep = alloc_pages_node(cpu_to_node(cpu), gfp, 0);
+		if (!*pagep)
+			goto err;
+	}
+	return 0;
+
+err:
+	while (--i >= page_start)
+		__free_page(pages[pcpu_page_idx(cpu, i)]);
+
+	return -ENOMEM;
+}
+
+/**
+ * pcpu_free_pages_cpu - free pages which were allocated for @chunk for @cpu
+ * @cpu: cpu for which the pages were allocated
+ * @chunk: chunk pages were allocated for
+ * @pages: array of pages to be freed, indexed by pcpu_page_idx()
+ * @page_start: page index of the first page to be freed
+ * @page_end: page index of the last page to be freed + 1
+ *
+ * Free pages [@page_start and @page_end) in @pages for @cpu.
+ * The pages were allocated for @chunk.
+ */
+static void pcpu_free_pages_cpu(unsigned int cpu, struct pcpu_chunk *chunk,
+				struct page **pages, int page_start, int page_end)
+{
+	int i;
+
+	for (i = page_start; i < page_end; i++) {
+		struct page *page = pages[pcpu_page_idx(cpu, i)];
+
+		if (page)
+			__free_page(page);
+	}
+}
+
 /**
  * pcpu_free_pages - free pages which were allocated for @chunk
  * @chunk: chunk pages were allocated for
@@ -137,6 +198,37 @@ static void __pcpu_unmap_pages(unsigned long addr, int nr_pages)
 	vunmap_range_noflush(addr, addr + (nr_pages << PAGE_SHIFT));
 }
 
+/**
+ * pcpu_unmap_pages_cpu - unmap pages out of a pcpu_chunk for a cpu
+ * @cpu: cpu of interest
+ * @chunk: chunk of interest
+ * @pages: pages array which can be used to pass information to free
+ * @page_start: page index of the first page to unmap
+ * @page_end: page index of the last page to unmap + 1
+ *
+ * For the given cpu, unmap pages [@page_start,@page_end) out of @chunk.
+ * Corresponding elements in @pages were cleared by the caller and can
+ * be used to carry information to pcpu_free_pages() which will be
+ * called after all unmaps are finished.  The caller should call
+ * proper pre/post flush functions.
+ */
+static void pcpu_unmap_pages_cpu(unsigned int cpu, struct pcpu_chunk *chunk,
+				 struct page **pages, int page_start,
+				 int page_end)
+{
+	int i;
+
+	for (i = page_start; i < page_end; i++) {
+		struct page *page;
+
+		page = pcpu_chunk_page(chunk, cpu, i);
+		WARN_ON(!page);
+		pages[pcpu_page_idx(cpu, i)] = page;
+	}
+	__pcpu_unmap_pages(pcpu_chunk_addr(chunk, cpu, page_start),
+				   page_end - page_start);
+}
+
 /**
  * pcpu_unmap_pages - unmap pages out of a pcpu_chunk
  * @chunk: chunk of interest
@@ -197,6 +289,41 @@ static int __pcpu_map_pages(unsigned long addr, struct page **pages,
 					PAGE_KERNEL, pages, PAGE_SHIFT);
 }
 
+/**
+ * pcpu_map_pages_cpu - map pages into a pcpu_chunk for a cpu
+ * @cpu: cpu of interest
+ * @chunk: chunk of interest
+ * @pages: pages array containing pages to be mapped
+ * @page_start: page index of the first page to map
+ * @page_end: page index of the last page to map + 1
+ *
+ * For the given cpu, map pages [@page_start,@page_end) into @chunk.  The
+ * caller is responsible for calling pcpu_post_map_flush() after all
+ * mappings are complete.
+ *
+ * This function is responsible for setting up whatever is necessary for
+ * reverse lookup (addr -> chunk).
+ */
+static int pcpu_map_pages_cpu(unsigned int cpu, struct pcpu_chunk *chunk,
+			      struct page **pages, int page_start, int page_end)
+{
+	int i, err;
+
+	err = __pcpu_map_pages(pcpu_chunk_addr(chunk, cpu, page_start),
+			       &pages[pcpu_page_idx(cpu, page_start)],
+			       page_end - page_start);
+	if (err < 0)
+		goto err;
+
+	for (i = page_start; i < page_end; i++)
+		pcpu_set_page_chunk(pages[pcpu_page_idx(cpu, i)],
+				    chunk);
+	return 0;
+err:
+	pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
+	return err;
+}
+
 /**
  * pcpu_map_pages - map pages into a pcpu_chunk
  * @chunk: chunk of interest
@@ -260,6 +387,40 @@ static void pcpu_post_map_flush(struct pcpu_chunk *chunk,
 		pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, page_end));
 }
 
+/**
+ * pcpu_populate_chunk_cpu - populate and map an area of a pcpu_chunk for a cpu
+ * @cpu: cpu of interest
+ * @chunk: chunk of interest
+ * @page_start: the start page
+ * @page_end: the end page
+ * @gfp: allocation flags passed to the underlying memory allocator
+ *
+ * For the given cpu, populate and map pages [@page_start,@page_end) into
+ * @chunk.
+ *
+ * CONTEXT:
+ * pcpu_alloc_mutex, does GFP_KERNEL allocation.
+ */
+static int pcpu_populate_chunk_cpu(unsigned int cpu, struct pcpu_chunk *chunk,
+				   int page_start, int page_end, gfp_t gfp)
+{
+	struct page **pages;
+
+	pages = pcpu_get_pages();
+	if (!pages)
+		return -ENOMEM;
+
+	if (pcpu_alloc_pages_cpu(cpu, chunk, pages, page_start, page_end, gfp))
+		return -ENOMEM;
+
+	if (pcpu_map_pages_cpu(cpu, chunk, pages, page_start, page_end)) {
+		pcpu_free_pages_cpu(cpu, chunk, pages, page_start, page_end);
+		return -ENOMEM;
+	}
+	pcpu_post_map_flush(chunk, page_start, page_end);
+
+	return 0;
+}
 /**
  * pcpu_populate_chunk - populate and map an area of a pcpu_chunk
  * @chunk: chunk of interest
@@ -294,6 +455,44 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
 	return 0;
 }
 
+/**
+ * pcpu_depopulate_chunk_cpu - depopulate and unmap an area of a pcpu_chunk
+ * for a cpu
+ * @cpu: cpu of interest
+ * @chunk: chunk to depopulate
+ * @page_start: the start page
+ * @page_end: the end page
+ *
+ * For the given cpu, depopulate and unmap pages [@page_start,@page_end)
+ * from @chunk.
+ *
+ * CONTEXT:
+ * pcpu_alloc_mutex.
+ */
+static void pcpu_depopulate_chunk_cpu(unsigned int cpu,
+				      struct pcpu_chunk *chunk,
+				      int page_start, int page_end)
+{
+	struct page **pages;
+
+	/*
+	 * If control reaches here, there must have been at least one
+	 * successful population attempt so the temp pages array must
+	 * be available now.
+	 */
+	pages = pcpu_get_pages();
+	BUG_ON(!pages);
+
+	/* unmap and free */
+	pcpu_pre_unmap_flush(chunk, page_start, page_end);
+
+	pcpu_unmap_pages_cpu(cpu, chunk, pages, page_start, page_end);
+
+	/* no need to flush tlb, vmalloc will handle it lazily */
+
+	pcpu_free_pages_cpu(cpu, chunk, pages, page_start, page_end);
+}
+
 /**
  * pcpu_depopulate_chunk - depopulate and unmap an area of a pcpu_chunk
  * @chunk: chunk to depopulate
diff --git a/mm/percpu.c b/mm/percpu.c
index f99e9306b939..ca8ca541bede 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1324,6 +1324,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 		      alloc_size);
 
 	INIT_LIST_HEAD(&chunk->list);
+	INIT_LIST_HEAD(&chunk->cpuhp);
 
 	chunk->base_addr = (void *)aligned_addr;
 	chunk->start_offset = start_offset;
@@ -1404,6 +1405,7 @@ static struct pcpu_chunk *pcpu_alloc_chunk(enum pcpu_chunk_type type, gfp_t gfp)
 		return NULL;
 
 	INIT_LIST_HEAD(&chunk->list);
+	INIT_LIST_HEAD(&chunk->cpuhp);
 	chunk->nr_pages = pcpu_unit_pages;
 	region_bits = pcpu_chunk_map_bits(chunk);
 
@@ -1659,6 +1661,161 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
+static void pcpu_cpuhp_register(struct pcpu_chunk *chunk,
+				struct percpu_cpuhp_notifier *n)
+{
+	list_add(&n->list, &chunk->cpuhp);
+}
+
+static void pcpu_cpuhp_deregister(struct pcpu_chunk *chunk,
+				  void __percpu *ptr)
+{
+	struct percpu_cpuhp_notifier *n, *next;
+
+	list_for_each_entry_safe(n, next, &chunk->cpuhp, list)
+		if (n->ptr == ptr) {
+			list_del(&n->list);
+			kfree(n);
+			return;
+		}
+}
+
+static void __pcpu_cpuhp_setup(enum pcpu_chunk_type type, unsigned int cpu)
+{
+	int slot;
+	struct list_head *pcpu_slot = pcpu_chunk_list(type);
+	struct pcpu_chunk *chunk;
+
+	for (slot = 0; slot < pcpu_nr_slots; slot++) {
+		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
+			unsigned int rs, re;
+
+			if (chunk == pcpu_first_chunk)
+				continue;
+
+			bitmap_for_each_set_region(chunk->populated, rs, re, 0,
+						   chunk->nr_pages)
+				pcpu_populate_chunk_cpu(cpu, chunk, rs, re,
+							GFP_KERNEL);
+		}
+	}
+}
+
+/**
+ * cpu hotplug callback for percpu allocator
+ * @cpu: cpu that is being hotplugged
+ *
+ * Allocates and maps the pages that corresponds to @cpu's unit
+ * in all chunks.
+ */
+static int percpu_cpuhp_setup(unsigned int cpu)
+{
+	enum pcpu_chunk_type type;
+
+	mutex_lock(&pcpu_alloc_mutex);
+	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
+		__pcpu_cpuhp_setup(type, cpu);
+	mutex_unlock(&pcpu_alloc_mutex);
+
+	return 0;
+}
+
+static void __pcpu_cpuhp_destroy(enum pcpu_chunk_type type, unsigned int cpu)
+{
+	int slot;
+	struct list_head *pcpu_slot = pcpu_chunk_list(type);
+	struct pcpu_chunk *chunk;
+
+	for (slot = 0; slot < pcpu_nr_slots; slot++) {
+		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
+			unsigned int rs, re;
+
+			if (chunk == pcpu_first_chunk)
+				continue;
+
+			bitmap_for_each_set_region(chunk->populated, rs, re, 0,
+						   chunk->nr_pages)
+				pcpu_depopulate_chunk_cpu(cpu, chunk, rs, re);
+		}
+	}
+}
+
+/**
+ * cpu unplug callback for percpu allocator
+ * @cpu: cpu that is being hotplugged
+ *
+ * Unmaps and frees the pages that corresponds to @cpu's unit
+ * in all chunks.
+ */
+static int percpu_cpuhp_destroy(unsigned int cpu)
+{
+	enum pcpu_chunk_type type;
+
+	mutex_lock(&pcpu_alloc_mutex);
+	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
+		__pcpu_cpuhp_destroy(type, cpu);
+	mutex_unlock(&pcpu_alloc_mutex);
+
+	return 0;
+}
+
+static void __pcpu_cpuhp_alloc(enum pcpu_chunk_type type, unsigned int cpu)
+{
+	int slot;
+	struct list_head *pcpu_slot = pcpu_chunk_list(type);
+	struct pcpu_chunk *chunk;
+	struct percpu_cpuhp_notifier *n;
+
+	for (slot = 0; slot < pcpu_nr_slots; slot++) {
+		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
+			list_for_each_entry(n, &chunk->cpuhp, list)
+				n->cb(n->ptr, cpu, n->data);
+		}
+	}
+}
+
+/**
+ * cpu hotplug callback for executing any initialization routines
+ * registered by the callers of alloc_percpu_cb()
+ *
+ * @cpu: cpu that is being hotplugged
+ */
+static int percpu_cpuhp_alloc(unsigned int cpu)
+{
+	enum pcpu_chunk_type type;
+
+	mutex_lock(&pcpu_alloc_mutex);
+	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
+		__pcpu_cpuhp_alloc(type, cpu);
+	mutex_unlock(&pcpu_alloc_mutex);
+
+	return 0;
+}
+
+static int percpu_cpuhp_free(unsigned int cpu)
+{
+	return 0;
+}
+
+/**
+ * Register cpu hotplug callbacks for the percpu allocator
+ * and its callers
+ */
+static int percpu_hotplug_setup(void)
+{
+	/* Callback for percpu allocator */
+	if (cpuhp_setup_state(CPUHP_PERCPU_SETUP, "percpu:setup",
+	    percpu_cpuhp_setup, percpu_cpuhp_destroy))
+		return -EINVAL;
+
+	/* Callback for the callers of alloc_percpu() */
+	if (cpuhp_setup_state(CPUHP_PERCPU_ALLOC, "percpu:alloc",
+	    percpu_cpuhp_alloc, percpu_cpuhp_free))
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * pcpu_alloc - the percpu allocator
  * @size: size of area to allocate in bytes
@@ -1675,7 +1832,7 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
  * Percpu pointer to the allocated area on success, NULL on failure.
  */
 static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
-				 gfp_t gfp)
+				 gfp_t gfp,  pcpu_cpuhp_fn_t cb, void *data)
 {
 	gfp_t pcpu_gfp;
 	bool is_atomic;
@@ -1690,6 +1847,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 	unsigned long flags;
 	void __percpu *ptr;
 	size_t bits, bit_align;
+	struct percpu_cpuhp_notifier *n;
 
 	gfp = current_gfp_context(gfp);
 	/* whitelisted flags that can be passed to the backing allocators */
@@ -1697,6 +1855,12 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 	is_atomic = (gfp & GFP_KERNEL) != GFP_KERNEL;
 	do_warn = !(gfp & __GFP_NOWARN);
 
+	if (cb) {
+		n = kmalloc(sizeof(*n), gfp);
+		if (!n)
+			return NULL;
+	}
+
 	/*
 	 * There is now a minimum allocation size of PCPU_MIN_ALLOC_SIZE,
 	 * therefore alignment must be a minimum of that many bytes.
@@ -1847,6 +2011,13 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 
 	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size);
 
+	if (cb) {
+		n->ptr = ptr;
+		n->cb = cb;
+		n->data = data;
+		pcpu_cpuhp_register(chunk, n);
+	}
+
 	return ptr;
 
 fail_unlock:
@@ -1870,6 +2041,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 	}
 
 	pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
+	kfree(n);
 
 	return NULL;
 }
@@ -1891,7 +2063,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
  */
 void __percpu *__alloc_percpu_gfp(size_t size, size_t align, gfp_t gfp)
 {
-	return pcpu_alloc(size, align, false, gfp);
+	return pcpu_alloc(size, align, false, gfp, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(__alloc_percpu_gfp);
 
@@ -1904,7 +2076,7 @@ EXPORT_SYMBOL_GPL(__alloc_percpu_gfp);
  */
 void __percpu *__alloc_percpu(size_t size, size_t align)
 {
-	return pcpu_alloc(size, align, false, GFP_KERNEL);
+	return pcpu_alloc(size, align, false, GFP_KERNEL, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(__alloc_percpu);
 
@@ -1926,7 +2098,33 @@ EXPORT_SYMBOL_GPL(__alloc_percpu);
  */
 void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
 {
-	return pcpu_alloc(size, align, true, GFP_KERNEL);
+	return pcpu_alloc(size, align, true, GFP_KERNEL, NULL, NULL);
+}
+
+/**
+ * alloc_percpu variants that take a callback to handle
+ * any required initialization to the percpu ptr corresponding
+ * to the cpu that is coming online.
+ * @cb: This callback will be called whenever a cpu is hotplugged.
+ */
+void __percpu *__alloc_percpu_gfp_cb(size_t size, size_t align, gfp_t gfp,
+				     pcpu_cpuhp_fn_t cb, void *data)
+{
+	return pcpu_alloc(size, align, false, gfp, cb, data);
+}
+EXPORT_SYMBOL_GPL(__alloc_percpu_gfp_cb);
+
+void __percpu *__alloc_percpu_cb(size_t size, size_t align, pcpu_cpuhp_fn_t cb,
+				 void *data)
+{
+	return pcpu_alloc(size, align, false, GFP_KERNEL, cb, data);
+}
+EXPORT_SYMBOL_GPL(__alloc_percpu_cb);
+
+void __percpu *__alloc_reserved_percpu_cb(size_t size, size_t align,
+					  pcpu_cpuhp_fn_t cb, void *data)
+{
+	return pcpu_alloc(size, align, true, GFP_KERNEL, cb, data);
 }
 
 /**
@@ -2116,6 +2314,7 @@ void free_percpu(void __percpu *ptr)
 			}
 	}
 
+	pcpu_cpuhp_deregister(chunk, ptr);
 	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
 
 	spin_unlock_irqrestore(&pcpu_lock, flags);
@@ -2426,6 +2625,8 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 	}								\
 } while (0)
 
+	PCPU_SETUP_BUG_ON(percpu_hotplug_setup() < 0);
+
 	/* sanity checks */
 	PCPU_SETUP_BUG_ON(ai->nr_groups <= 0);
 #ifdef CONFIG_SMP
-- 
2.31.1


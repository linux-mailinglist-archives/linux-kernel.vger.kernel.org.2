Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FDC399761
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFCBL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:11:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51380 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbhFCBLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:11:25 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 153156rl001840
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jun 2021 18:09:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ARhb7LuCIq1opteq5fdrP+OmJU26ZSKi5fmg3xeQfV8=;
 b=Qa84P06Ft1xm8Sh/mB88T/wvkHirwZ5QfqHfp/PV9YqPDnRi62Ydxqavk0wpnRCxBvYe
 GaCRXhXV94X4unqhXpEqt+4Fn+Luy16J8h0x3x2mUVnAS320nrPsFrZ4BRNCPd46sZn6
 NYLfT2UsUM/GYnb1VyjOZiFdqnU0Eja2bwE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38wn32ubkg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 18:09:41 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 18:09:40 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id D500A7F1B34B; Wed,  2 Jun 2021 18:09:32 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 3/3] percpu: rework memcg accounting
Date:   Wed, 2 Jun 2021 18:09:31 -0700
Message-ID: <20210603010931.1472512-4-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603010931.1472512-1-guro@fb.com>
References: <20210603010931.1472512-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: uhPIV1kyZoe0O3TwOVYUXtKG9k_6QC79
X-Proofpoint-ORIG-GUID: uhPIV1kyZoe0O3TwOVYUXtKG9k_6QC79
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of the memcg accounting of the percpu
memory is based on the idea of having two separate sets of chunks for
accounted and non-accounted memory. This approach has an advantage
of not wasting any extra memory for memcg data for non-accounted
chunks, however it complicates the code and leads to a higher chunks
number due to a lower chunk utilization.

Instead of having two chunk types it's possible to declare all* chunks
memcg-aware unless the kernel memory accounting is disabled globally
by a boot option. The size of objcg_array is usually small in
comparison to chunks themselves (it obviously depends on the number of
CPUs), so even if some chunk will have no accounted allocations, the
memory waste isn't significant and will likely be compensated by
a higher chunk utilization. Also, with time more and more percpu
allocations will likely become accounted.

* The first chunk is initialized before the memory cgroup subsystem,
  so we don't know for sure whether we need to allocate obj_cgroups.
  Because it's small, let's make it free for use. Then we don't need
  to allocate obj_cgroups for it.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu-internal.h |  52 +----------------
 mm/percpu-km.c       |   5 +-
 mm/percpu-stats.c    |  46 +++++----------
 mm/percpu-vm.c       |  11 ++--
 mm/percpu.c          | 133 +++++++++++++++++--------------------------
 5 files changed, 75 insertions(+), 172 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 10604dce806f..b6dc22904088 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -5,25 +5,6 @@
 #include <linux/types.h>
 #include <linux/percpu.h>
=20
-/*
- * There are two chunk types: root and memcg-aware.
- * Chunks of each type have separate slots list.
- *
- * Memcg-aware chunks have an attached vector of obj_cgroup pointers, wh=
ich is
- * used to store memcg membership data of a percpu object.  Obj_cgroups =
are
- * ref-counted pointers to a memory cgroup with an ability to switch dyn=
amically
- * to the parent memory cgroup.  This allows to reclaim a deleted memory=
 cgroup
- * without reclaiming of all outstanding objects, which hold a reference=
 at it.
- */
-enum pcpu_chunk_type {
-	PCPU_CHUNK_ROOT,
-#ifdef CONFIG_MEMCG_KMEM
-	PCPU_CHUNK_MEMCG,
-#endif
-	PCPU_NR_CHUNK_TYPES,
-	PCPU_FAIL_ALLOC =3D PCPU_NR_CHUNK_TYPES
-};
-
 /*
  * pcpu_block_md is the metadata block struct.
  * Each chunk's bitmap is split into a number of full blocks.
@@ -91,7 +72,7 @@ extern struct list_head *pcpu_chunk_lists;
 extern int pcpu_nr_slots;
 extern int pcpu_sidelined_slot;
 extern int pcpu_to_depopulate_slot;
-extern int pcpu_nr_empty_pop_pages[];
+extern int pcpu_nr_empty_pop_pages;
=20
 extern struct pcpu_chunk *pcpu_first_chunk;
 extern struct pcpu_chunk *pcpu_reserved_chunk;
@@ -132,37 +113,6 @@ static inline int pcpu_chunk_map_bits(struct pcpu_ch=
unk *chunk)
 	return pcpu_nr_pages_to_map_bits(chunk->nr_pages);
 }
=20
-#ifdef CONFIG_MEMCG_KMEM
-static inline enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *ch=
unk)
-{
-	if (chunk->obj_cgroups)
-		return PCPU_CHUNK_MEMCG;
-	return PCPU_CHUNK_ROOT;
-}
-
-static inline bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
-{
-	return chunk_type =3D=3D PCPU_CHUNK_MEMCG;
-}
-
-#else
-static inline enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *ch=
unk)
-{
-	return PCPU_CHUNK_ROOT;
-}
-
-static inline bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
-{
-	return false;
-}
-#endif
-
-static inline struct list_head *pcpu_chunk_list(enum pcpu_chunk_type chu=
nk_type)
-{
-	return &pcpu_chunk_lists[pcpu_nr_slots *
-				 pcpu_is_memcg_chunk(chunk_type)];
-}
-
 #ifdef CONFIG_PERCPU_STATS
=20
 #include <linux/spinlock.h>
diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index c84a9f781a6c..c9d529dc7651 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -44,8 +44,7 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *ch=
unk,
 	/* nada */
 }
=20
-static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
-					    gfp_t gfp)
+static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 {
 	const int nr_pages =3D pcpu_group_sizes[0] >> PAGE_SHIFT;
 	struct pcpu_chunk *chunk;
@@ -53,7 +52,7 @@ static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_c=
hunk_type type,
 	unsigned long flags;
 	int i;
=20
-	chunk =3D pcpu_alloc_chunk(type, gfp);
+	chunk =3D pcpu_alloc_chunk(gfp);
 	if (!chunk)
 		return NULL;
=20
diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
index 2125981acfb9..c6bd092ff7a3 100644
--- a/mm/percpu-stats.c
+++ b/mm/percpu-stats.c
@@ -34,15 +34,11 @@ static int find_max_nr_alloc(void)
 {
 	struct pcpu_chunk *chunk;
 	int slot, max_nr_alloc;
-	enum pcpu_chunk_type type;
=20
 	max_nr_alloc =3D 0;
-	for (type =3D 0; type < PCPU_NR_CHUNK_TYPES; type++)
-		for (slot =3D 0; slot < pcpu_nr_slots; slot++)
-			list_for_each_entry(chunk, &pcpu_chunk_list(type)[slot],
-					    list)
-				max_nr_alloc =3D max(max_nr_alloc,
-						   chunk->nr_alloc);
+	for (slot =3D 0; slot < pcpu_nr_slots; slot++)
+		list_for_each_entry(chunk, &pcpu_chunk_lists[slot], list)
+			max_nr_alloc =3D max(max_nr_alloc, chunk->nr_alloc);
=20
 	return max_nr_alloc;
 }
@@ -133,9 +129,6 @@ static void chunk_map_stats(struct seq_file *m, struc=
t pcpu_chunk *chunk,
 	P("cur_min_alloc", cur_min_alloc);
 	P("cur_med_alloc", cur_med_alloc);
 	P("cur_max_alloc", cur_max_alloc);
-#ifdef CONFIG_MEMCG_KMEM
-	P("memcg_aware", pcpu_is_memcg_chunk(pcpu_chunk_type(chunk)));
-#endif
 	seq_putc(m, '\n');
 }
=20
@@ -144,8 +137,6 @@ static int percpu_stats_show(struct seq_file *m, void=
 *v)
 	struct pcpu_chunk *chunk;
 	int slot, max_nr_alloc;
 	int *buffer;
-	enum pcpu_chunk_type type;
-	int nr_empty_pop_pages;
=20
 alloc_buffer:
 	spin_lock_irq(&pcpu_lock);
@@ -166,10 +157,6 @@ static int percpu_stats_show(struct seq_file *m, voi=
d *v)
 		goto alloc_buffer;
 	}
=20
-	nr_empty_pop_pages =3D 0;
-	for (type =3D 0; type < PCPU_NR_CHUNK_TYPES; type++)
-		nr_empty_pop_pages +=3D pcpu_nr_empty_pop_pages[type];
-
 #define PL(X)								\
 	seq_printf(m, "  %-20s: %12lld\n", #X, (long long int)pcpu_stats_ai.X)
=20
@@ -201,7 +188,7 @@ static int percpu_stats_show(struct seq_file *m, void=
 *v)
 	PU(nr_max_chunks);
 	PU(min_alloc_size);
 	PU(max_alloc_size);
-	P("empty_pop_pages", nr_empty_pop_pages);
+	P("empty_pop_pages", pcpu_nr_empty_pop_pages);
 	seq_putc(m, '\n');
=20
 #undef PU
@@ -215,20 +202,17 @@ static int percpu_stats_show(struct seq_file *m, vo=
id *v)
 		chunk_map_stats(m, pcpu_reserved_chunk, buffer);
 	}
=20
-	for (type =3D 0; type < PCPU_NR_CHUNK_TYPES; type++) {
-		for (slot =3D 0; slot < pcpu_nr_slots; slot++) {
-			list_for_each_entry(chunk, &pcpu_chunk_list(type)[slot],
-					    list) {
-				if (chunk =3D=3D pcpu_first_chunk)
-					seq_puts(m, "Chunk: <- First Chunk\n");
-				else if (slot =3D=3D pcpu_to_depopulate_slot)
-					seq_puts(m, "Chunk (to_depopulate)\n");
-				else if (slot =3D=3D pcpu_sidelined_slot)
-					seq_puts(m, "Chunk (sidelined):\n");
-				else
-					seq_puts(m, "Chunk:\n");
-				chunk_map_stats(m, chunk, buffer);
-			}
+	for (slot =3D 0; slot < pcpu_nr_slots; slot++) {
+		list_for_each_entry(chunk, &pcpu_chunk_lists[slot], list) {
+			if (chunk =3D=3D pcpu_first_chunk)
+				seq_puts(m, "Chunk: <- First Chunk\n");
+			else if (slot =3D=3D pcpu_to_depopulate_slot)
+				seq_puts(m, "Chunk (to_depopulate)\n");
+			else if (slot =3D=3D pcpu_sidelined_slot)
+				seq_puts(m, "Chunk (sidelined):\n");
+			else
+				seq_puts(m, "Chunk:\n");
+			chunk_map_stats(m, chunk, buffer);
 		}
 	}
=20
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index c75f6f24f2d5..e59566b949d1 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -328,13 +328,12 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk=
 *chunk,
 	pcpu_free_pages(chunk, pages, page_start, page_end);
 }
=20
-static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
-					    gfp_t gfp)
+static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 {
 	struct pcpu_chunk *chunk;
 	struct vm_struct **vms;
=20
-	chunk =3D pcpu_alloc_chunk(type, gfp);
+	chunk =3D pcpu_alloc_chunk(gfp);
 	if (!chunk)
 		return NULL;
=20
@@ -403,7 +402,7 @@ static bool pcpu_should_reclaim_chunk(struct pcpu_chu=
nk *chunk)
 	 * chunk, move it to the to_depopulate list.
 	 */
 	return ((chunk->isolated && chunk->nr_empty_pop_pages) ||
-		(pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
-		 PCPU_EMPTY_POP_PAGES_HIGH + chunk->nr_empty_pop_pages &&
-		chunk->nr_empty_pop_pages >=3D chunk->nr_pages / 4));
+		(pcpu_nr_empty_pop_pages > PCPU_EMPTY_POP_PAGES_HIGH +
+		 chunk->nr_empty_pop_pages &&
+		 chunk->nr_empty_pop_pages >=3D chunk->nr_pages / 4));
 }
diff --git a/mm/percpu.c b/mm/percpu.c
index 3135e56ce8d4..e77e3fe45b38 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -179,10 +179,10 @@ struct list_head *pcpu_chunk_lists __ro_after_init;=
 /* chunk list slots */
 static LIST_HEAD(pcpu_map_extend_chunks);
=20
 /*
- * The number of empty populated pages by chunk type, protected by pcpu_=
lock.
+ * The number of empty populated pages, protected by pcpu_lock.
  * The reserved chunk doesn't contribute to the count.
  */
-int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
+int pcpu_nr_empty_pop_pages;
=20
 /*
  * The number of populated pages in use by the allocator, protected by
@@ -532,13 +532,10 @@ static void __pcpu_chunk_move(struct pcpu_chunk *ch=
unk, int slot,
 			      bool move_front)
 {
 	if (chunk !=3D pcpu_reserved_chunk) {
-		struct list_head *pcpu_slot;
-
-		pcpu_slot =3D pcpu_chunk_list(pcpu_chunk_type(chunk));
 		if (move_front)
-			list_move(&chunk->list, &pcpu_slot[slot]);
+			list_move(&chunk->list, &pcpu_chunk_lists[slot]);
 		else
-			list_move_tail(&chunk->list, &pcpu_slot[slot]);
+			list_move_tail(&chunk->list, &pcpu_chunk_lists[slot]);
 	}
 }
=20
@@ -574,27 +571,22 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *=
chunk, int oslot)
=20
 static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
 {
-	enum pcpu_chunk_type type =3D pcpu_chunk_type(chunk);
-	struct list_head *pcpu_slot =3D pcpu_chunk_list(type);
-
 	lockdep_assert_held(&pcpu_lock);
=20
 	if (!chunk->isolated) {
 		chunk->isolated =3D true;
-		pcpu_nr_empty_pop_pages[type] -=3D chunk->nr_empty_pop_pages;
+		pcpu_nr_empty_pop_pages -=3D chunk->nr_empty_pop_pages;
 	}
-	list_move(&chunk->list, &pcpu_slot[pcpu_to_depopulate_slot]);
+	list_move(&chunk->list, &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
 }
=20
 static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
 {
-	enum pcpu_chunk_type type =3D pcpu_chunk_type(chunk);
-
 	lockdep_assert_held(&pcpu_lock);
=20
 	if (chunk->isolated) {
 		chunk->isolated =3D false;
-		pcpu_nr_empty_pop_pages[type] +=3D chunk->nr_empty_pop_pages;
+		pcpu_nr_empty_pop_pages +=3D chunk->nr_empty_pop_pages;
 		pcpu_chunk_relocate(chunk, -1);
 	}
 }
@@ -612,7 +604,7 @@ static inline void pcpu_update_empty_pages(struct pcp=
u_chunk *chunk, int nr)
 {
 	chunk->nr_empty_pop_pages +=3D nr;
 	if (chunk !=3D pcpu_reserved_chunk && !chunk->isolated)
-		pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] +=3D nr;
+		pcpu_nr_empty_pop_pages +=3D nr;
 }
=20
 /*
@@ -1405,7 +1397,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_=
chunk(unsigned long tmp_addr,
 		      alloc_size);
=20
 #ifdef CONFIG_MEMCG_KMEM
-	/* first chunk isn't memcg-aware */
+	/* first chunk is free to use */
 	chunk->obj_cgroups =3D NULL;
 #endif
 	pcpu_init_md_blocks(chunk);
@@ -1447,7 +1439,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_=
chunk(unsigned long tmp_addr,
 	return chunk;
 }
=20
-static struct pcpu_chunk *pcpu_alloc_chunk(enum pcpu_chunk_type type, gf=
p_t gfp)
+static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 {
 	struct pcpu_chunk *chunk;
 	int region_bits;
@@ -1476,7 +1468,7 @@ static struct pcpu_chunk *pcpu_alloc_chunk(enum pcp=
u_chunk_type type, gfp_t gfp)
 		goto md_blocks_fail;
=20
 #ifdef CONFIG_MEMCG_KMEM
-	if (pcpu_is_memcg_chunk(type)) {
+	if (!mem_cgroup_kmem_disabled()) {
 		chunk->obj_cgroups =3D
 			pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
 					sizeof(struct obj_cgroup *), gfp);
@@ -1589,8 +1581,7 @@ static int pcpu_populate_chunk(struct pcpu_chunk *c=
hunk,
 			       int page_start, int page_end, gfp_t gfp);
 static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
 				  int page_start, int page_end);
-static struct pcpu_chunk *pcpu_create_chunk(enum pcpu_chunk_type type,
-					    gfp_t gfp);
+static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp);
 static void pcpu_destroy_chunk(struct pcpu_chunk *chunk);
 static struct page *pcpu_addr_to_page(void *addr);
 static int __init pcpu_verify_alloc_info(const struct pcpu_alloc_info *a=
i);
@@ -1633,25 +1624,25 @@ static struct pcpu_chunk *pcpu_chunk_addr_search(=
void *addr)
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
-static enum pcpu_chunk_type pcpu_memcg_pre_alloc_hook(size_t size, gfp_t=
 gfp,
-						     struct obj_cgroup **objcgp)
+static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
+				      struct obj_cgroup **objcgp)
 {
 	struct obj_cgroup *objcg;
=20
 	if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT))
-		return PCPU_CHUNK_ROOT;
+		return true;
=20
 	objcg =3D get_obj_cgroup_from_current();
 	if (!objcg)
-		return PCPU_CHUNK_ROOT;
+		return true;
=20
 	if (obj_cgroup_charge(objcg, gfp, size * num_possible_cpus())) {
 		obj_cgroup_put(objcg);
-		return PCPU_FAIL_ALLOC;
+		return false;
 	}
=20
 	*objcgp =3D objcg;
-	return PCPU_CHUNK_MEMCG;
+	return true;
 }
=20
 static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
@@ -1661,7 +1652,7 @@ static void pcpu_memcg_post_alloc_hook(struct obj_c=
group *objcg,
 	if (!objcg)
 		return;
=20
-	if (chunk) {
+	if (likely(chunk && chunk->obj_cgroups)) {
 		chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] =3D objcg;
=20
 		rcu_read_lock();
@@ -1678,10 +1669,12 @@ static void pcpu_memcg_free_hook(struct pcpu_chun=
k *chunk, int off, size_t size)
 {
 	struct obj_cgroup *objcg;
=20
-	if (!pcpu_is_memcg_chunk(pcpu_chunk_type(chunk)))
+	if (unlikely(!chunk->obj_cgroups))
 		return;
=20
 	objcg =3D chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
+	if (!objcg)
+		return;
 	chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] =3D NULL;
=20
 	obj_cgroup_uncharge(objcg, size * num_possible_cpus());
@@ -1695,10 +1688,10 @@ static void pcpu_memcg_free_hook(struct pcpu_chun=
k *chunk, int off, size_t size)
 }
=20
 #else /* CONFIG_MEMCG_KMEM */
-static enum pcpu_chunk_type
+static bool
 pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp, struct obj_cgroup **ob=
jcgp)
 {
-	return PCPU_CHUNK_ROOT;
+	return true;
 }
=20
 static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
@@ -1733,8 +1726,6 @@ static void __percpu *pcpu_alloc(size_t size, size_=
t align, bool reserved,
 	gfp_t pcpu_gfp;
 	bool is_atomic;
 	bool do_warn;
-	enum pcpu_chunk_type type;
-	struct list_head *pcpu_slot;
 	struct obj_cgroup *objcg =3D NULL;
 	static int warn_limit =3D 10;
 	struct pcpu_chunk *chunk, *next;
@@ -1770,10 +1761,8 @@ static void __percpu *pcpu_alloc(size_t size, size=
_t align, bool reserved,
 		return NULL;
 	}
=20
-	type =3D pcpu_memcg_pre_alloc_hook(size, gfp, &objcg);
-	if (unlikely(type =3D=3D PCPU_FAIL_ALLOC))
+	if (unlikely(!pcpu_memcg_pre_alloc_hook(size, gfp, &objcg)))
 		return NULL;
-	pcpu_slot =3D pcpu_chunk_list(type);
=20
 	if (!is_atomic) {
 		/*
@@ -1812,7 +1801,7 @@ static void __percpu *pcpu_alloc(size_t size, size_=
t align, bool reserved,
 restart:
 	/* search through normal chunks */
 	for (slot =3D pcpu_size_to_slot(size); slot <=3D pcpu_free_slot; slot++=
) {
-		list_for_each_entry_safe(chunk, next, &pcpu_slot[slot], list) {
+		list_for_each_entry_safe(chunk, next, &pcpu_chunk_lists[slot], list) {
 			off =3D pcpu_find_block_fit(chunk, bits, bit_align,
 						  is_atomic);
 			if (off < 0) {
@@ -1841,8 +1830,8 @@ static void __percpu *pcpu_alloc(size_t size, size_=
t align, bool reserved,
 		goto fail;
 	}
=20
-	if (list_empty(&pcpu_slot[pcpu_free_slot])) {
-		chunk =3D pcpu_create_chunk(type, pcpu_gfp);
+	if (list_empty(&pcpu_chunk_lists[pcpu_free_slot])) {
+		chunk =3D pcpu_create_chunk(pcpu_gfp);
 		if (!chunk) {
 			err =3D "failed to allocate new chunk";
 			goto fail;
@@ -1886,7 +1875,7 @@ static void __percpu *pcpu_alloc(size_t size, size_=
t align, bool reserved,
 		mutex_unlock(&pcpu_alloc_mutex);
 	}
=20
-	if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_LOW)
+	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
 		pcpu_schedule_balance_work();
=20
 	/* clear the areas and return address relative to base address */
@@ -1985,18 +1974,16 @@ void __percpu *__alloc_reserved_percpu(size_t siz=
e, size_t align)
=20
 /**
  * pcpu_balance_free - manage the amount of free chunks
- * @type: chunk type
  * @empty_only: free chunks only if there are no populated pages
  *
  * If empty_only is %false, reclaim all fully free chunks regardless of =
the
  * number of populated pages.  Otherwise, only reclaim chunks that have =
no
  * populated pages.
  */
-static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only=
)
+static void pcpu_balance_free(bool empty_only)
 {
 	LIST_HEAD(to_free);
-	struct list_head *pcpu_slot =3D pcpu_chunk_list(type);
-	struct list_head *free_head =3D &pcpu_slot[pcpu_free_slot];
+	struct list_head *free_head =3D &pcpu_chunk_lists[pcpu_free_slot];
 	struct pcpu_chunk *chunk, *next;
=20
 	/*
@@ -2035,7 +2022,6 @@ static void pcpu_balance_free(enum pcpu_chunk_type =
type, bool empty_only)
=20
 /**
  * pcpu_balance_populated - manage the amount of populated pages
- * @type: chunk type
  *
  * Maintain a certain amount of populated pages to satisfy atomic alloca=
tions.
  * It is possible that this is called when physical memory is scarce cau=
sing
@@ -2043,11 +2029,10 @@ static void pcpu_balance_free(enum pcpu_chunk_typ=
e type, bool empty_only)
  * allocation causes the failure as it is possible that requests can be
  * serviced from already backed regions.
  */
-static void pcpu_balance_populated(enum pcpu_chunk_type type)
+static void pcpu_balance_populated(void)
 {
 	/* gfp flags passed to underlying allocators */
 	const gfp_t gfp =3D GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
-	struct list_head *pcpu_slot =3D pcpu_chunk_list(type);
 	struct pcpu_chunk *chunk;
 	int slot, nr_to_pop, ret;
=20
@@ -2068,7 +2053,7 @@ static void pcpu_balance_populated(enum pcpu_chunk_=
type type)
 		pcpu_atomic_alloc_failed =3D false;
 	} else {
 		nr_to_pop =3D clamp(PCPU_EMPTY_POP_PAGES_HIGH -
-				  pcpu_nr_empty_pop_pages[type],
+				  pcpu_nr_empty_pop_pages,
 				  0, PCPU_EMPTY_POP_PAGES_HIGH);
 	}
=20
@@ -2079,7 +2064,7 @@ static void pcpu_balance_populated(enum pcpu_chunk_=
type type)
 			break;
=20
 		spin_lock_irq(&pcpu_lock);
-		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
+		list_for_each_entry(chunk, &pcpu_chunk_lists[slot], list) {
 			nr_unpop =3D chunk->nr_pages - chunk->nr_populated;
 			if (nr_unpop)
 				break;
@@ -2111,7 +2096,7 @@ static void pcpu_balance_populated(enum pcpu_chunk_=
type type)
=20
 	if (nr_to_pop) {
 		/* ran out of chunks to populate, create a new one and retry */
-		chunk =3D pcpu_create_chunk(type, gfp);
+		chunk =3D pcpu_create_chunk(gfp);
 		if (chunk) {
 			spin_lock_irq(&pcpu_lock);
 			pcpu_chunk_relocate(chunk, -1);
@@ -2123,7 +2108,6 @@ static void pcpu_balance_populated(enum pcpu_chunk_=
type type)
=20
 /**
  * pcpu_reclaim_populated - scan over to_depopulate chunks and free empt=
y pages
- * @type: chunk type
  *
  * Scan over chunks in the depopulate list and try to release unused pop=
ulated
  * pages back to the system.  Depopulated chunks are sidelined to preven=
t
@@ -2133,9 +2117,8 @@ static void pcpu_balance_populated(enum pcpu_chunk_=
type type)
  * Each chunk is scanned in the reverse order to keep populated pages cl=
ose to
  * the beginning of the chunk.
  */
-static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
+static void pcpu_reclaim_populated(void)
 {
-	struct list_head *pcpu_slot =3D pcpu_chunk_list(type);
 	struct pcpu_chunk *chunk;
 	struct pcpu_block_md *block;
 	int i, end;
@@ -2149,8 +2132,8 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_=
type type)
 	 * other accessor is the free path which only returns area back to the
 	 * allocator not touching the populated bitmap.
 	 */
-	while (!list_empty(&pcpu_slot[pcpu_to_depopulate_slot])) {
-		chunk =3D list_first_entry(&pcpu_slot[pcpu_to_depopulate_slot],
+	while (!list_empty(&pcpu_chunk_lists[pcpu_to_depopulate_slot])) {
+		chunk =3D list_first_entry(&pcpu_chunk_lists[pcpu_to_depopulate_slot],
 					 struct pcpu_chunk, list);
 		WARN_ON(chunk->immutable);
=20
@@ -2164,8 +2147,7 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_=
type type)
 				break;
=20
 			/* reintegrate chunk to prevent atomic alloc failures */
-			if (pcpu_nr_empty_pop_pages[type] <
-			    PCPU_EMPTY_POP_PAGES_HIGH) {
+			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
 				pcpu_reintegrate_chunk(chunk);
 				goto restart;
 			}
@@ -2205,7 +2187,7 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_=
type type)
 			pcpu_reintegrate_chunk(chunk);
 		else
 			list_move(&chunk->list,
-				  &pcpu_slot[pcpu_sidelined_slot]);
+				  &pcpu_chunk_lists[pcpu_sidelined_slot]);
 	}
=20
 	spin_unlock_irq(&pcpu_lock);
@@ -2221,8 +2203,6 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_=
type type)
  */
 static void pcpu_balance_workfn(struct work_struct *work)
 {
-	enum pcpu_chunk_type type;
-
 	/*
 	 * pcpu_balance_free() is called twice because the first time we may
 	 * trim pages in the active pcpu_nr_empty_pop_pages which may cause us
@@ -2230,14 +2210,12 @@ static void pcpu_balance_workfn(struct work_struc=
t *work)
 	 * to move fully free chunks to the active list to be freed if
 	 * appropriate.
 	 */
-	for (type =3D 0; type < PCPU_NR_CHUNK_TYPES; type++) {
-		mutex_lock(&pcpu_alloc_mutex);
-		pcpu_balance_free(type, false);
-		pcpu_reclaim_populated(type);
-		pcpu_balance_populated(type);
-		pcpu_balance_free(type, true);
-		mutex_unlock(&pcpu_alloc_mutex);
-	}
+	mutex_lock(&pcpu_alloc_mutex);
+	pcpu_balance_free(false);
+	pcpu_reclaim_populated();
+	pcpu_balance_populated();
+	pcpu_balance_free(true);
+	mutex_unlock(&pcpu_alloc_mutex);
 }
=20
 /**
@@ -2256,7 +2234,6 @@ void free_percpu(void __percpu *ptr)
 	unsigned long flags;
 	int size, off;
 	bool need_balance =3D false;
-	struct list_head *pcpu_slot;
=20
 	if (!ptr)
 		return;
@@ -2272,8 +2249,6 @@ void free_percpu(void __percpu *ptr)
=20
 	size =3D pcpu_free_area(chunk, off);
=20
-	pcpu_slot =3D pcpu_chunk_list(pcpu_chunk_type(chunk));
-
 	pcpu_memcg_free_hook(chunk, off, size);
=20
 	/*
@@ -2284,7 +2259,7 @@ void free_percpu(void __percpu *ptr)
 	if (!chunk->isolated && chunk->free_bytes =3D=3D pcpu_unit_size) {
 		struct pcpu_chunk *pos;
=20
-		list_for_each_entry(pos, &pcpu_slot[pcpu_free_slot], list)
+		list_for_each_entry(pos, &pcpu_chunk_lists[pcpu_free_slot], list)
 			if (pos !=3D chunk) {
 				need_balance =3D true;
 				break;
@@ -2592,7 +2567,6 @@ void __init pcpu_setup_first_chunk(const struct pcp=
u_alloc_info *ai,
 	int map_size;
 	unsigned long tmp_addr;
 	size_t alloc_size;
-	enum pcpu_chunk_type type;
=20
 #define PCPU_SETUP_BUG_ON(cond)	do {					\
 	if (unlikely(cond)) {						\
@@ -2716,17 +2690,14 @@ void __init pcpu_setup_first_chunk(const struct p=
cpu_alloc_info *ai,
 	pcpu_to_depopulate_slot =3D pcpu_free_slot + 1;
 	pcpu_nr_slots =3D pcpu_to_depopulate_slot + 1;
 	pcpu_chunk_lists =3D memblock_alloc(pcpu_nr_slots *
-					  sizeof(pcpu_chunk_lists[0]) *
-					  PCPU_NR_CHUNK_TYPES,
+					  sizeof(pcpu_chunk_lists[0]),
 					  SMP_CACHE_BYTES);
 	if (!pcpu_chunk_lists)
 		panic("%s: Failed to allocate %zu bytes\n", __func__,
-		      pcpu_nr_slots * sizeof(pcpu_chunk_lists[0]) *
-		      PCPU_NR_CHUNK_TYPES);
+		      pcpu_nr_slots * sizeof(pcpu_chunk_lists[0]));
=20
-	for (type =3D 0; type < PCPU_NR_CHUNK_TYPES; type++)
-		for (i =3D 0; i < pcpu_nr_slots; i++)
-			INIT_LIST_HEAD(&pcpu_chunk_list(type)[i]);
+	for (i =3D 0; i < pcpu_nr_slots; i++)
+		INIT_LIST_HEAD(&pcpu_chunk_lists[i]);
=20
 	/*
 	 * The end of the static region needs to be aligned with the
@@ -2763,7 +2734,7 @@ void __init pcpu_setup_first_chunk(const struct pcp=
u_alloc_info *ai,
=20
 	/* link the first chunk in */
 	pcpu_first_chunk =3D chunk;
-	pcpu_nr_empty_pop_pages[PCPU_CHUNK_ROOT] =3D pcpu_first_chunk->nr_empty=
_pop_pages;
+	pcpu_nr_empty_pop_pages =3D pcpu_first_chunk->nr_empty_pop_pages;
 	pcpu_chunk_relocate(pcpu_first_chunk, -1);
=20
 	/* include all regions of the first chunk */
--=20
2.31.1


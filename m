Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36AF348137
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbhCXTHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:07:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17320 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237778AbhCXTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:06:36 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OJ4wiF000640
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bi+ZbmtxcdgH0pfzfRcg/J0Vbgya0T1siOkC3SlTLHI=;
 b=ZbTat/A0SSIUolp64PuqCTZDscnZ9v78UQGun14zkAPxf3E7QewnBPfPaKPx7HR+qH++
 lD2PIbqMZy9oUgduGJlUupNNRrvZN9Y52R4+xN+zcSqtZWV0cuHiGlOT4CWl0MyQ7E9N
 dLQhzIm++HCgCVDz8EOWrWZmiTJYkKkQVSU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37fpjt6t8a-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:36 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 12:06:35 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 8E1CF57ACF2E; Wed, 24 Mar 2021 12:06:33 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 3/4] percpu: on demand chunk depopulation
Date:   Wed, 24 Mar 2021 12:06:25 -0700
Message-ID: <20210324190626.564297-4-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324190626.564297-1-guro@fb.com>
References: <20210324190626.564297-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_13:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To return unused memory to the system schedule an async
depopulation of percpu chunks.

To balance between scanning too much and creating an overhead because
of the pcpu_lock contention and scanning not enough, let's track an
amount of chunks to scan and mark chunks which are potentially a good
target for the depopulation with a new boolean flag.  The async
depopulation work will clear the flag after trying to depopulate a
chunk (successfully or not).

This commit suggest the following logic: if a chunk
  1) has more than 1/4 of total pages free and populated
  2) isn't a reserved chunk
  3) isn't entirely free
  4) isn't alone in the corresponding slot
it's a good target for depopulation.

If there are 2 or more of such chunks, an async depopulation
is scheduled.

Because chunk population and depopulation are opposite processes
which make a little sense together, split out the shrinking part of
pcpu_balance_populated() into pcpu_grow_populated() and make
pcpu_balance_populated() calling into pcpu_grow_populated() or
pcpu_shrink_populated() conditionally.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu-internal.h |   1 +
 mm/percpu.c          | 111 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 85 insertions(+), 27 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 18b768ac7dca..1c5b92af02eb 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -67,6 +67,7 @@ struct pcpu_chunk {
=20
 	void			*data;		/* chunk data */
 	bool			immutable;	/* no [de]population allowed */
+	bool			depopulate;	/* depopulation hint */
 	int			start_offset;	/* the overlap with the previous
 						   region to have a page aligned
 						   base_addr */
diff --git a/mm/percpu.c b/mm/percpu.c
index 015d076893f5..148137f0fc0b 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -178,6 +178,12 @@ static LIST_HEAD(pcpu_map_extend_chunks);
  */
 int pcpu_nr_empty_pop_pages;
=20
+/*
+ * Track the number of chunks with a lot of free memory.
+ * It's used to release unused pages to the system.
+ */
+static int pcpu_nr_chunks_to_depopulate;
+
 /*
  * The number of populated pages in use by the allocator, protected by
  * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a pag=
e gets
@@ -1955,6 +1961,11 @@ static void pcpu_balance_free(enum pcpu_chunk_type=
 type)
 		if (chunk =3D=3D list_first_entry(free_head, struct pcpu_chunk, list))
 			continue;
=20
+		if (chunk->depopulate) {
+			chunk->depopulate =3D false;
+			pcpu_nr_chunks_to_depopulate--;
+		}
+
 		list_move(&chunk->list, &to_free);
 	}
=20
@@ -1976,7 +1987,7 @@ static void pcpu_balance_free(enum pcpu_chunk_type =
type)
 }
=20
 /**
- * pcpu_balance_populated - manage the amount of populated pages
+ * pcpu_grow_populated - populate chunk(s) to satisfy atomic allocations
  * @type: chunk type
  *
  * Maintain a certain amount of populated pages to satisfy atomic alloca=
tions.
@@ -1985,35 +1996,15 @@ static void pcpu_balance_free(enum pcpu_chunk_typ=
e type)
  * allocation causes the failure as it is possible that requests can be
  * serviced from already backed regions.
  */
-static void pcpu_balance_populated(enum pcpu_chunk_type type)
+static void pcpu_grow_populated(enum pcpu_chunk_type type, int nr_to_pop=
)
 {
 	/* gfp flags passed to underlying allocators */
 	const gfp_t gfp =3D GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
 	struct list_head *pcpu_slot =3D pcpu_chunk_list(type);
 	struct pcpu_chunk *chunk;
-	int slot, nr_to_pop, ret;
+	int slot, ret;
=20
-	/*
-	 * Ensure there are certain number of free populated pages for
-	 * atomic allocs.  Fill up from the most packed so that atomic
-	 * allocs don't increase fragmentation.  If atomic allocation
-	 * failed previously, always populate the maximum amount.  This
-	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
-	 * failing indefinitely; however, large atomic allocs are not
-	 * something we support properly and can be highly unreliable and
-	 * inefficient.
-	 */
 retry_pop:
-	if (pcpu_atomic_alloc_failed) {
-		nr_to_pop =3D PCPU_EMPTY_POP_PAGES_HIGH;
-		/* best effort anyway, don't worry about synchronization */
-		pcpu_atomic_alloc_failed =3D false;
-	} else {
-		nr_to_pop =3D clamp(PCPU_EMPTY_POP_PAGES_HIGH -
-				  pcpu_nr_empty_pop_pages,
-				  0, PCPU_EMPTY_POP_PAGES_HIGH);
-	}
-
 	for (slot =3D pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot+=
+) {
 		unsigned int nr_unpop =3D 0, rs, re;
=20
@@ -2084,9 +2075,18 @@ static void pcpu_shrink_populated(enum pcpu_chunk_=
type type)
 		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
 			bool isolated =3D false;
=20
-			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH)
+			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH ||
+			    pcpu_nr_chunks_to_depopulate < 1)
 				break;
=20
+			/*
+			 * Don't try to depopulate a chunk again and again.
+			 */
+			if (!chunk->depopulate)
+				continue;
+			chunk->depopulate =3D false;
+			pcpu_nr_chunks_to_depopulate--;
+
 			for (i =3D 0, start =3D -1; i < chunk->nr_pages; i++) {
 				if (!chunk->nr_empty_pop_pages)
 					break;
@@ -2153,6 +2153,41 @@ static void pcpu_shrink_populated(enum pcpu_chunk_=
type type)
 	spin_unlock_irq(&pcpu_lock);
 }
=20
+/**
+ * pcpu_balance_populated - manage the amount of populated pages
+ * @type: chunk type
+ *
+ * Populate or depopulate chunks to maintain a certain amount
+ * of free pages to satisfy atomic allocations, but not waste
+ * large amounts of memory.
+ */
+static void pcpu_balance_populated(enum pcpu_chunk_type type)
+{
+	int nr_to_pop;
+
+	/*
+	 * Ensure there are certain number of free populated pages for
+	 * atomic allocs.  Fill up from the most packed so that atomic
+	 * allocs don't increase fragmentation.  If atomic allocation
+	 * failed previously, always populate the maximum amount.  This
+	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
+	 * failing indefinitely; however, large atomic allocs are not
+	 * something we support properly and can be highly unreliable and
+	 * inefficient.
+	 */
+	if (pcpu_atomic_alloc_failed) {
+		nr_to_pop =3D PCPU_EMPTY_POP_PAGES_HIGH;
+		/* best effort anyway, don't worry about synchronization */
+		pcpu_atomic_alloc_failed =3D false;
+		pcpu_grow_populated(type, nr_to_pop);
+	} else if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
+		nr_to_pop =3D PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages;
+		pcpu_grow_populated(type, nr_to_pop);
+	} else if (pcpu_nr_chunks_to_depopulate > 0) {
+		pcpu_shrink_populated(type);
+	}
+}
+
 /**
  * pcpu_balance_workfn - manage the amount of free chunks and populated =
pages
  * @work: unused
@@ -2188,6 +2223,7 @@ void free_percpu(void __percpu *ptr)
 	int size, off;
 	bool need_balance =3D false;
 	struct list_head *pcpu_slot;
+	struct pcpu_chunk *pos;
=20
 	if (!ptr)
 		return;
@@ -2207,15 +2243,36 @@ void free_percpu(void __percpu *ptr)
=20
 	pcpu_memcg_free_hook(chunk, off, size);
=20
-	/* if there are more than one fully free chunks, wake up grim reaper */
 	if (chunk->free_bytes =3D=3D pcpu_unit_size) {
-		struct pcpu_chunk *pos;
-
+		/*
+		 * If there are more than one fully free chunks,
+		 * wake up grim reaper.
+		 */
 		list_for_each_entry(pos, &pcpu_slot[pcpu_nr_slots - 1], list)
 			if (pos !=3D chunk) {
 				need_balance =3D true;
 				break;
 			}
+
+	} else if (chunk->nr_empty_pop_pages > chunk->nr_pages / 4) {
+		/*
+		 * If there is more than one chunk in the slot and
+		 * at least 1/4 of its pages are empty, mark the chunk
+		 * as a target for the depopulation. If there is more
+		 * than one chunk like this, schedule an async balancing.
+		 */
+		int nslot =3D pcpu_chunk_slot(chunk);
+
+		list_for_each_entry(pos, &pcpu_slot[nslot], list)
+			if (pos !=3D chunk && !chunk->depopulate &&
+			    !chunk->immutable) {
+				chunk->depopulate =3D true;
+				pcpu_nr_chunks_to_depopulate++;
+				break;
+			}
+
+		if (pcpu_nr_chunks_to_depopulate > 1)
+			need_balance =3D true;
 	}
=20
 	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
--=20
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7735745B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbhDGSaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:30:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39070 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233235AbhDGSaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:30:04 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137ITsTY026313
        for <linux-kernel@vger.kernel.org>; Wed, 7 Apr 2021 11:29:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ReA43FElu/qiPRvQ+Zvo0244Bs2e0pMf2a/L26yxIc4=;
 b=MP1VCdX0BcrjS+2ifbfCSSHgV/RoZ4bNB5mPktio7WgPKY/q4wEqEf4O0oOE+vzKFmY5
 10O+Tc/eqg27gVXZrYEOUg8BquvGc+nAPcarmD42yp6/9PMbwlleg+Cn+/lL+7jZBSk4
 9Anm1dx2PlUyIbCbF/7aeE4+9ZkOfVERvQ4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37seq89pyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:29:53 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 11:26:29 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 4EE4B5FEBC09; Wed,  7 Apr 2021 11:26:19 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 5/5] percpu: implement partial chunk depopulation
Date:   Wed, 7 Apr 2021 11:26:18 -0700
Message-ID: <20210407182618.2728388-6-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407182618.2728388-1-guro@fb.com>
References: <20210407182618.2728388-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: maeEDZdnx0rBz1iXQbBR2Mb_rvZsNZeH
X-Proofpoint-ORIG-GUID: maeEDZdnx0rBz1iXQbBR2Mb_rvZsNZeH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_09:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements partial depopulation of percpu chunks.

As now, a chunk can be depopulated only as a part of the final
destruction, if there are no more outstanding allocations. However
to minimize a memory waste it might be useful to depopulate a
partially filed chunk, if a small number of outstanding allocations
prevents the chunk from being fully reclaimed.

This patch implements the following depopulation process: it scans
over the chunk pages, looks for a range of empty and populated pages
and performs the depopulation. To avoid races with new allocations,
the chunk is previously isolated. After the depopulation the chunk is
sidelined to a special list or freed. New allocations can't be served
using a sidelined chunk. The chunk can be moved back to a corresponding
slot if there are not enough chunks with empty populated pages.

The depopulation is scheduled on the free path. Is the chunk:
  1) has more than 1/4 of total pages free and populated
  2) the system has enough free percpu pages aside of this chunk
  3) isn't the reserved chunk
  4) isn't the first chunk
  5) isn't entirely free
it's a good target for depopulation. If it's already depopulated
but got free populated pages, it's a good target too.
The chunk is moved to a special pcpu_depopulate_list, chunk->isolate
flag is set and the async balancing is scheduled.

The async balancing moves pcpu_depopulate_list to a local list
(because pcpu_depopulate_list can be changed when pcpu_lock is
releases), and then tries to depopulate each chunk.  The depopulation
is performed in the reverse direction to keep populated pages close to
the beginning, if the global number of empty pages is reached.
Depopulated chunks are sidelined to prevent further allocations.
Skipped and fully empty chunks are returned to the corresponding slot.

On the allocation path, if there are no suitable chunks found,
the list of sidelined chunks in scanned prior to creating a new chunk.
If there is a good sidelined chunk, it's placed back to the slot
and the scanning is restarted.

Many thanks to Dennis Zhou for his great ideas and a very constructive
discussion which led to many improvements in this patchset!

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu-internal.h |   2 +
 mm/percpu.c          | 164 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 095d7eaa0db4..8e432663c41e 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -67,6 +67,8 @@ struct pcpu_chunk {
=20
 	void			*data;		/* chunk data */
 	bool			immutable;	/* no [de]population allowed */
+	bool			isolated;	/* isolated from chunk slot lists */
+	bool			depopulated;    /* sidelined after depopulation */
 	int			start_offset;	/* the overlap with the previous
 						   region to have a page aligned
 						   base_addr */
diff --git a/mm/percpu.c b/mm/percpu.c
index e20119668c42..0a5a5e84e0a4 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -181,6 +181,19 @@ static LIST_HEAD(pcpu_map_extend_chunks);
  */
 int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
=20
+/*
+ * List of chunks with a lot of free pages.  Used to depopulate them
+ * asynchronously.
+ */
+static struct list_head pcpu_depopulate_list[PCPU_NR_CHUNK_TYPES];
+
+/*
+ * List of previously depopulated chunks.  They are not usually used for=
 new
+ * allocations, but can be returned back to service if a need arises.
+ */
+static struct list_head pcpu_sideline_list[PCPU_NR_CHUNK_TYPES];
+
+
 /*
  * The number of populated pages in use by the allocator, protected by
  * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a pag=
e gets
@@ -542,6 +555,12 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *c=
hunk, int oslot)
 {
 	int nslot =3D pcpu_chunk_slot(chunk);
=20
+	/*
+	 * Keep isolated and depopulated chunks on a sideline.
+	 */
+	if (chunk->isolated || chunk->depopulated)
+		return;
+
 	if (oslot !=3D nslot)
 		__pcpu_chunk_move(chunk, nslot, oslot < nslot);
 }
@@ -1778,6 +1797,25 @@ static void __percpu *pcpu_alloc(size_t size, size=
_t align, bool reserved,
 		}
 	}
=20
+	/* search through sidelined depopulated chunks */
+	list_for_each_entry(chunk, &pcpu_sideline_list[type], list) {
+		struct pcpu_block_md *chunk_md =3D &chunk->chunk_md;
+		int bit_off;
+
+		/*
+		 * If the allocation can fit in the chunk's contig hint,
+		 * place the chunk back into corresponding slot and restart
+		 * the scanning.
+		 */
+		bit_off =3D ALIGN(chunk_md->contig_hint_start, align) -
+			chunk_md->contig_hint_start;
+		if (bit_off + bits > chunk_md->contig_hint) {
+			chunk->depopulated =3D false;
+			pcpu_chunk_relocate(chunk, -1);
+			goto restart;
+		}
+	}
+
 	spin_unlock_irqrestore(&pcpu_lock, flags);
=20
 	/*
@@ -2048,6 +2086,106 @@ static void pcpu_grow_populated(enum pcpu_chunk_t=
ype type, int nr_to_pop)
 	}
 }
=20
+/**
+ * pcpu_shrink_populated - scan chunks and release unused pages to the s=
ystem
+ * @type: chunk type
+ *
+ * Scan over chunks in the depopulate list, try to release unused popula=
ted
+ * pages to the system.  Depopulated chunks are sidelined to prevent fur=
ther
+ * allocations without a need.  Skipped and fully free chunks are return=
ed
+ * to corresponding slots.  Stop depopulating if the number of empty pop=
ulated
+ * pages reaches the threshold.  Each chunk is scanned in the reverse or=
der to
+ * keep populated pages close to the beginning of the chunk.
+ */
+static void pcpu_shrink_populated(enum pcpu_chunk_type type)
+{
+	struct pcpu_block_md *block;
+	struct pcpu_chunk *chunk, *tmp;
+	LIST_HEAD(to_depopulate);
+	bool depopulated;
+	int i, end;
+
+	spin_lock_irq(&pcpu_lock);
+
+	list_splice_init(&pcpu_depopulate_list[type], &to_depopulate);
+
+	list_for_each_entry_safe(chunk, tmp, &to_depopulate, list) {
+		WARN_ON(chunk->immutable);
+		depopulated =3D false;
+
+		/*
+		 * Scan chunk's pages in the reverse order to keep populated
+		 * pages close to the beginning of the chunk.
+		 */
+		for (i =3D chunk->nr_pages - 1, end =3D -1; i >=3D 0; i--) {
+			/*
+			 * If the chunk has no empty pages or
+			 * we're short on empty pages in general,
+			 * just put the chunk back into the original slot.
+			 */
+			if (!chunk->nr_empty_pop_pages ||
+			    pcpu_nr_empty_pop_pages[type] <=3D
+			    PCPU_EMPTY_POP_PAGES_HIGH)
+				break;
+
+			/*
+			 * If the page is empty and populated, start or
+			 * extend the (i, end) range.  If i =3D=3D 0, decrease
+			 * i and perform the depopulation to cover the last
+			 * (first) page in the chunk.
+			 */
+			block =3D chunk->md_blocks + i;
+			if (block->contig_hint =3D=3D PCPU_BITMAP_BLOCK_BITS &&
+			    test_bit(i, chunk->populated)) {
+				if (end =3D=3D -1)
+					end =3D i;
+				if (i > 0)
+					continue;
+				i--;
+			}
+
+			/*
+			 * Otherwise check if there is an active range,
+			 * and if yes, depopulate it.
+			 */
+			if (end =3D=3D -1)
+				continue;
+
+			depopulated =3D true;
+
+			spin_unlock_irq(&pcpu_lock);
+			pcpu_depopulate_chunk(chunk, i + 1, end + 1);
+			cond_resched();
+			spin_lock_irq(&pcpu_lock);
+
+			pcpu_chunk_depopulated(chunk, i + 1, end + 1);
+
+			/*
+			 * Reset the range and continue.
+			 */
+			end =3D -1;
+		}
+
+		chunk->isolated =3D false;
+		if (chunk->free_bytes =3D=3D pcpu_unit_size || !depopulated) {
+			/*
+			 * If the chunk is empty or hasn't been depopulated,
+			 * return it to the original slot.
+			 */
+			pcpu_chunk_relocate(chunk, -1);
+		} else {
+			/*
+			 * Otherwise put the chunk to the list of depopulated
+			 * chunks.
+			 */
+			chunk->depopulated =3D true;
+			list_move(&chunk->list, &pcpu_sideline_list[type]);
+		}
+	}
+
+	spin_unlock_irq(&pcpu_lock);
+}
+
 /**
  * pcpu_balance_populated - manage the amount of populated pages
  * @type: chunk type
@@ -2078,6 +2216,8 @@ static void pcpu_balance_populated(enum pcpu_chunk_=
type type)
 	} else if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_HIGH) {
 		nr_to_pop =3D PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages[type=
];
 		pcpu_grow_populated(type, nr_to_pop);
+	} else if (!list_empty(&pcpu_depopulate_list[type])) {
+		pcpu_shrink_populated(type);
 	}
 }
=20
@@ -2135,7 +2275,13 @@ void free_percpu(void __percpu *ptr)
=20
 	pcpu_memcg_free_hook(chunk, off, size);
=20
-	/* if there are more than one fully free chunks, wake up grim reaper */
+	/*
+	 * If there are more than one fully free chunks, wake up grim reaper.
+	 * Otherwise if at least 1/4 of its pages are empty and there is no
+	 * system-wide shortage of empty pages aside from this chunk, isolate
+	 * the chunk and schedule an async depopulation.  If the chunk was
+	 * depopulated previously and got free pages, depopulate it too.
+	 */
 	if (chunk->free_bytes =3D=3D pcpu_unit_size) {
 		struct pcpu_chunk *pos;
=20
@@ -2144,6 +2290,16 @@ void free_percpu(void __percpu *ptr)
 				need_balance =3D true;
 				break;
 			}
+	} else if (chunk !=3D pcpu_first_chunk && chunk !=3D pcpu_reserved_chun=
k &&
+		   !chunk->isolated &&
+		   pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
+		   PCPU_EMPTY_POP_PAGES_HIGH + chunk->nr_empty_pop_pages &&
+		   ((chunk->depopulated && chunk->nr_empty_pop_pages) ||
+		    (chunk->nr_empty_pop_pages >=3D chunk->nr_pages / 4))) {
+		list_move(&chunk->list, &pcpu_depopulate_list[pcpu_chunk_type(chunk)])=
;
+		chunk->isolated =3D true;
+		chunk->depopulated =3D false;
+		need_balance =3D true;
 	}
=20
 	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
@@ -2571,10 +2727,14 @@ void __init pcpu_setup_first_chunk(const struct p=
cpu_alloc_info *ai,
 		      pcpu_nr_slots * sizeof(pcpu_chunk_lists[0]) *
 		      PCPU_NR_CHUNK_TYPES);
=20
-	for (type =3D 0; type < PCPU_NR_CHUNK_TYPES; type++)
+	for (type =3D 0; type < PCPU_NR_CHUNK_TYPES; type++) {
 		for (i =3D 0; i < pcpu_nr_slots; i++)
 			INIT_LIST_HEAD(&pcpu_chunk_list(type)[i]);
=20
+		INIT_LIST_HEAD(&pcpu_depopulate_list[type]);
+		INIT_LIST_HEAD(&pcpu_sideline_list[type]);
+	}
+
 	/*
 	 * The end of the static region needs to be aligned with the
 	 * minimum allocation size as this offsets the reserved and
--=20
2.30.2


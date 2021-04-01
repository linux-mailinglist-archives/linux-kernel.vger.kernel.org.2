Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8246F3521CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhDAVnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:43:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6470 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234938AbhDAVnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:43:09 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131LTjQW011778
        for <linux-kernel@vger.kernel.org>; Thu, 1 Apr 2021 14:43:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=QVdhf09sdPP4hg1rGgyRDvDtnIvQgNsVYQzwnzVp1Jc=;
 b=T2IRM0qpKjbGH6XBQpftfExxwH+jvjfvAhSEv8veVWsSREXD8n8IkHJC3Vq2eePiUxQb
 eQ/yp1HvVlM/mxh9kaUisPIeFP/E/aK86S9LXJPaNM7NJuobRWswjVC8YVnFp01fPHPq
 asJUzOXvbyms6QrMn9BnU5SZj/tx0rH0NKA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37ng35330r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:43:09 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 14:43:09 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 545555C2F8EF; Thu,  1 Apr 2021 14:43:04 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v1 5/5] percpu: implement partial chunk depopulation
Date:   Thu, 1 Apr 2021 14:43:01 -0700
Message-ID: <20210401214301.1689099-6-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401214301.1689099-1-guro@fb.com>
References: <20210401214301.1689099-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WJss8cGiRKWD5nPpiYN1bn0Ykx5lhqWY
X-Proofpoint-ORIG-GUID: WJss8cGiRKWD5nPpiYN1bn0Ykx5lhqWY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_13:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=689 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104010138
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
returned to the original slot (but is appended to the tail of the list
to minimize the chances of population).

Because the pcpu_lock is dropped while calling pcpu_depopulate_chunk(),
the chunk can be concurrently moved to a different slot. To prevent
this, bool chunk->isolated flag is introduced. If set, the chunk can't
be moved to a different slot.

The depopulation is scheduled on the free path. Is the chunk:
  1) has more than 1/8 of total pages free and populated
  2) the system has enough free percpu pages aside of this chunk
  3) isn't the reserved chunk
  4) isn't the first chunk
  5) isn't entirely free
it's a good target for depopulation.

If so, the chunk is moved to a special pcpu_depopulate_list,
chunk->isolate flag is set and the async balancing is scheduled.

The async balancing moves pcpu_depopulate_list to a local list
(because pcpu_depopulate_list can be changed when pcpu_lock is
releases), and then tries to depopulate each chunk. Successfully
or not, at the end all chunks are returned to appropriate slots
and their isolated flags are cleared.

Many thanks to Dennis Zhou for his great ideas and a very constructive
discussion which led to many improvements in this patchset!

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu-internal.h |   1 +
 mm/percpu.c          | 101 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 095d7eaa0db4..ff318752915d 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -67,6 +67,7 @@ struct pcpu_chunk {
=20
 	void			*data;		/* chunk data */
 	bool			immutable;	/* no [de]population allowed */
+	bool			isolated;	/* isolated from chunk slot lists */
 	int			start_offset;	/* the overlap with the previous
 						   region to have a page aligned
 						   base_addr */
diff --git a/mm/percpu.c b/mm/percpu.c
index e20119668c42..dae0b870e10a 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -181,6 +181,12 @@ static LIST_HEAD(pcpu_map_extend_chunks);
  */
 int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
=20
+/*
+ * List of chunks with a lot of free pages. Used to depopulate them
+ * asynchronously.
+ */
+static LIST_HEAD(pcpu_depopulate_list);
+
 /*
  * The number of populated pages in use by the allocator, protected by
  * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a pag=
e gets
@@ -542,7 +548,7 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *ch=
unk, int oslot)
 {
 	int nslot =3D pcpu_chunk_slot(chunk);
=20
-	if (oslot !=3D nslot)
+	if (!chunk->isolated && oslot !=3D nslot)
 		__pcpu_chunk_move(chunk, nslot, oslot < nslot);
 }
=20
@@ -2048,6 +2054,82 @@ static void pcpu_grow_populated(enum pcpu_chunk_ty=
pe type, int nr_to_pop)
 	}
 }
=20
+/**
+ * pcpu_shrink_populated - scan chunks and release unused pages to the s=
ystem
+ * @type: chunk type
+ *
+ * Scan over all chunks, find those marked with the depopulate flag and
+ * try to release unused pages to the system. On every attempt clear the
+ * chunk's depopulate flag to avoid wasting CPU by scanning the same
+ * chunk again and again.
+ */
+static void pcpu_shrink_populated(enum pcpu_chunk_type type)
+{
+	struct pcpu_block_md *block;
+	struct pcpu_chunk *chunk, *tmp;
+	LIST_HEAD(to_depopulate);
+	int i, start;
+
+	spin_lock_irq(&pcpu_lock);
+
+	list_splice_init(&pcpu_depopulate_list, &to_depopulate);
+
+	list_for_each_entry_safe(chunk, tmp, &to_depopulate, list) {
+		WARN_ON(chunk->immutable);
+
+		for (i =3D 0, start =3D -1; i < chunk->nr_pages; i++) {
+			/*
+			 * If the chunk has no empty pages or
+			 * we're short on empty pages in general,
+			 * just put the chunk back into the original slot.
+			 */
+			if (!chunk->nr_empty_pop_pages ||
+			    pcpu_nr_empty_pop_pages[type] <
+			    PCPU_EMPTY_POP_PAGES_HIGH)
+				break;
+
+			/*
+			 * If the page is empty and populated, start or
+			 * extend the [start, i) range.
+			 */
+			block =3D chunk->md_blocks + i;
+			if (block->contig_hint =3D=3D PCPU_BITMAP_BLOCK_BITS &&
+			    test_bit(i, chunk->populated)) {
+				if (start =3D=3D -1)
+					start =3D i;
+				continue;
+			}
+
+			/*
+			 * Otherwise check if there is an active range,
+			 * and if yes, depopulate it.
+			 */
+			if (start =3D=3D -1)
+				continue;
+
+			spin_unlock_irq(&pcpu_lock);
+			pcpu_depopulate_chunk(chunk, start, i);
+			cond_resched();
+			spin_lock_irq(&pcpu_lock);
+
+			pcpu_chunk_depopulated(chunk, start, i);
+
+			/*
+			 * Reset the range and continue.
+			 */
+			start =3D -1;
+		}
+
+		/*
+		 * Return the chunk to the corresponding slot.
+		 */
+		chunk->isolated =3D false;
+		pcpu_chunk_relocate(chunk, -1);
+	}
+
+	spin_unlock_irq(&pcpu_lock);
+}
+
 /**
  * pcpu_balance_populated - manage the amount of populated pages
  * @type: chunk type
@@ -2078,6 +2160,8 @@ static void pcpu_balance_populated(enum pcpu_chunk_=
type type)
 	} else if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_HIGH) {
 		nr_to_pop =3D PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages[type=
];
 		pcpu_grow_populated(type, nr_to_pop);
+	} else if (!list_empty(&pcpu_depopulate_list)) {
+		pcpu_shrink_populated(type);
 	}
 }
=20
@@ -2135,7 +2219,12 @@ void free_percpu(void __percpu *ptr)
=20
 	pcpu_memcg_free_hook(chunk, off, size);
=20
-	/* if there are more than one fully free chunks, wake up grim reaper */
+	/*
+	 * If there are more than one fully free chunks, wake up grim reaper.
+	 * Otherwise if at least 1/8 of its pages are empty and there is no
+	 * system-wide shortage of empty pages aside from this chunk, isolate
+	 * the chunk and schedule an async depopulation.
+	 */
 	if (chunk->free_bytes =3D=3D pcpu_unit_size) {
 		struct pcpu_chunk *pos;
=20
@@ -2144,6 +2233,14 @@ void free_percpu(void __percpu *ptr)
 				need_balance =3D true;
 				break;
 			}
+	} else if (chunk !=3D pcpu_first_chunk && chunk !=3D pcpu_reserved_chun=
k &&
+		   !chunk->isolated &&
+		   chunk->nr_empty_pop_pages >=3D chunk->nr_pages / 8 &&
+		   pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
+		   PCPU_EMPTY_POP_PAGES_HIGH + chunk->nr_empty_pop_pages) {
+		list_move(&chunk->list, &pcpu_depopulate_list);
+		chunk->isolated =3D true;
+		need_balance =3D true;
 	}
=20
 	trace_percpu_free_percpu(chunk->base_addr, off, ptr);
--=20
2.30.2


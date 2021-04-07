Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5E357445
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355281AbhDGS1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:27:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27092 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355286AbhDGS1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:27:39 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137IOXOM025124
        for <linux-kernel@vger.kernel.org>; Wed, 7 Apr 2021 11:27:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qAEXwgccNCJwApJKnF3tbkjWwzvQ4ovmNeHysDx48R0=;
 b=mEeRG7sPGv50Ky2JSH6CgTWhLoyXkyr1QkdhgZWwDUhITwBNitKkP84GpwJoGdvxSd/4
 igrnWzJ8i4day6hYyZSvLzP08koAVugeHilNMxiYePWDn/NTZz/Lq10IA4f+Nbl8rLjI
 /5ykFw7JLTGVP5CEGqKTeczzvnHb2aq7q7U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37sfq616r4-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:27:27 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 11:26:23 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 4957B5FEBC07; Wed,  7 Apr 2021 11:26:19 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 4/5] percpu: generalize pcpu_balance_populated()
Date:   Wed, 7 Apr 2021 11:26:17 -0700
Message-ID: <20210407182618.2728388-5-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407182618.2728388-1-guro@fb.com>
References: <20210407182618.2728388-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eih7BQX_WlNNrC_ioxxpEcw9Qv3Hkpjh
X-Proofpoint-GUID: eih7BQX_WlNNrC_ioxxpEcw9Qv3Hkpjh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_09:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for the depopulation of percpu chunks, split out the
populating part of the pcpu_balance_populated() into the new
pcpu_grow_populated() (with an intention to add
pcpu_shrink_populated() in the next commit).

The goal of pcpu_balance_populated() is to determine whether
there is a shortage or an excessive amount of empty percpu pages
and call into the corresponding function.

pcpu_grow_populated() takes a desired number of pages as an argument
(nr_to_pop). If it creates a new chunk, nr_to_pop should be updated
to reflect that the new chunk could be created already populated.
Otherwise an infinite loop might appear.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu.c | 63 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 61339b3d9337..e20119668c42 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1979,7 +1979,7 @@ static void pcpu_balance_free(enum pcpu_chunk_type =
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
@@ -1988,35 +1988,15 @@ static void pcpu_balance_free(enum pcpu_chunk_typ=
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
-				  pcpu_nr_empty_pop_pages[type],
-				  0, PCPU_EMPTY_POP_PAGES_HIGH);
-	}
-
 	for (slot =3D pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot+=
+) {
 		unsigned int nr_unpop =3D 0, rs, re;
=20
@@ -2060,12 +2040,47 @@ static void pcpu_balance_populated(enum pcpu_chun=
k_type type)
 		if (chunk) {
 			spin_lock_irq(&pcpu_lock);
 			pcpu_chunk_relocate(chunk, -1);
+			nr_to_pop =3D max_t(int, 0, nr_to_pop - chunk->nr_populated);
 			spin_unlock_irq(&pcpu_lock);
-			goto retry_pop;
+			if (nr_to_pop)
+				goto retry_pop;
 		}
 	}
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
+	} else if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_HIGH) {
+		nr_to_pop =3D PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages[type=
];
+		pcpu_grow_populated(type, nr_to_pop);
+	}
+}
+
 /**
  * pcpu_balance_workfn - manage the amount of free chunks and populated =
pages
  * @work: unused
--=20
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC6348139
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbhCXTHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:07:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10190 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237774AbhCXTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:06:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12OJ1vnY029571
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=981pKgSo+LC/Mf3Xm+swjmvg5jsIj7ppALj3/zde3Ag=;
 b=cd4Gcco+nv3ez94MZ6gARvy8sCGAOUDJ/cCrqivDlRFEjHF/PAVntCHtqUMVHNeomK2R
 vsM8Laq2ojwA/zLSGSRXm0GmfwEBu2oudeJ+bqxvI5wyv0D+ypiSPJBLWv16Nza0UkSF
 NrMMnbsHzNtAAgZRMXbthYbnMePHh8zjj14= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37g173kq14-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:35 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 12:06:34 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 8321E57ACF2A; Wed, 24 Mar 2021 12:06:33 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 1/4] percpu: implement partial chunk depopulation
Date:   Wed, 24 Mar 2021 12:06:23 -0700
Message-ID: <20210324190626.564297-2-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324190626.564297-1-guro@fb.com>
References: <20210324190626.564297-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_13:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=714 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements partial depopulation of percpu chunks.

As now, a chunk can be depopulated only as a part of the final
destruction, when there are no more outstanding allocations. However
to minimize a memory waste, it might be useful to depopulate a
partially filed chunk, if a small number of outstanding allocations
prevents the chunk from being reclaimed.

This patch implements the following depopulation process: it scans
over the chunk pages, looks for a range of empty and populated pages
and performs the depopulation. To avoid races with new allocations,
the chunk is previously isolated. After the depopulation the chunk is
returned to the original slot (but is appended to the tail of the list
to minimize the chances of population).

Because the pcpu_lock is dropped while calling pcpu_depopulate_chunk(),
the chunk can be concurrently moved to a different slot. So we need
to isolate it again on each step. pcpu_alloc_mutex is held, so the
chunk can't be populated/depopulated asynchronously.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index 6596a0a4286e..78c55c73fa28 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2055,6 +2055,96 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_=
type type)
 	mutex_unlock(&pcpu_alloc_mutex);
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
+	struct list_head *pcpu_slot =3D pcpu_chunk_list(type);
+	struct pcpu_chunk *chunk;
+	int slot, i, off, start;
+
+	spin_lock_irq(&pcpu_lock);
+	for (slot =3D pcpu_nr_slots - 1; slot >=3D 0; slot--) {
+restart:
+		list_for_each_entry(chunk, &pcpu_slot[slot], list) {
+			bool isolated =3D false;
+
+			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH)
+				break;
+
+			for (i =3D 0, start =3D -1; i < chunk->nr_pages; i++) {
+				if (!chunk->nr_empty_pop_pages)
+					break;
+
+				/*
+				 * If the page is empty and populated, start or
+				 * extend the [start, i) range.
+				 */
+				if (test_bit(i, chunk->populated)) {
+					off =3D find_first_bit(
+						pcpu_index_alloc_map(chunk, i),
+						PCPU_BITMAP_BLOCK_BITS);
+					if (off >=3D PCPU_BITMAP_BLOCK_BITS) {
+						if (start =3D=3D -1)
+							start =3D i;
+						continue;
+					}
+				}
+
+				/*
+				 * Otherwise check if there is an active range,
+				 * and if yes, depopulate it.
+				 */
+				if (start =3D=3D -1)
+					continue;
+
+				/*
+				 * Isolate the chunk, so new allocations
+				 * wouldn't be served using this chunk.
+				 * Async releases can still happen.
+				 */
+				if (!list_empty(&chunk->list)) {
+					list_del_init(&chunk->list);
+					isolated =3D true;
+				}
+
+				spin_unlock_irq(&pcpu_lock);
+				pcpu_depopulate_chunk(chunk, start, i);
+				cond_resched();
+				spin_lock_irq(&pcpu_lock);
+
+				pcpu_chunk_depopulated(chunk, start, i);
+
+				/*
+				 * Reset the range and continue.
+				 */
+				start =3D -1;
+			}
+
+			if (isolated) {
+				/*
+				 * The chunk could have been moved while
+				 * pcpu_lock wasn't held. Make sure we put
+				 * the chunk back into the slot and restart
+				 * the scanning.
+				 */
+				if (list_empty(&chunk->list))
+					list_add_tail(&chunk->list,
+						      &pcpu_slot[slot]);
+				goto restart;
+			}
+		}
+	}
+	spin_unlock_irq(&pcpu_lock);
+}
+
 /**
  * pcpu_balance_workfn - manage the amount of free chunks and populated =
pages
  * @work: unused
--=20
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834683ABC43
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhFQTFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:05:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65200 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231226AbhFQTFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:05:39 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HInakO001893
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:03:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=d+nLnwYgG5RBmjWZ9saeYXNOrjRWtO97H6uDIVoSAeQ=;
 b=Mhis0N2sxqzy+o/Tiuqqhwa34a41EtZpoFn0nDMHm4pT9sU1MCT2Cmi+99MCqqHnS3Dt
 BHwJ2VlIaQYgcOJAmStZE0fmcGBe79mn64MWYbsWDqLBXNGoPkT0uN3XRUmH5xE9TB7j
 I3zhEhUumypi1Ic9jFfaJxprdoSzM43UuAE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 397mg0rpxe-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:03:31 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 12:03:29 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 86215877F889; Thu, 17 Jun 2021 12:03:25 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2] percpu: optimize locking in pcpu_balance_workfn()
Date:   Thu, 17 Jun 2021 12:03:22 -0700
Message-ID: <20210617190322.3636731-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: frIj5SWgypxzRrd4i4NWtuEiNHMXvuOi
X-Proofpoint-GUID: frIj5SWgypxzRrd4i4NWtuEiNHMXvuOi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_15:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcpu_balance_workfn() unconditionally calls pcpu_balance_free(),
pcpu_reclaim_populated(), pcpu_balance_populated() and
pcpu_balance_free() again.

Each call to pcpu_balance_free() and pcpu_reclaim_populated() will
cause at least one acquisition of the pcpu_lock. So even if the
balancing was scheduled because of a failed atomic allocation,
pcpu_lock will be acquired at least 4 times. This obviously
increases the contention on the pcpu_lock.

To optimize the scheme let's grab the pcpu_lock on the upper level
(in pcpu_balance_workfn()) and keep it generally locked for the whole
duration of the scheduled work, but release conditionally to perform
any slow operations like chunk (de)population and creation of new
chunks.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index e7b9ca82e9aa..deee7e5bb255 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1980,6 +1980,9 @@ void __percpu *__alloc_reserved_percpu(size_t size,=
 size_t align)
  * If empty_only is %false, reclaim all fully free chunks regardless of =
the
  * number of populated pages.  Otherwise, only reclaim chunks that have =
no
  * populated pages.
+ *
+ * CONTEXT:
+ * pcpu_lock (can be dropped temporarily)
  */
 static void pcpu_balance_free(bool empty_only)
 {
@@ -1987,12 +1990,12 @@ static void pcpu_balance_free(bool empty_only)
 	struct list_head *free_head =3D &pcpu_chunk_lists[pcpu_free_slot];
 	struct pcpu_chunk *chunk, *next;
=20
+	lockdep_assert_held(&pcpu_lock);
+
 	/*
 	 * There's no reason to keep around multiple unused chunks and VM
 	 * areas can be scarce.  Destroy all free chunks except for one.
 	 */
-	spin_lock_irq(&pcpu_lock);
-
 	list_for_each_entry_safe(chunk, next, free_head, list) {
 		WARN_ON(chunk->immutable);
=20
@@ -2004,8 +2007,10 @@ static void pcpu_balance_free(bool empty_only)
 			list_move(&chunk->list, &to_free);
 	}
=20
-	spin_unlock_irq(&pcpu_lock);
+	if (list_empty(&to_free))
+		return;
=20
+	spin_unlock_irq(&pcpu_lock);
 	list_for_each_entry_safe(chunk, next, &to_free, list) {
 		unsigned int rs, re;
=20
@@ -2019,6 +2024,7 @@ static void pcpu_balance_free(bool empty_only)
 		pcpu_destroy_chunk(chunk);
 		cond_resched();
 	}
+	spin_lock_irq(&pcpu_lock);
 }
=20
 /**
@@ -2029,6 +2035,9 @@ static void pcpu_balance_free(bool empty_only)
  * OOM killer to be triggered.  We should avoid doing so until an actual
  * allocation causes the failure as it is possible that requests can be
  * serviced from already backed regions.
+ *
+ * CONTEXT:
+ * pcpu_lock (can be dropped temporarily)
  */
 static void pcpu_balance_populated(void)
 {
@@ -2037,6 +2046,8 @@ static void pcpu_balance_populated(void)
 	struct pcpu_chunk *chunk;
 	int slot, nr_to_pop, ret;
=20
+	lockdep_assert_held(&pcpu_lock);
+
 	/*
 	 * Ensure there are certain number of free populated pages for
 	 * atomic allocs.  Fill up from the most packed so that atomic
@@ -2064,13 +2075,11 @@ static void pcpu_balance_populated(void)
 		if (!nr_to_pop)
 			break;
=20
-		spin_lock_irq(&pcpu_lock);
 		list_for_each_entry(chunk, &pcpu_chunk_lists[slot], list) {
 			nr_unpop =3D chunk->nr_pages - chunk->nr_populated;
 			if (nr_unpop)
 				break;
 		}
-		spin_unlock_irq(&pcpu_lock);
=20
 		if (!nr_unpop)
 			continue;
@@ -2080,12 +2089,13 @@ static void pcpu_balance_populated(void)
 					     chunk->nr_pages) {
 			int nr =3D min_t(int, re - rs, nr_to_pop);
=20
+			spin_unlock_irq(&pcpu_lock);
 			ret =3D pcpu_populate_chunk(chunk, rs, rs + nr, gfp);
+			cond_resched();
+			spin_lock_irq(&pcpu_lock);
 			if (!ret) {
 				nr_to_pop -=3D nr;
-				spin_lock_irq(&pcpu_lock);
 				pcpu_chunk_populated(chunk, rs, rs + nr);
-				spin_unlock_irq(&pcpu_lock);
 			} else {
 				nr_to_pop =3D 0;
 			}
@@ -2097,11 +2107,12 @@ static void pcpu_balance_populated(void)
=20
 	if (nr_to_pop) {
 		/* ran out of chunks to populate, create a new one and retry */
+		spin_unlock_irq(&pcpu_lock);
 		chunk =3D pcpu_create_chunk(gfp);
+		cond_resched();
+		spin_lock_irq(&pcpu_lock);
 		if (chunk) {
-			spin_lock_irq(&pcpu_lock);
 			pcpu_chunk_relocate(chunk, -1);
-			spin_unlock_irq(&pcpu_lock);
 			goto retry_pop;
 		}
 	}
@@ -2117,6 +2128,10 @@ static void pcpu_balance_populated(void)
  * populated pages threshold, reintegrate the chunk if it has empty free=
 pages.
  * Each chunk is scanned in the reverse order to keep populated pages cl=
ose to
  * the beginning of the chunk.
+ *
+ * CONTEXT:
+ * pcpu_lock (can be dropped temporarily)
+ *
  */
 static void pcpu_reclaim_populated(void)
 {
@@ -2124,7 +2139,7 @@ static void pcpu_reclaim_populated(void)
 	struct pcpu_block_md *block;
 	int i, end;
=20
-	spin_lock_irq(&pcpu_lock);
+	lockdep_assert_held(&pcpu_lock);
=20
 restart:
 	/*
@@ -2190,8 +2205,6 @@ static void pcpu_reclaim_populated(void)
 			list_move(&chunk->list,
 				  &pcpu_chunk_lists[pcpu_sidelined_slot]);
 	}
-
-	spin_unlock_irq(&pcpu_lock);
 }
=20
 /**
@@ -2212,10 +2225,14 @@ static void pcpu_balance_workfn(struct work_struc=
t *work)
 	 * appropriate.
 	 */
 	mutex_lock(&pcpu_alloc_mutex);
+	spin_lock_irq(&pcpu_lock);
+
 	pcpu_balance_free(false);
 	pcpu_reclaim_populated();
 	pcpu_balance_populated();
 	pcpu_balance_free(true);
+
+	spin_unlock_irq(&pcpu_lock);
 	mutex_unlock(&pcpu_alloc_mutex);
 }
=20
--=20
2.31.1


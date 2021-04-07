Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB56357439
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355236AbhDGS0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:26:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43620 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355223AbhDGS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:26:42 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137INefg010235
        for <linux-kernel@vger.kernel.org>; Wed, 7 Apr 2021 11:26:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HMmvNQkcS7gbusULGAPo0RXdrobA76PG+Ea0H7xaLXk=;
 b=SBRCH4NrwB+YCeuLBBUYJU/+6re8/z93gs/5zgHKoC49lsqb/f7sgfUW7KEWBhXX1gCH
 8ij0xDpNa4Wb0Mva7bSutg6SgnrKldWb2sUsUypoFczAaLJIaQD7Ga8V0pAJCzFnaimx
 yWsAZWBp1bWeFbfpbiWVrejzXM6vXopzK5U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37sew1sjvj-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:26:32 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 11:26:29 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 3D4105FEBC03; Wed,  7 Apr 2021 11:26:19 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 2/5] percpu: split __pcpu_balance_workfn()
Date:   Wed, 7 Apr 2021 11:26:15 -0700
Message-ID: <20210407182618.2728388-3-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407182618.2728388-1-guro@fb.com>
References: <20210407182618.2728388-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pHbQ_pXG3bK1-TGlv-nRe0zYvHTXrPR6
X-Proofpoint-ORIG-GUID: pHbQ_pXG3bK1-TGlv-nRe0zYvHTXrPR6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_09:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__pcpu_balance_workfn() became fairly big and hard to follow, but in
fact it consists of two fully independent parts, responsible for
the destruction of excessive free chunks and population of necessarily
amount of free pages.

In order to simplify the code and prepare for adding of a new
functionality, split it in two functions:

  1) pcpu_balance_free,
  2) pcpu_balance_populated.

Move the taking/releasing of the pcpu_alloc_mutex to an upper level
to keep the current synchronization in place.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 2f27123bb489..7e31e1b8725f 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1933,31 +1933,22 @@ void __percpu *__alloc_reserved_percpu(size_t siz=
e, size_t align)
 }
=20
 /**
- * __pcpu_balance_workfn - manage the amount of free chunks and populate=
d pages
+ * pcpu_balance_free - manage the amount of free chunks
  * @type: chunk type
  *
- * Reclaim all fully free chunks except for the first one.  This is also
- * responsible for maintaining the pool of empty populated pages.  Howev=
er,
- * it is possible that this is called when physical memory is scarce cau=
sing
- * OOM killer to be triggered.  We should avoid doing so until an actual
- * allocation causes the failure as it is possible that requests can be
- * serviced from already backed regions.
+ * Reclaim all fully free chunks except for the first one.
  */
-static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
+static void pcpu_balance_free(enum pcpu_chunk_type type)
 {
-	/* gfp flags passed to underlying allocators */
-	const gfp_t gfp =3D GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
 	LIST_HEAD(to_free);
 	struct list_head *pcpu_slot =3D pcpu_chunk_list(type);
 	struct list_head *free_head =3D &pcpu_slot[pcpu_nr_slots - 1];
 	struct pcpu_chunk *chunk, *next;
-	int slot, nr_to_pop, ret;
=20
 	/*
 	 * There's no reason to keep around multiple unused chunks and VM
 	 * areas can be scarce.  Destroy all free chunks except for one.
 	 */
-	mutex_lock(&pcpu_alloc_mutex);
 	spin_lock_irq(&pcpu_lock);
=20
 	list_for_each_entry_safe(chunk, next, free_head, list) {
@@ -1985,6 +1976,25 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_=
type type)
 		pcpu_destroy_chunk(chunk);
 		cond_resched();
 	}
+}
+
+/**
+ * pcpu_balance_populated - manage the amount of populated pages
+ * @type: chunk type
+ *
+ * Maintain a certain amount of populated pages to satisfy atomic alloca=
tions.
+ * It is possible that this is called when physical memory is scarce cau=
sing
+ * OOM killer to be triggered.  We should avoid doing so until an actual
+ * allocation causes the failure as it is possible that requests can be
+ * serviced from already backed regions.
+ */
+static void pcpu_balance_populated(enum pcpu_chunk_type type)
+{
+	/* gfp flags passed to underlying allocators */
+	const gfp_t gfp =3D GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
+	struct list_head *pcpu_slot =3D pcpu_chunk_list(type);
+	struct pcpu_chunk *chunk;
+	int slot, nr_to_pop, ret;
=20
 	/*
 	 * Ensure there are certain number of free populated pages for
@@ -2054,22 +2064,24 @@ static void __pcpu_balance_workfn(enum pcpu_chunk=
_type type)
 			goto retry_pop;
 		}
 	}
-
-	mutex_unlock(&pcpu_alloc_mutex);
 }
=20
 /**
  * pcpu_balance_workfn - manage the amount of free chunks and populated =
pages
  * @work: unused
  *
- * Call __pcpu_balance_workfn() for each chunk type.
+ * Call pcpu_balance_free() and pcpu_balance_populated() for each chunk =
type.
  */
 static void pcpu_balance_workfn(struct work_struct *work)
 {
 	enum pcpu_chunk_type type;
=20
-	for (type =3D 0; type < PCPU_NR_CHUNK_TYPES; type++)
-		__pcpu_balance_workfn(type);
+	for (type =3D 0; type < PCPU_NR_CHUNK_TYPES; type++) {
+		mutex_lock(&pcpu_alloc_mutex);
+		pcpu_balance_free(type);
+		pcpu_balance_populated(type);
+		mutex_unlock(&pcpu_alloc_mutex);
+	}
 }
=20
 /**
--=20
2.30.2


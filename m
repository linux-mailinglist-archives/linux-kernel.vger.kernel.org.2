Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC55334813C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhCXTHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:07:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34412 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237793AbhCXTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:06:40 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OJ4gnw013503
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PesfLSNqaSnZtUHwp3bX+VBIVffZ0kcnPolfYW+BQSc=;
 b=T+oxbpDviEl0fIWV4bv5zE8Lxxf0+84pGTjkPgw3UjTqaXIzM8asm5g1Ri/HfBkZYYo+
 9MryB1lXbLJDYSaWYLvvXv/qNzpiQm48E8OmXPsTa23cnf+ZVgUHY5s+z2bQwzyy0Op2
 adgJ8tSlKegNu2fTHSZU31/n/Amhr0gIH2A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37g1wjbgnw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:39 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 12:06:37 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 888AA57ACF2C; Wed, 24 Mar 2021 12:06:33 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 2/4] percpu: split __pcpu_balance_workfn()
Date:   Wed, 24 Mar 2021 12:06:24 -0700
Message-ID: <20210324190626.564297-3-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324190626.564297-1-guro@fb.com>
References: <20210324190626.564297-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_13:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240137
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
---
 mm/percpu.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 78c55c73fa28..015d076893f5 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1930,31 +1930,22 @@ void __percpu *__alloc_reserved_percpu(size_t siz=
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
@@ -1982,6 +1973,25 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_=
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
@@ -2051,8 +2061,6 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_t=
ype type)
 			goto retry_pop;
 		}
 	}
-
-	mutex_unlock(&pcpu_alloc_mutex);
 }
=20
 /**
@@ -2149,14 +2157,18 @@ static void pcpu_shrink_populated(enum pcpu_chunk=
_type type)
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


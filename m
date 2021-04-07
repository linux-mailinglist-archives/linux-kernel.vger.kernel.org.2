Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09C235743B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355253AbhDGS04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:26:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45958 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355218AbhDGS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:26:47 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137IOaNE011864
        for <linux-kernel@vger.kernel.org>; Wed, 7 Apr 2021 11:26:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4vZaaBFsaOB4F8XygoHlUQdcYtLDpiQQyW830Fvwijw=;
 b=ju1ElUjgUtep2DPWfT2bUcNSEbLGe6xYXzXFM41DOn3GWUs2tmj9GWqSbAeUCk3x4Ogn
 A507Q3LaPJTC6rW8HS1rTSF8ZF9GQfqd1romiMxw/MUDTyjdVq4b71eGAFfJ5pYg1eNR
 F7tXQ3vPEC6onwTby9BJ5JV5IjT3klG2h1w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37sf0qheb8-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:26:36 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 11:26:24 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 43DC65FEBC05; Wed,  7 Apr 2021 11:26:19 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 3/5] percpu: make pcpu_nr_empty_pop_pages per chunk type
Date:   Wed, 7 Apr 2021 11:26:16 -0700
Message-ID: <20210407182618.2728388-4-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407182618.2728388-1-guro@fb.com>
References: <20210407182618.2728388-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PCr59K3blA5MwbOb-yOo9XQLuNRe9iMG
X-Proofpoint-ORIG-GUID: PCr59K3blA5MwbOb-yOo9XQLuNRe9iMG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_09:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_empty_pop_pages is used to guarantee that there are some free
populated pages to satisfy atomic allocations. Accounted and
non-accounted allocations are using separate sets of chunks,
so both need to have a surplus of empty pages.

This commit makes pcpu_nr_empty_pop_pages and the corresponding logic
per chunk type.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu-internal.h |  2 +-
 mm/percpu-stats.c    |  9 +++++++--
 mm/percpu.c          | 14 +++++++-------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 18b768ac7dca..095d7eaa0db4 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -87,7 +87,7 @@ extern spinlock_t pcpu_lock;
=20
 extern struct list_head *pcpu_chunk_lists;
 extern int pcpu_nr_slots;
-extern int pcpu_nr_empty_pop_pages;
+extern int pcpu_nr_empty_pop_pages[];
=20
 extern struct pcpu_chunk *pcpu_first_chunk;
 extern struct pcpu_chunk *pcpu_reserved_chunk;
diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
index c8400a2adbc2..f6026dbcdf6b 100644
--- a/mm/percpu-stats.c
+++ b/mm/percpu-stats.c
@@ -145,6 +145,7 @@ static int percpu_stats_show(struct seq_file *m, void=
 *v)
 	int slot, max_nr_alloc;
 	int *buffer;
 	enum pcpu_chunk_type type;
+	int nr_empty_pop_pages;
=20
 alloc_buffer:
 	spin_lock_irq(&pcpu_lock);
@@ -165,7 +166,11 @@ static int percpu_stats_show(struct seq_file *m, voi=
d *v)
 		goto alloc_buffer;
 	}
=20
-#define PL(X) \
+	nr_empty_pop_pages =3D 0;
+	for (type =3D 0; type < PCPU_NR_CHUNK_TYPES; type++)
+		nr_empty_pop_pages +=3D pcpu_nr_empty_pop_pages[type];
+
+#define PL(X)								\
 	seq_printf(m, "  %-20s: %12lld\n", #X, (long long int)pcpu_stats_ai.X)
=20
 	seq_printf(m,
@@ -196,7 +201,7 @@ static int percpu_stats_show(struct seq_file *m, void=
 *v)
 	PU(nr_max_chunks);
 	PU(min_alloc_size);
 	PU(max_alloc_size);
-	P("empty_pop_pages", pcpu_nr_empty_pop_pages);
+	P("empty_pop_pages", nr_empty_pop_pages);
 	seq_putc(m, '\n');
=20
 #undef PU
diff --git a/mm/percpu.c b/mm/percpu.c
index 7e31e1b8725f..61339b3d9337 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -176,10 +176,10 @@ struct list_head *pcpu_chunk_lists __ro_after_init;=
 /* chunk list slots */
 static LIST_HEAD(pcpu_map_extend_chunks);
=20
 /*
- * The number of empty populated pages, protected by pcpu_lock.  The
- * reserved chunk doesn't contribute to the count.
+ * The number of empty populated pages by chunk type, protected by pcpu_=
lock.
+ * The reserved chunk doesn't contribute to the count.
  */
-int pcpu_nr_empty_pop_pages;
+int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
=20
 /*
  * The number of populated pages in use by the allocator, protected by
@@ -559,7 +559,7 @@ static inline void pcpu_update_empty_pages(struct pcp=
u_chunk *chunk, int nr)
 {
 	chunk->nr_empty_pop_pages +=3D nr;
 	if (chunk !=3D pcpu_reserved_chunk)
-		pcpu_nr_empty_pop_pages +=3D nr;
+		pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] +=3D nr;
 }
=20
 /*
@@ -1835,7 +1835,7 @@ static void __percpu *pcpu_alloc(size_t size, size_=
t align, bool reserved,
 		mutex_unlock(&pcpu_alloc_mutex);
 	}
=20
-	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
+	if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_LOW)
 		pcpu_schedule_balance_work();
=20
 	/* clear the areas and return address relative to base address */
@@ -2013,7 +2013,7 @@ static void pcpu_balance_populated(enum pcpu_chunk_=
type type)
 		pcpu_atomic_alloc_failed =3D false;
 	} else {
 		nr_to_pop =3D clamp(PCPU_EMPTY_POP_PAGES_HIGH -
-				  pcpu_nr_empty_pop_pages,
+				  pcpu_nr_empty_pop_pages[type],
 				  0, PCPU_EMPTY_POP_PAGES_HIGH);
 	}
=20
@@ -2595,7 +2595,7 @@ void __init pcpu_setup_first_chunk(const struct pcp=
u_alloc_info *ai,
=20
 	/* link the first chunk in */
 	pcpu_first_chunk =3D chunk;
-	pcpu_nr_empty_pop_pages =3D pcpu_first_chunk->nr_empty_pop_pages;
+	pcpu_nr_empty_pop_pages[PCPU_CHUNK_ROOT] =3D pcpu_first_chunk->nr_empty=
_pop_pages;
 	pcpu_chunk_relocate(pcpu_first_chunk, -1);
=20
 	/* include all regions of the first chunk */
--=20
2.30.2


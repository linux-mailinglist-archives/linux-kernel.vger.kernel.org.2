Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B567C357AF7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhDHD6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:58:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhDHD57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:57:59 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1383qcZJ010009
        for <linux-kernel@vger.kernel.org>; Wed, 7 Apr 2021 20:57:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nfieNUNbNb1D09215aq0Md0ODibFOEFLCBSQhP0UblY=;
 b=Ei+F+GPAXOR6U7V8sokiEiHmPHl3xizv7f+HIBM04VR4nK3TayJLBK9RopBf9i3a5UDo
 Kq0KHkMK+f26xQi1M9w4ZL2apqcBTVTgbILwGMd985t/fA6sgCty2ER6aRK9sXmkXU02
 qDTzAdVkfAUsLfK4Vfr/CDU5ZVfrC3tBJ+M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37sf0qm5cq-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 20:57:49 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 20:57:47 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 6D269602B014; Wed,  7 Apr 2021 20:57:41 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 5/6] percpu: factor out pcpu_check_chunk_hint()
Date:   Wed, 7 Apr 2021 20:57:35 -0700
Message-ID: <20210408035736.883861-6-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210408035736.883861-1-guro@fb.com>
References: <20210408035736.883861-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NPbYt0Rm6niQOSoXIBldMZYD4Yj3A_Y1
X-Proofpoint-ORIG-GUID: NPbYt0Rm6niQOSoXIBldMZYD4Yj3A_Y1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_01:2021-04-07,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the pcpu_check_chunk_hint() helper, which will be useful
in the future. The new function checks if the allocation can likely
fit the given chunk.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index e20119668c42..357fd6994278 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -306,6 +306,26 @@ static unsigned long pcpu_block_off_to_off(int index=
, int off)
 	return index * PCPU_BITMAP_BLOCK_BITS + off;
 }
=20
+/**
+ * pcpu_check_chunk_hint - check that allocation can fit a chunk
+ * @chunk_md: chunk's block
+ * @bits: size of request in allocation units
+ * @align: alignment of area (max PAGE_SIZE)
+ *
+ * Check to see if the allocation can fit in the chunk's contig hint.
+ * This is an optimization to prevent scanning by assuming if it
+ * cannot fit in the global hint, there is memory pressure and creating
+ * a new chunk would happen soon.
+ */
+static bool pcpu_check_chunk_hint(struct pcpu_block_md *chunk_md, int bi=
ts,
+				  size_t align)
+{
+	int bit_off =3D ALIGN(chunk_md->contig_hint_start, align) -
+		chunk_md->contig_hint_start;
+
+	return bit_off + bits <=3D chunk_md->contig_hint;
+}
+
 /*
  * pcpu_next_hint - determine which hint to use
  * @block: block of interest
@@ -1065,15 +1085,7 @@ static int pcpu_find_block_fit(struct pcpu_chunk *=
chunk, int alloc_bits,
 	struct pcpu_block_md *chunk_md =3D &chunk->chunk_md;
 	int bit_off, bits, next_off;
=20
-	/*
-	 * Check to see if the allocation can fit in the chunk's contig hint.
-	 * This is an optimization to prevent scanning by assuming if it
-	 * cannot fit in the global hint, there is memory pressure and creating
-	 * a new chunk would happen soon.
-	 */
-	bit_off =3D ALIGN(chunk_md->contig_hint_start, align) -
-		  chunk_md->contig_hint_start;
-	if (bit_off + alloc_bits > chunk_md->contig_hint)
+	if (!pcpu_check_chunk_hint(chunk_md, alloc_bits, align))
 		return -1;
=20
 	bit_off =3D pcpu_next_hint(chunk_md, alloc_bits);
--=20
2.30.2


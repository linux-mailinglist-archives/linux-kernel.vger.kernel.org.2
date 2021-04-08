Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE85B357AF4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhDHD6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:58:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2598 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhDHD56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:57:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1383uMGX008445
        for <linux-kernel@vger.kernel.org>; Wed, 7 Apr 2021 20:57:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=twOL+x7dWTU1or/wZU/ar4/+kx+XkJUUrC30nFb+VAw=;
 b=K4AILJ+yroqCe2BRfrojA6CaefIjSggFHuY5SJl1J3tuSkifoFCNuWhyauwwfs+vRDlI
 1oeN8n0k5xTkRh7jCuLrHLqq/KnQkyWaqSo6/dXauLG6bUURgLRX7rAGiPeSnr0onQwd
 jV9lRf5SKwNFU8arrRlbWtUjCU5UHYyVZtc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37sg04kmv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 20:57:48 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 20:57:47 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 58BCE602B00C; Wed,  7 Apr 2021 20:57:41 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 1/6] percpu: fix a comment about the chunks ordering
Date:   Wed, 7 Apr 2021 20:57:31 -0700
Message-ID: <20210408035736.883861-2-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210408035736.883861-1-guro@fb.com>
References: <20210408035736.883861-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7nY0Bov3Q8mWwrbSoDOTibmZaRoOnPqS
X-Proofpoint-GUID: 7nY0Bov3Q8mWwrbSoDOTibmZaRoOnPqS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_01:2021-04-07,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=827 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 3e54097beb22 ("percpu: manage chunks based on
contig_bits instead of free_bytes") chunks are sorted based on the
size of the biggest continuous free area instead of the total number
of free bytes. Update the corresponding comment to reflect this.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 6596a0a4286e..2f27123bb489 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -99,7 +99,10 @@
=20
 #include "percpu-internal.h"
=20
-/* the slots are sorted by free bytes left, 1-31 bytes share the same sl=
ot */
+/*
+ * The slots are sorted by the size of the biggest continuous free area.
+ * 1-31 bytes share the same slot.
+ */
 #define PCPU_SLOT_BASE_SHIFT		5
 /* chunks in slots below this are subject to being sidelined on failed a=
lloc */
 #define PCPU_SLOT_FAIL_THRESHOLD	3
--=20
2.30.2


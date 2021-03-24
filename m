Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC134813B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhCXTHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:07:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237758AbhCXTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:06:37 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OJ30SI023852
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Ieh/wcC81zFFEwxI9926Yf3+LMLmn6Q4SUMf1JE6GPM=;
 b=hwxZIJ0Yh7ybjJwK0QbrtsH5dNtKA4QyKoonlP8x2piRsUGYViKrKRG9ykge5RPm/1VG
 YhnwZKNU9FY3EMUbJmsOk8EYF0VEjQ51hbAdPFr4NyG91vvOba5LcOikkYC81Mpyuzga
 Dr6iqv2ITjKWds66PDjwCKmu66ty/sk+hRs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37fpghpvwe-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:37 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 12:06:36 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 937BB57ACF30; Wed, 24 Mar 2021 12:06:33 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 4/4] percpu: fix a comment about the chunks ordering
Date:   Wed, 24 Mar 2021 12:06:26 -0700
Message-ID: <20210324190626.564297-5-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324190626.564297-1-guro@fb.com>
References: <20210324190626.564297-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_13:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=867 priorityscore=1501 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240137
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
index 148137f0fc0b..08fb6e5d3232 100644
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


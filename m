Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11383521CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhDAVnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:43:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52364 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234808AbhDAVnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:43:09 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131LUU9T010850
        for <linux-kernel@vger.kernel.org>; Thu, 1 Apr 2021 14:43:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TU7lTbDXY8/HWHxH0VIAq/x9yCbCUSjHY51BRaDIVTc=;
 b=B933Z5v9dI4Z0GR55v8Q4DQsbYAQYYpL3hv9DTYyDPYM1hv+m697iEUsP0zI9em3iaJU
 +7DYD92tKQrcf73NwIZ17fS9UJMSay2g7ufNWzu4lXnFQb8UtekjimVE0ZVez6jFU+hc
 HBsLPKNQdIn8NasvuPLLAbK2Umlk0EoLDP0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37n2yue6j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:43:09 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 14:43:09 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 4EF8B5C2F8ED; Thu,  1 Apr 2021 14:43:04 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v1 4/5] percpu: fix a comment about the chunks ordering
Date:   Thu, 1 Apr 2021 14:43:00 -0700
Message-ID: <20210401214301.1689099-5-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401214301.1689099-1-guro@fb.com>
References: <20210401214301.1689099-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: iykYMBbRUnUqu0io0H3Sx-ZhfsMugGvY
X-Proofpoint-ORIG-GUID: iykYMBbRUnUqu0io0H3Sx-ZhfsMugGvY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_13:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=857 clxscore=1015 priorityscore=1501
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010138
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
index 25a181328353..e20119668c42 100644
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


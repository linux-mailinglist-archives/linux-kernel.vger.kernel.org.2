Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4005A424879
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 23:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhJFVJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 17:09:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14814 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239530AbhJFVJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 17:09:32 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196L2hlA006976
        for <linux-kernel@vger.kernel.org>; Wed, 6 Oct 2021 14:07:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=FuZ/BsmiuysM48gUHybvifEGoML00PwXwRs5ktTKdKw=;
 b=HXB8IwSh3ma+X6UwyJ6qoRParbRdZcRl2yxnz6nt+x9ZoyNSHpiZ5N/2em5oeeZ2b4kP
 k+lU5gaZA1v1YvPAbjFoS1n2mTTEZitOot5Odw3O0LY5+g7rezE9QUWlzjBVrsq0RfSJ
 ZQGpb7GnXze5Q9XBtrEDcX2Er2Dq1i4ICJg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhe6qaxsq-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 14:07:39 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 14:07:36 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 3AE0B15D9C828; Wed,  6 Oct 2021 14:07:32 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH] perf/core: allow ftrace for functions in kernel/event/core.c
Date:   Wed, 6 Oct 2021 14:07:32 -0700
Message-ID: <20211006210732.2826289-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: gevAj4540yeNeUsFmKPfpaYOiNme3DHD
X-Proofpoint-GUID: gevAj4540yeNeUsFmKPfpaYOiNme3DHD
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=768 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to trace functions in kernel/event/core.c. Allow ftrace for
them by removing $(CC_FLAGS_FTRACE) from Makefile.

---
We had some discussions about this last year [1]. Seems that enabling
ftrace in kernel/events won't really cause fatal recursion in the tests.
Shall we give it another try?

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2174018.ht=
ml

Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/events/Makefile b/kernel/events/Makefile
index 3c022e33c1091..8591c180b52b3 100644
--- a/kernel/events/Makefile
+++ b/kernel/events/Makefile
@@ -1,10 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_core.o =3D $(CC_FLAGS_FTRACE)
-endif
-
 obj-y :=3D core.o ring_buffer.o callchain.o
=20
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) +=3D hw_breakpoint.o
 obj-$(CONFIG_UPROBES) +=3D uprobes.o
-
--=20
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F16413EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 03:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhIVBSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 21:18:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230469AbhIVBSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 21:18:53 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLH4dt009558
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 18:17:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=33BZOTeb3sp01FGLAUq4mrxu/MD0AjIl5uIt8QTyQvw=;
 b=dOpb0NfH7yo+aMkR/AXHYkG+Wz1dwqhvCNqaKMXq3rqxLZ9iWsLz2Ij/yAMBsND8zakw
 R9wEl/1OH6Utz+iOjJnuzzb96GqpXkivTCsa6Nzt9uRRf67gtYqU3ZlYntuP1xdgOmfY
 5pnjehxayHJzqPPTVcFpFjUG0fxiSgCX+/w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q62h9uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 18:17:24 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 18:17:23 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 948C212E38414; Tue, 21 Sep 2021 18:17:21 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <kernel-team@fb.com>, <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Lucian Grijincu <lucian@fb.com>
Subject: [PATCH] perf/core: fix userpage->time_enabled of inactive events
Date:   Tue, 21 Sep 2021 18:17:15 -0700
Message-ID: <20210922011715.4154119-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: U4zLyooFPl5nnwJL16vK7NAv90EmTLHx
X-Proofpoint-GUID: U4zLyooFPl5nnwJL16vK7NAv90EmTLHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of rdpmc rely on the mmapped user page to calculate accurate
time_enabled. Currently, userpage->time_enabled is only updated when the
event is added to the pmu. As a result, inactive event (due to counter
multiplexing) does not have accurate userpage->time_enabled. This can
be reproduced with something like:

   /* open 20 task perf_event "cycles", to create multiplexing */

   fd =3D perf_event_open();  /* open task perf_event "cycles" */
   userpage =3D mmap(fd);     /* use mmap and rdmpc */

   while (true) {
     time_enabled_mmap =3D xxx; /* use logic in perf_event_mmap_page */
     time_enabled_read =3D read(fd).time_enabled;
     if (time_enabled_mmap > time_enabled_read)
         BUG();
   }

Fix this by updating userpage for inactive events in ctx_sched_in.

Reported-and-tested-by: Lucian Grijincu <lucian@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/perf_event.h |  4 +++-
 kernel/events/core.c       | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d510ad750edc..4aa52f7a48c16 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -683,7 +683,9 @@ struct perf_event {
 	/*
 	 * timestamp shadows the actual context timing but it can
 	 * be safely used in NMI interrupt context. It reflects the
-	 * context time as it was when the event was last scheduled in.
+	 * context time as it was when the event was last scheduled in,
+	 * or when ctx_sched_in failed to schedule the event because we
+	 * run out of PMC.
 	 *
 	 * ctx_time already accounts for ctx->timestamp. Therefore to
 	 * compute ctx_time for a sample, simply add perf_clock().
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1cb1f9b8392e2..549ce22df7bc7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3766,6 +3766,15 @@ ctx_flexible_sched_in(struct perf_event_context *c=
tx,
 			   merge_sched_in, &can_add_hw);
 }
=20
+static inline void
+perf_event_update_inactive_userpage(struct perf_event *event,
+				    struct perf_event_context *ctx)
+{
+	perf_event_update_time(event);
+	perf_set_shadow_time(event, ctx);
+	perf_event_update_userpage(event);
+}
+
 static void
 ctx_sched_in(struct perf_event_context *ctx,
 	     struct perf_cpu_context *cpuctx,
@@ -3807,6 +3816,23 @@ ctx_sched_in(struct perf_event_context *ctx,
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE)
 		ctx_flexible_sched_in(ctx, cpuctx);
+
+	/*
+	 * Update userpage for inactive events. This is needed for accurate
+	 * time_enabled.
+	 */
+	if (unlikely(ctx->rotate_necessary)) {
+		struct perf_event *event;
+
+		perf_event_groups_for_each(event, &ctx->pinned_groups) {
+			if (event->state =3D=3D PERF_EVENT_STATE_INACTIVE)
+				perf_event_update_inactive_userpage(event, ctx);
+		}
+		perf_event_groups_for_each(event, &ctx->flexible_groups) {
+			if (event->state =3D=3D PERF_EVENT_STATE_INACTIVE)
+				perf_event_update_inactive_userpage(event, ctx);
+		}
+	}
 }
=20
 static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
--=20
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ECF41CCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbhI2TpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:45:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30990 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244887AbhI2TpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:45:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TJ5CDL028925
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:43:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=sRrg8f7G8plGq5vXY6WRx/mM+5PaDDf0M+RH2W6eI4Q=;
 b=S3jsbUo//M0zC1JrP+tofqCYONwG96xjLSn25xlnKAAH0741OQreB/3OVn5o/+eaX5SY
 M0ymNSHrOmImiHvAc3aqeqfO8kKfqHgom5S2LepfXm8cQXXXRy1OwmEzNuoRSJG7o4YX
 djFMNh8wn23gl54rF0fdKeU+eow5f7DRtgk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bcbfeytrs-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:43:37 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 29 Sep 2021 12:43:30 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id BA5DB143CA1E5; Wed, 29 Sep 2021 12:43:27 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Lucian Grijincu <lucian@fb.com>
Subject: [PATCH v3] perf/core: fix userpage->time_enabled of inactive events
Date:   Wed, 29 Sep 2021 12:43:13 -0700
Message-ID: <20210929194313.2398474-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 2lm_iJubYZsOb57DYipt87RcB-rBORkT
X-Proofpoint-GUID: 2lm_iJubYZsOb57DYipt87RcB-rBORkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_08,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290115
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

Fix this by updating userpage for inactive events in merge_sched_in.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-and-tested-by: Lucian Grijincu <lucian@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/perf_event.h |  4 +++-
 kernel/events/core.c       | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)

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
index 1cb1f9b8392e2..00c46d839ed90 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3707,6 +3707,29 @@ static noinline int visit_groups_merge(struct perf=
_cpu_context *cpuctx,
 	return 0;
 }
=20
+static inline bool event_update_userpage(struct perf_event *event)
+{
+	if (likely(!atomic_read(&event->mmap_count)))
+		return false;
+
+	perf_event_update_time(event);
+	perf_set_shadow_time(event, event->ctx);
+	perf_event_update_userpage(event);
+
+	return true;
+}
+
+static inline void group_update_userpage(struct perf_event *group_event)
+{
+	struct perf_event *event;
+
+	if (!event_update_userpage(group_event))
+		return;
+
+	for_each_sibling_event(event, group_event)
+		event_update_userpage(event);
+}
+
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx =3D event->ctx;
@@ -3725,14 +3748,15 @@ static int merge_sched_in(struct perf_event *even=
t, void *data)
 	}
=20
 	if (event->state =3D=3D PERF_EVENT_STATE_INACTIVE) {
+		*can_add_hw =3D 0;
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		} else {
+			ctx->rotate_necessary =3D 1;
+			perf_mux_hrtimer_restart(cpuctx);
+			group_update_userpage(event);
 		}
-
-		*can_add_hw =3D 0;
-		ctx->rotate_necessary =3D 1;
-		perf_mux_hrtimer_restart(cpuctx);
 	}
=20
 	return 0;
@@ -6311,6 +6335,8 @@ static int perf_mmap(struct file *file, struct vm_a=
rea_struct *vma)
=20
 		ring_buffer_attach(event, rb);
=20
+		perf_event_update_time(event);
+		perf_set_shadow_time(event, event->ctx);
 		perf_event_init_userpage(event);
 		perf_event_update_userpage(event);
 	} else {
--=20
2.30.2


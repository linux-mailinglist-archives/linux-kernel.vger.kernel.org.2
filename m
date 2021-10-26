Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB343AE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhJZIty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:49:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233440AbhJZItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:49:52 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q6EJcf024705;
        Tue, 26 Oct 2021 08:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UhXzjMa3txna4iKnajb+vIdMHJskouD4poe3BF/9KFg=;
 b=sXooSLWN7Ed5dhvoVXgngeUWt0qYuUC1qUF0kuBuSissDbOfHJa23ZaChAUFDqK2Uamm
 wvGcvIcVU/zQyZydJXHAMlr9OX2zAmoFcrftERWnSfR4NX8jXHHVuUvl6y5w9FwRhim4
 jA2tXOJ9yHa92bisyNUUrwJWPe2AyJwYKGazn56pWb/LyCHYblCwVKyjSVsdf255kCnZ
 O0NTn6pPQvFhltaisjo4ES4+u2srdLWUTpCKF87vBdF0/egMhCW5E2HrTUjw+52XIyOb
 CnLgUA0tAfa0bV7adqzNPGTALLDp3F503Qq9fUixaI3nsiQ+V7vGNzeOAaXQV3asI6va iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx4k5pjaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 08:47:18 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q8ROZ2002811;
        Tue, 26 Oct 2021 08:47:18 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx4k5pja2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 08:47:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q8khCg006209;
        Tue, 26 Oct 2021 08:47:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3bx4esujwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 08:47:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q8lDXZ61341986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 08:47:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90367AE05D;
        Tue, 26 Oct 2021 08:47:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36357AE059;
        Tue, 26 Oct 2021 08:47:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.190.3])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 08:47:10 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org
Cc:     linux-kernel@vger.kernel.org, songliubraving@fb.com,
        maddy@linux.vnet.ibm.com, kjain@linux.ibm.com, mingo@redhat.com,
        eranian@google.com
Subject: [PATCH V2] perf/core: Avoid calling perf_mux_hrtimer_restart multiple times when scheduling event groups
Date:   Tue, 26 Oct 2021 14:17:09 +0530
Message-Id: <20211026084709.47079-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K70G4mL2aWnWdvFLa6Ial7f4TSNUAM_u
X-Proofpoint-GUID: WBBkJCfQxhFnht6Xmchj-tbPzc4_GPUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf uses multiplexing if there are more events to be scheduled than the
available counters. With multiplexing, event groups will be rotated at
specified interval of time which is set using "hrtimer". During event
scheduling, if any of the event group fails to schedule, multiplexing
gets enabled by setting "rotate_necessary" for that event context and
starting the hrtimer by calling "perf_mux_hrtimer_restart".

Patch adds an optimisation to avoid calling "perf_mux_hrtimer_restart"
multiple times if already rotate_necessary is set for that context.
Even though "perf_mux_hrtimer_restart" will just return if hrtimer is
already active, this could avoid the overhead of calling this function
multiple times if there are many event groups. Patch adds the check to
avoid calling perf_mux_hrtimer_restart() for each event group on
every schedule.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Acked-by: Song Liu <song@kernel.org>
---
Changelog:
From v1 -> v2:
 - Rebased on top of latest kernel source.
 - Added Acked-by from Song Liu

 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f23ca260307f..9e1a06646ad0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3753,8 +3753,10 @@ static int merge_sched_in(struct perf_event *event, void *data)
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 		} else {
-			ctx->rotate_necessary = 1;
-			perf_mux_hrtimer_restart(cpuctx);
+			if (!ctx->rotate_necessary) {
+				ctx->rotate_necessary = 1;
+				perf_mux_hrtimer_restart(cpuctx);
+			}
 			group_update_userpage(event);
 		}
 	}
-- 
2.33.0


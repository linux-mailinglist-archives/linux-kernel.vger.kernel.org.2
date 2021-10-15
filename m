Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7466442E9A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhJOHGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:06:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231265AbhJOHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:06:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F43Idl027081;
        Fri, 15 Oct 2021 03:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ikN0UI9Sqp09c6YjwYSOIIoLdglCOUwjLyCHLGvDJTc=;
 b=tTmZnmeuunUQwqFc5mVBky6CvyF0CkDM14jRyidfnzOBXLlOXagfBB1KCQ7Aq5WgH1Cf
 CTjFHzA5WCMNVyufuDJoPRKeTTNRtiLUefu0UgJSax5pH3058Tce61NQHk7Q3QhWzOSH
 4ZMwhfhJvL28lsgQ1SWsNq75rCuko1RhxrvMjVdoiHnd5qcF4zXjmDSIGPiGPn9UVnGi
 uY86HEfzqd6j6JOEQoET19WQ180eeK97FAc8ZdLHamcfP1WB1dPLJ1URRKWIRz7sjFMi
 ztwkYEFOps5mmejCKod6OS9OGvgE5XknFhRnTnl/Hrg4WpzPF5r7GaS+/stdNLCwS+hL cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bpxk4y1wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 03:04:15 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19F6blic014104;
        Fri, 15 Oct 2021 03:04:15 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bpxk4y1vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 03:04:15 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19F6vufM027323;
        Fri, 15 Oct 2021 07:04:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3bk2qagyrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 07:04:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19F74AZZ52560258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 07:04:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37F0CA405F;
        Fri, 15 Oct 2021 07:04:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1184A4060;
        Fri, 15 Oct 2021 07:04:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.195.35.87])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Oct 2021 07:04:06 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org
Cc:     linux-kernel@vger.kernel.org, songliubraving@fb.com,
        maddy@linux.vnet.ibm.com, kjain@linux.ibm.com, mingo@redhat.com,
        eranian@google.com
Subject: [V2] perf/core: Avoid calling perf_mux_hrtimer_restart multiple times when scheduling event groups
Date:   Fri, 15 Oct 2021 12:34:03 +0530
Message-Id: <20211015070403.4809-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aNjqvGOUaQZqTSmkchZWjV68-MAq_ktx
X-Proofpoint-ORIG-GUID: W3I1eZwqA3yxMEIhxHG27LVWlKrxWKZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_02,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150043
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
---
Changelog:
From v1 -> v2:
 - Rebased on top of latest kernel source.

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
2.27.0


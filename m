Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691B041DAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350626AbhI3NRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:17:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48672 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350528AbhI3NRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:17:47 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UD0POk030761;
        Thu, 30 Sep 2021 09:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=75uF3Ld1MXK2bY0HiwRxp8CJcuKYf1vmsNYGBKdn6Yg=;
 b=K1T123IIAAe1RhG3k0jKYCblTzJSuM2Wx2UduSfqeDZNdtFoYl4eS8jJt/vdGRY+JwNZ
 JGzp3s/KS7nvLjknnHDwm7XWyiFOB3LKSfvPfo1IW8GR7Kx/3Hs8UEKAxRC8PFErPb10
 OP8Q87mdogyjD4lhWW3HrUOkqZM7sk5+TZXYGokJQ2IHisT5sQ1DsvMeqrrfFmX8gczh
 Jw/BFSMbMOGJqHU1xhxwYnSsjBKR/aH7hLE3JtrfuWX1oEe8WgKzqeJKZCCrK1sxrqH2
 i1dN5USaz49NKpN4RKAjxFTgBClCJZrgT0nulcViE6q/9dzYkJdGNPk/uMJI7Zw5QjRw /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bddr8gffh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 09:15:58 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18UD1Yku003513;
        Thu, 30 Sep 2021 09:15:58 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bddr8gff2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 09:15:58 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18UDC7e0002240;
        Thu, 30 Sep 2021 13:15:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3b9udah49k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 13:15:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18UDAiNS55902594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 13:10:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01327A405C;
        Thu, 30 Sep 2021 13:15:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6C68A4054;
        Thu, 30 Sep 2021 13:15:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.207.39])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Sep 2021 13:15:50 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org
Cc:     linux-kernel@vger.kernel.org, songliubraving@fb.com,
        maddy@linux.vnet.ibm.com, kjain@linux.ibm.com, mingo@redhat.com,
        eranian@google.com
Subject: [PATCH] perf/core: Avoid calling perf_mux_hrtimer_restart multiple times when scheduling event groups
Date:   Thu, 30 Sep 2021 18:45:47 +0530
Message-Id: <20210930131547.1923-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q2nH4y5_cjiu0Uo-PGC6X-2bi5cyinO8
X-Proofpoint-ORIG-GUID: WlCF_sWSNQ3C_B3SZMF-ZHeGVkt0B8Fd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_04,2021-09-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300083
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
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0c000cb01eeb..26eae79bd723 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3731,8 +3731,10 @@ static int merge_sched_in(struct perf_event *event, void *data)
 		}
 
 		*can_add_hw = 0;
-		ctx->rotate_necessary = 1;
-		perf_mux_hrtimer_restart(cpuctx);
+		if (!ctx->rotate_necessary) {
+			ctx->rotate_necessary = 1;
+			perf_mux_hrtimer_restart(cpuctx);
+		}
 	}
 
 	return 0;
-- 
2.30.1 (Apple Git-130)


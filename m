Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945D741DA48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351163AbhI3MyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:54:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7776 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351133AbhI3MyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:54:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UCgkRf015395;
        Thu, 30 Sep 2021 08:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jcneVHluFK9Ah2ZjC1w6GzemQbNI/5QEimSyZhzoQ7k=;
 b=QuT1wYjhLT3BeRswTb9P40UIABwdryo1cldcGvVYHN5v7uMl/UzQgehhW37P78dKfpTE
 /NVeOktsZ1Q8s0MtwwO18kAjeN2x/3KSUuVF25WfUWZ114t9RTiue+sgBNk8qNwzZHHT
 Hhmt6F71Ut7Pzpnwo/D8I5dZB0LwjMe2fNPi/ejVsxTdyiB35bsJOnUHzeyZx7A2Qwyr
 DLkH/JXhRPcOTzZQx8IOHBS1jljCYMrtDTBT5tSgIgSsxBM95brMPuXKYh1ztSq/C1dD
 tK2P2cmlQWIqEsRQdIMYrXjACuEkBTTwj9zn9N3/+c6yyK7xJqYMOJx1TCLfEViR+wW6 fA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bddfs06k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 08:52:28 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18UChGfI017001;
        Thu, 30 Sep 2021 12:52:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3b9udabkh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 12:52:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18UClIts45941230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:47:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56688A405B;
        Thu, 30 Sep 2021 12:52:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F1A0A4062;
        Thu, 30 Sep 2021 12:52:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.207.39])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Sep 2021 12:52:21 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        arjan@linux.intel.com, srikar@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, kjain@linux.ibm.com
Subject: [RFC] hrtimer: Fix the hrtimer_forward to use correct delta for expiry time
Date:   Thu, 30 Sep 2021 18:22:19 +0530
Message-Id: <20210930125219.1658-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wiznxC953AO-n5qFKBaJt0C-uWtud3Sh
X-Proofpoint-ORIG-GUID: wiznxC953AO-n5qFKBaJt0C-uWtud3Sh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_04,2021-09-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hrtimer uses "hrtimer_forward" function to forward the timer
expiry. This function takes the "time" from when to forward
and how much "interval" to forward as inputs. In some cases, it
is observed that though correct interval is given to forward the
timer, the expiry time is set to value less than expected interval.
This will cause the timer to expire ahead of expected expiry time.
Before updating the timer expiry value, hrtimer_forward checks to
see if there is any delta between the time from when to forwad
and previously set expiry. And this behaviiour is observed when
delta is large value.

For example, consider case where we want to forward the expiry
from "now" to 10 milliseconds. Below is trace prints captured by
dumping the values used in "hrtimer_forward". And this instance is
captured while forwarding timer from perf event multiplexing code
which uses hrtimer.

<<>>
[001] d....   304.118944: perf_mux_hrtimer_restart: Restarting timer from perf_mux_hrtimer_restart
[001] d....   304.118945: hrtimer_forward: In nanoseconds, now is 303938589749, delta is 52868589749, hrtimer_get_expires(timer) is 251070000000, interval is 10000000
[001] d....   304.118945: hrtimer_forward: Caller is perf_mux_hrtimer_restart+0xb0/0x120
[001] d....   304.118946: hrtimer_forward: Caller's caller is merge_sched_in+0x268/0x4e0
[001] d....   304.118946: hrtimer_forward: orun is 5286
[001] d....   304.118947: hrtimer_forward: In hrtimer_add_expires_ns, before ktime_add_ns timer->node.expires in ns is 251070000000, timer->_softexpires is 251070000000,  ns is 52860000000
[001] d....   304.118948: hrtimer_forward: In hrtimer_add_expires_ns, after ktime_add_ns timer->node.expires in ns is 303930000000, timer->_softexpires is 303930000000
[001] d....   304.118948: hrtimer_forward: In hrtimer_add_expires, in nanoseconds, before ktime_add_safe, timer->node.expires in ns is 303930000000, timer->_softexpires is 303930000000
[001] d....   304.118949: hrtimer_forward: In hrtimer_add_expires, in nanoseconds, after ktime_add_safe, timer->node.expires in ns is 303940000000, timer->_softexpires is 303940000000
[001] d....   304.118949: hrtimer_forward: After hrtimer_add_expires, hrtimer_get_remaining in nanoseconds is 1405169

<<>>

In this example,
timer->node.expires = 251070000000 ns ( previously set expiry )
now = 303938589749 ns
delta = 52868589749 ns

Here delta is "52868589749" which is greater than the interval to
forward ( ie 10000000 ns ). Hence hrtimer_forwards adds this difference
to present timer->node.expires in hrtimer_add_expires_ns() function. But
instead of using actual "delta", code is using (delta/interval * interval)
as below:

<<>>
s64 incr = ktime_to_ns(interval);
orun = ktime_divns(delta, incr);
hrtimer_add_expires_ns(timer, incr * orun);
<<>>

Hence we are actually using "orun * 10000000". In this example, it will be
"52860000000" since "orun" does not include the mod value. Here we are
missing "8589749" nanoseconds in the timer expiry. Hence, the final expiry
time will be set to "303940000000".

Since we are not using exact delta, the hrtime remaining will be
around 1405169 nanoseconds and will cause the timer to expire in 1.4 ms
instead of 10 ms. Fix this by using "delta" instead of using the divided
value.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ea8702eb516..9e085813d9d2 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1054,7 +1054,7 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
 		s64 incr = ktime_to_ns(interval);
 
 		orun = ktime_divns(delta, incr);
-		hrtimer_add_expires_ns(timer, incr * orun);
+		hrtimer_add_expires_ns(timer, ktime_to_ns(delta));
 		if (hrtimer_get_expires_tv64(timer) > now)
 			return orun;
 		/*
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8BF3CEBA5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353945AbhGSRWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:22:47 -0400
Received: from mail-co1nam11on2103.outbound.protection.outlook.com ([40.107.220.103]:34205
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348388AbhGSPno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:43:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDf2DIA0eK3P8JCEUr6mTO4jI/vm5AaX6VYfBiOUuyyiSfz8Kc/U0U9exI90wd7zmEjLd1FJMW3YvRujfy9GJHwLWL0GYaPGkUduHIIRFmCQQyicrWBpdI8GaHNUHZkk12w1KDWMWK4ZVW5JOWb95K3dWEqbcl0qCpdQiJW3fXZQfz6F6q5oOcdd3Eyir/oDKOlvTDCPASZdKz5Lrzgh//rbzr1pSXQIdQE2B2NmNbeMNdy4MwppOxHYDHujpcop4SIWXHGYDEakhKD9/UQG/JtJnNVsMmgaHd2AVYHpheOeBWOASAlIaisEQ4la41d94hlhKtPuLill7VzmIXFNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WX+6y2WfKO5pkPRzE0a3FLutQ1IUOWovZEjbDGhOng=;
 b=E5RrN5SPZNM4LbtFjHOHhkutkR6+PfBf1yPMNS4GdqCNG4c2XtD+04UxxOrt1DSlR68qDSEENsfycQXOsd8fORd+RWq3Gr8rquz5fc81uEAFTE658MiSbH9A8FqVMoHNNadQvy9DtzNQu/mCKvmD0aGUaVMuBtDM6pm5Rjf4xoJsE0VJU2fzRPRYr88godfkvmesIMgz4LgNTM4AGiTo54II7X0GOj4oz+n171oCQs3v4/TakM6RszCMw1c2ZDDHCFFc3EmoQepW/VzXkNUeQmxncbj6bQ7FAZJxmClRtOaV7pNUSqVLIEydeW/7lrFuOfmaBzeqL1cxd6JevxSA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WX+6y2WfKO5pkPRzE0a3FLutQ1IUOWovZEjbDGhOng=;
 b=anuYWY3COuDiFfG8U/CRfxzZY0bPaDE2WUhakIRO9k3mIm4WY6jP5ui0nvHrlUeUc8YV9NgHCNnbmOtQpe5kSCMxkP95kzb8B+KKdsYKlEyajwh1SEOi4k+uOLJm4wzS13KcaO71yMvPhq5usXAYnsL4rX2SebEpODBSSbex8B4=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CY4PR11MB2007.namprd11.prod.outlook.com (2603:10b6:903:30::7)
 by CY4PR1101MB2264.namprd11.prod.outlook.com (2603:10b6:910:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 16:24:22 +0000
Received: from CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::542c:7439:3edd:1a9b]) by CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::542c:7439:3edd:1a9b%3]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 16:24:22 +0000
Date:   Mon, 19 Jul 2021 12:24:18 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [BUG] 4.4.262: infinite loop in futex_unlock_pi (EAGAIN loop)
Message-ID: <20210719162418.GA28003@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN6PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:405:14::20) To CY4PR11MB2007.namprd11.prod.outlook.com
 (2603:10b6:903:30::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN6PR16CA0034.namprd16.prod.outlook.com (2603:10b6:405:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Mon, 19 Jul 2021 16:24:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce45ea7-f25b-4303-9739-08d94ad1aa5f
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2264:
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2264EB95EBA2BACCFC3B8DECA0E19@CY4PR1101MB2264.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0yPtedfPm55kLcaYXGjijHjjQKOXswml2rz52G1q7XQrk+g/2/NjX27Z/AI4kxSIPf3ptbimvKNZ9gO42EoOwHvgtlSBocSl8JOtY5gpaSg0i5xVKgokInicUTSzcNKzTNarqc1zzILatFxPKkLYWTDO4pGQsqNaE1Cc8OH7+784eMpPUwqGSdHYv4i19Mxp2f2NMtaVwW6u1DZNfoHHR7aYs/Qwj1qIuP/4/3U5cIgBm+IG0BBa/DwqaJtaXO448eUejGIU7P5WE7v2V3gGSR3anUunOe4lrnS+Oy2uokEbbuF3zUp9ULO3BfXnapqqd7BkjBoMf/rBViU1PMZRWoYAokILKzu0xYe6zxNeKxBsZ3/c9l4BDWa0WcaTTsTwHLd1V/dhyIZQ7rVufPCVA6WIhKFBPc2ZlWGAOLKimSNWzitiMhMdQKtcgjenamJlTPnCmjKiCDSzwgWa5enpwSSbYcMkSf/+i/vI+5lDze3OjumVvBs5bYhgrmtqcMt8Tt9YoBDmmDVbzzlQkySZbtcD+0h1xbmSldZFZtoj9fiWfXDIltBB1Q5IraZzKD6t7V1r0TCfjfXdyKgznLh7AVBTPxk6YQWZqv7viUVGsaVwif0dZEwb4ADrqYEOmTG7YwaDDp+PdBIlYtRrhqAzJnSBQ6w8/vCQZ1LEKVaxfW4QGybgc1/6AtsL1eqpnkL8C8TtleGAeRoJshAZuaktobtRLcHZxdBs98dwI3+Yds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39830400003)(136003)(346002)(396003)(26005)(478600001)(4326008)(8936002)(7696005)(44144004)(52116002)(2906002)(66556008)(66476007)(66576008)(38350700002)(38100700002)(66946007)(8676002)(86362001)(235185007)(83380400001)(186003)(110136005)(54906003)(33656002)(1076003)(5660300002)(316002)(55016002)(3450700001)(956004)(44832011)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TsOozwEMHaq2tpaDMNuB880XLFe48TzG9TbMHBmL28vcUI69xxGCBnXJdXjT?=
 =?us-ascii?Q?vUcrCpFp3u4+XfkGNUbwuTHH/qL9gev5p1v5pH/LVy3rPW2Zlz5hZe+64TCZ?=
 =?us-ascii?Q?Ame0CcBHy0pngE8vnLVqkaPMyqWxZjB/UbId6177dX5zitwvx/xocQykwOXr?=
 =?us-ascii?Q?4KrkNfAlgj/I64WgiCwhXEBJsktAagHfuxkiR5hWZ5yXdSdOI6gVFTBQUxei?=
 =?us-ascii?Q?9cUWjTG3+rcpGo2Ekz5vdYEmRvHqJl9kn4sd19kyQog+yh4m+QcK2iTQRmXG?=
 =?us-ascii?Q?xaA9wEjpnt4HRcQ6LkWxoyIWgViGtrJTNaxMve2Cmiq29iOCLZVOx3YkP8bB?=
 =?us-ascii?Q?TOPVUCM8tkIk3vF19ES1uIXblz83XHW++JPuFaCFym1oDtQl9YxA/WpjGEl4?=
 =?us-ascii?Q?rYgyzhkNfP/lVPfDDSWzt2HVeJ2L/AUqHdXGKCKfUdUHoRULOMrkD/6t/gVC?=
 =?us-ascii?Q?bdyHgwc9yRrsKr09NDug1QJy0c3UqKVRgy78gAX/AoHjUUfGAd+sUNeSVxQW?=
 =?us-ascii?Q?x6m36wvZSQE6CW0C5RS/dThptZpMjELcr00lxjy3p5AJuJ0a5qStLwqdt5xm?=
 =?us-ascii?Q?Ip6OCbE34RBu9gFiwDKldGEocaVWVmih5L8M1u2PPl9EMzi02hBRaHa4sfQk?=
 =?us-ascii?Q?nxXsqXs/phvdRRtKYsqd3TXwsvSxPKBfFRx5NmP6wphKQTgUEGmQM9c+1ZbB?=
 =?us-ascii?Q?sOwMbBAsExkHuIGpZmgjgcEAKZHO1CzXk3vrhWNhZUAAUYpBglS9vPAaVAYG?=
 =?us-ascii?Q?2mTWJzSIzfoYt4VSTs+/mGoYBgMqRYEHB+0AkOl0r7c8tYZ+lGAaZZJsWtv+?=
 =?us-ascii?Q?OCrSNhvdp/fX3srxfPx+cyhgV4ykPSUUt2sHRY1UjuByyfsDP/gPo3lXEJ/g?=
 =?us-ascii?Q?c9KiWUq8le0wSNl9l6qqMiPIN97mPVqwthVChIyi4SAOtY+KBRvG5p49Pzzk?=
 =?us-ascii?Q?vzr6hCXyM4bNppLDK9+ze66yVPn864fnu9CZps3BVJN8vnu0o2dEIPceCPhH?=
 =?us-ascii?Q?DA/hk9f2iCXPbasBrXBNvGCfhU3pzWA1l7KFSNbFDiT2WEHgvHDbRfKNaGBn?=
 =?us-ascii?Q?JsXEGQ6HAEpKxMbgvmd/ha3I+A9wCiz+1ZR1/RlQC/WsWLqgRp5nllVLOyfi?=
 =?us-ascii?Q?CHe6bwcSa0YMobE4pBNSvG/Rrp8aD8piOWDSf7coHiPzAiJFW0Lb8vWiL4lh?=
 =?us-ascii?Q?6LcOOjxKe5k+/9yYZwqRhtKOiwMBUVOFBCyhEkKNjhYl0+3bGvZ7HZMHWqvp?=
 =?us-ascii?Q?1QJwXQBZg532GdT1JWsRc7d/2F43LzA9giF0hr2MxkSmBlcWx0w6OvENkw/f?=
 =?us-ascii?Q?H8yhfH6Up81fGsmy+QtVVDpu?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce45ea7-f25b-4303-9739-08d94ad1aa5f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 16:24:22.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEh9BK0wZ29lY9d2GvzGwhCRJNKsRCqHgKoAxIKTQpJm5/HmG8emlz6tRHui0JCgnC38Q0iQgiR+M17Sr1MMgkXcNKDcrAJCYGR1/3D61wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2264
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[BUG] 4.4.262: infinite loop in futex_unlock_pi (EAGAIN loop)

   [ replicator, attached ]
   [ workaround patch that crudely clears the loop, attached ]
   [ 4.4.256 does _not_ have this problem, 4.4.262 is known to have it ]

When a certain, secure-site application is run on 4.4.262, it locks up and
is unkillable.  Crash(8) and sysrq backtraces show that the application
is looping in the kernel in futex_unlock_pi.

Between 4.4.256 and .257, 4.4 got this 4.12 patch backported into it:

   73d786b ("[PATCH] futex: Rework inconsistent rt_mutex/futex_q state")

This patch has the following comment:

   The only problem is that this breaks RT timeliness guarantees. That
   is, consider the following scenario:

      T1 and T2 are both pinned to CPU0. prio(T2) > prio(T1)

        CPU0

        T1
          lock_pi()
          queue_me()  <- Waiter is visible
   
        preemption

        T2
          unlock_pi()
            loops with -EAGAIN forever

    Which is undesirable for PI primitives. Future patches will rectify
    this.

This describes the situation exactly.  To prove, we developed a little
kernel patch that, on loop detection, puts a message into the kernel log for
just the first occurrence, keeps a count of the number of occurrences seen
since boot, and tries to break out of the loop via usleep_range(1000,1000).
Note that the patch is not really needed for replication.  It merely shows,
by 'fixing' the problem, that it really is the EAGAIN loop that triggers
the lockup.

Along with this patch, we submit a replicator.  Running this replicator
with this patch, it can be seen that 4.4.256 does not have the problem.
4.4.267 and the latest 4.4, 4.4.275, do.  In addition, 4.9.274 (tested
w/o the patch) does not have the problem.

From this pattern there may be some futex fixup patch that was ported
back into 4.9 but failed to make it to 4.4.

Acknowledgements: My colleague, Scott Shaffer, performed the crash/sysrq
analysis that found the futex_unlock_pi loop, and he raised the suspicion
that commit 73d786b might be the cause.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=futex-unlock-pi-eagain-hack

Fix infinite 'EAGAIN' loop in futex_unlock_pi (Raytheon bug).

  [ 4.4.256-RedHawk is known _not_ to have this problem ]
  [ 4.4.262-RedHawk is known to have it ]
  [ This is unlikely to be caused by the rt patch ]
  [ or by our patches ]

A customer with a rather large, secure-site application
occasionally stalls indefinately, spinning in
futex_unlock_pi.  This cannot be cleared except by
rebooting.

New to 4.4 is 73d786b ("[PATCH] futex: Rework inconsistent
rt_mutex/futex_q state").  This adds an EAGAIN loop which
appears to be the cause of the problem.  That commit has
this comment:

   The only problem is that this breaks RT timeliness guarantees. That
   is, consider the following scenario:

      T1 and T2 are both pinned to CPU0. prio(T2) > prio(T1)

        CPU0

        T1
          lock_pi()
          queue_me()  <- Waiter is visible
    
        preemption

        T2
          unlock_pi()
            loops with -EAGAIN forever

    Which is undesirable for PI primitives. Future patches will rectify
    this.

The above matches the behavor exactly.  Our replicator,
based on posix-thread/pthread_mutex_lock/1-1.c test shows
that indeed this is the problem.

We fix, for now, by introducing a one millisecond sleep
in the looping code.  This gives the lower priority task
T1 the time it needs to clean up the condition that the
higher priority task T2 is spin-waiting on.

This patch is temporary until mainline linux fixes this.
We suspect that some futex patch from 4.12 that actually
fixes this failed to be backported.

Problem-Analysed-by: Scott Shaffer while at concurrent-rt.com
Developed-by: Joe Korty while at concurrent-rt.com

Index: b/kernel/futex.c
===================================================================
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -66,6 +66,7 @@
 #include <linux/freezer.h>
 #include <linux/bootmem.h>
 #include <linux/fault-inject.h>
+#include <linux/delay.h>
 
 #include <asm/futex.h>
 
@@ -1529,8 +1530,10 @@ static void mark_wake_futex(struct wake_
 	q->lock_ptr = NULL;
 }
 
+unsigned long futex_eagain_ctr = 0;
+
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *this,
-			 struct futex_hash_bucket *hb)
+			 struct futex_hash_bucket *hb, int *dologp)
 {
 	struct task_struct *new_owner;
 	struct futex_pi_state *pi_state = this->pi_state;
@@ -1564,6 +1567,7 @@ static int wake_futex_pi(u32 __user *uad
 	 */
 	if (!new_owner) {
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+		*dologp = 1;
 		return -EAGAIN;
 	}
 
@@ -2967,7 +2971,8 @@ retry:
 	 */
 	match = futex_top_waiter(hb, &key);
 	if (match) {
-		ret = wake_futex_pi(uaddr, uval, match, hb);
+		int log_eagain = 0;
+		ret = wake_futex_pi(uaddr, uval, match, hb, &log_eagain);
 		/*
 		 * In case of success wake_futex_pi dropped the hash
 		 * bucket lock.
@@ -2987,6 +2992,11 @@ retry:
 		if (ret == -EAGAIN) {
 			spin_unlock(&hb->lock);
 			put_futex_key(&key);
+			if (log_eagain) {
+				printk_once("WARNING: futex_unlock_pi: in EAGAIN loop\n");
+				futex_eagain_ctr++;
+				usleep_range(1000, 1000); /* let the guy run who will clean things up */
+			}
 			goto retry;
 		}
 		/*

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1-1.c"

/*   
 * LTP project test pthread_mutex_lock/1-1.c, modified to trigger
 * the futex_unlock_pi EAGAIN loopstall, on those kernels having
 * this bug.
 *
 * To build: cc -o 1-1 1-1.c -pthread
 * To run: taskset 4 ./1-1
 * Result: if helper kernel patch is installed, one will get this
 * in the kernel log: 'WARNING: futex_unlock_pi: in EAGAIN loop'.
 * This indicates that the EAGAIN loop was seen and broken out of with
 * a usleep_range(1000,1000).  If the helper kernel patch is not present,
 * 1-1 loops forever in futex_unlock_pi, and is unkillable.
 *
 *
 *
 * Copyright (c) 2002, Intel Corporation. All rights reserved.
 * Created by:  bing.wei.liu REMOVE-THIS AT intel DOT com
 * This file is licensed under the GPL license.  For the full content
 * of this license, see the COPYING file at the top level of this 
 * source tree.

 * Test that pthread_mutex_lock()
 *   shall lock the mutex object referenced by 'mutex'.  If the mutex is
 *   already locked, the calling thread shall block until the mutex becomes
 *   available. This operation shall return with the mutex object referenced
 *   by 'mutex' in the locked state with the calling thread as its owner.

 * Steps: 
 *   -- Initialize a mutex to protect a global variable 'value'
 *   -- Create N threads. Each is looped M times to acquire the mutex, 
 *      increase the value, and then release the mutex.
 *   -- Check if the value has increased properly (M*N); a broken mutex 
 *      implementation may cause lost augments.
 *
 */

#define _XOPEN_SOURCE 600

#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <sched.h>
#include "posixtest.h"

#define    THREAD_NUM  	15
#define    LOOPS     	40000

static void setpri(int priority)
{
	struct sched_param parm;
	parm.sched_priority = priority;
	sched_setscheduler(0, SCHED_FIFO, &parm);
}

void *f1(void *parm);

pthread_mutex_t    mutex = PTHREAD_MUTEX_INITIALIZER;
int                value;	/* value protected by mutex */

int main(void)
{
  	int                   i, rc __attribute__((unused));
  	pthread_attr_t        pta;
	pthread_mutexattr_t   mta;
  	pthread_t             threads[THREAD_NUM];

  	pthread_attr_init(&pta);
  	pthread_attr_setdetachstate(&pta, PTHREAD_CREATE_JOINABLE);

	pthread_mutexattr_init(&mta);
	pthread_mutexattr_setprotocol(&mta, PTHREAD_PRIO_INHERIT);
	pthread_mutex_init(&mutex, &mta);
  
  	/* Create threads */
  	fprintf(stderr,"Creating %d threads\n", THREAD_NUM);
  	fprintf(stderr,"Executing %d loops\n", LOOPS);
  	for (i=0; i<THREAD_NUM; ++i)
    		rc = pthread_create(&threads[i], &pta, f1, NULL);

	/* Wait to join all threads */
  	for (i=0; i<THREAD_NUM; ++i)
    		pthread_join(threads[i], NULL);
  	pthread_attr_destroy(&pta);
  	pthread_mutex_destroy(&mutex);
  
  	/* Check if the final value is as expected */
  	if(value != (THREAD_NUM) * LOOPS) {
	  	fprintf(stderr,"Using %d threads and each loops %d times\n", THREAD_NUM, LOOPS);
    		fprintf(stderr,"Final value must be %d instead of %d\n", (THREAD_NUM)*LOOPS, value);
		printf("Test FAILED\n");
		return PTS_FAIL;
  	}
	
	printf("Test PASSED\n");
	return PTS_PASS;
}

void *f1(void *parm)
{
  	int   i, tmp;
  	int   rc = 0;

	static int next = 1;
	int thread_id = next++;
	int priority = thread_id + 4;
	setpri(priority);

	/* Loopd M times to acquire the mutex, increase the value, 
	   and then release the mutex. */
	   
  	for (i=0; i<LOOPS; ++i) {
      		rc = pthread_mutex_lock(&mutex);
      		if(rc!=0) {
        		fprintf(stderr,"Error on pthread_mutex_lock(), rc=%d\n", rc);
			return (void*)(PTS_FAIL);
      		}

    		tmp = value;
    		tmp = tmp+1;
    		// fprintf(stderr,"%2d: ", thread_id);
    		usleep((i%150)+9);	  /* delay the increasement operation */
    		value = tmp;

      		rc = pthread_mutex_unlock(&mutex);
      		if(rc!=0) {
        		fprintf(stderr,"Error on pthread_mutex_unlock(), rc=%d\n", rc);
 			return (void*)(PTS_UNRESOLVED);
      		}
    		usleep(67);
  	}
  	pthread_exit(0);
  	return (void*)(0);
}

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="posixtest.h"

/*
 * Copyright (c) 2002, Intel Corporation. All rights reserved.
 * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
 * This file is licensed under the GPL license.  For the full content
 * of this license, see the COPYING file at the top level of this
 * source tree.
 */

/*
 * return codes
 */
#define PTS_PASS        0
#define PTS_FAIL        1
#define PTS_UNRESOLVED  2
#define PTS_UNSUPPORTED 0 /* was 4 */
#define PTS_UNTESTED    0 /* was 5 */


--G4iJoqBmSsgzjUCe--

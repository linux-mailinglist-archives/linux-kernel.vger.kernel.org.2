Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEAE36D1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhD1GGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:06:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:61543 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234334AbhD1GGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:06:03 -0400
IronPort-SDR: 2tAuWH748QAcRXC+jH4GLUTY2EGxDZ9Nt6w9VjHPmIUmkJp9Baf+BXiQMsT7Zeag3E7GDbSAzy
 CtiReFyl1EOw==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="257968207"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="257968207"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 23:05:17 -0700
IronPort-SDR: okLhxuR/iAreFUh6pLiqdMv1n14w3pDRc8ALNB6WVGJqOLzYE/vScdD2etknxwQV1qDXZmHHjq
 UvCSgHmD+kcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="447853452"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 23:05:14 -0700
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Aubrey Li <aubrey.intel@gmail.com>, Josh Don <joshdon@google.com>
Cc:     Don Hiatt <dhiatt@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net>
 <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com>
 <CABk29Nuz-FDCk23ajcr9gS4KD-wMpwyn=ASu+yuTTT445rwTvw@mail.gmail.com>
 <CAERHkrvU2Xzi5p9Dph3zZ7zkoYjSV1krK-UhqE7+Qb80FodEGg@mail.gmail.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com>
Date:   Wed, 28 Apr 2021 14:05:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAERHkrvU2Xzi5p9Dph3zZ7zkoYjSV1krK-UhqE7+Qb80FodEGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/21 9:03 AM, Aubrey Li wrote:
> On Wed, Apr 28, 2021 at 7:36 AM Josh Don <joshdon@google.com> wrote:
>>
>> On Tue, Apr 27, 2021 at 10:10 AM Don Hiatt <dhiatt@digitalocean.com> wrote:
>>> Hi Josh and Peter,
>>>
>>> I've been running into soft lookups and hard lockups when running a script
>>> that just cycles setting the cookie of a group of processes over and over again.
>>>
>>> Unfortunately the only way I can reproduce this is by setting the cookies
>>> on qemu. I've tried sysbench, stress-ng but those seem to work just fine.
>>>
>>> I'm running Peter's branch and even tried the suggested changes here but
>>> still see the same behavior. I enabled panic on hard lockup and here below
>>> is a snippet of the log.
>>>
>>> Is there anything you'd like me to try or have any debugging you'd like me to
>>> do? I'd certainly like to get to the bottom of this.
>>
>> Hi Don,
>>
>> I tried to repro using qemu, but did not generate a lockup. Could you
>> provide more details on what your script is doing (or better yet,
>> share the script directly)? I would have expected you to potentially
>> hit a lockup if you were cycling sched_core being enabled and
>> disabled, but it sounds like you are just recreating the cookie for a
>> process group over and over?
>>
> 
> I saw something similar on a bare metal hardware. Also tried the suggested
> patch here and no luck. Panic stack attached with
> softlockup_all_cpu_backtrace=1.
> (sorry, my system has 192 cpus and somehow putting 184 cpus offline causes
> system hang without any message...)

Can you please try the following change to see if the problem is gone on your side?

Thanks,
-Aubrey

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f732642e3e09..1ef13b50dfcd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -493,14 +493,17 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
 {
 	lockdep_assert_irqs_disabled();
 
-	if (rq1->cpu > rq2->cpu)
-		swap(rq1, rq2);
-
-	raw_spin_rq_lock(rq1);
-	if (__rq_lockp(rq1) == __rq_lockp(rq2))
-		return;
-
-	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
+	if (__rq_lockp(rq1) == __rq_lockp(rq2)) {
+		raw_spin_rq_lock(rq1);
+	} else {
+		if (__rq_lockp(rq1) < __rq_lockp(rq2)) {
+			raw_spin_rq_lock(rq1);
+			raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
+		} else {
+			raw_spin_rq_lock(rq2);
+			raw_spin_rq_lock_nested(rq1, SINGLE_DEPTH_NESTING);
+		}
+	}
 }
 #endif
 

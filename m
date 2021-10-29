Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C58A4400DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJ2RDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:03:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:55654 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhJ2RDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:03:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="291539941"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="291539941"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 10:00:44 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="726234669"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.248.12])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 10:00:42 -0700
Message-ID: <f21e1c14148039eb5c7d475f53aba1f4a2e0ca43.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Date:   Fri, 29 Oct 2021 10:00:40 -0700
In-Reply-To: <CAKfTPtAv7vPGYAwUSmGL5wtbY=if8G+3geWMKpHu3vLGqthPfg@mail.gmail.com>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
         <7128695d64e9161637b67315b5beb51c4accdc82.camel@linux.intel.com>
         <CAKfTPtAv7vPGYAwUSmGL5wtbY=if8G+3geWMKpHu3vLGqthPfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-27 at 10:49 +0200, Vincent Guittot wrote:
> 
> 
> Few problems still remain in your case if I'm not wrong:
> There is a patch that ensures that rq->next_balance is never set in
> the past.
> 

Vincent,

Were you planning to take the patch to prevent the next_balance to be
in the past?

Tim

---
From 2a5ebdeabbfdf4584532ef0e27d37ed75ca7dbd3 Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Tue, 11 May 2021 09:55:41 -0700
Subject: [PATCH] sched: sched: Fix rq->next_balance time updated to earlier
 than current time
To: hmem@eclists.intel.com

In traces on newidle_balance(), this_rq->next_balance
time goes backward and earlier than current time jiffies, e.g.

11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
14.637 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73c
14.666 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c

It doesn't make sense to have a next_balance in the past.
Fix newidle_balance() and update_next_balance() so the next
balance time is at least jiffies+1.
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d75af1ecfb4..740a0572cbf1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9901,7 +9901,10 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
 
 	/* used by idle balance, so cpu_busy = 0 */
 	interval = get_sd_balance_interval(sd, 0);
-	next = sd->last_balance + interval;
+	if (time_after(jiffies+1, sd->last_balance + interval))
+		next = jiffies+1;
+	else
+		next = sd->last_balance + interval;
 
 	if (time_after(*next_balance, next))
 		*next_balance = next;
@@ -10681,6 +10684,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 out:
 	/* Move the next balance forward */
+	if (time_after(jiffies+1, this_rq->next_balance))
+		this_rq->next_balance = jiffies+1;
 	if (time_after(this_rq->next_balance, next_balance))
 		this_rq->next_balance = next_balance;
 
-- 
2.20.1



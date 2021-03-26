Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6060034A5C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCZKoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCZKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:44:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D1FC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hK/R59Nh973XhTXjUjNFL5eml1I+OYJPEGxK9I4f5RA=; b=C72vEYW9221SOS84RLRZCYe6WY
        +0xmw9yYXk44hLDmB2+pSlby49le2eZ2LZSbl1bmh4yLrnlNugTBtb++u7L5c4csPrl9+13+B87dK
        7QUhlw6FnDxOdSxFkRoSqu3ceiVrzdHJgAnvYgtjd+WmHG/Mxd+EP6rokZaCKGVxnLiZhAAjOw7Oo
        3kjiPuy4UFsC0Q+oeDlmEJPRW8fpmq1+iBu7Gmclhyw7lHI9dabynXuQLSJf7WhMwyP1QcEINGTtU
        OeGBDTHksS6ohugFGGxm0B+yzdNcOqmlH5Cyc1iSDLTqQ8wiq4RUFhJaaEOvLly4uT/RLc3YFB4ec
        FrPxpKuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPjvF-00EgYX-VM; Fri, 26 Mar 2021 10:42:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5394F3077D7;
        Fri, 26 Mar 2021 11:42:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D00732BD73361; Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Message-ID: <20210326103935.444833549@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 11:34:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: [PATCH 9/9] sched,fair: Alternative sched_slice()
References: <20210326103352.603456266@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current sched_slice() seems to have issues; there's two possible
things that could be improved:

 - the 'nr_running' used for __sched_period() is daft when cgroups are
   considered. Using the RQ wide h_nr_running seems like a much more
   consistent number.

 - (esp) cgroups can slice it real fine, which makes for easy
   over-scheduling, ensure min_gran is what the name says.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   15 ++++++++++++++-
 kernel/sched/features.h |    3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -680,7 +680,16 @@ static u64 __sched_period(unsigned long
  */
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
+	unsigned int nr_running = cfs_rq->nr_running;
+	u64 slice;
+
+	if (sched_feat(ALT_PERIOD))
+		nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
+
+	slice = __sched_period(nr_running + !se->on_rq);
+
+	if (sched_feat(BASE_SLICE))
+		slice -= sysctl_sched_min_granularity;
 
 	for_each_sched_entity(se) {
 		struct load_weight *load;
@@ -697,6 +706,10 @@ static u64 sched_slice(struct cfs_rq *cf
 		}
 		slice = __calc_delta(slice, se->load.weight, load);
 	}
+
+	if (sched_feat(BASE_SLICE))
+		slice += sysctl_sched_min_granularity;
+
 	return slice;
 }
 
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -90,3 +90,6 @@ SCHED_FEAT(WA_BIAS, true)
  */
 SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
+
+SCHED_FEAT(ALT_PERIOD, true)
+SCHED_FEAT(BASE_SLICE, true)



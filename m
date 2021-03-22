Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE39343F63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhCVLNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCVLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:13:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C16C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IIIw13O8cplkzyhExasOFLMgFkr0z+hZIs3WQKQ9yFU=; b=v40pu7Sjgj89k9iH9TmwhRiPVb
        IUzOsxkrh1STZqx7Mkg4kso7yqoj5EMssEHesSQcVr+G1oG3YeKVRGP3JSG4bYTEFvG7Pbt3Ek6ah
        H5/lSs+Pr9WBphU2wBsbbyIPaB4LAlBTFUxfaLiwr1O4Y99WP1/HuiTJtZjqeUSp5mo0/VU10bZLf
        B7oQDbbe1caKiV3MUUvT2AJcuO/hW97DijP+cEu37vxRPSDqOHTqEcBhBWtb//XHsDPtevbI0+0b4
        IH22PhfFp2Fza/T1q8iPmvEg9am+7C4vboLibIJ4sJWMe9eqtQnj1dQDL1lvAcj7ruiaK5YSLHVgd
        +9TEO5dg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOIQl-008OfY-PJ; Mon, 22 Mar 2021 11:09:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0021930377D;
        Mon, 22 Mar 2021 12:09:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4B902BCFBDAD; Mon, 22 Mar 2021 12:09:05 +0100 (CET)
Date:   Mon, 22 Mar 2021 12:09:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        valentin.schneider@arm.com, aubrey.li@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xuwei5@huawei.com, prime.zeng@hisilicon.com, guodong.xu@linaro.org,
        yangyicong@huawei.com, liguozhu@hisilicon.com,
        linuxarm@openeuler.org
Subject: Re: [PATCH] sched/fair: remove redundant test_idle_cores for non-smt
Message-ID: <YFh60XwkqZ4G0y2b@hirez.programming.kicks-ass.net>
References: <20210320221432.924-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320221432.924-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 11:14:32AM +1300, Barry Song wrote:
> update_idle_core() is only done for the case of sched_smt_present.
> but test_idle_cores() is done for all machines even those without
> smt.
> this could contribute to up 8%+ hackbench performance loss on a
> machine like kunpeng 920 which has no smt. this patch removes the
> redundant test_idle_cores() for non-smt machines.
> 
> we run the below hackbench with different -g parameter from 2 to
> 14, for each different g, we run the command 10 times and get the
> average time:
> $ numactl -N 0 hackbench -p -T -l 20000 -g $1
> 
> hackbench will report the time which is needed to complete a certain
> number of messages transmissions between a certain number of tasks,
> for example:
> $ numactl -N 0 hackbench -p -T -l 20000 -g 10
> Running in threaded mode with 10 groups using 40 file descriptors each
> (== 400 tasks)
> Each sender will pass 20000 messages of 100 bytes
> 
> The below is the result of hackbench w/ and w/o this patch:
> g=    2      4     6       8      10     12      14
> w/o: 1.8151 3.8499 5.5142 7.2491 9.0340 10.7345 12.0929
> w/ : 1.8428 3.7436 5.4501 6.9522 8.2882  9.9535 11.3367
>                           +4.1%  +8.3%  +7.3%   +6.3%
> 

The patch looks obvious, but the Changelog and Subject needed a lot of
help.

I've changed it like so:

---
Subject: sched/fair: Optimize test_idle_cores() for !SMT
From: Barry Song <song.bao.hua@hisilicon.com>
Date: Sun, 21 Mar 2021 11:14:32 +1300

From: Barry Song <song.bao.hua@hisilicon.com>

update_idle_core() is only done for the case of sched_smt_present.
but test_idle_cores() is done for all machines even those without
SMT.

This can contribute to up 8%+ hackbench performance loss on a
machine like kunpeng 920 which has no SMT. This patch removes the
redundant test_idle_cores() for !SMT machines.

Hackbench is ran with -g {2..14}, for each g it is ran 10 times to get
an average.

  $ numactl -N 0 hackbench -p -T -l 20000 -g $1

The below is the result of hackbench w/ and w/o this patch:

  g=    2      4     6       8      10     12      14
  w/o: 1.8151 3.8499 5.5142 7.2491 9.0340 10.7345 12.0929
  w/ : 1.8428 3.7436 5.4501 6.9522 8.2882  9.9535 11.3367
			    +4.1%  +8.3%  +7.3%   +6.3%

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20210320221432.924-1-song.bao.hua@hisilicon.com
---
 kernel/sched/fair.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6038,9 +6038,11 @@ static inline bool test_idle_cores(int c
 {
 	struct sched_domain_shared *sds;
 
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
+	if (static_branch_likely(&sched_smt_present)) {
+		sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+		if (sds)
+			return READ_ONCE(sds->has_idle_cores);
+	}
 
 	return def;
 }

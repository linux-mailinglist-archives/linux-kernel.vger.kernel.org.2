Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA7835C3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbhDLKVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhDLKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:21:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B15DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PEzDXmHxHw2qJ5puOPZvDc+LsZojBXbFdFwtv26Rpa0=; b=kdPJUC2PxRSlbslqVJRK7ra6jb
        TDHmxR5zojBokY2yzb/sVnXc22R4SegYkU4vaMZC7ux1nCG5OYY2AExAM1shelg2Wd5RYqScmbVEa
        ceG0T5rKDtefarZ+WVQVw8gPXgWQO0SNEfqyKKoDfLOxFD6ypeNPeovBxjRxwBR7dZdS8SD8/GwcM
        a/OesiQOnauz+5aSPe2UlbwS7f81oE47GIrd+d4dBps59Vvo9CNFKPwj1EePf8qbK3D1HwwPyaY2j
        tP89BM5tbbfTPK9jOcUCO0PrirkAapB+9YxFa59tzp/sSmpy3f9sZ291fZjo4LTkNGeO0XfI+57xx
        9RJFB8MQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtgj-006QVK-If; Mon, 12 Apr 2021 10:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D14EE3002C6;
        Mon, 12 Apr 2021 12:20:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D9B5329D8B776; Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Message-ID: <20210412102001.611897312@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 12:14:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com,
        linux@rasmusvillemoes.dk
Subject: [PATCH v2 9/9] sched,fair: Alternative sched_slice()
References: <20210412101421.609526370@infradead.org>
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
 kernel/sched/fair.c     |   12 +++++++++++-
 kernel/sched/features.h |    3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -680,7 +680,13 @@ static u64 __sched_period(unsigned long
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
 
 	for_each_sched_entity(se) {
 		struct load_weight *load;
@@ -697,6 +703,10 @@ static u64 sched_slice(struct cfs_rq *cf
 		}
 		slice = __calc_delta(slice, se->load.weight, load);
 	}
+
+	if (sched_feat(BASE_SLICE))
+		slice = min(slice, (u64)sysctl_sched_min_granularity);
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



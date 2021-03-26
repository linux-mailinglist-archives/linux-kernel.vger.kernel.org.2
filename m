Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7150D34A5BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCZKnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhCZKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:42:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB86C0613B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4FZ7mSk+jdT38j1pSNwsY+DQyckGwuS5OzdXXzcwtqA=; b=RT5jnOK33Zm7/VelPXyUKxWs/3
        9Wm4dLGsBJmPP/qylAakZhx3QcMBeLH51oep7nio7Wj6OBQ7zHCat6bpk8tvuyb2JTKhRFqiSyz5o
        0TpYa4SEbTHxqSTXw8YWF5awzf3V0YMWGUJwEnqxMNP7gTDsJfTuShw/3ocCeGZRK8CFRe3IPjvMY
        xt+41TRiWdKgQaUqoWvWMA7QBcM/iiFMEDA4AEpRjHbgXjkQ1SscWzVydW4vdU0EXsJdR04lyChbp
        dd1/M5dc5dV1rt18dOljglliLBNoYbcq5B94HMa6aut0zP9JCQgcRMtl0mEiUtEvrjwg08WMrEEkc
        5V+mQwhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPjvE-003L6C-Tw; Fri, 26 Mar 2021 10:42:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3F443060C5;
        Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AD9382BCA7ED5; Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Message-ID: <20210326103934.946702998@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 11:33:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: [PATCH 3/9] sched: Dont make LATENCYTOP select SCHED_DEBUG
References: <20210326103352.603456266@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCHED_DEBUG is not in fact required for LATENCYTOP, don't select it.

Suggested-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/Kconfig.debug |    1 -
 1 file changed, 1 deletion(-)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1670,7 +1670,6 @@ config LATENCYTOP
 	select KALLSYMS_ALL
 	select STACKTRACE
 	select SCHEDSTATS
-	select SCHED_DEBUG
 	help
 	  Enable this option if you want to use the LatencyTOP tool
 	  to find out which userspace is blocking on what kernel operations.



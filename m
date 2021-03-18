Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052C934087D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhCRPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhCRPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:11:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BCBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sPkqE4Z4nq4U5S9p+k8pFb8Y9xvqDbx2znk4jhaW/AQ=; b=nNFw9z6AAP1lC4HDV6hyJgzeXz
        7w+6wwoE2KFIoMGFfqGk9z2mTLKwADhCDiRON6N0myY0yYTh8MIldXO1ILK/eSzDfG7fVAmWWect1
        JVIpbYhaaq0KhHjg2YojiXimKOrzcNh8FJsT7jhbUHmjdmWTLGuMcyZdNeN89C1/LQko4xc/gr00g
        rKfEkd6uh6TtfJETraNW4By9BdhZlI+EGqtrpePhUPbzGUQsUJpgA5qXna/laRCY1wdsCiNl1VJ8n
        Mxh5ra6IUNN4rqsQYhzSuLtiTGDhK2SrPScY6dZEs68XaMUUhTDygOzhG1uH4v1KHdfYiUyhWoFcz
        TNH9HyHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMuIY-005YJJ-2N; Thu, 18 Mar 2021 15:10:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22FBD3012DF;
        Thu, 18 Mar 2021 16:10:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA96020D3873F; Thu, 18 Mar 2021 16:10:50 +0100 (CET)
Date:   Thu, 18 Mar 2021 16:10:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>, mgorman@suse.de,
        mingo@redhat.com, Odin Ugedal <odin@uged.al>,
        Odin Ugedal <odin@ugedal.com>, Paul Turner <pjt@google.com>,
        rostedt@goodmis.org, Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS
 bandwidth burst
Message-ID: <YFNtesvbxUY4XTYR@hirez.programming.kicks-ass.net>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
 <YFCAXeZj6sXBI5Ls@hirez.programming.kicks-ass.net>
 <B75EDF95-96B3-44E4-8169-3C1FCBC30A7B@linux.alibaba.com>
 <YFG4hEOe65cbCo26@hirez.programming.kicks-ass.net>
 <EA9BCA7F-8B57-4A87-A32E-DBBF8E7BAD8F@linux.alibaba.com>
 <YFNNWumXTSa3Bssl@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFNNWumXTSa3Bssl@lorien.usersys.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 08:59:44AM -0400, Phil Auld wrote:
> I admit to not having followed all the history of this patch set. That
> said, when I see the above I just think your quota is too low for your
> workload.

This.

> The burst (mis?)feature seems to be a way to bypass the quota.  And it
> sort of assumes cooperative containers that will only burst when they
> need it and then go back to normal. 

Its not entirely unreasonable or unheard of. There's soft realtime
systems that use this to increase the utilization with the trade-off
that you're going to miss deadlines once every so often.

If you do it right, you can calculate the probabilities. Or usually the
other way around, you calculate the allowed variance/burst given a P
value for making the deadline.

Input then isn't the WCET for each task, but a runtime distribution as
measured for your workload on your system etc..

I used to have papers on this, but I can't seem to find them in a hurry.

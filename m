Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505E23B3E40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFYILu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhFYILt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:11:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pk4JdYaTmkcafJVH7LMc/B00NbQ927vWeJUlkQ+x8rI=; b=lvoXyscItXa1rIH1Cf3JU882AC
        04AMKH8huNJHIbnEEIRC20vxvowkTNgcru1F17YQHjklc5l6e8K19Mo2+cBEwJhbhTvgxXQYxhwqq
        b/y4+gpq732HHhk/S4/ZFVNZr9363cOUF1xiMS1TgtLZ39JveB/xRFrQh1LtTbgiggiiGzRFUjd8G
        krLxEfrFbEor/PvXy2vFGKXUwu+cXngZ5iZuBJX1K6y4Ktyl+c7dlbh5LDf8E2WPyFQlaUE3CdWwA
        B1ZFWdrCXM92nk5lV1R955ufsJ8PRA6XRQrvJUHpn7kwWgAzR+zSei43lIgFeruNY1mHKi+BhjGPR
        spJfDPdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwgtD-00HRl9-5x; Fri, 25 Jun 2021 08:08:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AFC030022B;
        Fri, 25 Jun 2021 10:08:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E1772B64C055; Fri, 25 Jun 2021 10:08:36 +0200 (CEST)
Date:   Fri, 25 Jun 2021 10:08:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
Message-ID: <YNWPBDH/mQdojEu9@hirez.programming.kicks-ass.net>
References: <20210608231132.32012-1-joshdon@google.com>
 <YMobzbLecaFYuLtq@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMobzbLecaFYuLtq@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:42:05AM -0400, Tejun Heo wrote:
> A high-level problem that I see with the proposal is that this would bake
> the current recursive implementation into the interface. The semantics of
> the currently exposed interface, at least the weight based part, is abstract
> and doesn't necessarily dictate how the scheduling is actually performed.
> Adding this would mean that we're now codifying the current behavior of
> fully nested scheduling into the interface.

It's a direct concequence of the hierarchical requirement. The approach
is the only valid one. The other relative controllers that don't do
this, are simply broken.

Absolute controllers have it easier, they can be trivially flattened.

> There are several practical challenges with the current implementation
> caused by the full nesting - e.g. nesting levels are expensive for context
> switch heavy applicaitons often going over >1% per level,

Yeah, and there's numerical problems you run into as well due to
limitied precision.

Just don't do deep hierarchies.

AFAICT it's a simple matter of conflicting requirements, on the one hand
the hierarchical thing is required, on the other hand people seem to
think all this crap is 'free' and create super deep hierarchies and then
complain shit don't work right.





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2F344ED36
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 20:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhKLT0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 14:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhKLT0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:26:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603C2C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 11:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W/oEMYWi1Duf6rJ5rrN5IwaTiOZUzA2k5aHxrkIsuIU=; b=fajv81nAf9IFR15jc8zkYd4eIR
        bvS8zozoFRpYJ+eaS+36jBwKeNeztF7yQ+Uuj7v0GEF3rFys2cdTXsiUIeR1Hjj1T4w5mxYYyFwfH
        hMFXv5aqBHYuanhmlQIjmkuTX8SJsappsCjvp4IyOA/HImayfYSjNJY6y4mhHgM7/0a+jKwTmXJ19
        lklvB0U9DhgYl2ZH3N1futpmndpWvpatlFm0PMVJUqlJUF/T8RYjPLhrvje7FNyJsq/60OYnG4rQp
        mCDcPGaPzp1MujN+7dR430zsKVxfaEZsvdJCxUW8BbCppUQtDWGCH3MqZIN6xexC2qnANlGUplGGh
        exVAWkbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlc93-003mOH-FZ; Fri, 12 Nov 2021 19:23:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DE07986981; Fri, 12 Nov 2021 20:23:29 +0100 (CET)
Date:   Fri, 12 Nov 2021 20:23:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
Message-ID: <20211112192329.GL174703@worktop.programming.kicks-ass.net>
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org>
 <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
 <YY6X+HPS8A4sLEiO@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY6X+HPS8A4sLEiO@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 11:36:08AM -0500, Johannes Weiner wrote:
> On Tue, Nov 09, 2021 at 03:56:36PM +0100, Peter Zijlstra wrote:

> > I think that focus on RT/IRQ is mis-guided here, and the implementation
> > is horrendous.
> > 
> > So the fundamental question seems to be; and I think Johannes is the one
> > to answer that: What time-base do these metrics want to use?
> > 
> > Do some of these states want to account in task-time instead of
> > wall-time perhaps? I can't quite remember, but vague memories are
> > telling me most of the PSI accounting was about blocked tasks, not
> > running tasks, which makes all this rather more complicated.
> > 
> > Randomly scaling time as proposed seems almost certainly wrong. What
> > would that make the stats mean?
> 
> It *could* be argued that IRQs and RT preemptions are CPU stalls.
> 
> I'm less convinced we should subtract preemptions from memory stalls.
> 
> Yes, when you're reclaiming and you get preempted for whatever reason,
> you're technically stalled on CPU in this moment. However, reclaim
> itself consumes CPU and walltime, and it could be what is causing
> those preemptions to begin with! For example, reclaim could eat up 90%
> of your scheduling timeslice and then cause a preemption when the
> thread is back in userspace and trying to be productive. By consuming
> time, it also drags out the overall timeline for userspace to finish
> its work, and a longer timeline will have more disruptions from
> independent events like IRQs and RT thread wakeups.

Reclaim could be running at RT priority. There is fundamentally no
distinction between CFS and RT tasks. Consider priority inheritance on
kernel mutexes, or an admin thinking it makes sense to chrt kswapd. Or
an RT task ends up direct reclaim or...

Either they all count or they don't. There is no sane middle ground
here.

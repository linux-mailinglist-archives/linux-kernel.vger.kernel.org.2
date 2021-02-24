Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27223243A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhBXSSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbhBXSR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:17:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EF5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mW17obZYHxgqq8NqyID1PaWyTvdWia3zxGHSfanX3QQ=; b=LTb9ekPDBE2BlPrNsDs+p3oxmg
        zOSxObzCWyCKogG024Wlz2b16A1kf+j4aifINmkMOjIYBxndKt9pUXzE/oFn7bx8m9TG6ZKGmGrCq
        sj6Nl6mL88+LMh6fR+Hn7fWm/T6SMfafN08ypHUmwbNCuBG2eyq0s3dCLx4Hpclt4G6NjqQFNuXsm
        i9lkh6CHPTegXHN5inyVzb1gSignhRw8GR5OWT2W8ThMgZX98MBJEUyNUcvU2PNcJRewdQxBPttxd
        aJ5eG//KtVCXWZab8a/6wvfiSlS5FSQSUHBGkfWwmG1zdkPUDwWQjV0NKALhD4E6fmUni1GZ20D5l
        uvHlB3+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEyie-0003xN-7P; Wed, 24 Feb 2021 18:17:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91253301A32;
        Wed, 24 Feb 2021 19:17:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72FAA206FA6AD; Wed, 24 Feb 2021 19:17:02 +0100 (CET)
Date:   Wed, 24 Feb 2021 19:17:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH 0/7 v4] move update blocked load outside newidle_balance
Message-ID: <YDaYHglbHOrCb1Ph@hirez.programming.kicks-ass.net>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
 <YDZ2kl2dpHUgmjTS@hirez.programming.kicks-ass.net>
 <CAKfTPtCwmt9HHDuN7tVhZiy7R3e5XHuExU-PVOb++40fYzu-2Q@mail.gmail.com>
 <YDaPtc47NnB5BGEW@hirez.programming.kicks-ass.net>
 <CAKfTPtAa5wCUbNs4+6sTJmSi8wkoEdbtUyzSGpkA0OuRHB67GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAa5wCUbNs4+6sTJmSi8wkoEdbtUyzSGpkA0OuRHB67GA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 06:51:01PM +0100, Vincent Guittot wrote:

> > OK, shall I add something like:
> >
> > This reduces the IRQ latency from O(nr_cgroups * nr_nohz_cpus) to
> > O(nr_cgroups).
> >
> > To the changelog of patch #1 ?
> 
> Yes, good point. This will clarify the range of improvement

OK, done.

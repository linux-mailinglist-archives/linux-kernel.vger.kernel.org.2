Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECA5372808
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 11:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhEDJXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 05:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhEDJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 05:23:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C12C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HVDMhGxlUpZhhlMcAlfvkm85ng62ef3vR38l+wYqSfI=; b=EzaBXYOkcVlhuSpp3qYEK+E5DZ
        zCKLb6yXKM4BJnWD9c0kek7AZagdy46sOlX8+HJS3nn6sMwOEAGcU+5Diq3/AJtcJ7NaMUR2vtZiV
        2fOfyHc3BI53ggiKFBlhBm3EgbL4qk55XGlrQLBnfqXy198q9+EUWxgBBd/Cg65qRLsrozGQPfAA8
        BYWNz7sbE8+UnxTeZlSIacD9tbaK+pDH6leYyfzV2Ho8xSEb+PnV48VKGTr58Ov9Uwa1Qi0LPt4OJ
        5NnMdioICQFmigFU1GhSDgB4IFSxsJscQk4lAY+17bVJSyWW1fQ3UwKi30VzDoK9n7SdK1O0SlZ1v
        FNeKD2qQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldrFS-00GOBK-Vq; Tue, 04 May 2021 09:21:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8B553001D0;
        Tue,  4 May 2021 11:21:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF0B020264CB5; Tue,  4 May 2021 11:21:44 +0200 (CEST)
Date:   Tue, 4 May 2021 11:21:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v4] sched,fair: Skip newidle_balance if a wakeup is
 pending
Message-ID: <YJESKDaf3U3XYcuG@hirez.programming.kicks-ass.net>
References: <20210422130236.0bb353df@imladris.surriel.com>
 <CAKfTPtBM=H53Vu+qXZROBwV6UAuNzf-m6eJBk=cPGS4aoQxzyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBM=H53Vu+qXZROBwV6UAuNzf-m6eJBk=cPGS4aoQxzyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:09:46PM +0200, Vincent Guittot wrote:
> On Thu, 22 Apr 2021 at 19:02, Rik van Riel <riel@surriel.com> wrote:
> >
> > The try_to_wake_up function has an optimization where it can queue
> > a task for wakeup on its previous CPU, if the task is still in the
> > middle of going to sleep inside schedule().
> >
> > Once schedule() re-enables IRQs, the task will be woken up with an
> > IPI, and placed back on the runqueue.
> >
> > If we have such a wakeup pending, there is no need to search other
> > CPUs for runnable tasks. Just skip (or bail out early from) newidle
> > balancing, and run the just woken up task.
> >
> > For a memcache like workload test, this reduces total CPU use by
> > about 2%, proportionally split between user and system time,
> > and p99 and p95 application response time by 10% on average.
> > The schedstats run_delay number shows a similar improvement.
> >
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!

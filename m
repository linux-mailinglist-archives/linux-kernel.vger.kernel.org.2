Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1CE4223B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhJEKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbhJEKkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:40:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C03BC06161C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t9uwTcpRAkuxtDd8N8WgM5ZhUGx0canA4I39+YkmP/0=; b=kTqPsDsFhZu+P+KsHET12MMsJb
        MJ2cUoF7pzVQQUry2j8Ms7vabgpWxJLV38z4/yS0SmuvKY+Osxx3Dz+WFy+lu0BmCV92F5OUvcE8R
        tYTZEhhLDp0fIyrreBbxljABrYySML4A6htwIQF5J/Usq9vBCs3hgiLKDkuFPvmld5kWJXm6AgB85
        0m3gsWE3i/suIaONkRdYdH8W7W7tbdcp3clcJgrWVvPQWqA0kNpi+KB5uEaJ1kKcqZflMdvZLL42A
        rSM88GmJ5vSsMeP8ZeGZ+Y7w8MDl/Q9uzlA7HALYKQd2mob2E1jZDj1bhxMmPhWUM3A811ATl2Nys
        wSL3/LAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXho7-000EXp-Mq; Tue, 05 Oct 2021 10:36:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E879C30003C;
        Tue,  5 Oct 2021 12:36:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3A682038E20D; Tue,  5 Oct 2021 12:36:22 +0200 (CEST)
Date:   Tue, 5 Oct 2021 12:36:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mike Galbraith <efault@gmx.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <YVwqphxxNSDL828Y@hirez.programming.kicks-ass.net>
References: <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net>
 <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
 <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
 <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
 <YUxx42W3K2Ur7W84@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUxx42W3K2Ur7W84@lorien.usersys.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 08:24:03AM -0400, Phil Auld wrote:

> It's capped at 8 cpus, which is pretty easy to reach these days, so the
> values don't get too large.  That scaling is almost a no-op these days.

  https://lkml.kernel.org/r/YVwdrh5pg0zSv2/b@hirez.programming.kicks-ass.net

Ooh, hey, we already fixed that :-)

So the reasoning there is that if the values get too big, interactiviy
get *really* bad, but if you go from say 1 to 4 CPUs, interactivity can
improve due to being able to run on other CPUs.

At 8 CPUs we end up at 6ms*4=24ms, which is already pretty terrible.

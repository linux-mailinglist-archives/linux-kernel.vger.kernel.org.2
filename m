Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D044467E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhKERbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhKERa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:30:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6101C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+j1/xAiEIC6nTouHB02W+EU9E1MWR8L29Tegegb7m5I=; b=T5jlVIrHjUi0TxOlYlZYyLjfhn
        3ORz4lrlDr0NWTo02+svZcK6hLAi7sLzsCs5bBE4lPSbCQaYTeyYeUyLU8oYNMF/oJkpbyMKKvG+S
        8DbF7dkpFslhR3lsnRtur6Hs/Fl5ijBJAfgvc5Co4HcYK1wPT0aL5M3OoQ37oy2CZCtztLGoORJ/L
        PF5/mwfuQBd76duvwbyCQ/FQXkaTT2KdV3RC58VIPJ3bzdKCEl+TmcpoaHD/Jnhkw/n0gd93MrcO1
        mlwFqQCpNKqkycPEUr/UhzpcWjewoJ42rlbFr6iVNxNET9W01hrDXROrS8hiEBKtwEVncUzNo4+2E
        myGxLOBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj30O-00ENHK-9n; Fri, 05 Nov 2021 17:27:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B9453000D5;
        Fri,  5 Nov 2021 18:27:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F865203C0534; Fri,  5 Nov 2021 18:27:55 +0100 (CET)
Date:   Fri, 5 Nov 2021 18:27:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
Message-ID: <YYVpm7LRWMZMzxId@hirez.programming.kicks-ass.net>
References: <xm26ilx86gmp.fsf@google.com>
 <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
 <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
 <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
 <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
 <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
 <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net>
 <20211105162914.215420-1-minipli@grsecurity.net>
 <YYVim5qpteqfwYjx@hirez.programming.kicks-ass.net>
 <a113044b-b5b6-8bc1-864b-c817535889ff@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a113044b-b5b6-8bc1-864b-c817535889ff@grsecurity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 06:14:33PM +0100, Mathias Krause wrote:
> Am 05.11.21 um 17:58 schrieb Peter Zijlstra:
> > On Fri, Nov 05, 2021 at 05:29:14PM +0100, Mathias Krause wrote:
> >>> Looks like it needs to be the kfree_rcu() one in this case. I'll prepare
> >>> a patch.
> >>
> >> Testing the below patch right now. Looking good so far. Will prepare a
> >> proper patch later, if we all can agree that this covers all cases.
> >>
> >> But the basic idea is to defer the kfree()'s to after the next RCU GP,
> >> which also means we need to free the tg object itself later. Slightly
> >> ugly. :/
> > 
> > Can't we add an rcu_head to struct task_group and simply call_rcu() the
> > thing with a free function?
> 
> There is already one and this patch makes use of it for the second RCU
> GP requirement. Basically, the patch is doing what you request, no? See
> the new free_fair_sched_group().

For some reason I thought you still did kfree_rcu(), I suppose reading
is hard. I'll give it another go after dinner.

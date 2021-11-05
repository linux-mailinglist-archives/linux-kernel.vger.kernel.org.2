Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6A446780
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhKERF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhKERF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:05:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F2C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X1Uc0xG1ycwLqEqfHYgzuR37X93BKygFxrIOeSsoh0k=; b=K+pXQiH0veWQE9+dUByB6VuuLs
        HlhjZHPU6F1j7yyg6abyUqckyhns2U/CxNYMUAvj0F8kD3Sg9G8ZDmaQBNpK3mYPt3jUC9QbeZd58
        2xkVye7H1iodhtIVjxC9lgRTvJfgQKpv1jiLDVgke+fc523BE6XMkj6wU/nsO47DtLcdq5u/JGn8R
        32pbUIX+5VNzZbA+89hsRaPfIH9hLFYO6UUISsLX/MvciAe4zD2Z0nn8bc7Q1MXdSyr/F4j0VHL2L
        UesVVYUfmDCoRBM+HNEW1Mmfobr6vVX4wzqK0UDOhbPebT1UJz0AIctfp7ISYPGtx9QCUSAbp7ZJJ
        YvEacANw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2XV-006gyQ-Ui; Fri, 05 Nov 2021 16:58:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E2B23000DD;
        Fri,  5 Nov 2021 17:58:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F842302B9809; Fri,  5 Nov 2021 17:58:03 +0100 (CET)
Date:   Fri, 5 Nov 2021 17:58:03 +0100
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
Message-ID: <YYVim5qpteqfwYjx@hirez.programming.kicks-ass.net>
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
 <20211103190613.3595047-1-minipli@grsecurity.net>
 <xm26ilx86gmp.fsf@google.com>
 <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
 <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
 <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
 <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
 <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
 <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net>
 <20211105162914.215420-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105162914.215420-1-minipli@grsecurity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 05:29:14PM +0100, Mathias Krause wrote:
> > Looks like it needs to be the kfree_rcu() one in this case. I'll prepare
> > a patch.
> 
> Testing the below patch right now. Looking good so far. Will prepare a
> proper patch later, if we all can agree that this covers all cases.
> 
> But the basic idea is to defer the kfree()'s to after the next RCU GP,
> which also means we need to free the tg object itself later. Slightly
> ugly. :/

Can't we add an rcu_head to struct task_group and simply call_rcu() the
thing with a free function?

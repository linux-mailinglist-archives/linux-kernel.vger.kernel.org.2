Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D363F5A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhHXI43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhHXI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:56:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCD8C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=25tLido20qf09e1xyoklr9DCNsjopfjqyz+wEdkRuCY=; b=YbAVLprNfZ9PX2CRrqfNQQ1D1C
        KwJrH2Pwj9usHTkfuvEPKk3gudguF/3CMYtJPKNdF/CCnfBRsRyJGQLFJsy2Yk6Oecpwd9BaWsiR4
        LZpYdejC75u7PYTJD/H2crNVv8W7f2r4qpAsbVMqg5/KsEwndaoJW7IVlNlEboAaF4PKgGcWzTkzK
        M9+ZXXUYAwCDwZgZYHx9hlremX2qlxC/UY6RJsrlOM+xqsn9qezOYna+Nsh/78FOIopE5zK5i8YCN
        82ZWldYyBVMVmUXUjiZ4lyprRTcQkSeRAaO5U/cRTW6QFmnxiQty1L9k8XK3SxAxReha37+VEzqfG
        tttEQz8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mISDM-00CXoZ-Ou; Tue, 24 Aug 2021 08:55:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E5F2300024;
        Tue, 24 Aug 2021 10:55:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54D2D2C57D1E9; Tue, 24 Aug 2021 10:55:23 +0200 (CEST)
Date:   Tue, 24 Aug 2021 10:55:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH] sched/core: fix pick_next_task 'max' tracking
Message-ID: <YSSz+wSVrf6jAw8Q@hirez.programming.kicks-ass.net>
References: <20210818005615.138527-1-joshdon@google.com>
 <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
 <CABk29Ns-aiSjf8WTWL5U0ggKr32NKC3Q6ANJ8MheDP5P-k_JuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ns-aiSjf8WTWL5U0ggKr32NKC3Q6ANJ8MheDP5P-k_JuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 04:24:26PM -0700, Josh Don wrote:
> Hi Peter,
> 
> On Mon, Aug 23, 2021 at 4:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> [snip]
> > +       for_each_cpu(i, smt_mask) {
> > +               rq_i = cpu_rq(i);
> > +               p = rq_i->core_temp;
> >
> > -                       /*
> > -                        * If this sibling doesn't yet have a suitable task to
> > -                        * run; ask for the most eligible task, given the
> > -                        * highest priority task already selected for this
> > -                        * core.
> > -                        */
> > -                       p = pick_task(rq_i, class, max, fi_before);
> > +               if (!cookie_equals(p, cookie)) {
> > +                       p = NULL;
> > +                       if (cookie)
> > +                               p = sched_core_find(rq_i, cookie);
> 
> In the case that 'max' has a zero cookie, shouldn't we search for a
> match on this cpu if the original class pick ('p') had a non-zero
> cookie? We don't enqueue tasks with zero cookie in the core_tree, so I
> forget if there was some other reasoning here.

IIRC we don't keep 0-cookies in the tree. Lemme check.

Yeah, see sched_core_enqueue(), they bail for 0-cookie.

This is indeed sub-optimal, but also having the 0-cookie tasks in the
tree has other issues IIRC.

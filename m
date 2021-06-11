Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660FA3A4178
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhFKLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 07:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhFKLvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 07:51:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF64C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yAtCEL32DjGgSIxfxPxU5dWT3AR6+igTd5JCoSyHt1o=; b=Y2htFAzVHmfHPDH8NsQEyrFrjG
        o3CBZ6de3y7IrZzbmrX4m5wZUqbr6WBqiqD5kLoySPHAHZozBsUs79Bj1iWRQMelTyExWEGFkdH0i
        Z1Egf0nYHd5g8cxPf3VbNYtBIQ0eamKKfCDDchWI/YP7KGVmi0z9tzv5SfM99Q/01c+Cx4ExuNgPB
        E4si87PGOqal8uT88SHJhTPTrOemEcje6Hi0AKgRBiYELtojn13lBJ+dwNabQ5oe3LSMeQMaOCvwV
        VaOIlbwtnrnfmFtxf59GElFQkMgvY4dFQw17PcpgCbri5pVlxLkj8PFrgyuZ6T3Ohtv1LX4JvHe8N
        OSnX6yFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrfeo-005sKq-A8; Fri, 11 Jun 2021 11:49:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E9DA300091;
        Fri, 11 Jun 2021 13:49:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1154321AB0AD9; Fri, 11 Jun 2021 13:49:08 +0200 (CEST)
Date:   Fri, 11 Jun 2021 13:49:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/6] posix-cpu-timers: Fix rearm racing against process
 tick
Message-ID: <YMNNtOTN9u3eC0n0@hirez.programming.kicks-ass.net>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-2-frederic@kernel.org>
 <20210609115400.GD104634@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609115400.GD104634@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 01:54:00PM +0200, Frederic Weisbecker wrote:
> On Fri, Jun 04, 2021 at 01:31:54PM +0200, Frederic Weisbecker wrote:
> > Since the process wide cputime counter is started locklessly from
> > posix_cpu_timer_rearm(), it can be concurrently stopped by operations
> > on other timers from the same thread group, such as in the following
> > unlucky scenario:
> > 
> >          CPU 0                                CPU 1
> >          -----                                -----
> >                                            timer_settime(TIMER B)
> >    posix_cpu_timer_rearm(TIMER A)
> >        cpu_clock_sample_group()
> >            (pct->timers_active already true)
> > 
> >                                            handle_posix_cpu_timers()
> >                                                check_process_timers()
> >                                                    stop_process_timers()
> >                                                        pct->timers_active = false
> >        arm_timer(TIMER A)
> > 
> >    tick -> run_posix_cpu_timers()
> >        // sees !pct->timers_active, ignore
> >        // our TIMER A
> > 
> > Fix this with simply locking process wide cputime counting start and
> > timer arm in the same block.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> 
> Fixes: 60f2ceaa8111 ("posix-cpu-timers: Remove unnecessary locking around cpu_clock_sample_group")
> Cc: stable@vger.kernel.org

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>


Problem seems to be calling cpu_clock_sample_group(.start = true)
without sighand locked. Do we want a lockdep assertion for that?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278B13A1381
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbhFIL4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231612AbhFILz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:55:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C70296100B;
        Wed,  9 Jun 2021 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623239643;
        bh=B2VGGA/Njpagy/zTT2ydH2UN3O5PEQtkbmNoWUl0Ny0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5+jSkqJM0u5bFGSzIbpT77QtTxILy1RtAkdAqjRcII2YuxGQo4sYJly7ct8Ec266
         N1H0K+aVJsORPozfP6LJJ3JafTbL9o7TeWDhEqRHrt+4gdKO2/0isbqXLj7JJUnsNq
         O6iSx3dIg2jUcC51pYmv/zt0rgewO3PTRRZDduG4t90HdVpRCKpwvi2Kt4jfY8VIwX
         sDsxv8Ya01tJIhN2pVb6U1hu38lNXmqdPUTXoaWU5WhmlDmsJyOXcNhatr4lPbviBe
         7SnVUPq5IFPRsEmkoWiJlZyfP6FVWcYPA/3zL+wpntj2Xsm29a8eqCtew2GzggT9Pb
         p79jwyuCPQlow==
Date:   Wed, 9 Jun 2021 13:54:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/6] posix-cpu-timers: Fix rearm racing against process
 tick
Message-ID: <20210609115400.GD104634@lothringen>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604113159.26177-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:31:54PM +0200, Frederic Weisbecker wrote:
> Since the process wide cputime counter is started locklessly from
> posix_cpu_timer_rearm(), it can be concurrently stopped by operations
> on other timers from the same thread group, such as in the following
> unlucky scenario:
> 
>          CPU 0                                CPU 1
>          -----                                -----
>                                            timer_settime(TIMER B)
>    posix_cpu_timer_rearm(TIMER A)
>        cpu_clock_sample_group()
>            (pct->timers_active already true)
> 
>                                            handle_posix_cpu_timers()
>                                                check_process_timers()
>                                                    stop_process_timers()
>                                                        pct->timers_active = false
>        arm_timer(TIMER A)
> 
>    tick -> run_posix_cpu_timers()
>        // sees !pct->timers_active, ignore
>        // our TIMER A
> 
> Fix this with simply locking process wide cputime counting start and
> timer arm in the same block.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>

Fixes: 60f2ceaa8111 ("posix-cpu-timers: Remove unnecessary locking around cpu_clock_sample_group")
Cc: stable@vger.kernel.org

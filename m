Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270163D4C0B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 07:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhGYEXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 00:23:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58710 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYEXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 00:23:20 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 24F131C0B76; Sun, 25 Jul 2021 07:03:50 +0200 (CEST)
Date:   Sun, 25 Jul 2021 07:03:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, stable@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RT 5/8] sched: Fix affine_move_task() self-concurrency
Message-ID: <20210725050349.GA983@bug>
References: <20210709215953.122804544@goodmis.org>
 <20210709220018.003428207@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709220018.003428207@goodmis.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 5.10.47-rt46-rc1 stable review patch.
> If anyone has any objections, please let me know.
> 
> Add set_affinity_pending::stop_pending, to indicate if a stopper is in
> progress.
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9cbe12d8c5bd..20588a59300d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1900,6 +1900,7 @@ struct migration_arg {
>  
>  struct set_affinity_pending {
>  	refcount_t		refs;
> +	unsigned int		stop_pending;
>  	struct completion	done;
>  	struct cpu_stop_work	stop_work;
>  	struct migration_arg	arg;

For better readability, this should be bool, AFAICT.

>  		 * and have the stopper function handle it all race-free.
>  		 */
> +		stop_pending = pending->stop_pending;
> +		if (!stop_pending)
> +			pending->stop_pending = true;
>  
...because it is used as bool.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

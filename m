Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80BB319E68
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 13:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhBLM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 07:27:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhBLM0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:26:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 236E664E08;
        Fri, 12 Feb 2021 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613132723;
        bh=y5Zu5DaSe5YSQROZFDmQMEM/SLB1B4Zi5B+xZw/6laQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7dRM6wj5IEwUVWtIdiRquEySnaehLrt5vu0S6Q6bywuN1ypraAYDHQ7hENK38lbd
         kppTPbO5Bkb0QkjY5vQB1ENG833TkhZqGGIWqG8Bzlw6BMaZnAw4Tb/UPj2MkQIaCd
         Fic2PwHCnNo7yom6cl9OnK5mAs5QJIpQBsGxxsUP/5DJsl7YmC+qKdhVMS9DwWfH85
         Z2gOIKwqvp225UYEuPQ98BVTfP/S8E/1vehmyQ9MuxAj2yUuSv+AJJ//qu6jBX4biH
         tPiz69FMPfeKcI83jvo/tDWtXyqlM7uGUcXSlUBhVjG2W1Xyfd5l9Mmf86nJ8pAp4m
         +zi5guY1yPVhg==
Date:   Fri, 12 Feb 2021 13:25:21 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] nohz: change signal tick dependency to wakeup CPUs
 of member tasks
Message-ID: <20210212122521.GA90839@lothringen>
References: <20210128202134.608115362@fuller.cnet>
 <20210128202235.849263653@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128202235.849263653@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:21:36PM -0300, Marcelo Tosatti wrote:
> Rather than waking up all nohz_full CPUs on the system, only wakeup 
> the target CPUs of member threads of the signal.
> 
> Reduces interruptions to nohz_full CPUs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Index: linux-2.6/kernel/time/tick-sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/time/tick-sched.c
> +++ linux-2.6/kernel/time/tick-sched.c
> @@ -444,9 +444,20 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_ta
>   * Set a per-taskgroup tick dependency. Posix CPU timers need this in order to elapse
>   * per process timers.
>   */
> -void tick_nohz_dep_set_signal(struct signal_struct *sig, enum tick_dep_bits
> bit)

Why not keeping the signal struct as a parameter?

Thanks.

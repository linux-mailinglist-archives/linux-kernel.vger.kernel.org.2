Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FAA454B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhKQRG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239009AbhKQRGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:06:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EA566322D;
        Wed, 17 Nov 2021 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637168599;
        bh=93LKUrFwHBwKm3lauSHt4w2/lQiuxgqz/qn0Ck+cf5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4bIxA9CBiVud8v6olG/ywFlkds193yddreK4GnBcN/kDOTsHtQy6nC/sC0PKuxq2
         /F4Ph5TmTzUCx39k7KJT6L4O5cWLoeq1IhPye5eUYJRyRsu2zg/gadnU1WK8PhuPq0
         BRwicsCemkrO9AYGn3+pGbaQqot56sseRBy6VrBnxlz0uuZXXMiVxebjF46Oaidy4L
         2teodUGF6nybAWg9TAZ0F1N8bjmmpA50DJc6j+9/9F2hW9Vtoh9Q6vTMWLis47pkPi
         kIsOTHR6HIqoPpM0lJqf74FjYnq1HNZJZJuGE4SNllHFqcWMRibR2x9cv+6TGsqZJE
         UGLMm6T1yrztQ==
Date:   Wed, 17 Nov 2021 18:03:16 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     pmladek@suse.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] watchdog: ignore nohz_full cores in new cpumask
Message-ID: <20211117170316.GA364234@lothringen>
References: <20211116061536.16293-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116061536.16293-1-qiang.zhang1211@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 02:15:36PM +0800, Zqiang wrote:
> If the nohz_full is enabled, when update watchdog_mask, the
> nohz_full cores should be ignored.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

I don't know, I guess it can still be useful to have the lockup detector
available to debug some issues in nohz_full.

Those who override the cpumask should know what they are doing,
but you can still print a warning when a nohz_full CPU is included in
the range.

Thanks.

> ---
>  v1->v2:
>  if watchdog_cpumask became empty, set housekeeping_cpumask.
> 
>  kernel/watchdog.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index ad912511a0c0..6f0c5528b399 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -628,7 +628,9 @@ void lockup_detector_soft_poweroff(void)
>  static void proc_watchdog_update(void)
>  {
>  	/* Remove impossible cpus to keep sysctl output clean. */
> -	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
> +	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, housekeeping_cpumask(HK_FLAG_TIMER));
> +	if (cpumask_empty(&watchdog_cpumask))
> +		cpumask_copy(&watchdog_cpumask, housekeeping_cpumask(HK_FLAG_TIMER));
>  	lockup_detector_reconfigure();
>  }
>  
> -- 
> 2.17.1
> 

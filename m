Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84730A909
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhBANsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhBANsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:48:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3889564D99;
        Mon,  1 Feb 2021 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612187245;
        bh=OblNRRU9kt2opjlL2A1b+cyHiv7FjD00GN257vO0Hyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kX4MnFOwjVBTO0dX5qcuLJTS2yo8RCXKR6PQ1fuvA77uLu740cUMxT7zzZ+oiUWS5
         NZB5sJFOEaW23R7+j0cP/Nn1UZH27I/DOn6DT5xU3sl57uNb1y4yQVCyGqZyHGQFBD
         gbP651gjDexnAhZANFmg56DKTcoJkfFZdT4eGrqQL96Cv0yUVepoS7PeTHzsXrhRJr
         ptt0Oigp5jmK8lhy94ylbqEpb0Q72fp8yHOuz1PkWuwHfp9c9OI8Yv1vu0OYQf91F5
         lqZ784U7BwnTakLFWmy/tgLPMMlzQp4wp4tC05RpuvbIW+DoKDp3cHgPOKf8YpCsRT
         Xto/3opHaKO4Q==
Date:   Mon, 1 Feb 2021 14:47:23 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the issue that the tick_nohz_get_sleep_length()
 function could return a negative value
Message-ID: <20210201134723.GB41955@lothringen>
References: <YTBPR01MB3262A1EAA009500DF6DD2132C4A20@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTBPR01MB3262A1EAA009500DF6DD2132C4A20@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:49:38PM +0000, Zhou Ti (x2019cwm) wrote:
> Fix the issue that the tick_nohz_get_sleep_length() function could return a 
> negative value.
> 
> The variable "dev->next_event" has a small possibility to be smaller than 
> the variable "now" during running, which would result in a negative value 
> of "*delta_next". The variable "next_event" also has a small posibility to 
> be smaller than the variable "now". Both case could lead to a negative 
> return of function tick_nohz_get_sleep_length().

Makes sense, queued, thanks!

> 
> Signed-off-by: Ti Zhou <x2019cwm@stfx.ca>
> ---
> --- tip/kernel/time/tick-sched.c.orig	2021-01-20 05:34:25.151325912 -0400
> +++ tip/kernel/time/tick-sched.c	2021-01-20 19:44:28.238538380 -0400
> @@ -1142,6 +1142,9 @@ ktime_t tick_nohz_get_sleep_length(ktime
>  
>  	*delta_next = ktime_sub(dev->next_event, now);
>  
> +	if (unlikely(*delta_next < 0))
> +		*delta_next = 0;
> +
>  	if (!can_stop_idle_tick(cpu, ts))
>  		return *delta_next;
>  
> @@ -1156,6 +1159,9 @@ ktime_t tick_nohz_get_sleep_length(ktime
>  	next_event = min_t(u64, next_event,
>  			   hrtimer_next_event_without(&ts->sched_timer));
>  
> +	if (unlikely(next_event < now))
> +		next_event = now;
> +
>  	return ktime_sub(next_event, now);
>  }
>  

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FDA362671
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbhDPRNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235011AbhDPRNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618593206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sXzXZtuk+/8vAl4M3yX6Qq2AHAfdqj3pd1vTDTtJiIk=;
        b=E2O0ECgsoyaUsSSwaXbdZTv8P3IRmxg1aTAa8IaA19acU8r+pN07bRYlOYl+jbBSDCQoWb
        od+WZfuxkNTEaqOzw0PZWE4X94ayitPFGRpiRMUo8eKRYRTuYe3WzaF93OIqr20PjHDPlt
        T6r1kmK1QkLBPR6LYNfNNwC78TgnQ2Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-w4LFjUzIP-SbgrbjCC-mkQ-1; Fri, 16 Apr 2021 13:13:24 -0400
X-MC-Unique: w4LFjUzIP-SbgrbjCC-mkQ-1
Received: by mail-qt1-f198.google.com with SMTP id b8-20020a05622a0208b02901b5b18f4f91so3646116qtx.18
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sXzXZtuk+/8vAl4M3yX6Qq2AHAfdqj3pd1vTDTtJiIk=;
        b=oelJfMsPwD7lEjcNVBMQc5efSysf+BaDrkBqeOlNnWdt6P4ITElBcbXJY1tHKxbgR7
         QKXPd4GsaD6iJx4synvK3SME5hD6tNJq9TGz4P29kKdBZqF6r9gqt1A4sNrUpABQgE/K
         Djv/vaOdCzs8Eu+AMiCMRHCijN8kjx19Gci4CvOpLD5749RTxxbhAjLLBYckzplqqNg9
         loLHD0nQRAM425OPbcVDz8doz7pbvSf9nACS1iASmI3vYzRnpBrNVnyKZWyA4gl/Lh3c
         vz0Z0qw28usWr4P2Q4pkA738L89+zMv+QWiH1713CHCzSLR8wRPts6+vbanoGjAHUeB6
         5wxw==
X-Gm-Message-State: AOAM530qBFJq0DpQN0BcIXbUvkUIzW+w+ijKcmjQb3rhOLmO3n9i5vLE
        oaiGGBOC33lUH0oqv6fQ8ePs4c/d49xgLzZo+WW7+uZFr3wzso4zr+QVd9HhK+sWidid5UgsmHY
        wCKLeUSbfqtpTMJht/WuDXSck
X-Received: by 2002:a37:f509:: with SMTP id l9mr267122qkk.172.1618593204046;
        Fri, 16 Apr 2021 10:13:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZTl5Qx9AJrkl3nM/Sc7dUYo5lI/w/V00uW1CClA2TVmkJxfQ3zNQGPv7O84ctaCfiHo5isQ==
X-Received: by 2002:a37:f509:: with SMTP id l9mr267102qkk.172.1618593203769;
        Fri, 16 Apr 2021 10:13:23 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id q198sm4626113qke.3.2021.04.16.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 10:13:22 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:13:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH v5] hrtimer: avoid retrigger_next_event IPI
Message-ID: <20210416171321.GU4440@xz-x1>
References: <20210407135301.GA16985@fuller.cnet>
 <87o8en4k9a.ffs@nanos.tec.linutronix.de>
 <20210409165146.GA40118@fuller.cnet>
 <87lf9q4lue.ffs@nanos.tec.linutronix.de>
 <20210413170431.GA16190@fuller.cnet>
 <20210415153935.GA69750@fuller.cnet>
 <87im4nv0fh.ffs@nanos.tec.linutronix.de>
 <20210415204017.GA111847@fuller.cnet>
 <20210416160023.GA6187@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416160023.GA6187@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

On Fri, Apr 16, 2021 at 01:00:23PM -0300, Marcelo Tosatti wrote:
> 
> Setting the realtime clock triggers an IPI to all CPUs to reprogram
> the clock event device.
> 
> However, only realtime and TAI clocks have their offsets updated
> (and therefore potentially require a reprogram).
> 
> Instead of sending an IPI unconditionally, check each per CPU hrtimer base
> whether it has active timers in the CLOCK_REALTIME and CLOCK_TAI bases. If
> that's not the case, update the realtime and TAI base offsets remotely and
> skip the IPI. This ensures that any subsequently armed timers on
> CLOCK_REALTIME and CLOCK_TAI are evaluated with the correct offsets.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> v5:
>   - Add missing hrtimer_update_base (Peter Xu).
> 
> v4:
>    - Drop unused code (Thomas).
> 
> v3:
>    - Nicer changelog  (Thomas).
>    - Code style fixes (Thomas).
>    - Compilation warning with CONFIG_HIGH_RES_TIMERS=n (Thomas).
>    - Shrink preemption disabled section (Thomas).
> 
> v2:
>    - Only REALTIME and TAI bases are affected by offset-to-monotonic changes (Thomas).
>    - Don't special case nohz_full CPUs (Thomas).
> 
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 5c9d968187ae..06fcc272e28d 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -871,6 +871,19 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
>  	tick_program_event(expires, 1);
>  }
>  
> +#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME) |	\
> +			 (1U << HRTIMER_BASE_REALTIME_SOFT) |	\
> +			 (1U << HRTIMER_BASE_TAI) |		\
> +			 (1U << HRTIMER_BASE_TAI_SOFT))
> +
> +static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
> +{
> +	if (cpu_base->softirq_activated)
> +		return true;

A pure question on whether this check is needed...

Here even if softirq_activated==1 (as softirq is going to happen), as long as
(cpu_base->active_bases & CLOCK_SET_BASES)==0, shouldn't it already mean that
"yes indeed clock was set, but no need to kick this cpu as no relevant timer"?
As that question seems to be orthogonal to whether a softirq is going to
trigger on that cpu.

Thanks,

> +
> +	return (cpu_base->active_bases & CLOCK_SET_BASES) != 0;
> +}

-- 
Peter Xu


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79654188EE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhIZNAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 09:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhIZNAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 09:00:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E094C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 05:58:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bj3-20020a17090b088300b0019e6603fe89so9679632pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V+3JPP/qEjst6P3kdqUslUZDsJtrB7rfM+MHK2FemcU=;
        b=mxZHKoBBbrBiaoQtw/wBSVbdCemxd3N1m0sT/3/tmW4YnLhsA/uUXnj8Aqaj0MUk+Q
         Q9J2cWloxM/Vp4iJQJaRufXwPdEyV1Liex1kherOMXSBnPvOmf23qdINO+qIVH08+JR5
         2DqaiaVi8+HYbAXzHCUlw8DZgTJtYTzUGUya8AuzD2aQhChHRCK8kdH575SDU4LHGxZc
         2C0Hzg4xwjsInN6aGqba8eoeKvAKK51YIAIzSW3r+oBcUeV10yNOLn+d1SwKzDQ+T1Yd
         MyvQfv2t/ECo/hoCXAj6GUFT7f28GSSU0YH9mQ10wc111bQ2kvnm6Wc8miwQqvVtAfJM
         Aq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V+3JPP/qEjst6P3kdqUslUZDsJtrB7rfM+MHK2FemcU=;
        b=MI45GTRtYlK2F/3q4T5KFQbK2I79p+b+3Ti96PGqNVAJyckr6iX1HOgvau+WuqOS7v
         sDGQTC0U6epyJ2r5gyItCXxAstai/sWZapt0sld0gRUgpuBKk8FpIAnNdxOZyYMnyl+U
         mMpatIpdJSl0kaMf2p2k5bYE5yFGXVOC9nIvP5WVSZX1we+KrJQGIAny2vG16qY/uaBn
         2wf13tXw6JfCeMo1cbGiUs4WWvmr6cwclZ9pwDwKbtp9p6pNXWTbj38OZn1PcqcqNOao
         9Xi0r2/ReBJPnhVXn0jNsb7yk+GaG3oWjQGPw6BtzWrJhqzrbdk6fEEgJCkioYwntHcQ
         /zBg==
X-Gm-Message-State: AOAM5332dCU3ZJ3RQ9ja5aL9KtKK5r4IPtHgQTyvAcTw6XfJJVuwzBAY
        jXvNPh5kAxY686n/Zf9DdL8=
X-Google-Smtp-Source: ABdhPJxJrrnR22arYrelpjajNT/NjOocjOeBm3+FEWwt3VRgsKtj5PGm5MrqT3+v/A7XhRPnh4mUKw==
X-Received: by 2002:a17:902:b70d:b0:13d:f6c9:2066 with SMTP id d13-20020a170902b70d00b0013df6c92066mr9654270pls.2.1632661118473;
        Sun, 26 Sep 2021 05:58:38 -0700 (PDT)
Received: from localhost (g22.61-45-46.ppp.wakwak.ne.jp. [61.45.46.22])
        by smtp.gmail.com with ESMTPSA id u12sm13971671pjr.2.2021.09.26.05.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 05:58:37 -0700 (PDT)
Date:   Sun, 26 Sep 2021 21:58:35 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Victor Stinner <vstinner@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        GLIBC patches <libc-alpha@sourceware.org>
Subject: Re: [PATCH] posix-cpu-timers: Fix spuriously armed 0-value itimer
Message-ID: <YVBue6owgaW31Kdz@antec>
References: <20210913145332.232023-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913145332.232023-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ccing libc-alpha,

On Mon, Sep 13, 2021 at 04:53:32PM +0200, Frederic Weisbecker wrote:
> Resetting/stopping an itimer eventually leads to it being reprogrammed
> with an actual "0" value. As a result the itimer expires on the next
> tick, triggering an unexpected signal.

Thanks for this I just tracked down the same issue.

I just wanted to give an FYI in case anyone else notices this.

This was causing gprof (gcc -pg) to fail.  I noticed this when running the glibc
test suite, tests: gmon/tst-gmon-static, gmon/tst-gmon

Gprof uses ITIMER_PROF, as per:

 - https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/posix/profil.c;h=fbf1184df1ccc6e1d2098f92c7d87fc28f5a8f09;hb=HEAD

I was seeing the extra SIGPROF signal after profil de-registered the timer and
signal handler.  The spurious signal causes all profiled programs to be killed
and collect no gprof data.

-Stafford

> To fix this, make sure that
> struct signal_struct::it[CPUCLOCK_PROF/VIRT]::expires is set to 0 when
> setitimer() passes a 0 it_value, indicating that the timer must stop.
> 
> Reported-by: Victor Stinner <vstinner@redhat.com>
> Fixes: 406dd42bd1ba ("posix-cpu-timers: Force next expiration recalc after itimer reset")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/time/posix-cpu-timers.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index ee736861b18f..643d412ac623 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -1404,7 +1404,8 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
>  			}
>  		}
>  
> -		*newval += now;
> +		if (*newval)
> +			*newval += now;
>  	}
>  
>  	/*
> -- 
> 2.25.1
> 

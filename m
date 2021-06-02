Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8785F3991E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFBRsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhFBRsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:48:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6793AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 10:46:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 69so1487424plc.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1yJMrgCzqazffsveozdnJnJ/59tXPl4Si38PxDtQ0Bg=;
        b=GzkkucdjMqNfaFqLgX+NZElJD9d3Ga6cbJt3M3WZ8fYYafj3+Jav/49QVC4Vf0vA/I
         LPmI35j/Umj7g5Kjm+WD2frgvTuqv7Q7stUmEKBnZxgwHDKgUzLkcSEXGzEsX2q/8r40
         ErjkIpRn+TqE60jqHzrl+vYNbpEScbrL28vTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1yJMrgCzqazffsveozdnJnJ/59tXPl4Si38PxDtQ0Bg=;
        b=YIg2u6geIHD8xzekmdJQkgb7AhlT92djC9pxH8qqTNo3CKmbO1y7SMLiit0VKLQVKG
         LC0/uAtYKpm6i5FJQ6yR/mq+RdAqKnkSEi9xjB+rk626QqmTo6qb8f5Iss3RT6hVKHr9
         DWzV667B896Dkw2NbkVP0rspJXG0jV6+BKthQ7des2j4amZAdqSxlWK7BeiuIMgYSVHk
         a8/Oaih+c4SSXvk3/MeTsS0qi1Y0BpAKWCfYE3nSaZlbZhli1E4AoMGbEWeD087rfnrr
         /FKJbF3YRMU8o2nDu2FdO65uY5Mi8k//DdaiO+zdyoXCv1uUnMfp02E7ynxZ56MxITvH
         QAHA==
X-Gm-Message-State: AOAM532zHVCbAIKnJ5fbYU4jOWjM0iELd30guRjwXXHj2Xb9ep8KZSPa
        +ycbiXo/yaI2RinywYqgAIAZuw==
X-Google-Smtp-Source: ABdhPJwPZxDGHl3sbwkIbwfXjOgf2vRHJ15hZytJSCPEPG7tz2Hwg55y0tz+tmG+yfXLqdovrGoycg==
X-Received: by 2002:a17:90b:4a8a:: with SMTP id lp10mr30462148pjb.121.1622655974004;
        Wed, 02 Jun 2021 10:46:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm234626pfe.61.2021.06.02.10.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:46:13 -0700 (PDT)
Date:   Wed, 2 Jun 2021 10:46:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] sched/debug: remove obsolete init_schedstats()
Message-ID: <202106021045.7C51D37@keescook>
References: <20210602112108.1709635-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602112108.1709635-1-eric.dumazet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:21:08AM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Revert "sched/debug: Fix 'schedstats=enable' cmdline option"
> 
> This reverts commit 4698f88c06b893f2acc0b443004a53bf490fde7c.
> 
> After commit 6041186a3258 ("init: initialize jump labels before command
> line option parsing") we can rely on jump label infra being ready for use
> when setup_schedstats() is called.

Ah yeah, good catch.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Guenter Roeck <groeck@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  kernel/sched/core.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5226cc26a095f427dafa864ff37d39d529e2ba85..105fa6c73e7d9ded05683ee43a11e3b4461932d5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3648,7 +3648,6 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
>  #ifdef CONFIG_SCHEDSTATS
>  
>  DEFINE_STATIC_KEY_FALSE(sched_schedstats);
> -static bool __initdata __sched_schedstats = false;
>  
>  static void set_schedstats(bool enabled)
>  {
> @@ -3672,16 +3671,11 @@ static int __init setup_schedstats(char *str)
>  	if (!str)
>  		goto out;
>  
> -	/*
> -	 * This code is called before jump labels have been set up, so we can't
> -	 * change the static branch directly just yet.  Instead set a temporary
> -	 * variable so init_schedstats() can do it later.
> -	 */
>  	if (!strcmp(str, "enable")) {
> -		__sched_schedstats = true;
> +		set_schedstats(true);
>  		ret = 1;
>  	} else if (!strcmp(str, "disable")) {
> -		__sched_schedstats = false;
> +		set_schedstats(false);
>  		ret = 1;
>  	}
>  out:
> @@ -3692,11 +3686,6 @@ static int __init setup_schedstats(char *str)
>  }
>  __setup("schedstats=", setup_schedstats);
>  
> -static void __init init_schedstats(void)
> -{
> -	set_schedstats(__sched_schedstats);
> -}
> -
>  #ifdef CONFIG_PROC_SYSCTL
>  int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos)
> @@ -3718,8 +3707,6 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
>  	return err;
>  }
>  #endif /* CONFIG_PROC_SYSCTL */
> -#else  /* !CONFIG_SCHEDSTATS */
> -static inline void init_schedstats(void) {}
>  #endif /* CONFIG_SCHEDSTATS */
>  
>  /*
> @@ -8258,8 +8245,6 @@ void __init sched_init(void)
>  #endif
>  	init_sched_fair_class();
>  
> -	init_schedstats();
> -
>  	psi_init();
>  
>  	init_uclamp();
> -- 
> 2.32.0.rc0.204.g9fa02ecfa5-goog
> 

-- 
Kees Cook

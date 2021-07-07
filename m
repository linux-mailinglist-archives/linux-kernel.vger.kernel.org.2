Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E63BF01F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhGGTUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 15:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGGTUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:20:50 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2FFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 12:18:09 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso767266ooc.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Y7Q51/7FLsCms66glLj41BP5mqecTdjNWpQEsIZ8maA=;
        b=GhGgdo1uZFPwlJDhrxzSSKETzBZEfVoXMQ3Ml4ZKUlafAZUF4OHN0xRl5PnsgDfxFq
         1jGcfEat3uGzVNqztVDKGxfT5VJXWYgroBb86qiN71d63McvKGeGGaBTphuvzI9JRRVT
         +zkEuUnlZz9XlhMPlhTuA5lOC0NIxmRfNTd4MjWU7osgUy6IjX9ihL6S77qRBnzlkN23
         0O4qjM/uhD+wxl4nKCLRGkT2MUyCA/tgWdiUSbCYNTPfNdUfaFO/+Y8IZxC4cisUn2BU
         FJIwsnKM8W5jUkSiT7Vc8QZzWNg/BygY0M64pesU7o+j2b3HeBqmmV0Im1uw6z/6n69e
         M3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Y7Q51/7FLsCms66glLj41BP5mqecTdjNWpQEsIZ8maA=;
        b=XwvIrQ32grrXr1mxZkciTmgWxGJ1bGaDEt0YyNYECAf61SiL7kSSSoWrcKZuUdqU4n
         TRrLKfM3jifgVAIA/otJO64wp0aJlo17NtJoy5e4m3cdUbLjaNi3nWFDLxfspfejbUu6
         5xpcCtaBchA4KJtwY6jMkCwj6/oIfIwfEiVTMXksU8BCmI1e0Btt/FdiMEGjUoE+rtB5
         oNogyZA8CFk7ADS48/9+FQ8LYwnHstcR+XNQprr3T8UrfC4ZsF0fBYUPHvBPayQwwaRo
         YtFiVt19N+Yj23y4jkl2grPvHvWj1nX1eVsFNyv4pYwLpzx6kUWdybtDXWfojHHrFgSE
         VJkw==
X-Gm-Message-State: AOAM530mmaWpHg2nbQuAyIK++Ga4iM//O6GZBd2Hmj9HfsToKhGR16Ja
        CtjzllLtnYHhh5PSKwbUvdg=
X-Google-Smtp-Source: ABdhPJxhpgZtFpXxgiq4iFjsks77cNfTgE5hakcSlpkJO0GiSRepWq4Fn3wdns7pp1X2Xlw/4ENwVw==
X-Received: by 2002:a4a:8687:: with SMTP id x7mr19627528ooh.46.1625685488815;
        Wed, 07 Jul 2021 12:18:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h25sm990890oop.15.2021.07.07.12.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:18:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 7 Jul 2021 12:18:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Bharata B Rao <bharata@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: preempt: Don't touch the idle task's
 preempt_count during hotplug
Message-ID: <20210707191806.GA2205122@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 07:38:31PM +0100, Valentin Schneider wrote:
> Powerpc currently resets a CPU's idle task preempt_count to 0 before said
> task starts executing the secondary startup routine (and becomes an idle
> task proper).
> 
> This conflicts with commit
> 
>   f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
> 
> which initializes all of the idle tasks' preempt_count to PREEMPT_DISABLED
> during smp_init(). Note that this was superfluous before said commit, as
> back then the hotplug machinery would invoke init_idle() via
> idle_thread_get(), which would have already reset the CPU's idle task's
> preempt_count to PREEMPT_ENABLED.
> 
> Get rid of this preempt_count write.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
> Reported-by: Bharata B Rao <bharata@linux.ibm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/powerpc/platforms/cell/smp.c    | 3 ---
>  arch/powerpc/platforms/pseries/smp.c | 5 +----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
> index c855a0aeb49c..d7ab868aab54 100644
> --- a/arch/powerpc/platforms/cell/smp.c
> +++ b/arch/powerpc/platforms/cell/smp.c
> @@ -78,9 +78,6 @@ static inline int smp_startup_cpu(unsigned int lcpu)
>  
>  	pcpu = get_hard_smp_processor_id(lcpu);
>  
> -	/* Fixup atomic count: it exited inside IRQ handler. */
> -	task_thread_info(paca_ptrs[lcpu]->__current)->preempt_count	= 0;
> -
>  	/*
>  	 * If the RTAS start-cpu token does not exist then presume the
>  	 * cpu is already spinning.
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
> index 096629f54576..7ebf3382816a 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -105,10 +105,7 @@ static inline int smp_startup_cpu(unsigned int lcpu)
>  		return 1;
>  	}
>  
> -	/* Fixup atomic count: it exited inside IRQ handler. */
> -	task_thread_info(paca_ptrs[lcpu]->__current)->preempt_count	= 0;
> -
> -	/* 
> +	/*
>  	 * If the RTAS start-cpu token does not exist then presume the
>  	 * cpu is already spinning.
>  	 */
> -- 
> 2.25.1
> 

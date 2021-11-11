Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4938B44D3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhKKJOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhKKJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:14:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE33FC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:11:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso5097148wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJN505w6CL42PiEBXtyIsEZEsP4VhYdScJ4DvF6IvUE=;
        b=WV4O0X4udKGv3mXB+Hyjn+Y0JK+NaM83No3U8ONvBfm9JnOz7BosU+qPGnOX9b7h6a
         viRTnicfbRqxuku9BNAtdIx3oK590XlPQBEkrBTm62zhnZE1IJsEA1FQP58xcf2TNLzX
         jyL2Aq1TA5p1/bMTJey4kNHPHCP9uZhAk4E2PU2VC+70VuJQ8z5K4t9dt3Eiyc6++s15
         bKWtIr5Dq33i55/WXa0Vo+Bqxk31w5GQA4XHVaKSeX1M0i/ya66UgTtwxMST8st7S11r
         pAnYVnVLMQXG/FNCi/rsCpVlkSXbcQrNBPgjwm4AmtvqLHhqkMOMTUPM4WPEx6+vHrpA
         fyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJN505w6CL42PiEBXtyIsEZEsP4VhYdScJ4DvF6IvUE=;
        b=FQXPT43xdVmLYsXz6F6HYsBh/fcEXL8Lg44KghMzydeiXCyox0o7+A1LGUMpY0UB3C
         mBq2eDJiS/ZtW1TNDstDnsReUafTFVzzTRLYrvqB83x5kS1mf2FvP/dmmO9x5BOi4GK9
         S4NRMtX8gx0CtwzO0pODq9OEpOpUT6cuHwhCJWvf2jzxcRdIOJ7cDsQSsAvtVWk3PrqB
         NKuZ9wmxXwBor7G8vHre+zXbUH7ZXe7FfusvHGtuK11A/vMfbJ6CvVHrFDZHHSpfcpmP
         sYxKBvn8N9G0KkRaBR3GJ43iUKI345cbPt9SoE8PyWn8FxTRLMwkQosXVfHChw0flDxZ
         jiqA==
X-Gm-Message-State: AOAM533I3jysInPmNTbwMLUWeY2C7+HIoLsMdKyge4asObHH7mtmzONC
        qHtN0rfYNMW6RAYz337z04c6XIcHkldKgQ==
X-Google-Smtp-Source: ABdhPJzkZFauMx8KH0DEgUcMSakcoswH2SNKj7IhgTRnKWp9Auzdv8qBuhpD4B2Wlp1Wmez/UFj7Vw==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr6684146wme.38.1636621889057;
        Thu, 11 Nov 2021 01:11:29 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:fd21:69cc:1f2b:9812])
        by smtp.gmail.com with ESMTPSA id s13sm8531050wmc.47.2021.11.11.01.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 01:11:28 -0800 (PST)
Date:   Thu, 11 Nov 2021 10:11:21 +0100
From:   Marco Elver <elver@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 4/5] kscan: Use preemption model accessors
Message-ID: <YYzeOQNFmuieCk3T@elver.google.com>
References: <20211110202448.4054153-1-valentin.schneider@arm.com>
 <20211110202448.4054153-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110202448.4054153-5-valentin.schneider@arm.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject s/kscan/kcsan/

On Wed, Nov 10, 2021 at 08:24PM +0000, Valentin Schneider wrote:
> Per PREEMPT_DYNAMIC, checking CONFIG_PREEMPT doesn't tell you the actual
> preemption model of the live kernel. Use the newly-introduced accessors
> instead.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

Though it currently doesn't compile as a module due to missing
EXPORT_SYMBOL of is_preempt*().

> ---
>  kernel/kcsan/kcsan_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index dc55fd5a36fc..14d811eb9a21 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -1005,13 +1005,13 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
>  	else
>  		nthreads *= 2;
>  
> -	if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
> +	if (!is_preempt_full() || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
>  		/*
>  		 * Without any preemption, keep 2 CPUs free for other tasks, one
>  		 * of which is the main test case function checking for
>  		 * completion or failure.
>  		 */
> -		const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
> +		const long min_unused_cpus = is_preempt_none() ? 2 : 0;
>  		const long min_required_cpus = 2 + min_unused_cpus;
>  
>  		if (num_online_cpus() < min_required_cpus) {
> -- 
> 2.25.1

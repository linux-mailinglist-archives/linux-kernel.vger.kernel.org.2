Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2DD44D38D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhKKI5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhKKI5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:57:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1EAC061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:54:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so3864527wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2pRx3VrkRvZzvTAGodY7FBYbqa7VwcKa7WgFhF9R6k=;
        b=hKMluJXv3cyn/6Ynmj9veQdzGcfSmCSFG579re0rSO1tRqLHpBWJu9Fwffh1MImSiV
         9lVDbZ+PTmFa5VLZtW+4dmbkNJhCiV6Mn31mAn/sv9C2ywUe+5Zi9nw1sKPf3D79mJuH
         Xu78Qr/gH0FY/7l8aYSagKd3qmz9gYzLZ62FAXcMZVNkqPtXOBh3x22yTvvJpgfPc81T
         ek0wMLCyit/12eBl70fjor1e4lUxm8HvOdo/uiRyMJ+z0uM+jdn8tMtRpiqnoCejQ6s1
         9Mxz0cBVuYZN6jSzMhjTX2uPJYFwb+XZ+JH+qIGcAEGf2NQ1Qs5ojQHmD9vsEWdGVZcM
         GY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2pRx3VrkRvZzvTAGodY7FBYbqa7VwcKa7WgFhF9R6k=;
        b=FQXtxfaDc5BWfLB5ldgNa1BmGPmQr0/qpYiMUbf3unBr8WG+WlnwmZnXN/UgPBujRm
         6n/hqsUdUeZIf6lu/x6Yi6EMARPIwC0nu8Ov+xNW+gSiHVUFB1axIlsjc8iMK92BGqJf
         BNmlRalLF7M6PsK3XnraE4DAhVBIlUP4mYQ7ydJp24RqnGsZjvXgSsR+FVigQlmIjRJp
         RVw9rpUWFmxGU119oVu9WQY/yQ15qmyhh2dvt6LYdwfRMlYWuH+mDTl461r9d1lj3UM/
         1Ox4EIlm75nAFc0bzMUTt2R0kW8LvxcxihEDi+dtRHB3OJgvWv+rsE626AqF/JF0EWmw
         wfAQ==
X-Gm-Message-State: AOAM533CetQp73D0KAR2Xv8JguUv4zMtQNG1w4WHScLm9z2Dl1fibnRj
        oK6acBJM5BTzqa4GoAaPSFctTQ==
X-Google-Smtp-Source: ABdhPJxEBRNPec/bxvLCqnLUS7WDbPiOxrRwFfQ0JkP8imwe8zHRLQn9sFwrFH2xKqmya9LJVZJJMA==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id n10mr6436687wmq.54.1636620852405;
        Thu, 11 Nov 2021 00:54:12 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:fd21:69cc:1f2b:9812])
        by smtp.gmail.com with ESMTPSA id l2sm8637092wmq.42.2021.11.11.00.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 00:54:11 -0800 (PST)
Date:   Thu, 11 Nov 2021 09:54:05 +0100
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
Subject: Re: [PATCH v2 2/5] preempt/dynamic: Introduce preempt mode accessors
Message-ID: <YYzaLTtf1tFbqDSn@elver.google.com>
References: <20211110202448.4054153-1-valentin.schneider@arm.com>
 <20211110202448.4054153-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110202448.4054153-3-valentin.schneider@arm.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 08:24PM +0000, Valentin Schneider wrote:
[...]
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +
> +extern bool is_preempt_none(void);
> +extern bool is_preempt_voluntary(void);
> +extern bool is_preempt_full(void);
> +
> +#else
> +
> +#define is_preempt_none() IS_ENABLED(CONFIG_PREEMPT_NONE)
> +#define is_preempt_voluntary() IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)
> +#define is_preempt_full() IS_ENABLED(CONFIG_PREEMPT)
> +
> +#endif
> +
> +#define is_preempt_rt() IS_ENABLED(CONFIG_PREEMPT_RT)
> +

Can these callables be real functions in all configs, making the
!DYNAMIC ones just static inline bool ones? That'd catch invalid use in
#if etc. in all configs.

>  /*
>   * Does a critical section need to be broken due to another
>   * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 97047aa7b6c2..9db7f77e53c3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6638,6 +6638,17 @@ static void __init preempt_dynamic_init(void)
>  	}
>  }
>  
> +#define PREEMPT_MODE_ACCESSOR(mode) \
> +	bool is_preempt_##mode(void)						 \
> +	{									 \
> +		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
> +		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
> +	}

This needs an EXPORT_SYMBOL, so it's usable from modules like the
kcsan_test module.

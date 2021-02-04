Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F33330EEFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhBDItn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhBDItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:49:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35503C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 00:48:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c12so2469405wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GX8PFk+rrBjk3+DRdB72kCYTMar9krxJSG+CXUd9b5Y=;
        b=U7oSOy0n0eDTWoPFbM+ww1vFob047faR/zB0z3DXVnCKJPy2kf6ZyQYIg65jOiPbz+
         XdyeZ1xkQUtIwxCv5RmQBKVygNsdOQwsIW7wznr1+N+ajPJ2QF1TkiOhAnn1p652lHPN
         llqOPj8JfLpTKFR/gJa+5YkjVw09iZLaryIH6d67nB8XHW5GdUG3+7dE5wRq+DjJAl30
         bgNWA6eB9zh9g00V3ZNo43fIWKNbnmo7ZIaw7gfnZAonZaLiKTliIhQtM1JrzyJqgkSb
         2qm/5pod8zGlkPHYH/T+K4+6pWT9/ccIsKV8DWXG7XHfrRFaqe/2j15RObDO9IEH4qI8
         zJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GX8PFk+rrBjk3+DRdB72kCYTMar9krxJSG+CXUd9b5Y=;
        b=aNtdVF6xTjNZEpnQ/3LlHXWkl35pc+hBzRw+yZ4hLnWm7DKpny74QPQ0SBmx1Am1RQ
         SJd+OEJaFvDHFAwijbqT32Ge94JYT2EsFvwueabfVPb6vuhS2k61xkE+7scQduQEMr9w
         kPLnkM+ZeFJePES3frhg4Ork1vWtJm3J/n1NbyKeWzRWCi+Erbk+0mnBeZcdr2ciHQYj
         GoAOd88QcvMMT7evD7V5vjaeAFWVmpNV//csgu3v7E+rGRSp+l5NZjEv0EJGCYqnDSxb
         4WVbEWceRpOvEmU+NrAvZiBTUmeMrmdmAZH0RJKR++KXcAhnjFnR4VL0vDMnhsRwQoL+
         sDRg==
X-Gm-Message-State: AOAM530IXRs0FSNUrKvGUrHrubr4E2iuMry5l6P/NzxrXXS2TIH9+gfu
        h77W2NNTMY1wgnebwnZXv9RQsAt0sC+RZg==
X-Google-Smtp-Source: ABdhPJzLe65V0rUsDWCfg8r1gcsnXpOBoDtmW7vFp3f8n8bR3WJMnfOYrW9ic840fJJPhft0iUPzew==
X-Received: by 2002:a5d:49c1:: with SMTP id t1mr8123153wrs.56.1612428502591;
        Thu, 04 Feb 2021 00:48:22 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:d57d:36c2:c8de:a0ef? ([2a01:e34:ed2f:f020:d57d:36c2:c8de:a0ef])
        by smtp.googlemail.com with ESMTPSA id y63sm5237303wmd.21.2021.02.04.00.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 00:48:21 -0800 (PST)
Subject: Re: [PATCH v2 2/2] drivers/clocksource: Fixup csky,mptimer compile
 error with CPU_CK610
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <20210204074609.3553018-1-guoren@kernel.org>
 <20210204074609.3553018-2-guoren@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c36b816b-6d80-9542-45fc-507c5cc302fb@linaro.org>
Date:   Thu, 4 Feb 2021 09:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204074609.3553018-2-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2021 08:46, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The timer-mp-csky.c only could support CPU_CK860 and it will
> compile error with CPU_CK610.
> 
> It has been selected in arch/csky/Kconfig.

It would be better if you fix the root cause of the compilation error.

The COMPILE_TEST is there for compilation test coverage when the changes
are touching a lot of drivers.

> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/clocksource/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> ---
> v2: Drop the string after bool,
>     as suggested by Marc Zyngier <maz@kernel.org>
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 14c7c4712478..d39e6ca86d25 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -662,7 +662,7 @@ config CLINT_TIMER
>  	  driver is usually used for NoMMU RISC-V systems.
>  
>  config CSKY_MP_TIMER
> -	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
> +	bool
>  	depends on CSKY
>  	select TIMER_OF
>  	help
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB69B3991F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhFBRy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFBRyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:54:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01D9C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 10:53:11 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x10so1500126plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8bAhTDCF3igchPug+xoUDLeQvBBVeA496XBVDpdCOxg=;
        b=UTqvaGkKaH5qEVy2RpUg+nC3Z3fv31rd8XwQTk0cOtz2tfPyb2mmuhEFLRn7n3iO+C
         QUBtILQc1xtYwye8iJ3weAXJ9m8YoOI65+nhBl97QzJ8Lx9ecRureRsR/9m7sLwcTa04
         LOIdE2pyTZGoTKWC1oH4QUUi/o0dRZsTWHz58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8bAhTDCF3igchPug+xoUDLeQvBBVeA496XBVDpdCOxg=;
        b=M7WPzP2q5K/oVSm+Q2PPc43Rg6a7fhhA8xJfEJse3OJoFDvDnKpzXSUAxh0CX7NbFb
         fSO2rqaAl5+FEwJ97MQjtYCV21q0L/61Tx1s65Sfry6veuQk7TZWSXWiFTNMhF27ruPa
         3VHNDVQ1MHHrj/dtwSIQzarbyq8B8B7QMMPEjikTEd7bV8shyQIbhJURbNSIKFEAESCr
         l9Eqt/xAR9nbsiHC1cmQmnYdiaR9R5v+qlu17alVak8z5iPMoT8Kh+qvrmdJmmzrP94a
         B9VMINojHuNPtVpVNWZO8h5moePourcyXXQ1TsWZVlCyAFwAkLcWEa1QO1fWMBZcsxBV
         uD7w==
X-Gm-Message-State: AOAM531YuH+JHWxz6bSrlSCsshtl7TLS6qBBSWpQV2hcEWY9Pk08zTq0
        wrxNwy16tI/IeOC+/EsLEc7F5g==
X-Google-Smtp-Source: ABdhPJw8FRlb5UqKvDfAjLuAOoeF3qE7ddNKwUsn89HMexRewXW9/Po34jBYVXjVtPpiraGcBQI4dQ==
X-Received: by 2002:a17:902:9f83:b029:f6:5c3c:db03 with SMTP id g3-20020a1709029f83b02900f65c3cdb03mr32345585plq.2.1622656389930;
        Wed, 02 Jun 2021 10:53:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fs24sm156452pjb.6.2021.06.02.10.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:53:09 -0700 (PDT)
Date:   Wed, 2 Jun 2021 10:53:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org,
        mingo@kernel.org, dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Yejune Deng <yejunedeng@gmail.com>
Subject: Re: [PATCH] softirq: Remove the unnecessary CONFIG_TRACE_IRQFLAGS
Message-ID: <202106021051.0AF942F9@keescook>
References: <1622619282-12077-1-git-send-email-yejunedeng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622619282-12077-1-git-send-email-yejunedeng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 03:34:42PM +0800, Yejune Deng wrote:
> The local_irq_enable() and local_irq_disable() had two definitions that
> include CONFIG_TRACE_IRQFLAGS or not.

Hm, this has a behavioral change. Current code only does tracing and
raw_local_irq_disable/enable when CONFIG_TRACE_IRQFLAGS. This change
causes it to always do raw_local_irq_disable/enable. Which is the right
behavior?

-Kees

> 
> Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
> ---
>  kernel/softirq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 4992853..a81d804 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -362,9 +362,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  {
>  	WARN_ON_ONCE(in_irq());
>  	lockdep_assert_irqs_enabled();
> -#ifdef CONFIG_TRACE_IRQFLAGS
>  	local_irq_disable();
> -#endif
>  	/*
>  	 * Are softirqs going to be turned on now:
>  	 */
> @@ -385,9 +383,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  	}
>  
>  	preempt_count_dec();
> -#ifdef CONFIG_TRACE_IRQFLAGS
>  	local_irq_enable();
> -#endif
>  	preempt_check_resched();
>  }
>  EXPORT_SYMBOL(__local_bh_enable_ip);
> -- 
> 2.7.4
> 

-- 
Kees Cook

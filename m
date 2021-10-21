Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA14366BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJUPwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhJUPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:52:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1FC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:49:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g184so695040pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B1/Vs59OV/rlWJ6WA3d6EaWlhOZ3vZvbO+vUp8p6+uU=;
        b=ZbrLEWc8XCHfsf9wt1aDQHxFzTJ8rEsxaTYPDKBbrRupbVWpHtTCPlV/ZHjauRl9rY
         qqkbRN9u2kl4MJlEwsbw0rYEHrGvH+9pp2aqwMMD7r6fnoNhZFk1foo8lO7382V3WVGC
         0FbbFl888tBrxihLXPYLfXAufTVIgRjw+nugY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B1/Vs59OV/rlWJ6WA3d6EaWlhOZ3vZvbO+vUp8p6+uU=;
        b=Yy7YmGZsDHNaPaeHVMm+htn1qGeMtj0JErSubahoSyUk9FqqZHNe63aVRvhdPbGLck
         hskJSO+ONknjMV0iGaIuSJ3LO4VaZJ8meNUAATmCHRQimEw9cb4fDUX/vd4mzqJcMqii
         TWenSXmPaxS3aw3HtH7un4Lia2bpa/hZC5QvCJSXAxgzqPtaDRHhNVe+M/QHGT13Ik9+
         XJ2uxvPfpA4MChjsPAs+tyL3NbE7d2uTmCMbCqsDx28Y49oD5D+s3wtd1/zas0sDXlJF
         Llz7cutuaLhKwSz69hpnVhWpKj1jQtL3g3vFQ7Y/oBN5zvG239owOXCfmHh71eBdGeoF
         +jRg==
X-Gm-Message-State: AOAM530IBksFTkqqc6oC1aAvlkj/NGwZx5zs75AjdiiqHo2yeCZ2Rgpm
        oGV5kgaZSlpyKCDUphd29+4P0g==
X-Google-Smtp-Source: ABdhPJw+9J2A0sNBhnV+GqqNjnX5G4VuuTqU8s7+dkEe3eTfgQVYMCUKYcJCcnwHJb/H4t3RMrJRHQ==
X-Received: by 2002:a62:1596:0:b0:44c:f7b3:df74 with SMTP id 144-20020a621596000000b0044cf7b3df74mr6803173pfv.60.1634831387812;
        Thu, 21 Oct 2021 08:49:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12sm9595637pjh.51.2021.10.21.08.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:49:47 -0700 (PDT)
Date:   Thu, 21 Oct 2021 08:49:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 4/4] perf: arm_spe: Dynamically switch PID tracing to
 contextidr
Message-ID: <202110210848.35971643C6@keescook>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021134530.206216-5-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 09:45:30PM +0800, Leo Yan wrote:
> Now Arm64 provides API for enabling and disable PID tracing, Arm SPE
> driver invokes these functions to dynamically enable it during
> profiling when the program runs in root PID name space, and disable PID
> tracing when the perf event is stopped.
> 
> Device drivers should not depend on CONFIG_PID_IN_CONTEXTIDR for PID
> tracing, so this patch uses the consistent condition for setting bit
> EL1_CX for PMSCR.

My own preference here would be to not bother with the new
enable/disable helpers, but just open code it right here. (Save a patch
and is the only user.) But I defer to the taste of arm64 maintainers. :)

-Kees

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/perf/arm_spe_pmu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index d44bcc29d99c..935343cdcb39 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -23,6 +23,7 @@
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> +#include <linux/mmu_context.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> @@ -272,7 +273,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>  	if (!attr->exclude_kernel)
>  		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
>  
> -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
> +	if (perfmon_capable() && (task_active_pid_ns(current) == &init_pid_ns))
>  		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
>  
>  	return reg;
> @@ -731,6 +732,13 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
>  	if (hwc->state)
>  		return;
>  
> +	/*
> +	 * Enable tracing PID to contextidr if profiling program runs in
> +	 * root PID namespace.
> +	 */
> +	if (perfmon_capable() && (task_active_pid_ns(current) == &init_pid_ns))
> +		contextidr_enable();
> +
>  	reg = arm_spe_event_to_pmsfcr(event);
>  	write_sysreg_s(reg, SYS_PMSFCR_EL1);
>  
> @@ -792,6 +800,9 @@ static void arm_spe_pmu_stop(struct perf_event *event, int flags)
>  	}
>  
>  	hwc->state |= PERF_HES_STOPPED;
> +
> +	if (perfmon_capable() && (task_active_pid_ns(current) == &init_pid_ns))
> +		contextidr_disable();
>  }
>  
>  static int arm_spe_pmu_add(struct perf_event *event, int flags)
> -- 
> 2.25.1
> 

-- 
Kees Cook

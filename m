Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC4A400955
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 04:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350746AbhIDCcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 22:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbhIDCcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 22:32:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC799C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 19:31:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c17so860612pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 19:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OyXn9whqgoBPI+82Ub9Acbq8v9c7Sx+Dk/WDUp7VoDs=;
        b=fA+bgyEZn/RACKE+b07YTN+d0MxIb0VABaY4rEP/etKiVJ9ivQMNdMr47CifJ+6xt3
         UIJKC2UuSffSt5SKsR6LAMZQ8Pw6UE0IFxrY/r2MIjSLPe3KhExABb3yHtYwUqDCQ0N0
         o+2mMZRwLUKdEmRe9DIcDBPzs6hpzlzuG/4X1gxzrbeoyJS7xz/gU6Cl9+1Erd5yaFrZ
         sXl9q5Thz88a2+3Q3vmB3P2ebk0qArtzOhWASx0rdWhsHS17OwkcmgKqqRF+UCLGVs5m
         Epf3Hylx/lE3Qe9yk6UOEOIRoOJE0EoGHIsZpjH7PB4cJU5BLWDdc+um4y/b0wrDQJQF
         fTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OyXn9whqgoBPI+82Ub9Acbq8v9c7Sx+Dk/WDUp7VoDs=;
        b=iExxufKIVhPJtyE0C/uX28EY0hUP4/wu4RJfsqsRlGZkWmbWnUi1bIYQzv0rX8uxFK
         phRHSclK9Y1Y5nmwTVWFzf8x1ELDFbpyHmHrfE2CZVKrj45SvpTZQJQjzlxo64YjYL/i
         XG74lMfZD+5JYMzy1lei0ohXewuvUH663QFXlcMpxafzoYnr5cV70oGK0jaPp0a+kjuc
         uEqHdCdgaVGcCU+vJ65p5a8pgSCQWFRx9Weo8ZDeiyGpOp9fHKMCk+s/cNFoSLiYvVvD
         0/zXUfw7ncOARWwOzZarAcFmfDNoFC8cGkvrSkYPodWFEPf0NZBAMIcZ6EkedKbd9Zvo
         eY8Q==
X-Gm-Message-State: AOAM530pN2932uloUCrbqSahPVDcUNbf8aulcqH/+523uz3OGg+C8EEA
        edy/W4zF3wynUrnnPvBBornLhiYoypSV6QAwp6g=
X-Google-Smtp-Source: ABdhPJz+YZM973P2EOVFVwPN03rsfV4bZgWNFBlEKnp5ptr8wgE76WeECaEKGKnrqEyblMHcUvPMpg==
X-Received: by 2002:a05:6a00:244f:b0:404:fa55:c1a with SMTP id d15-20020a056a00244f00b00404fa550c1amr6022233pfj.42.1630722681294;
        Fri, 03 Sep 2021 19:31:21 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id z24sm582561pfj.88.2021.09.03.19.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 19:31:20 -0700 (PDT)
Date:   Sat, 4 Sep 2021 10:31:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: cpu-debug: control default behavior via
 Kconfig
Message-ID: <20210904023116.GK303522@leoy-ThinkPad-X240s>
References: <20210903182839.1.I20856983f2841b78936134dcf9cdf6ecafe632b9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903182839.1.I20856983f2841b78936134dcf9cdf6ecafe632b9@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 06:28:54PM -0700, Brian Norris wrote:
> Debugfs is nice and so are module parameters, but
>  * debugfs doesn't take effect early (e.g., if drivers are locking up
>    before user space gets anywhere)
>  * module parameters either add a lot to the kernel command line, or
>    else take effect late as well (if you build =m and configure in
>    /etc/modprobe.d/)
> 
> So in the same spirit as these
>   CONFIG_PANIC_ON_OOPS (also available via cmdline or modparam)
>   CONFIG_INTEL_IOMMU_DEFAULT_ON (also available via cmdline)
> add a new Kconfig option.
> 
> Module parameters and debugfs can still override.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Thanks for the patch, looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
> 
>  drivers/hwtracing/coresight/Kconfig               | 13 +++++++++++++
>  drivers/hwtracing/coresight/coresight-cpu-debug.c |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index f026e5c0e777..8b638eb3cb7d 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -150,6 +150,19 @@ config CORESIGHT_CPU_DEBUG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called coresight-cpu-debug.
>  
> +config CORESIGHT_CPU_DEBUG_DEFAULT_ON
> +	bool "Enable CoreSight CPU Debug by default
> +	depends on CORESIGHT_CPU_DEBUG
> +	help
> +	  Say Y here to enable the CoreSight Debug panic-debug by default. This
> +	  can also be enabled via debugfs, but this ensures the debug feature
> +	  is enabled as early as possible.
> +
> +	  Has the same effect as setting coresight_cpu_debug.enable=1 on the
> +	  kernel command line.
> +
> +	  Say N if unsure.
> +
>  config CORESIGHT_CTI
>  	tristate "CoreSight Cross Trigger Interface (CTI) driver"
>  	depends on ARM || ARM64
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 00de46565bc4..8845ec4b4402 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -105,7 +105,7 @@ static DEFINE_PER_CPU(struct debug_drvdata *, debug_drvdata);
>  static int debug_count;
>  static struct dentry *debug_debugfs_dir;
>  
> -static bool debug_enable;
> +static bool debug_enable = IS_ENABLED(CONFIG_CORESIGHT_CPU_DEBUG_DEFAULT_ON);
>  module_param_named(enable, debug_enable, bool, 0600);
>  MODULE_PARM_DESC(enable, "Control to enable coresight CPU debug functionality");
>  
> -- 
> 2.33.0.153.gba50c8fa24-goog
> 

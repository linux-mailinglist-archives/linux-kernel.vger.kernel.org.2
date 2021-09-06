Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D90401DB0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbhIFPik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 11:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhIFPii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 11:38:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03983C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 08:37:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fs6so4512508pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EgjZqYtbAjQybf0FiR3jfzwWnoQOjy/QCj2+jtWcOhQ=;
        b=fW/yrbJWXEF8BNtyC21n5Xx55xzQ/RBdn/T08eWb38C90PPnjTx95H9rj0kMBu5mus
         XRbeYBnolP0To/STHqnTjN/Ihubr/5m5XQu+VxgBP/9EsDq1zFQKacrKhDOMrY+rd2nY
         osD0OSqsNBAzk1QlK+/ILFyj0doLjDCgSdA+7ntp9Hh767rqQ5gJZ6EJHJyOA7c/eoZo
         RHWQSPSF1OPSVckzhjtXEEB3nfYnKxivAXfew1cxyPAhhB/z0gT7NOAxYD4pQAk4OIT/
         n9EgkqE7AWPQBSZXjQ4giY2be1DmyCgDICV9n05csVd8wn89byLSSNUHNuDTERu2XRPt
         BavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EgjZqYtbAjQybf0FiR3jfzwWnoQOjy/QCj2+jtWcOhQ=;
        b=Bm4vHL06Wy/IMUGvUHaNfVBL1xAfJ2LWD/2AiDqpH8qFK/ADdkJU1wLRu+sknAwM2y
         LarolTYTeDYXC+JWOSV1PBqX1H60kqi7MdQJZzEtGfkmM6nKbtlN9uv0QwJORMM2ven3
         tY8UGCNX/k7nb5wlEsllnAd6vphZMKxc1os62Dbi8c/GF1DkkL293ojTPAmKpMgxJ67g
         odpvTGwQbvKfnKcspjyGrQ7cuPPj7MdL/D2QJxoxoVW2Xf1GlYXbYozAzki2H81fCItD
         c2EgvJx6nP1pTR87tdZjRu6g0bssil2sE7oAp2AiEiRIab6LsRpXFYEF6v6VKziztPS4
         7+CQ==
X-Gm-Message-State: AOAM531A68WcNakOqNZPz/6Fn76/umW3uzObquli6VXaNylfr/Sjhiip
        0QWY9aPdWTv6B1+AxNvOlCYvHw==
X-Google-Smtp-Source: ABdhPJzzPqszgGttLXpvxN/HeZUksi77ohZQH4hWeR9s38MZ+z/8kKRQErgVfOv6IUYbWEpWcelnsA==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr14800601pjb.80.1630942653471;
        Mon, 06 Sep 2021 08:37:33 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z65sm8214649pjj.43.2021.09.06.08.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 08:37:32 -0700 (PDT)
Date:   Mon, 6 Sep 2021 09:37:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: cpu-debug: control default behavior via
 Kconfig
Message-ID: <20210906153730.GB1228692@p14s>
References: <20210903182839.1.I20856983f2841b78936134dcf9cdf6ecafe632b9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903182839.1.I20856983f2841b78936134dcf9cdf6ecafe632b9@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

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
> ---
> 
>  drivers/hwtracing/coresight/Kconfig               | 13 +++++++++++++
>  drivers/hwtracing/coresight/coresight-cpu-debug.c |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 

I have applied this patch to my local tree.  I will make that tree public when
next week when 5.15-rc1 has been released.

Thanks,
Mathieu

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED31E382322
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 05:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhEQDjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 23:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhEQDjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 23:39:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F63C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 20:37:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v13so2356958ple.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 20:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FupRu5AWsQmUVuPcIMHgm5t/uONoJQKuf4lHF2i1dfg=;
        b=sZ7gwxQYvqXct3NL0XHX4MxoWKUYdCXlROQ+V+GP9zNlI6/dt1hghUYPoR/ZnvCMCi
         u0itUocMlFKtxTTV1p/7leZYK6oGzH5Lxqa6cPwpo7iTWX1QgAwZyaO3oqiHDkddnjOa
         fm+LZgeofa5zB4TFZhgJvDAgwCTzehKE1mtZoU5JcN8s3YXRe4F/UFYgkW4yjpbz6Ter
         L0xnf6eDhbHRmW9HniBoVxX+WoLMbysTwLJpsD/ZsBrsQaI3UOdO8KIGWLFQVRc5I3hW
         6ySlg5TrHss5iczwPUpi7viheEIqiAzIULbP7Kh7fkxnyrWA9b1NIqjXuAhd26KQwbXv
         q89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FupRu5AWsQmUVuPcIMHgm5t/uONoJQKuf4lHF2i1dfg=;
        b=EUcRUs5oZnZWCnm96WSc+iGYL1lTS6ivFfv/vZwvIOSR/zVUeDGv+MrSEGiivnpqNK
         1/EKhpF3NFafB8m7okrb50vhAEJEIAoMdk64fkv9KR99RAOHw4bF0UREPHEOnM3mYCt4
         r9irNrVOFcF9MV8hyp77RMmbopLEm0yrIPN+ygmfFGH4OzCxEtOVMm0dInNW5GaEo+Od
         IXXF2FHRYdzT9vgI3BVzqEa5Oo7f8pk6e7E1pR1O3dgoBZvGY3pDV8AjAueZBMYSOTNb
         He/PwE1IoZK3GHEKjifASRnRz8JjlUwsgz6/WiEhLE/cbwIE6EX77q8ZiZvVTa03qyNL
         AgKg==
X-Gm-Message-State: AOAM533YvmiNWE/lrixakcBOt6He3Cs1CA43mxfGrfeuwC4Ha+l8FpMU
        RpYtvsSRkgTtSZ2EFZGzlom9gA==
X-Google-Smtp-Source: ABdhPJwBKZAN9+V8RQD8WSRatUfykX2vTpM6twfmAP+4PNB0qpJMddOTRGdlcAzLCzOulelfWfOE5w==
X-Received: by 2002:a17:90a:94c5:: with SMTP id j5mr15134241pjw.121.1621222638577;
        Sun, 16 May 2021 20:37:18 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id b6sm9116439pfb.27.2021.05.16.20.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 20:37:17 -0700 (PDT)
Date:   Mon, 17 May 2021 09:07:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] soc/tegra: Add
 devm_tegra_core_dev_init_opp_table()
Message-ID: <20210517033705.uw5kfj46k6w6ptcl@vireshk-i7>
References: <20210516205138.22501-1-digetx@gmail.com>
 <20210516205138.22501-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516205138.22501-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure why you divided this into three different patchsets,
while it should really have been one. Like this one just adds the API
but doesn't use it.

On 16-05-21, 23:51, Dmitry Osipenko wrote:
> Add common helper which initializes OPP table for Tegra SoC core devices.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/common.c | 112 +++++++++++++++++++++++++++++++++++++
>  include/soc/tegra/common.h |  30 ++++++++++
>  2 files changed, 142 insertions(+)
> 
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index 3dc54f59cafe..c3fd2facfc2d 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -3,9 +3,16 @@
>   * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
>   */
>  
> +#define dev_fmt(fmt)	"tegra-soc: " fmt
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
>  #include <linux/of.h>
> +#include <linux/pm_opp.h>
>  
>  #include <soc/tegra/common.h>
> +#include <soc/tegra/fuse.h>
>  
>  static const struct of_device_id tegra_machine_match[] = {
>  	{ .compatible = "nvidia,tegra20", },
> @@ -31,3 +38,108 @@ bool soc_is_tegra(void)
>  
>  	return match != NULL;
>  }
> +
> +static int tegra_core_dev_init_opp_state(struct device *dev)
> +{
> +	struct dev_pm_opp *opp;
> +	unsigned long rate;
> +	struct clk *clk;
> +	int err;
> +
> +	clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "failed to get clk: %pe\n", clk);
> +		return PTR_ERR(clk);
> +	}
> +
> +	rate = clk_get_rate(clk);
> +	if (!rate) {
> +		dev_err(dev, "failed to get clk rate\n");
> +		return -EINVAL;
> +	}
> +
> +	opp = dev_pm_opp_find_freq_ceil(dev, &rate);
> +
> +	if (opp == ERR_PTR(-ERANGE))
> +		opp = dev_pm_opp_find_freq_floor(dev, &rate);
> +
> +	err = PTR_ERR_OR_ZERO(opp);
> +	if (err) {
> +		dev_err(dev, "failed to get OPP for %ld Hz: %d\n",
> +			rate, err);
> +		return err;
> +	}

Why do you need to do this floor/ceil thing? Why can't you simply do
set-rate ? 

> +
> +	dev_pm_opp_put(opp);
> +
> +	/* first dummy rate-setting initializes voltage vote */
> +	err = dev_pm_opp_set_rate(dev, rate);
> +	if (err) {
> +		dev_err(dev, "failed to initialize OPP clock: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}

-- 
viresh

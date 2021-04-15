Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2957035FEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 02:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhDOAn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 20:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhDOAnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 20:43:52 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD52C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 17:43:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a85so14452392pfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 17:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o82cjsB4Oezjpc667ree6NM4Xqp3Q8SKOL/PsOCDhUA=;
        b=jgbkHiHyumnqSHbVGeaAiPW2aAqqUhLIjDhUsMk2AZKzTrw3iYmoSfBYWHKz0+CB8c
         tMnoFRr+bSPYlz9VUcCSWwHTnYDhgrFUu0xMCNyeNBeKFqZo7PPTxdDaWGaoZmqRs3xY
         omnQdi3GrVpn82gd3iMpw4Dn9VDax5/J9tv+bL51h4Yx6SRNcLGz+lpC3hO19uC0JyoE
         49sNAq2jkiACoFmYnWuMywv2X+WIuRYk6qGKQNju8bCfysZ/logcjLN3Dbv1hnTWItvE
         bJnhHzUqByz/21N2f6PkIDPD4BELBBjOkDvg2DfVZVHbASVX59rWPQZ5dFYDNB8UDbDq
         HYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o82cjsB4Oezjpc667ree6NM4Xqp3Q8SKOL/PsOCDhUA=;
        b=ogVg2FrtWPeSg6X/ORMXQSwxQ963uoTYcjPGgGQTin8yxE68FLlEmbwQlZPXwIS/OX
         4AqpQGsEyIRu/lclmpTVXxABiUvmuIBaOAbxXlTtktkgICwMA9yT/6N1qhkqEFh9Doug
         D4mjoDZQ+GOBo6a3CrRyIqIhLHWh3wJNEGWGdNbm6czRl4xatMLrl6X8JWLlHW7mm6X1
         YCz/b8r0xa6X/VguZaHLZkLceY+wHbbr06bI8l6JfNUwyZLIW6bYg/lVwlIh4dGYWVE0
         OzLjlWv5AyzH4zNs+zHvy7t/TARugLMh5g+y9g3bU7xiLnKHI8W4RPu9n9IXJ6QxKrFb
         DiXg==
X-Gm-Message-State: AOAM533RukZdNAHXqU6I9SL3a9G04J5AQtq6niG8wV4Ak6k7phC5e+Th
        tex2jVSA1IhRYo1dBEYs5ubpHQ==
X-Google-Smtp-Source: ABdhPJxMHzCPjTk8E1GtbkrlGfGw+VZByHSVaTXN2ly/n3yiuXW7XF8EsecnnjLePdgRJN5q3V43PA==
X-Received: by 2002:a63:1347:: with SMTP id 7mr949163pgt.112.1618447409461;
        Wed, 14 Apr 2021 17:43:29 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id i9sm453556pji.41.2021.04.14.17.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 17:43:29 -0700 (PDT)
Date:   Thu, 15 Apr 2021 08:43:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: etm-perf: Fix define build issue when built
 as module
Message-ID: <20210415004325.GA955389@leoy-ThinkPad-X240s>
References: <20210414194808.22872-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414194808.22872-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:48:08PM +0100, Mike Leach wrote:
> CONFIG_CORESIGHT_SOURCE_ETM4X is undefined when built as module,
> CONFIG_CORESIGHT_SOURCE_ETM4X_MODULE is defined instead.
> 
> Therefore code in format_attr_contextid_show() not correctly complied
> when coresight built as module.
> 
> Use IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) to correct this.
> 
> Fixes: 88f11864cf1d ("coresight: etm-perf: Support PID tracing for kernel at EL2")
> Signed-off-by: Mike Leach <mike.leach@linaro.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

And sorry for introducing mistakes when sending the patches.

> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 560baefdfed8..b2d6db78a025 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -78,7 +78,7 @@ static ssize_t format_attr_contextid_show(struct device *dev,
>  {
>  	int pid_fmt = ETM_OPT_CTXTID;
>  
> -#if defined(CONFIG_CORESIGHT_SOURCE_ETM4X)
> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>  	pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID2 : ETM_OPT_CTXTID;
>  #endif
>  	return sprintf(page, "config:%d\n", pid_fmt);
> -- 
> 2.17.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062AE3932E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhE0PxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhE0PxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:53:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:51:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a7so185865plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P8n+j10CtxBhN58oDikgqY5q7G+Pum8G2KPAGFOMoQM=;
        b=jPc88E/Li2I3/MCp6PbTsfXs8TtZnXLmb8LdXdkTQ5vTSK/O4NfrBhYAFsH6149K2C
         8Dzg7ZUxwJefPaH+g3ruPpkiFLF7d3xvk3kSUjBx4L00M574OXpCIFIg9slizleb/XLf
         9Nu2PDmHJhXalDOOitKfMg4eR3sUk6Ao4FitbV3Nu+AQ6iEIkmtx2NhuQtH2osPxT+DY
         qtWbLsybPkM6QNJoU4rd+zYP9JwSBdUkB3omFDtvv/EDYlqjpsX0pHzOmWz4AiV6Honq
         L+HNC5YcOh5ieRsQ1ORuethWH/0SYGZHCCfEYziFX+45jC9ER0tmQBqm4qaC2LuLH683
         Erxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P8n+j10CtxBhN58oDikgqY5q7G+Pum8G2KPAGFOMoQM=;
        b=OMRlgMzCPngndqld5xZdvEjDJfysBAtEwNv+i78Df+Q6GAxOlVzXZq94BaO4sD0YsW
         51iEVi1av4/Qy3hfW2xn7Ie4fHNLNxGlWJedXhy3FaOm1Yf/2vNBv2Y4Mhk/jFxzIBF1
         M25t0i76Ot20dnatkPZWZbfSbhqY000U6lK7zm4OjQOYzFqPW1uIGjwKE8kOR1yfCoL2
         OBtPXP7piT+tv3M30NWqinrNxhTrTQpKHSlbshX+d8gl/P/LglzwLEprZ6lscOnOEleM
         LVKNosC6uHwD3FtwdEbElSqYjdz/63s6P+jIsLtF4SYVMAcmXos0B3FHV5qiBOxqFk/p
         O6Ew==
X-Gm-Message-State: AOAM533cA//ImlwOTkH88F4PcEvYAgSDT9JQB2feCiYc4RVp7ZPneCe+
        R0UfDiarBy2UTVoE41HiBFpqHA==
X-Google-Smtp-Source: ABdhPJwoNPGZY0cleeBw9UHOnt01xQnmJp/s6zYtjQoV9W6cTuQL+NMaDUZgw+qbaQLY1O6LN3+TMw==
X-Received: by 2002:a17:902:7c0b:b029:ff:5396:2edd with SMTP id x11-20020a1709027c0bb02900ff53962eddmr1462767pll.79.1622130698590;
        Thu, 27 May 2021 08:51:38 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id gt23sm2306226pjb.13.2021.05.27.08.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:51:37 -0700 (PDT)
Date:   Thu, 27 May 2021 09:51:35 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: Propagate symlink failure
Message-ID: <20210527155135.GA1297106@xps15>
References: <20210526204042.2681700-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526204042.2681700-1-jeremy.linton@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 03:40:42PM -0500, Jeremy Linton wrote:
> If the symlink is unable to be created, the driver goes
> ahead and continues device creation. Instead lets propagate
> the failure, and fail the probe.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 6c68d34d956e..2dc4b0110442 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1392,7 +1392,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
>  		}
>  	}
>  
> -	return 0;
> +	return ret;

I have applied your patch.

Thanks,
Mathieu

>  }
>  
>  static int coresight_remove_match(struct device *dev, void *data)
> -- 
> 2.31.1
> 

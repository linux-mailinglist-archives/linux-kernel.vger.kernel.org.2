Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EEB3B5CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhF1K4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhF1K4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:56:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:53:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso10886670wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xc68q9zHNgXF0iXAvRkF8n1MUjQAPNEkMyYgezEahGo=;
        b=ViBkHwv4QhQQ1coOQ7GI8Yo/9RSI7iCkoJDsmnR1d1l2CLLXkal8R3lMG9FU1BUnkm
         VihZVopq0LzhwLrYrH44EhwDfZsV7wGwHKLYlPDAW3DGoixm3JiqS0Fm0MPjhrmLajjn
         ds6TBOIQE35OC+sjzK/sHOVj+Jj/kSai8nl7hAAP8zCy+PuhMnT1FmXkVozcplhRRXio
         7ZLbq1CkrETXoDEWhzvCZvp7Bx87jQzsCIkDgL1Ntplk2DLyUOFfXsBJ8z+Rr2+2bYbk
         PwdaIY3rcnOjHkwBF5TY1Xd0V6J2DEXrrvvc3SuYIk21tZ1YIaQv2mb4j2Xt7FBacs34
         aQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xc68q9zHNgXF0iXAvRkF8n1MUjQAPNEkMyYgezEahGo=;
        b=GuntCDgsiixZiDaSa4oJP19lDRN4Y1eebYTk3WHdsXb5A+aPYhmsoiFPfmAWjAA+/b
         mJB35DCFInkdTZoSVxCEDcHdHSU6BBKvAq8Mq1L+vOjSX0KIgzLplPU2L/sFe0hQJnxq
         ZVCHMt98OUiXzfmVQoM6DR0v4BeDg/PZifPE19HxVDdUJTTqbAbCy749adCWAhMY5Jmv
         H9WbW7xvgUqQEmYKUHfAS+mBe1wIUSiHoT2OJWSMS1+3ofsIa0F8+bO42hu7qX7z7Oyd
         EQ/ziNzPCkuYA6/m/jlmCzHSiakeC5LB58TbwwzF8EUpBXrCS1ZcKZKN2299fXaI6Xgg
         wzFg==
X-Gm-Message-State: AOAM5301/qAfn0V0S96xCUn7xBhaTG30TxE7ek888NGfcAzU1K9jgrhh
        ddF9vQTF9QTnoxKsq9NilnGB5w==
X-Google-Smtp-Source: ABdhPJzNVGNBMxlTr80JFZl3Osu1wPhPDYGm6pVNyBZmdQQL/AnAoXe6WNGtZ55fouY7z1aJM5FVfg==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr1962050wmg.117.1624877621551;
        Mon, 28 Jun 2021 03:53:41 -0700 (PDT)
Received: from dell ([95.144.13.187])
        by smtp.gmail.com with ESMTPSA id o26sm12921396wmr.29.2021.06.28.03.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:53:41 -0700 (PDT)
Date:   Mon, 28 Jun 2021 11:53:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com
Subject: Re: [PATCH] SUNIX SDC PCIe multi-function card support
Message-ID: <YNmqM/5w4folmOzs@dell>
References: <20210625090555.11349-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625090555.11349-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021, Moriis Ku wrote:

> From: Morris Ku <saumah@gmail.com>
> 
> Add support for SUNIX SDC PCIe multi-function card

All of these patches should be merged into a single patch.

Please re-submit before a conduct a full review.

> Cc: Jason Lee <jason_lee@sunix.com>
> Cc: Taian Chen <taian.chen@sunix.com>
> Cc: Morris Ku <morris_ku@sunix.com>
> Cc: Edward Lee <Edward.lee@sunix.com>

Cc: Should not be used to mail internal personalities who are not
authors, maintainers or reviewers (listed in MAINTAINERS).

> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  Kconfig | 14 ++++++++++++++

Diffs should be taken from the top directory:

  drivers/mfd/Kconfig

>  1 file changed, 14 insertions(+)
> diff --git a/Kconfig b/Kconfig
> index b74efa4..0bab573 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -2156,5 +2156,19 @@ config MFD_INTEL_M10_BMC
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_SUNIX_SDC
> +	tristate
> +	select MFD_CORE
> +	select SERIAL_8250_SDC
> +	select CAN_SX2010
> +
> +config MFD_SUNIX_SDC_PCI
> +	tristate "SUNIX SDC PCIe multi-function card support"
> +	select MFD_SUNIX_SDC
> +	depends on X86 && PCI
> +	help
> +	  Selecting this option will add support for SUNIX SDC PCIe
> +	  multi-function card.
> +
>  endmenu
>  endif

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

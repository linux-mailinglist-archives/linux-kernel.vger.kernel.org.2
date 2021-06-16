Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B463A957B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhFPJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhFPJF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:05:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F502C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:03:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z8so1740184wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R5IwZ5T10RFAZOqt5qcuDzQhKca6nmgiqgnrBFf4d0s=;
        b=XI4/RArI04XyRGOyO6qnd8JSW5hLOLesz9Q3yWt5JyjxgJGy0qmfYMd5UEdopSIn4d
         ZEoHiANcieeu3zTtC+tcHAAtDdxSpQB6cEhoXKthR3GsLa6QEGgaAgl4z7MI+svYjUaY
         gm7Tb8bML+EKtre/PcTndDIsXpNjortodY3HnVDxIBAKL3w6dS1Ki5prQzZ7+3OL8FBs
         bL7zHMyiHhoIMtfK/00jq3sEpf1oRP0A6wPdcBKedgrEM/3nxgIClrFfbfnFygocTAJN
         4MrgyjFK4GyNwPIczDGTVuFBb3TtE1pm702aarKQZAg8oCb2AWl9abk5CgvGO2wH0v0z
         qhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R5IwZ5T10RFAZOqt5qcuDzQhKca6nmgiqgnrBFf4d0s=;
        b=gNV36PEJv1cPpfL5kdx/qibu2Hr8TjH83g6Q4Cr7iH+4/tI7wS9j5945/h4g/V+KrB
         rEmCTc+cayAUyVbeOjfnBfcX/z4PjtjCkUKW6gXzGlCYEkub3Y2c48+9iTiBGkKg9943
         7j+uIWBQj6t6Z2nvXmBWkruXVfPvC5Th1LPZLwjro8PbS9zwYRJXaHU6QrWTWN9MrwnP
         Nunxhv9ut597IDeB2ujJwyvHUCaSMVAWAxjM3GmbvQEPO9a83/BZqfMNzefrmL4VJnRY
         Eucpnp0o+f2m9AXpQ6O1rkxr71TJKlg2C4PYEn5iQcwx8T/6vXnqchrwIR4CLe2N6HlP
         xYww==
X-Gm-Message-State: AOAM532pNOIsxFfp3cYg3EyXaFDLnEgLCPC3KLSOtxKowqZWQodtc0zI
        wuRct3xWMOu+z0J27qrSTgkmvbeoTV/qgQ==
X-Google-Smtp-Source: ABdhPJxOz1OWe9kuSrTnigTxWFPqfVk5W6nKvaKAcwO6qLkegofStZEAvSgjvWvYmo20BydttymtYw==
X-Received: by 2002:adf:a193:: with SMTP id u19mr4117281wru.9.1623834199539;
        Wed, 16 Jun 2021 02:03:19 -0700 (PDT)
Received: from dell (94-30-15-53.xdsl.murphx.net. [94.30.15.53])
        by smtp.gmail.com with ESMTPSA id e17sm1545929wre.79.2021.06.16.02.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 02:03:19 -0700 (PDT)
Date:   Wed, 16 Jun 2021 10:03:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yunus Bas <y.bas@phytec.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <YMm+VXRrRKIHGgmr@dell>
References: <20210616081949.26618-1-y.bas@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210616081949.26618-1-y.bas@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021, Yunus Bas wrote:

> The MFD-core iterates through all subdevices of the corresponding
> MFD-device and checks, if the devicetree subnode has a fitting compatible.
> When nothing is found, a warning is thrown. This can be the case, when it
> is the intention to not use the MFD-device to it's full content.
> Therefore, change the warning to a debug print instead, to also avoid
> irritations.
> 
> Signed-off-by: Yunus Bas <y.bas@phytec.de>
> ---
>  drivers/mfd/mfd-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 6f02b8022c6d..e34c97088943 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -213,7 +213,7 @@ static int mfd_add_device(struct device *parent, int id,
>  		}
>  
>  		if (!pdev->dev.of_node)
> -			pr_warn("%s: Failed to locate of_node [id: %d]\n",
> +			pr_debug("%s: Failed to locate of_node [id: %d]\n",
>  				cell->name, platform_id);
>  	}

Can you provide an example of a device tree where this is a problem?

Probably worth popping that in the commit message too.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

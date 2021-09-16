Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E01140E6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352252AbhIPRXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:23:50 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53716
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344122AbhIPQ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:57:29 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AC6454025A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811367;
        bh=NNyXWH0zPnl4XkyqEuGhQGilxobO7/w8aKocS2q24WY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=SnvXHv3lt3hFaXEv067f+sIAQzmrNDEu8/9goU3pYVPcXovtYxEJxtzR9D1SiefJy
         YcbjWT47ZXbtJXzqL9ZGqojwgwqF1TlTSO1+wd7+bBZ65O2zTjFXEVbqP3cZvOBCfh
         Mm0l2yx4hKsAv2d67Ht+ScGmgPJq9ZX58ATIiW+bfFEMfEEWoV4FJYsDPtTGbyl/xI
         fM/km2Rs/u4iqvLQIHIIo9hymJhQS6av25e/dzOwPPLsrb/eZEmdp4jDUYhn3LSXGH
         f0uQCb+N7O9tbqiPg7Nnov8ViFaUJtRDw7sS9dfenohlFwYZo6gNlpOJyDJXHrgEaD
         gl3a2QQe2tVAQ==
Received: by mail-wm1-f70.google.com with SMTP id j21-20020a05600c1c1500b00300f1679e4dso2798933wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NNyXWH0zPnl4XkyqEuGhQGilxobO7/w8aKocS2q24WY=;
        b=FNNdW912emXt1zGDJfRhmw2Lush9xuHaSiYeKqT4l5Ogak98IVO5q9SrUF7s6unR+Q
         2z0XJ81PHrODuiFt8ODe4RM0e4xhj0weYm62bVRxxa9Z9eFjEj0bjM786X3Zhw0DRhSX
         dBGugGitBd4wxppDieVv2DVjFEuMsgdEB43exp0WFH5s3g2JqOT5DHMXmqy8WbJXttpi
         +R++FzQQTkjbYWZEmZj47q1GN3EYzS7aqG1aahHkzTAjrR9ls2z1h7qiUp8bsLw2401s
         iucwkQkKP4kHg/GkIO36q7Q2ECXY6GDM/VQym2dIXh/PXbHDAD8mvhjXbpDO3dbi0rPj
         2MjA==
X-Gm-Message-State: AOAM530UKD9RXf70h7sOtrIPuLwTtr72ZgzOtyO9CmHa7IdD968ExRgx
        oB0akyNigH9onsRbuIAhx52+gqOT2GBl1FPqHoNJSerGAjaw+4Wy6c/mn5XA5bNEqM4YO9g9X4H
        ZCGpJG5C7F3hZ5dsALKhAC5w6gEPb0Xkn2JNDnGJ2tQ==
X-Received: by 2002:a05:600c:354a:: with SMTP id i10mr10505321wmq.77.1631811367002;
        Thu, 16 Sep 2021 09:56:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYvG+0AGIvigBn/pTCgBLDueNOPjU3WvM2vjEkvSVSlmAouj2a9ZpRgMta37+FkXPUz2kuYw==
X-Received: by 2002:a05:600c:354a:: with SMTP id i10mr10505309wmq.77.1631811366847;
        Thu, 16 Sep 2021 09:56:06 -0700 (PDT)
Received: from [192.168.2.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id j4sm4068291wrt.67.2021.09.16.09.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 09:56:06 -0700 (PDT)
Subject: Re: [PATCH] nfc: st95hf: Make use of the helper function
 dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210916153614.16523-1-caihuoqing@baidu.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8ded55ac-1f0a-764b-6b11-9323742aec9c@canonical.com>
Date:   Thu, 16 Sep 2021 18:56:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916153614.16523-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2021 17:36, Cai Huoqing wrote:
> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/nfc/st95hf/core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
> index d16cf3ff644e..8337c0e0c964 100644
> --- a/drivers/nfc/st95hf/core.c
> +++ b/drivers/nfc/st95hf/core.c
> @@ -1087,10 +1087,9 @@ static int st95hf_probe(struct spi_device *nfc_spi_dev)
>  		st95context->st95hf_supply =
>  			devm_regulator_get(&nfc_spi_dev->dev,
>  					   "st95hfvin");
> -		if (IS_ERR(st95context->st95hf_supply)) {
> -			dev_err(&nfc_spi_dev->dev, "failed to acquire regulator\n");
> -			return PTR_ERR(st95context->st95hf_supply);
> -		}
> +		if (IS_ERR(st95context->st95hf_supply))
> +			return dev_err_probe(&nfc_spi_dev->dev, PTR_ERR(st95context->st95hf_supply),
> +					     "failed to acquire regulator\n");

I think the preferred approach was Rob's dev_err removal. See:

https://lore.kernel.org/lkml/20200911152943.GA17780@kozik-lap/
https://lore.kernel.org/lkml/CAL_Jsq+ajm5aiAJfQdS2+2DO1ynBDHWha_7TsA4u-2qwd87y6g@mail.gmail.com/

P.S. You need to Cc all folks and all lists. The cc-list here is too short.

Best regards,
Krzysztof

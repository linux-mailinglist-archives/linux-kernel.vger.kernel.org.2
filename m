Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984883A15CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhFINk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhFINk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:40:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF63C061574;
        Wed,  9 Jun 2021 06:38:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h3so4033882wmq.3;
        Wed, 09 Jun 2021 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2XtC26dDQI+8z2NBND3LcVHi35tPI4TG6eO9es29Zac=;
        b=DzJMNm+3h04RwqPbHWExMNYCF+kaN1b1pLrOfQW7uU+gGHoukXnx3AUoHcpShlEZO0
         G71QT3Yq2vT78oEWlHeQbmVZbe6WM94LtTSdjT/VxIglyPKyK3Q2T/JDNndT0yPXJsLv
         dzSJJGkGwPqQfbRaTULkHwERsRxu0yYuZnTzhu1Xntt4qzZgrVQnNR77xZGHBK9l9stF
         BXbE4iv+o0YLeRS2xXM1E2//e2UMHJyrgFdOtBoiyUlO/bQ62I9kCR/NdZq1THpFdIzK
         9DCO2qzA06o/FOLDmZ7BKKEoefE45EM+fOjGHTirVfQMUhogaiE+NoMOAtVlA0BO8b+B
         FG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2XtC26dDQI+8z2NBND3LcVHi35tPI4TG6eO9es29Zac=;
        b=JqlWxbF557ux6akCF4b6rFlbiCJ2yvCQOGTSDYJo1yF2kB4rli+OZwk68WaJCfGNLG
         3RMbQE5i8QqNDXs830vcqHY2cZMNzHWyNFd5syfhdyWSHo7I95d0jJ6KRMEGcKPueyzB
         Q42EFtEEbH+7xZE7GbbjWjFRWUGauKxwgpbmRxISjtkawNF3ymVXVNtgyjCv2lazwIVB
         FNvnnlL+MruSbAZJKAwAhNVnDaxopxS3eFIW4dyKh2UBb58Ic1Eq9ZI0k+lLlyKNpc0U
         FG3MRBrnQSHkbOEBENJZfPyVKlfkmICXrm1td0J0761h+cTLNkdjjkPeJsSCJIv5VydD
         q0ig==
X-Gm-Message-State: AOAM533aUxhUdz8ZHRKKH3xFXKSiWBoj66cvU5SXt9z9jENwBikkiYuW
        JUNOvXZozF4B5yiTnYSFx+I=
X-Google-Smtp-Source: ABdhPJwRn7xOH9cpkumSJykpQHFyX0W4qhaLI33hiASlySCZeUqCvFm4zsH9ez6+Ei9TmMDVCfoy+Q==
X-Received: by 2002:a05:600c:190f:: with SMTP id j15mr10147185wmq.4.1623245895818;
        Wed, 09 Jun 2021 06:38:15 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id u12sm2793979wrr.40.2021.06.09.06.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:38:15 -0700 (PDT)
Subject: Re: [PATCH v5 05/16] media: mtk-jpeg: Use pm_runtime_resume_and_get
 for PM get_sync
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, eizan@chromium.org, acourbot@chromium.org,
        Xia Jiang <xia.jiang@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-6-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <82aea4aa-0007-369d-9c0d-db0077471b80@gmail.com>
Date:   Wed, 9 Jun 2021 15:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210410091128.31823-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2021 11:11, Yong Wu wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> This patch use pm_runtime_resume_and_get instead of pm_runtime_get
> to keep usage counter balanced.
> 
> CC: Xia Jiang <xia.jiang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> index 88a23bce569d..a89c7b206eef 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -920,7 +920,7 @@ static void mtk_jpeg_enc_device_run(void *priv)
>  	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
>  	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
>  
> -	ret = pm_runtime_get_sync(jpeg->dev);
> +	ret = pm_runtime_resume_and_get(jpeg->dev);
>  	if (ret < 0)
>  		goto enc_end;
>  
> @@ -973,7 +973,7 @@ static void mtk_jpeg_dec_device_run(void *priv)
>  		return;
>  	}
>  
> -	ret = pm_runtime_get_sync(jpeg->dev);
> +	ret = pm_runtime_resume_and_get(jpeg->dev);
>  	if (ret < 0)
>  		goto dec_end;
>  
> 

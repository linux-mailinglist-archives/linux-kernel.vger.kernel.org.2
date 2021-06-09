Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B3B3A162F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhFIN4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:56:06 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34621 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhFIN4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:56:05 -0400
Received: by mail-wr1-f47.google.com with SMTP id q5so25621642wrm.1;
        Wed, 09 Jun 2021 06:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0acANAgz0MlP9hPrB8I/frs/iBRqhU+q6XEBhj3gv8Q=;
        b=Cb4nEUXmhZvh1I1hdtpEsgGzcI8hqQQrc7hh7BmIb/NX9p0nBm+QjwFq9gL6Ze2N9k
         5/kF/QBn0UJ0x7F6q/wS/GIekJmnYYdLBYYwnYGSwRI8T1fFvnS0Vt3wj9kG6zU0uN0H
         ZFPOXyzQVSXJJbyAkKMZ/rIMtRGWVYMRDbH30IuOvtdrAUkcjtlT+BNnp+toj6YK68x+
         SW+2wbaS6w12L2ph1J9OfxsbLKm6oQc0N4ZXjcenr30sAKY3LkKYddG/44vFeDVCwMyZ
         s+hkxsGE2LffD4jYDQDPDULTxBaqYCM1nxoPITOvQOymZOUkwmXNOGqH6G9uQtQPxHqg
         NrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0acANAgz0MlP9hPrB8I/frs/iBRqhU+q6XEBhj3gv8Q=;
        b=jFQyalXWMpS8afIru5kxoBouivTkeJhC5coJ+/43pL2UM0SIxIekf+jkSVWkvAIu4Y
         rxQ1HE7NCb53QNotzBDDcv1ISmOfK8m1PEYwoNKCpRgSDn1BpBPqVRz76jzA4B4uFhfU
         cqD9lh8K6tlL8rJTT42CqK162V1IIsyiNtRj9vp3Mn0qirhSzTNDu2cXOobiQQgIL07l
         AiKUA5FQSfaJxnG9lqD+PLU6ivWSE9rJgp8mDOCN/UgoiPknAvZGBXTB8qhkIRcKrumA
         iyRsKG88/JwCovP2drsGLsZhlm5uQnkUqEtOsQV5fsdWnqns16z9qiJZ+EPnrGcFn2SG
         i8kA==
X-Gm-Message-State: AOAM531wBRVOpUIVgqFLMvN9Jbl+W6RyUP4RYYVINvneDUcGUHrvF6x0
        OCyYFI6wmUsx5lasi0CC4zc=
X-Google-Smtp-Source: ABdhPJwdmtEhrw/I6sV9OLtji5VUn/ZbC7buSNEwtJICXxu0yAJLmTXM7NFYTrhsWxKQQG1r2WrGig==
X-Received: by 2002:adf:9d81:: with SMTP id p1mr27685928wre.287.1623246779787;
        Wed, 09 Jun 2021 06:52:59 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id v16sm10195wrr.6.2021.06.09.06.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:52:59 -0700 (PDT)
Subject: Re: [PATCH v5 09/16] drm/mediatek: Use pm_runtime_resume_and_get for
 PM get_sync
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
        yi.kuo@mediatek.com, eizan@chromium.org, acourbot@chromium.org
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-10-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <299857fd-533d-5e6e-0744-92ee56078638@gmail.com>
Date:   Wed, 9 Jun 2021 15:52:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210410091128.31823-10-yong.wu@mediatek.com>
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
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 8b0de90156c6..69d23ce56d2c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -259,7 +259,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>  		drm_connector_list_iter_end(&conn_iter);
>  	}
>  
> -	ret = pm_runtime_get_sync(crtc->dev->dev);
> +	ret = pm_runtime_resume_and_get(crtc->dev->dev);
>  	if (ret < 0) {
>  		DRM_ERROR("Failed to enable power domain: %d\n", ret);
>  		return ret;
> 

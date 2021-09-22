Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB16414E34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbhIVQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbhIVQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:37:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF98C061574;
        Wed, 22 Sep 2021 09:35:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so8719858wrq.4;
        Wed, 22 Sep 2021 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XdQgCWF+HbG2xPtwVWVByVbos5CxGYFvNsMZE3cxEp8=;
        b=JlrBGgWRjSNrAFP2UtKXrI5eKubObLSYQAXO9P1SFT661XJ0iXdB6D2OSKjk4o2BqK
         YnKVQavDm81Er7abThInPnhii2sd+fKmz4ReYpp+Hq4BZH4YzFsofaoZmd560yhWRsya
         xgZsW3wqrjwQ2iqf8kzkUMloY/u0Qxnm0uAhjE8R6zWizV6nEDAMjVAO078OktsG0X6n
         XSxw/eAZRj09tSUBKtFJHNVHCrjvCA6ooACft9G+tePoP2+1F0sdoN+q4K71GVNgdanc
         stBkDvSOcU8CnUFaPPFP5Cu9B+gCgCfFRlj9zmOsm0kN/j1iA031nRwnjCqIsVbldlKb
         s8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XdQgCWF+HbG2xPtwVWVByVbos5CxGYFvNsMZE3cxEp8=;
        b=DBIBKtKcCAr+BN77RWaWiDzAEcjhHoLHG0AeLvLX2WWCxyxerdH85nurH7JAVLB5MH
         1q/fCJ+LGy/O1qaE6Gfo782OUuwvWCYIvekXvv4HnFUYu7B9ir3SCwMsZKkYJyLTvpRS
         Y1AH4Rl3moA8lJ9zQibQsBdcIbVBVRrVoXJTP1IJrqTT3daBbp1kh/B6Ydg0KlGt+Twg
         FJE3mhgSz6SZP8/4/1k70SwZ3RhzSrblo3Jmeh85fOyCv9WhDqfXdGinpESaRfjHo28D
         ROvYayxny3uybnnHCbqqgynk+7vmg5KZOT0+CnmXAxgLwPjWqv0/zy0tXReGSmsgJb9o
         +Usg==
X-Gm-Message-State: AOAM530lK5RLc+gUvkJPEnYmavv1PTDEcvCl1My/KlWIUBoIgr+SZg//
        Jm967X+UNPgfKDBQRVwbj0rp2jlQXg==
X-Google-Smtp-Source: ABdhPJwVxjQpNqvuAwLwUaVV8QWAF0/MVmZ7ssPoivZ0DMahLg1fiWqMHLnVwcAMUFpfKJhOcE3iYA==
X-Received: by 2002:adf:d084:: with SMTP id y4mr585418wrh.249.1632328544941;
        Wed, 22 Sep 2021 09:35:44 -0700 (PDT)
Received: from ?IPv6:2a02:810b:f40:4200:c404:3070:bbbd:746b? ([2a02:810b:f40:4200:c404:3070:bbbd:746b])
        by smtp.gmail.com with ESMTPSA id y11sm3261447wrg.18.2021.09.22.09.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 09:35:44 -0700 (PDT)
Subject: Re: [PATCH][next] drm/rockchip: Remove redundant assignment of
 pointer connector
To:     Colin King <colin.king@canonical.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210922112416.182134-1-colin.king@canonical.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <27c79f7a-8e4c-fad8-c6cf-a89793f2e3c6@gmail.com>
Date:   Wed, 22 Sep 2021 18:35:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922112416.182134-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,
Am 22.09.21 um 13:24 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer connector is being assigned a value that is never
> read, it is being updated immediately afterwards. The assignment
> is redundant and can be removed.

The pointer to the connector is used in rockchip_rgb_fini for 
drm_connector_cleanup.
It's pretty much the same for the encoder, btw.

Regards,

Alex
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_rgb.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> index 09be9678f2bd..18fb84068a64 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> @@ -150,7 +150,6 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
>   	if (ret)
>   		goto err_free_encoder;
>   
> -	connector = &rgb->connector;
>   	connector = drm_bridge_connector_init(rgb->drm_dev, encoder);
>   	if (IS_ERR(connector)) {
>   		DRM_DEV_ERROR(drm_dev->dev,
> 


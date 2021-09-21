Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911CB413027
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhIUI3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhIUI33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:29:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:28:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w17so28598368wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T0XmoJFziofhO8Y+h0Rn94pKP5fmr2HqBsNSUgjyYvw=;
        b=5yroY8A5VZDD+FHjsZDG2Bp0VN/9NCmZ6ph34jSWwEsJDuCD1esKUGD45vE+WgS4Nx
         nLpmPK+HWxt4q0gKN2U73YMOnjSK+nmWRAOe5rrwvsVTm3YVJfv3Uk7Ft/ySqP8hex+L
         f1zgm40Kj0wD1HVJ/tqQEXWaO2g7jPTnpIsyC00BZBbdt1+5/r0+9IfMD8B0NR2OFV4N
         pz5rhxCmqkUUs9JHgj0UnqMfPvOUro47Byxx/qxy4BLAKotV6L/T/FwekBK8Wdm1LwTf
         IBIWoRX0nibMYi74t7oqbGH47mAj6G8IqCq4nOm+sVQjejoCmL+E3DfESpMyX7jXmi3L
         PQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T0XmoJFziofhO8Y+h0Rn94pKP5fmr2HqBsNSUgjyYvw=;
        b=S1BE5TM8nXx1c2A9h9bOaateojEsk3IEKuhwbHSGze3YJP//SwBgrwJqNDvga+adn3
         2GkEkOU069iwffQreOOnHWCwyE9VzgCawTbGc5VbCQal+CpLahK4fo1YJ7wbQgxpRjZY
         Sbm3b/lHjGurxuJ8fojGZZohO08ydFbIm+kK0RsmqwF8m9EExOUT1I58w/7cNvXoT0HU
         vXIVgNRVXws7CmTu/3z/b2FeNghEduxOLOuWZxwbyigWdy5lgLZx8aIyOPBzaE2U5Zl/
         rlq15T7DSiOdgoX0D6rVp/W0kS1PVAknnIOpHs5wmots12LAoU2put9PY68/wcVYCMuu
         /s1w==
X-Gm-Message-State: AOAM530wwxzL4R8RUQOn/z2w80/Dq9TZpJuITH9gvg9sTHD/smCO5N4K
        uia0BTjFy7+c83bT/6oD1vDHRK0U05v2Ap7E
X-Google-Smtp-Source: ABdhPJzdYtgEvUpitsO9NiVEWZkguYTXll2eKVobKG1pSehamwA8kyXtDfgNoQVbS8fawSppRasMdQ==
X-Received: by 2002:a1c:1b10:: with SMTP id b16mr3190466wmb.194.1632212879919;
        Tue, 21 Sep 2021 01:27:59 -0700 (PDT)
Received: from [192.168.1.10] (i16-les01-ntr-213-44-230-108.sfr.lns.abo.bbox.fr. [213.44.230.108])
        by smtp.gmail.com with ESMTPSA id m4sm22493531wrx.81.2021.09.21.01.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 01:27:59 -0700 (PDT)
Subject: Re: [PATCH] drm: bridge: it66121: Added it66121 chip external screen
 status judgment
To:     Yunlongli <liyunlonga@uniontech.com>, ple@baylibre.com,
        a.hajda@samsung.com, robert.foss@linaro.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210921075401.24926-1-liyunlonga@uniontech.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <13a71cec-06ef-d4d1-948e-c62d4c91d80f@baylibre.com>
Date:   Tue, 21 Sep 2021 10:27:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210921075401.24926-1-liyunlonga@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/09/2021 09:54, Yunlongli wrote:
> In the actual tests,  the IT66121 chip sometimes misjudged whether
> it had an external screen, so, reference the it66121_user_guid.pdf
> about Audio/Video data is stable or not A typical initialization
> of HDMI link should be based on interrupt signal and appropriate
> register probing. Recommended flow is detailed in IT66121
> Programming Guide. Simply put, the microcontroller should monitor
> the HPD status first. Upon valid HPD event, move on to check
> RxSENDetect register to see if the receiver chip is ready for
> further handshaking. When RxSENDetect is asserted, start reading EDID
> data through DDC channels and carry on the rest of the handshaking
> subsequently.If the micro-controller makes no use of the interrupt
> signal as well as the above-mentioned status  registers, the link
> establishment might fail. Please do follow the suggested
> initialization flow recommended in IT66121 Programming Guide.
> So, I add the IT66121_SYS_STATUS_SENDECTECT register status detection.

Ok, the RxSENDetect is the "rx-sense" detection bit as described in the same doc:

Receiver detection circuit reports the presence or absence of an active termination at the TMDS Clock Channel (RxSENDetect)

The usage of the rx-sense signal in hpd_detect() is not clear because this would break detection of "Fake" EDID dongles or idle monitors.

The dw-hdmi handles the rx-sense, but only to power-on/off the HDMI TX, but only returns the HPD status to DRM without the RX SENSE state,
so it only saves power and doesn't change anything on DRM HPD detection.

So not sure if we should merge this as-is.

Neil

> 
> Signed-off-by: Yunlongli <liyunlonga@uniontech.com>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 2f2a09adb4bc..9ed4fa298d11 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -523,7 +523,7 @@ static bool it66121_is_hpd_detect(struct it66121_ctx *ctx)
>  	if (regmap_read(ctx->regmap, IT66121_SYS_STATUS_REG, &val))
>  		return false;
>  
> -	return val & IT66121_SYS_STATUS_HPDETECT;
> +	return ((val & IT66121_SYS_STATUS_HPDETECT) && (val & IT66121_SYS_STATUS_SENDECTECT));
>  }
>  
>  static int it66121_bridge_attach(struct drm_bridge *bridge,
> 


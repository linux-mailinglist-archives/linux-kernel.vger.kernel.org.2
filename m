Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9269838149C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 02:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhEOAfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 20:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbhEOAfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 20:35:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E9DC061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 17:34:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v6so481043ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=of+8ovXa4aMkgT++S+Rbq2lvQyR6d2cuz8n7kSYpUpI=;
        b=Kq0QoHib0LhGTBGOmnLeO2uKT6lhZJ7JE6HW62W0k+OoJ0+syPzju2rPmKwXTUe5be
         07gVHhnxyERfyqW/hmhBLDrtyDW23n37LtpPFZ6hWJgOhufcMpJ6QABQkeiDdIPPRPD0
         SQrsmGds5m0bNY153xxt3Bn7AjlduyNDowXzNRmzZM8Hk1MfRNGm+7C8W3f2jO/qxhrv
         sTBWCVfzvNs+k2Sh2uttE/KM/uhnrnzrhnBX3r555f54Rq5u3KSlMee9GfJQgaXRdoQr
         GmoWBu0TOg/AC8mzIx2ZcaDVaAQLtUnyvO7NeT6zeXM9oqaaIjPC1hdLQaukPg0cK7+U
         cFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=of+8ovXa4aMkgT++S+Rbq2lvQyR6d2cuz8n7kSYpUpI=;
        b=RhoAl16wVQ3fUd6ka3e5VctgASzs8vRuHyZLaFrN543iJNmeekyBuov6FJkmMDbVGh
         3/1lYLqjhfZxDSVmluXn41z8K9cUkxOIAnHKKSfpqV74aDYw8pI+CfYnOkP4HbSS8h5B
         FZkKhNVlYisgQCrW5Z1svA8sf4XeT6KtTHj8mO8NRYR8rovQ3ZzHak1UvSJxEEPL0smW
         SUxwlHwQhjxpq1syR+6sb/KAmVfF0qg+SS5tXY2fTVrNp2jsIKAl/FF4GQ4JfQ4NuAzR
         c7PrcxgYKEzzecjTawLFyy5y06/vll6pxj5IO7zx7PQc/oA+tv4m3rWhxFm4y5TAeFZL
         6ieg==
X-Gm-Message-State: AOAM532NK11S1xtVTzLoWgQ+dz1pokFw1js8/1a49ayECAgc+Pfb/o6H
        a2ZXcm8tDdAv6K5M9atg/Bn7+4ClT8sCJA==
X-Google-Smtp-Source: ABdhPJy1qxqA5sO0wnDdnlQJEd6fDfdb/W8RDe1VFuE+W2M+2se5SRTFDkcx/m4HcH2jMNg2oOHEXw==
X-Received: by 2002:a05:651c:b28:: with SMTP id b40mr24154392ljr.9.1621038839814;
        Fri, 14 May 2021 17:33:59 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e17sm1581436ljp.71.2021.05.14.17.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 17:33:59 -0700 (PDT)
Subject: Re: [PATCH] drm/msm/dsi: save PLL registers across first PHY reset
To:     benl@squareup.com, robdclark@gmail.com, sean@poorly.run
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Harigovindan P <harigovi@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        zhengbin <zhengbin13@huawei.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <010101750064e17e-3db0087e-fc37-494d-aac9-2c2b9b0a7c5b-000000@us-west-2.amazonses.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <c425c92d-3149-592b-f72e-009c972b9b21@linaro.org>
Date:   Sat, 15 May 2021 03:33:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <010101750064e17e-3db0087e-fc37-494d-aac9-2c2b9b0a7c5b-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

On 07/10/2020 03:10, benl-kernelpatches@squareup.com wrote:
> From: Benjamin Li <benl@squareup.com>
> 
> Take advantage of previously-added support for persisting PLL
> registers across DSI PHY disable/enable cycles (see 328e1a6
> 'drm/msm/dsi: Save/Restore PLL status across PHY reset') to
> support persisting across the very first DSI PHY enable at
> boot.
> 
> The bootloader may have left the PLL registers in a non-default
> state. For example, for dsi_pll_28nm.c on 8x16/8x39, the byte
> clock mux's power-on reset configuration is to bypass DIV1, but
> depending on bandwidth requirements[1] the bootloader may have
> set the DIV1 path.
> 
> When the byte clock mux is registered with the generic clock
> framework at probe time, the framework reads & caches the value
> of the mux bit field (the initial clock parent). After PHY enable,
> when clk_set_rate is called on the byte clock, the framework
> assumes there is no need to reparent, and doesn't re-write the
> mux bit field. But PHY enable resets PLL registers, so the mux
> bit field actually silently reverted to the DIV1 bypass path.
> This causes the byte clock to be off by a factor of e.g. 2 for
> our tested WXGA panel.
> 
> The above issue manifests as the display not working and a
> constant stream of FIFO/LP0 contention errors.
> 
> [1] The specific requirement for triggering the DIV1 path (and
> thus this issue) on 28nm is a panel with pixel clock <116.7MHz
> (one-third the minimum VCO setting). FHD/1080p (~145MHz) is fine,
> WXGA/1280x800 (~75MHz) is not.

This patch seems to be still relevant. Applying it would allow us to 
drop respective save_state calls from 10nm and 7nm drivers.

I'd suggest applying it.

> 
> Signed-off-by: Benjamin Li <benl@squareup.com>
> ---
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> index 009f5b843dd1..139b4a5aaf86 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> @@ -621,6 +621,22 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
>   		phy->pll = NULL;
>   	}
>   
> +	/*
> +	 * As explained in msm_dsi_phy_enable, resetting the DSI PHY (as done
> +	 * in dsi_mgr_phy_enable) silently changes its PLL registers to power-on
> +	 * defaults, but the generic clock framework manages and caches several
> +	 * of the PLL registers. It initializes these caches at registration
> +	 * time via register read.
> +	 *
> +	 * As a result, we need to save DSI PLL registers once at probe in order
> +	 * for the first call to msm_dsi_phy_enable to successfully bring PLL
> +	 * registers back in line with what the generic clock framework expects.
> +	 *
> +	 * Subsequent PLL restores during msm_dsi_phy_enable will always be
> +	 * paired with PLL saves in msm_dsi_phy_disable.
> +	 */
> +	msm_dsi_pll_save_state(phy->pll);
> +
>   	dsi_phy_disable_resource(phy);
>   
>   	platform_set_drvdata(pdev, phy);
> 


-- 
With best wishes
Dmitry

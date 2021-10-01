Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E8B41F370
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354947AbhJARo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354604AbhJARo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:44:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC219C06177E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:43:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g41so41394461lfv.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=trOpTX3fPgPSfjOpDMDPYXwd4LNjI9d/+tq2q/EXfXQ=;
        b=KI3fJiRswZHK7JIIXimHTd8OowVIiXi/9S53GbwPQ83bF/hY52XkV0A9vlrTu+XBf6
         Y63wVv35AvDlsSlaO6hsekVqxNao1ElfQNxyhV8XtgGYuZS7p3RCZSy27g2Vm9ErDf4c
         AKLSENXIget1Mxj9It9IJBJFVM7fA5r1hVRrzLfyGI+UeHSCWlx8b4N+FHesI8dCOn+Y
         jVVqYwwcBZ4LPGR8DFafriSOG78Tuov+fIPsyruyJ/p6h5mrTwHUOctS/ioY2nN5zl76
         Fdx1siPDvoxni6Hvn3dPpXzTLCD/83TR630uVYjaQAWvTqiHgA2XqKyd8azozC1SGmWf
         owTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=trOpTX3fPgPSfjOpDMDPYXwd4LNjI9d/+tq2q/EXfXQ=;
        b=eAZB4wpAPBmlwyUEHjBbgnqnH1MAUegMveJ5yWf65g4hf9EgH1z8da1FsWOZN5E5+0
         ZWxaLqK6mtpqi9s4ruG1WrgFk/C3Aic70Lqjabhy3uwJ1dplmjlHKUS8Si/eBfxWPKHc
         36VD5HcpQBBOg67DJaYzGNIGsRxAtCLVLOjEz1ZMgWXMI1O24bpsbDjUwf8V4lsU0rOW
         ageg07EJTk2iBAAr84lZWL4OKkTOxZlCynzAUriHrp6Gu3Ri/roFYpN4gqsRh3tyUR9g
         WiDA57Z39dfOIjaIZtJSbo5LHh2if2wUf55xiex28jAsOeqf77n9m58lyuVQ7p0JU28M
         fmxA==
X-Gm-Message-State: AOAM532Rsk6/PKzdvPQsp/n/O+t4LBROhNdpUrbl2g/X4UQHLEErAl7W
        dKiFDE0al1xxlq6uq0rAdZ819yGdCCsChiA5
X-Google-Smtp-Source: ABdhPJwnqJ4zOBa3TwxdlBctEXCtk8ih+ennQVb4Li8mAsgMGpf5gT3g7NpA8Y+kGCVKPaXiLBBb9A==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr6563941lfc.43.1633110189970;
        Fri, 01 Oct 2021 10:43:09 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v3sm873116lfq.70.2021.10.01.10.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 10:43:09 -0700 (PDT)
Subject: Re: [PATCH] drm/msm/dp: Remove redundant initialization of variable
 bpp
To:     Colin King <colin.king@canonical.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210929105458.209895-1-colin.king@canonical.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <f0d9d9f5-2f6f-8936-1a6d-825ce07a5d65@linaro.org>
Date:   Fri, 1 Oct 2021 20:43:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929105458.209895-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2021 13:54, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable bpp is being initialized with a value that is never
> read, it is being updated later on in both paths of an if statement.
> The assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_panel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index 2181b60e1d1d..71db10c0f262 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -234,7 +234,7 @@ u32 dp_panel_get_mode_bpp(struct dp_panel *dp_panel,
>   		u32 mode_edid_bpp, u32 mode_pclk_khz)
>   {
>   	struct dp_panel_private *panel;
> -	u32 bpp = mode_edid_bpp;
> +	u32 bpp;
>   
>   	if (!dp_panel || !mode_edid_bpp || !mode_pclk_khz) {
>   		DRM_ERROR("invalid input\n");
> 


-- 
With best wishes
Dmitry

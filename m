Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA0396789
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhEaR7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhEaR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:59:20 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF3CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:57:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 131so15976359ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=333dg+4T08AjdOad74NZzvWXFUaJwUvbt5gSjRnF5Bk=;
        b=ccMoi6YQw2A/Dh6PUhcIIvNzDlKney868O40tFPLo84ubnWU8VScD1X9CBEKTyE5XO
         Yh+SHXnbPnuqA9+Ghy3ynubdRRy+jSFRn79EQBi9pwHec4qv5wwoBOclbqgqs8fyK55B
         zupywCtm05sPDGpxWJDQg746m1fKE6urgKNzHwOmHk1PL1fbcfaqG+eGIdT51q+CzDfB
         NTEjNnELQ19r0DpxySRgK67FoUKSDA1/7AdPjM5vO6087hF+TKXw2UssWzU5hP5Hsqy8
         YOw/23vkQoPxOYG2sk9vg+DjVnmMJygaxW2cZlupCxu+8n5gehEHwbDIYtpI92h+Txz3
         ksTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=333dg+4T08AjdOad74NZzvWXFUaJwUvbt5gSjRnF5Bk=;
        b=dRYTNG4LLm9/hhKAX5uwvPv3qpVXu7cLOj3NLm5Vc6Z9EpjJZRVpSLgFiIqB5UzhVE
         IGcs2ZA8iP/W3Zlx7KI82kJzBci9+BekUAHPBdNGoPAtmF+CDc/NAO9NHs1Iue+YeZEN
         Dv7SE2bcoxpO/IqgNI8Bep2FDkr/MQhjHMNCSOtfznpEybxLu6AnYJDxR5EyP8mS4d/S
         ivmTkf7Hp48mzd2B42A13IVLGUVmWvnApdjFRiM2nJ+eoSGFkUNzXfqJ1KwqIEF5Fw9i
         CKfq1PIf5k4eo3jsmL8gmmrk7vMYQ/r+uqtRVFj921gQ8hL0VCpfa0Hmkb8PmI2Hjra7
         1GhA==
X-Gm-Message-State: AOAM530XqceFmR16N1bdMD1psIPwP0MeNhBHFFgNTSjOrwWM8lm3CCI9
        2FQm3Gjph48EmQINMrHFi093Sw==
X-Google-Smtp-Source: ABdhPJwM7suewNJq5pRVK78PJGYgETOZsCEtDogRNSid13ZhqbxxIXaSRw6HS7Ifcco0SiiLzzZsag==
X-Received: by 2002:a2e:8653:: with SMTP id i19mr17547012ljj.11.1622483856102;
        Mon, 31 May 2021 10:57:36 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o2sm943808lfu.89.2021.05.31.10.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 10:57:35 -0700 (PDT)
Subject: Re: [v1 3/3] drm/msm/dsi: Add DSI support for SC7280
To:     Rajeev Nandan <rajeevny@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, abhinavk@codeaurora.org,
        kalyan_t@codeaurora.org, mkrishn@codeaurora.org, jonathan@marek.ca
References: <1622468035-8453-1-git-send-email-rajeevny@codeaurora.org>
 <1622468035-8453-4-git-send-email-rajeevny@codeaurora.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <03dd0cb1-433c-2bb8-6859-39e7c679dee2@linaro.org>
Date:   Mon, 31 May 2021 20:57:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1622468035-8453-4-git-send-email-rajeevny@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2021 16:33, Rajeev Nandan wrote:
> Add support for v2.5.0 DSI block in the SC7280 SoC.
> 
> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 20 ++++++++++++++++++++
>   drivers/gpu/drm/msm/dsi/dsi_cfg.h |  1 +
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index f3f1c03..d76a680 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -200,6 +200,24 @@ static const struct msm_dsi_config sc7180_dsi_cfg = {
>   	.num_dsi = 1,
>   };
>   
> +static const char * const dsi_sc7280_bus_clk_names[] = {
> +	"iface", "bus",
> +};
> +
> +static const struct msm_dsi_config sc7280_dsi_cfg = {
> +	.io_offset = DSI_6G_REG_SHIFT,
> +	.reg_cfg = {
> +		.num = 1,
> +		.regs = {
> +			{"vdda", 8350, 0 },	/* 1.2 V */
> +		},
> +	},
> +	.bus_clk_names = dsi_sc7280_bus_clk_names,
> +	.num_bus_clks = ARRAY_SIZE(dsi_sc7280_bus_clk_names),
> +	.io_start = { 0xae94000 },
> +	.num_dsi = 1,
> +};
> +
>   static const struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
>   	.link_clk_set_rate = dsi_link_clk_set_rate_v2,
>   	.link_clk_enable = dsi_link_clk_enable_v2,
> @@ -267,6 +285,8 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
>   		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>   	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_4_1,
>   		&sc7180_dsi_cfg, &msm_dsi_6g_v2_host_ops},
> +	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_5_0,
> +		&sc7280_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>   };
>   
>   const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> index ade9b60..b2c4d5e 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> @@ -24,6 +24,7 @@
>   #define MSM_DSI_6G_VER_MINOR_V2_3_0	0x20030000
>   #define MSM_DSI_6G_VER_MINOR_V2_4_0	0x20040000
>   #define MSM_DSI_6G_VER_MINOR_V2_4_1	0x20040001
> +#define MSM_DSI_6G_VER_MINOR_V2_5_0	0x20050000
>   
>   #define MSM_DSI_V2_VER_MINOR_8064	0x0
>   
> 


-- 
With best wishes
Dmitry

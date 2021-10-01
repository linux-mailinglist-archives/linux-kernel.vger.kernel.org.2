Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AA41F30C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355303AbhJAR1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhJAR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:27:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018FC06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:25:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so41747635lfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9nlprdDjKhZk+Io06k2/qaSebLAZUpDSI5ZQtfrSfFg=;
        b=I2mfpjE4lJi8vWiLrsdvjrZAZeA+6AtoulIGs0LqXRUet3ernh7Jg5b+wUb2JcCliC
         eTckG5Tr/VNQ/gMXz88clQnF940a/LnuLhqMMQc/e29+cITde/1+LUW0MM0Sg0kDQYrm
         fW4kwd8Gr1InLRHI7JDBZdzfjdimWiNeBgWxffmMUnCRuE1uBtzZNCfIz48ejxKlXHf5
         LKWQszn4ftRtWpwzONbbCtiuSiq0nKAVsT3Z+NmfyX39v+RU3pgjCfZnpqy4DnjlYd1Y
         EWVKMuC1JMIb3cok5QtIkH3j4iDIBhZk/llPZmbmxIrVDkLdzto0kljx7ZqeRN/xuU2i
         oxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9nlprdDjKhZk+Io06k2/qaSebLAZUpDSI5ZQtfrSfFg=;
        b=KRPF2GRv61ge7aZWTaJ7M5sq3/xSLK6uCxnghKDn2WDzF4g1z0DzyWj79vmOQh9knC
         Etc3n1kFoFhmkjDWOR1uSI3UPTFJxNREUpsD1cGIUwSDJ9ONDY+QTXliYnDligAOp1Xz
         e/pMpNrcNei8/khgx7pzWHkK1aGjxtWzwCXyogGxQfR8IzquNCOFNbKc9aP0ayQuiXFi
         TqN40dvvcsgNOrK7mtOGJtEXf5BjKrufZ0LlFE3hrYjM7/1LMmCKYLIkSde6l1T6oWmU
         gzr1VhgHeLLt710otx1ei6i64AfJXBv87wJYVsi9jxXk658tsjpPdPYeLcqBT0JsGRk0
         qseA==
X-Gm-Message-State: AOAM531Oy6jQp23V8nn3duXgN4tuZ5LwIRkDqGNCM6tAZHrjSfGEF2VH
        FWpPFkDY6BZkZ/A+YoS18tUNyYWWJrCdiJQy
X-Google-Smtp-Source: ABdhPJyUqOBhGpHw6dRT3MwCMEAjtj9svKASrprGteO8UneHjz58Fv/TfDELPSqBBydaxbNvLJ3rQw==
X-Received: by 2002:a05:6512:158a:: with SMTP id bp10mr6711563lfb.122.1633109123011;
        Fri, 01 Oct 2021 10:25:23 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g5sm796856lfc.98.2021.10.01.10.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 10:25:22 -0700 (PDT)
Subject: Re: [PATCH] drm: msm: hdmi: Constify static structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210920212014.40520-1-rikard.falkeborn@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <cf3442eb-ae42-4203-fbea-49ca3a45bdd5@linaro.org>
Date:   Fri, 1 Oct 2021 20:25:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210920212014.40520-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2021 00:20, Rikard Falkeborn wrote:
> The only usage of hdmi_8996_pll_ops is to assign its address to the ops
> field in the clk_init_data struct, and the only usage of pll_init is to
> assign its address to the init field in the clk_hw struct, both which
> are pointers to const. Make them const to allow the compiler to put them
> in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
> index a8f3b2cbfdc5..99c7853353fd 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
> @@ -682,7 +682,7 @@ static int hdmi_8996_pll_is_enabled(struct clk_hw *hw)
>   	return pll_locked;
>   }
>   
> -static struct clk_ops hdmi_8996_pll_ops = {
> +static const struct clk_ops hdmi_8996_pll_ops = {
>   	.set_rate = hdmi_8996_pll_set_clk_rate,
>   	.round_rate = hdmi_8996_pll_round_rate,
>   	.recalc_rate = hdmi_8996_pll_recalc_rate,
> @@ -695,7 +695,7 @@ static const char * const hdmi_pll_parents[] = {
>   	"xo",
>   };
>   
> -static struct clk_init_data pll_init = {
> +static const struct clk_init_data pll_init = {
>   	.name = "hdmipll",
>   	.ops = &hdmi_8996_pll_ops,
>   	.parent_names = hdmi_pll_parents,
> 


-- 
With best wishes
Dmitry

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11EC400555
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350811AbhICSwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350603AbhICSww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:52:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012A9C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 11:51:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y6so307063lje.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CGgzXCdE/Vq7B9miSyLOddv3Rnpk5fkhdhUAv/F6bFU=;
        b=j6uHwa3CYVqqxebmAZUpVozSQIY4vCnHYonuiFq2WdOpzYxZC4qv790QDk3DHG0O09
         7Hfu72FNXkNpUQI2bYtiHlhXp9w9Wv0M0brfzW+v2ifGhnO8lb3zjUF9a+n5vbYyePR0
         AVlxUwU/cJcTPe/aFsl+R2q5Nh19hTmNlUqV3d5mM1mrjv4fuLz68sd9LnDz+0BpTZOJ
         0/P0abPEeCsZZEG3/Qm0KCtcmXdneV4B5JCjpPVnZWTHZ8PGhcDkxCAJGCMHc9ZwB1ey
         te2M6vADtboCIrDx3C+2y9uEIYO4juBO+JmcibGxGmZmPJZSUebJJcI/trIXew0h/EzO
         T0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CGgzXCdE/Vq7B9miSyLOddv3Rnpk5fkhdhUAv/F6bFU=;
        b=kPajXWFAeOwK6xTzoHJ6/3lKOxzQyOs8r2pxNZcFQlCapZNsB8pPHFBFvmzKBBDprF
         PHQIKO9yEGQ+fzZksKTh0pIQEmDTpx+3dfXA0tr/SupFODrHHVqTMuBB7glMr+n+pZZr
         SnL5lCN1usFuQFnnGa6KGvx2yjcI46DnACgp+KYnOav47Fx22Sih0pJj84SWh0PY2u4I
         eejBc0qBRoMrMQt8l5V4CLqOYGouznefeBMtu2va3ui2f7LlpqeQDzN4skCHcAoh2PTS
         dcmFX0t/mDgjBeZUjYsNnjNel3iFck8p9SBIq2IB8J80ONWg7iNM5KELdSceT84hW080
         Z63A==
X-Gm-Message-State: AOAM532b+0P8sy95QoaOY6E/WxafM0LQDhMqk5ilm9JAojlmDUTaCTtp
        8oiXG/+7ITt8ANB4Hkx72CtvfA==
X-Google-Smtp-Source: ABdhPJyrp1FHP6A/jWM2UEHJjZAjv8wE5xkA68qW9HBXTbA6YbMhGtQ4qIeBH1MvoLAQijDEs8Gbcg==
X-Received: by 2002:a2e:83d0:: with SMTP id s16mr322899ljh.328.1630695108904;
        Fri, 03 Sep 2021 11:51:48 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y1sm22335lfb.297.2021.09.03.11.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 11:51:48 -0700 (PDT)
Subject: Re: [PATCH] drm/msm: remove unneeded variable
To:     cgel.zte@gmail.com, robdclark@gmail.com
Cc:     sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        lyude@redhat.com, airlied@redhat.com,
        laurent.pinchart@ideasonboard.com, chi.minghao@zte.com.cn,
        treding@nvidia.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Brian Masney <masneyb@onstation.org>
References: <20210831115127.18236-1-chi.minghao@zte.com.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <65f56c2b-591a-16c8-7f3a-41695b1147b3@linaro.org>
Date:   Fri, 3 Sep 2021 21:51:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831115127.18236-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2021 14:51, cgel.zte@gmail.com wrote:
> From: Chi Minghao <chi.minghao@zte.com.cn>
> 
> Fix the following coccicheck REVIEW:
> ./drivers/gpu/drm/msm/edp/edp_ctrl.c:1245:5-8 Unneeded variable
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Chi Minghao <chi.minghao@zte.com.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Glancing on msm/edp, as it was never supported by the in-kernel dts I 
wonder: maybe we should drop it completely? If the need arises the 
removal can be reverted anytime.

Does anybody hacking 8084/8074/8974 support has eDP port access?

> ---
>   drivers/gpu/drm/msm/edp/edp_ctrl.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/edp/edp_ctrl.c b/drivers/gpu/drm/msm/edp/edp_ctrl.c
> index 4fb397ee7c84..3610e26e62fa 100644
> --- a/drivers/gpu/drm/msm/edp/edp_ctrl.c
> +++ b/drivers/gpu/drm/msm/edp/edp_ctrl.c
> @@ -1242,8 +1242,6 @@ bool msm_edp_ctrl_panel_connected(struct edp_ctrl *ctrl)
>   int msm_edp_ctrl_get_panel_info(struct edp_ctrl *ctrl,
>   		struct drm_connector *connector, struct edid **edid)
>   {
> -	int ret = 0;
> -
>   	mutex_lock(&ctrl->dev_mutex);
>   
>   	if (ctrl->edid) {
> @@ -1278,7 +1276,7 @@ int msm_edp_ctrl_get_panel_info(struct edp_ctrl *ctrl,
>   	}
>   unlock_ret:
>   	mutex_unlock(&ctrl->dev_mutex);
> -	return ret;
> +	return 0;
>   }
>   
>   int msm_edp_ctrl_timing_cfg(struct edp_ctrl *ctrl,
> 


-- 
With best wishes
Dmitry

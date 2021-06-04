Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE839AF3D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 02:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFDAye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 20:54:34 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:42578 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFDAye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 20:54:34 -0400
Received: by mail-lj1-f173.google.com with SMTP id a4so9390208ljq.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 17:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CT2K/qS5lVIs3YEMDQdZKAD8IbCCmQONZ9+FgWAvX24=;
        b=JOmB2bGuNQSVZesELXq7kgWG5GtOYXhL8kI/x3kQrNHvB7/M6fmmDaKhhsnlOeywzR
         pUWUYbqF8f/aZ27tG2QiZSg793i3bBd89UkP2aCQMm5cKEQE5LRgha9N8azIYpZ8EnMA
         Q932dDMGQt4UMgB1aq/XdlGEPRXTXr6HdmazmGBQ0P5LYdc8lP9NKZngQMYq51XpNB9r
         O6uX2Tb3t4YL84IRQYvvC6SaUJMr9PDp5zC6rZ9dMfVRGi2UfwghPuN7hZRGsndI0ST+
         PFhY2vqVwNrjH6h+YtALzUeOMjHf94TJ72x3BWZxTFWYyzd7pyDDb6VcXkVM3HXJ48SV
         RKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CT2K/qS5lVIs3YEMDQdZKAD8IbCCmQONZ9+FgWAvX24=;
        b=JDvAhhIL9d+7OL01zxk/xUrapp52PA51I82kLv4VUS9bCKM1Yk6DLPbn1CyYNnZQYk
         HSIgj4N7YMhrkosTe0NS2TqCN0pjCK69tfj4B/6r7jTWHFem1Jm2+2wBPrrZek1ir9gl
         jCt+DmCDeFztsgLlTA+msSSvNlVR+krBXXnHozYrZ5XNhQDnGqMElpB0SDPe0LUlxMhq
         xdIe5u4RSHKqcBZVCc8TeKkFffUMeX9RluRd0VYOkm/+kQu71+BwmJ0dTqpwbEj4J0d6
         MLJAx/r+7nwlph9Exy8W5W/397W9jRuFFKSLECdovwLCnqZ+V/ymf/uzjroYcu2gKYQn
         ptAg==
X-Gm-Message-State: AOAM533tbfPdRTb2nfk4/vQ7kHpYduly0DLFf7jtytOfOA89J/S0VFQ+
        IrIvjBZi7gFVdgczahRvOIY1KA==
X-Google-Smtp-Source: ABdhPJwqxUWLj44z5pV1IxYjRC/4BbSsQYK/woXmzbgMRsur3QtiLC9JK1TbDTSqoIVXvRm2UjIBew==
X-Received: by 2002:a2e:350f:: with SMTP id z15mr1394722ljz.303.1622767893346;
        Thu, 03 Jun 2021 17:51:33 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d24sm459811lfn.213.2021.06.03.17.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 17:51:33 -0700 (PDT)
Subject: Re: [RESEND 14/26] drm/msm/dp/dp_link: Fix some potential doc-rot
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-15-lee.jones@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <c6f630b6-715a-2dec-0b91-f918adcbdbd3@linaro.org>
Date:   Fri, 4 Jun 2021 03:51:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210602143300.2330146-15-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2021 17:32, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/gpu/drm/msm/dp/dp_link.c:374: warning: expecting prototype for dp_parse_video_pattern_params(). Prototype was for dp_link_parse_video_pattern_params() instead
>   drivers/gpu/drm/msm/dp/dp_link.c:573: warning: expecting prototype for dp_parse_phy_test_params(). Prototype was for dp_link_parse_phy_test_params() instead
>   drivers/gpu/drm/msm/dp/dp_link.c:975: warning: expecting prototype for dp_link_process_downstream_port_status_change(). Prototype was for dp_link_process_ds_port_status_change() instead
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Chandan Uddaraju <chandanu@codeaurora.org>
> Cc: Kuogee Hsieh <khsieh@codeaurora.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/dp/dp_link.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
> index be986da78c4a5..1099604bd1c86 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.c
> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> @@ -364,7 +364,7 @@ static int dp_link_parse_timing_params3(struct dp_link_private *link,
>   }
>   
>   /**
> - * dp_parse_video_pattern_params() - parses video pattern parameters from DPCD
> + * dp_link_parse_video_pattern_params() - parses video pattern parameters from DPCD
>    * @link: Display Port Driver data
>    *
>    * Returns 0 if it successfully parses the video link pattern and the link
> @@ -563,7 +563,7 @@ static int dp_link_parse_link_training_params(struct dp_link_private *link)
>   }
>   
>   /**
> - * dp_parse_phy_test_params() - parses the phy link parameters
> + * dp_link_parse_phy_test_params() - parses the phy link parameters
>    * @link: Display Port Driver data
>    *
>    * Parses the DPCD (Byte 0x248) for the DP PHY link pattern that is being
> @@ -961,7 +961,7 @@ static int dp_link_process_link_status_update(struct dp_link_private *link)
>   }
>   
>   /**
> - * dp_link_process_downstream_port_status_change() - process port status changes
> + * dp_link_process_ds_port_status_change() - process port status changes
>    * @link: Display Port Driver data
>    *
>    * This function will handle downstream port updates that are initiated by
> 


-- 
With best wishes
Dmitry

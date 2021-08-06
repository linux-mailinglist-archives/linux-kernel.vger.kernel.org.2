Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685D23E2EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbhHFReT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbhHFReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:34:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE8DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 10:33:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d8so12024306wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=51Wt/epNCWPynZo+P6Tn8h9IazfrQzknOp2Tf5pj0cA=;
        b=hjwqkNIiEJwKS1s/Te9KqI1+7oDR4SYvX5/4vGEi/Ix4wAC0PeG+0xw8Sse6IV4WI9
         hWxlp6woHvgNjuEPWp2cs5WcJRwS0QiKxXDTXe4yLnXkkS1yxEBhJq3hBus+3GVpzyhf
         bt++srvFqauqJefvVBdz8hMKbhq4RAPidYEUGa0hbrqvS26TCoofEePDW+rSZ2DV4Lqp
         7Jk43NjqTehcwv+M++9+vGw3swh8m8jWmYMNYS7+ToUqTK0y13Sd6wQznmlV/MPLlxsJ
         NBUd544c4/R2Er6/VNP+x+sCmA1yV8592BACRaYW4ZNUbH75wFM6hylCwgE2me5ybZuE
         qeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=51Wt/epNCWPynZo+P6Tn8h9IazfrQzknOp2Tf5pj0cA=;
        b=BmhRy0yRbfzi4uGR2qnVjoecjDZGluSZ9BBPoN8OTRw+rswQtfrJh48B2CnAqJ+jIw
         ck7Zc3F9ebBfbyWxnwmFYPoq4LLZzMCObscXkjWvobkzlY7mRyX9mncVZTn9V1ZvOTGR
         FwR5SGVH/GuE64o1WmvGQ2np2Jik7M9e6gnJfHqHmDaJGApjRbUFYerkr9W93JxMdZUk
         iBPdQy2cJtyoTJ7yZgTp0U/TjGMjPxAI1Yqt6K5ffjITH5jvHMDkk/CBgiUiel/wg8WZ
         S5sVfj9OP8KfJlrQEwcvcvqIcGEIMqMV+/UftxRXAx5ZTxsUX3LCkTYhpzY79DVS3joC
         DM5A==
X-Gm-Message-State: AOAM532Wk7oWfyxO0+vGjMBQcb0Z+ilVmIXPYumu5jKG58aD4AclGgmr
        NNjlPDtjaqCvRW8CaupAipQ=
X-Google-Smtp-Source: ABdhPJzOTJ2EX8FsBZts+T/paw3f2zPRquLswWYFayFLKIcZGolcAU16ulg29fb0QV9HVRhGQ73qNw==
X-Received: by 2002:a05:6000:227:: with SMTP id l7mr11558350wrz.289.1628271235701;
        Fri, 06 Aug 2021 10:33:55 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id q14sm10474504wrm.66.2021.08.06.10.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 10:33:55 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] drm/mediatek: mtk_dsi: Reset the dsi0 hardware
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     chunkuang.hu@kernel.org, hsinyi@chromium.org, kernel@collabora.com,
        drinkcat@chromium.org, eizan@chromium.org,
        linux-mediatek@lists.infradead.org, jitao.shi@mediatek.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
 <20210714121116.v2.7.Idbb4727ddf00ba2fe796b630906baff10d994d89@changeid>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <07319ed2-aed9-cbd7-06aa-6603a9bd4567@gmail.com>
Date:   Fri, 6 Aug 2021 19:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210714121116.v2.7.Idbb4727ddf00ba2fe796b630906baff10d994d89@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2021 12:11, Enric Balletbo i Serra wrote:
> Reset dsi0 HW to default when power on. This prevents to have different
> settingbetween the bootloader and the kernel.

settings between the...

> 
> As not all Mediatek boards have the reset consumer configured in their
> board description, also is not needed on all of them, the reset is optional,
> so the change is compatible with all boards.
> 
> Cc: Jitao Shi <jitao.shi@mediatek.com>
> Suggested-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index ae403c67cbd9..d8b81e2ab841 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  
>  #include <video/mipi_display.h>
>  #include <video/videomode.h>
> @@ -980,8 +981,10 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>  	struct mtk_dsi *dsi = dev_get_drvdata(dev);
>  
>  	ret = mtk_dsi_encoder_init(drm, dsi);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	return device_reset_optional(dev);
>  }
>  
>  static void mtk_dsi_unbind(struct device *dev, struct device *master,
> 

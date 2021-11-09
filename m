Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58E444AA79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 10:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244800AbhKIJYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 04:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbhKIJYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:24:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40FBC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 01:21:25 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u11so19837436plf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 01:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VlGCNRAbCJyOrMfe7yxeDHsKpbkWTi/DwMsr2rG9iqc=;
        b=B95rJf9LytoLokK4d2RM8YJBBo4V8DR5ompwAnjsPSqwzZVa115Ghf4W56fi0ft+E0
         35y1LF46wO/OwVi06+GEPUZZsIibfDLlJfdUDMq0CDM+dB7FgFxOvHBowuLvTco/+j2U
         ou8+FMi/9w/x2GNWN/gSnCAQ8rhCd4/Ki9xFSQwf03YHH4wxDxwRlAUHMoXjINAd6r1w
         nxUdC0r/hSmvRcvkLwWhpp4536sybMkBSbPflcKFVQcTbxjPG92tTuMbJrO0T5nwhvBc
         8mVNlhVuSx4WFG/OE39swxHOS+yB8PXsS8lO2w6X/JryM/hEFUpGOXU9ZjfZbe0cuIst
         Nn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VlGCNRAbCJyOrMfe7yxeDHsKpbkWTi/DwMsr2rG9iqc=;
        b=0gMoVMbuR1W8ua89WQm5nBfsMhBgiXm22IW6wvI5iamDgKkoK0ccJ5KoU2tnDwrGoX
         9Mf/G52nqIQj+vIhXa2sTEp442s1fZEx/tGU0P08d+d6TsitARR9SxPCNQPfWibSpGYf
         W/nhmECthTNRZFArsNowi6FrWUZZCZv53HV/fPX40zDW9jCazFeph5DMGiDL8VwpFZdd
         GRFzvGt267bZWvZJ8HCdV7Mf2FD+eTiH9Y29wU230jTTLyjV8ADdIUnGzjuWqXm0s1ad
         MpI1TEj4mzJ7i2ziclwgwpeQ42kRN2tKVDtIhZ6Q3QAIp3Mb+LbIu4TPR+8+AueB4WWq
         VpZw==
X-Gm-Message-State: AOAM530r1eRvigmzz+RtnKI3wRCie3Xu3RcsPKUa75Ji//Kr2vOej44t
        vhUgjNkNt0+tS6AWoWbR3JXB6w==
X-Google-Smtp-Source: ABdhPJw4O+6Tc+jEcuEXkZG0VHy4lKkRci/QQtKyux1NreMeQ+csadk5zJ+tJlCUoZid6Vr7YVigBw==
X-Received: by 2002:a17:90b:38cd:: with SMTP id nn13mr5320131pjb.175.1636449685513;
        Tue, 09 Nov 2021 01:21:25 -0800 (PST)
Received: from localhost ([223.226.77.81])
        by smtp.gmail.com with ESMTPSA id y28sm7457013pfa.208.2021.11.09.01.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 01:21:25 -0800 (PST)
Date:   Tue, 9 Nov 2021 14:51:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     cgel.zte@gmail.com
Cc:     info@metux.net, vireshk@kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers:gpio: Remove unneeded semicolon
Message-ID: <20211109092123.ao6x4imbx5zg4pl2@vireshk-i7>
References: <20211109082357.131251-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109082357.131251-1-chi.minghao@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-11-21, 08:23, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>
> 
> Fix the following coccicheck REVIEW:
> ./drivers/gpio/gpio-virtio.c:437:2-3 REVIEW Unneeded semicolon
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
> ---
>  drivers/gpio/gpio-virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index aeec4bf0b625..84f96b78f32a 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -434,7 +434,7 @@ static void virtio_gpio_event_vq(struct virtqueue *vq)
>  		ret = generic_handle_domain_irq(vgpio->gc.irq.domain, gpio);
>  		if (ret)
>  			dev_err(dev, "failed to handle interrupt: %d\n", ret);
> -	};
> +	}
>  }
>  
>  static void virtio_gpio_request_vq(struct virtqueue *vq)

A similar patch was already reviewed earlier:

https://lore.kernel.org/all/1636344232-56537-1-git-send-email-yang.lee@linux.alibaba.com/

-- 
viresh

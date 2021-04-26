Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B803336B5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhDZPZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZPZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:25:12 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE9C061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 08:24:31 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so26488421otp.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XlOp4aQv5AKhOkuF/Zfl9vY9MXO0fLaz7BoffX5QRNw=;
        b=YwgACdhtaGPKcEkNRqu5UjdGP0cJ0mCIt/1EnwC0Q4Q9n+sDjAwUC4eJHVxr/bUVfd
         QyVMzpmJJTuAOLqPkcFN2akmL6oPD6pruQEJe4G6c0oHCHMQKqjyxuDrqlqJFby0J6UA
         aQQf+8UHfwnzJPZ1sIKSG0tYd/8ie7cY56WCRg0cN17tZ4lMjQubPRORcdMRRazsHoGW
         QfhscTHMfBt+ABKuB/aNdy8kFwSD+UUCQh+D0mZpNDbwGIDRtBEjI6FhNMnR+JUBANDF
         c+S0vUDcSViaHUdXbfYLVmnjMXwWxKKQyDT81ksz+uIbA2oRiBQDWcp2e2b+8eazxvQn
         cz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XlOp4aQv5AKhOkuF/Zfl9vY9MXO0fLaz7BoffX5QRNw=;
        b=N2nAi0I0xOa5KykgEk3zJOZA3eEJ98ZJd7AqPcNm/GFTT+q4HGNVWBTokEsfSsQbUK
         oiGEgBNL35BZkKohuNQTAzPrbwcCaqpCiclhIdliiR+eT7/xRMX8F8/GEIpLSAQWfhxe
         vDF3zpm3LGV7nOMgSQV21yBZJq8nFZTskkIWm0rENnrJmw0uZJBKC/qUyPB7bR0Z1oGw
         FaV9DzRqx7Dydu+MduC0ixu4f3tb1zjCtamDE9ZOijfJid5B02qdWHzzCkBqjzQrlIaB
         5S5mXUDRQT8TX1p6GtGBEaiv6h0ASubCddZrnmQ01HIcrAx3+gMiX5+Ad5YAUvBQEojs
         KPvg==
X-Gm-Message-State: AOAM530EAUotMeJKxKaP07PZ/M3iCUpZbjkiNUGZ8m95Qx63dpDccIMe
        46RBPDxbmXTzlai9UCzSVN45vQ==
X-Google-Smtp-Source: ABdhPJybRS10zd3ziRCBWMIWxM8vfG2fUnQW0ZWT1rN5dJNV1jqUEeZhOYkifFnnHBA3sRhipClJxg==
X-Received: by 2002:a9d:2030:: with SMTP id n45mr15978588ota.98.1619450670244;
        Mon, 26 Apr 2021 08:24:30 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n37sm3537816otn.9.2021.04.26.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 08:24:29 -0700 (PDT)
Date:   Mon, 26 Apr 2021 10:24:27 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Introduce single-PWM of_xlate function
Message-ID: <20210426152427.GG1908499@yoga>
References: <20210423213304.1371143-1-bjorn.andersson@linaro.org>
 <20210424113204.besr7gye2htzkbkr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210424113204.besr7gye2htzkbkr@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 24 Apr 06:32 CDT 2021, Uwe Kleine-K?nig wrote:

> Hello,
> 
> On Fri, Apr 23, 2021 at 04:33:04PM -0500, Bjorn Andersson wrote:
> > The existing pxa driver and the upcoming addition of PWM support in the
> > TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
> > thereby a need for a of_xlate function with the period as its single
> > argument.
> > 
> > Introduce a common helper function in the core that can be used as
> > of_xlate by such drivers and migrate the pxa driver to use this.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> I'm OK with the idea as such. I'd like to see the semantic expanded a
> bit however such that the function can parse
> 
> 	pwms = <&mypwm 50000>;
> 
> and also
> 
> 	pwms = <&mypwm 500000 PWM_POLARITY_INVERTED>;
> 
> . You suggetion only covers the former.

One concern though is that a single-channel pwm with the optional flag
would syntactically be indistinguishable from a multi-channel property
without flags. Presumably the values are out of range though, so I
suppose there's no problem in practice.

Please let me know if you think there's any merit to this concern and
I'll respin the patch accordingly.

Thanks,
Bjorn

> 
> See
> https://lore.kernel.org/r/20210315111124.2475274-2-u.kleine-koenig@pengutronix.de
> for my first attempt to unify of_pwm_xlate_with_flags and
> of_pwm_simple_xlate accordingly.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



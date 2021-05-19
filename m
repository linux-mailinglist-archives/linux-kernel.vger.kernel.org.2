Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6460A3891FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354854AbhESOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354849AbhESOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:52:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B72C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:51:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso3445972wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nvJsZjtlKlLIH6fdR/8rxsvo7mslRnhXMBMDcMwpR/k=;
        b=Gf+NBbClaX3c/oHpNH/owQaNKi5li/Aj7dV8g56asHuHG8FuUYgXdJJ0WQkYs7Zuab
         8YBTtfKAXsyXbD1S74Ly5jUECBkhRLs/GEStkBFfgTriUGMItv82pNpCfb695A+PDuwC
         FTCJgQFfa0o4psLOe/ShI0f3WMxXEH+AZnXF2+dR+iDDzhHyTY1lokDpxTmBLZ1G6qYx
         jPiCaW0C9Fua7d3QJ+81N8s2E0ey6cUSj8q84G9YvZgVpcmQ7jUnKPTeCplK2kAYUDhY
         JOhGRDNerL0KmPZzd18OpFLAr9gHJ3y9zgi7DbpTWxmbGbHIdaHtbTD+aRNlOzK/BefW
         VVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nvJsZjtlKlLIH6fdR/8rxsvo7mslRnhXMBMDcMwpR/k=;
        b=JsRaNNsiW7+4H8ohvy+Fd/o+ADFoFc3IvMxdpu/jVqEUGEohlGqW/4zJGGj4LxxvK0
         OC4XfI3cLM7HhzInWV9zPT1LALhZ/k+bcEcwruPvjWTPIPJyoFq/ZOfnuLlQpgW5trIu
         0Q5p+bub4KsZ4Ozc0z8bfequBH3gZl0qIpezKKTZPXGtVRFOIjCLvvbHYAVMqWNdfmYm
         MbNAu0tb+rz1C2sSljOV0+1DToqbKHDdv947Zglyq7UVxE/mwVgKEWNE8ClIcLB2Hm+Y
         Ynnos6hVzcpny9YjX4a8DO6FBEdgmujdQIZpAcysHo8kZbIABERmfO6tlYzgE/WyxHc1
         qhzA==
X-Gm-Message-State: AOAM533sLnLCzFOHZ0K/9EC9xEb8nqXrNNTpl7oGUAXChVKDW4b4k41h
        NBpjy42pxpCQ5ZpMz149VbEDjg==
X-Google-Smtp-Source: ABdhPJzw2ZX1L7rkBrbwUJlJD+6pDoXl8RrmUaoL4wF6IzOTk9tjI5t1y2Exc8dabwsaE4wIB0Qnmw==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr3775449wmj.131.1621435874758;
        Wed, 19 May 2021 07:51:14 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id t16sm17810288wrb.66.2021.05.19.07.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:51:14 -0700 (PDT)
Date:   Wed, 19 May 2021 15:51:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, pavel@ucw.cz, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, cy_huang@richtek.com
Subject: Re: [PATCH v7 4/4] backlight: rt4831: Adds support for Richtek
 RT4831 backlight
Message-ID: <20210519145112.GG2549456@dell>
References: <1621262161-9972-1-git-send-email-u0084500@gmail.com>
 <1621262161-9972-4-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1621262161-9972-4-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds support for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> since v7
> - Fix typo 'common' to 'commonly' in Kconfig description.
> ---
>  drivers/video/backlight/Kconfig            |   8 ++
>  drivers/video/backlight/Makefile           |   1 +
>  drivers/video/backlight/rt4831-backlight.c | 203 +++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 drivers/video/backlight/rt4831-backlight.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

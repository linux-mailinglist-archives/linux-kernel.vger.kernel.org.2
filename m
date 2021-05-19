Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE943891F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354840AbhESOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348647AbhESOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:52:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F8FC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:51:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f19-20020a05600c1553b02901794fafcfefso2986639wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9hWo+oUpcm6brp7QVlWP1qMLhPG7on+ugtgTIWdWGgk=;
        b=DkbY+S6Kg6quQSONCtHMXfCOVH4OqhINL2j5T2IQkq270nlPjxKYMOHAvn7NWQh8X3
         Jhma/fsIgCa0KwMhVLvInBhtvcRSi7uxPlGlTwbvO6clzDTUen87CWrbzK5cRjybbWRP
         PhJn84d1pBheNl2WpfksWb0E2d+ClU+7OKVwGil1F+lQanIzMlgNYDRkpjv5F54gFZAF
         JqAdn/Wh9QK5zpJOpgWnqRxeQRToHI85pqtl/YpVaxYF47j9Nz2GikmJ0e3/mhMoEV2F
         Fr0AE4zoSCrxSgKOhdk2qoKqrJ8Bsm9nTRjKH8MfzK/wIo1B8JlgqujcclkxDnRVOdcB
         2MVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9hWo+oUpcm6brp7QVlWP1qMLhPG7on+ugtgTIWdWGgk=;
        b=st88JtKoWy3fQ03RneH70ary6RQFHlrsRPfP18U8KKp/dx2I1ypVP5f5K6aXNyOi+D
         8VT1RUWuxvnHgNu5l6XR+YUGx9rRGvlAeRTM3qulpTiXaRrqpULF6ahFfn9ZgiGVGsew
         6ZtxmuT0fCzn1FBUjcSvpSKDiKV8dEMUi7zbcSYQGEt3ce1k56TTzIoFSVg5+3TUSVuu
         cFCOOGBk1wLZwd/BolVZnBEXkUZIer/TeI5w6svJxjUOpdD/2wpGodpb4R+otFmRGo6c
         OtNea47A2McFBmVz5VYjHfsjGXgF06fG+sWu723N3pfj8pMAOYz74lCzyOdGoEYeU3V/
         uQ3w==
X-Gm-Message-State: AOAM530jVv/nSz9pw0WcQXILtiy+Q/DFxHRtnkYt43IW2ZZb7qHYWcYP
        KYFM4CJnWo8MhAdAIH4BT5YJJg==
X-Google-Smtp-Source: ABdhPJxq4yOvrbz4+GMdrRqg0XGhy30GzDMOvEMevBFgiblHVaKtLBRosn/C9Txh2zMPl8KgwasAgQ==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr12270205wmq.4.1621435860634;
        Wed, 19 May 2021 07:51:00 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id l8sm7188514wry.55.2021.05.19.07.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:51:00 -0700 (PDT)
Date:   Wed, 19 May 2021 15:50:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, pavel@ucw.cz, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, cy_huang@richtek.com
Subject: Re: [PATCH v7 3/4] mfd: rt4831: Adds DT binding document for Richtek
 RT4831
Message-ID: <20210519145058.GF2549456@dell>
References: <1621262161-9972-1-git-send-email-u0084500@gmail.com>
 <1621262161-9972-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1621262161-9972-3-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

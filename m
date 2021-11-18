Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E6C456435
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhKRUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhKRUdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:33:37 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43985C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:30:37 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bj13so16934425oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lpxOUZi8eZtXgRuCBNNMVCz/8y8+r3vF20s7lvfQT9w=;
        b=u2a5n/mvSzduXGiOrrvh3GGtSy3rq5tEEjevCnZ2g5lFriIVQhxWwI2g68kAe+p1ht
         2pmrVbJHQ5kWPoIYX89tFsfC4oS5245rm3s1nhr2bT1j60N9qFy75Sp+5jPIr/StT78c
         uvZkxgkRrU+mLZajRbZlVd3t5hQlWDpZWNxQslU9TvLtYdK7w5EmWjj0GEJeqAaU7V/9
         pR5FW6PxyZ0QrCg94oifWcS9ucyh1eYAWemGWW4A/5Rv/6R+kgy2RSb48J3RMcGAUVa3
         /f/lke7WUGL62Y17itVE5qq/myng8G/tQHL4qvBhSBr7sP7Q1JLF/5TGaCbMqD794NHX
         q7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lpxOUZi8eZtXgRuCBNNMVCz/8y8+r3vF20s7lvfQT9w=;
        b=cOOrQEN5k8BEMeEfrGaLRpvzw1Q8fMI599REGwtaZ4V7izYZWxlDWQbcJwTrRyV0+K
         7pM3HKSWEU9wYFcM4Xl7eTzCdj0DWGwlNXTLSL123fYcQoIxH+aYupkQEXWUMjNU8P5+
         JvSxwp69X9HsqnkQpTxAyoCpdpy3ozcOmj5r/sNlYgYHRTFyNX4yr3PnJOll1pfDVnze
         MUlvihG5zrBzPWjTk4TZC2aew01EqOtcqY7vgEgiah7PdkCelgrcR4/V+6dm6V7Rtceq
         wmKe3Svop69R+EfLRrksIXUTnDX2Rm6ml04KwhOkBNuN8vEL9PxVQ9zXNH0q4W+PVvHY
         iXVQ==
X-Gm-Message-State: AOAM531e5Yh28vOButoxoLLtURZVmG42/b+pdWid6BykxIGlMYcl+Zz4
        mfBtFwlOQG6RY5B6enLYYv5PFQ==
X-Google-Smtp-Source: ABdhPJzr43gYSVIqQaBxtCBx1ey4ahfuAlTLLX8MN9Jlw6mkUxEuYKtvGcUH5Dafd4SArfdbXQ1/Jg==
X-Received: by 2002:a05:6808:4d9:: with SMTP id a25mr10210086oie.52.1637267436553;
        Thu, 18 Nov 2021 12:30:36 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w19sm215372oik.58.2021.11.18.12.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:30:35 -0800 (PST)
Date:   Thu, 18 Nov 2021 14:30:33 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Min <alexey.min@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Martin Botka <martin.botka@somainline.org>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: Re: [PATCH v3 0/8] Improve support for Xiaomi Redmi Note 7
Message-ID: <YZa36ZACKVShtNtM@builder.lan>
References: <20211111031635.3839947-1-danct12@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111031635.3839947-1-danct12@riseup.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10 Nov 21:16 CST 2021, Dang Huynh wrote:

> This series expand the Redmi Note 7 device port to support:
>  + Regulators
>  + Volume keys
>  + eMMC and SD card slot
>  + Framebuffer display
>  + USB
> 

Thanks for the patches Dang, I think they look good and would like to
merge them.

Could you please submit an updated version with the one gpio.h inclusion
pointed out by Konrad moved and fix up the Reviewed-by pointed out my
Martin?

Thanks,
Bjorn

> Changes in v2:
>  - Dropped linux,input-type from volume up as 1 is set by default.
>  - Dropped gpio-key,wakeup as it's a legacy property name and is
> not relevant for a volume button.
>  - Rename label cont_splash_mem to framebuffer_mem and change node
> name to memory.
> 
> Changes in v3:
>  - Add voltage range for vph_pwr
>  - Move RESIN to PM660 and make PON keys disabled by default 
>  - Addressed review comments from Konrad
>  - Make Alexey Min the author of the USB patch as he came up with
> the patch first on downstream. 
> 
> Alexey Min (1):
>   arm64: dts: qcom: sdm660-xiaomi-lavender: Add USB
> 
> Dang Huynh (7):
>   arm64: dts: qcom: sdm630: Assign numbers to eMMC and SD
>   arm64: dts: qcom: sdm630-pm660: Move RESIN to pm660 dtsi
>   arm64: dts: qcom: sdm660-xiaomi-lavender: Add RPM and fixed regulators
>   arm64: dts: qcom: sdm660-xiaomi-lavender: Add PWRKEY and RESIN
>   arm64: dts: qcom: sdm660-xiaomi-lavender: Add volume up button
>   arm64: dts: qcom: sdm660-xiaomi-lavender: Add eMMC and SD
>   arm64: dts: qcom: sdm660-xiaomi-lavender: Enable Simple Framebuffer
> 
>  arch/arm64/boot/dts/qcom/pm660.dtsi           |  12 +-
>  .../dts/qcom/sdm630-sony-xperia-nile.dtsi     |  16 +-
>  arch/arm64/boot/dts/qcom/sdm630.dtsi          |   5 +
>  .../boot/dts/qcom/sdm660-xiaomi-lavender.dts  | 383 ++++++++++++++++++
>  4 files changed, 407 insertions(+), 9 deletions(-)
> 
> -- 
> 2.33.1
> 

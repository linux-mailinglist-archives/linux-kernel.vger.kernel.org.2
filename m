Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C72D351288
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhDAJkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbhDAJjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:39:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970DCC0613E6;
        Thu,  1 Apr 2021 02:39:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so2500342wmd.4;
        Thu, 01 Apr 2021 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tVIUyZe1K8XZ+WdFPHcdsFBxCUN5Igt+uXBRDrDZlWE=;
        b=TQbrqEciyXKtf8PEikqo7E1hSDW3qgNmyiRsHCA0IIXASwSWq9dKlJDSXBgbbxh9Yb
         qrTWB13TlNzyDxfcV4I7H2ydX8tY+n4yfxrKwSn0Sosz1NhrkkBLdK+M/jyajOis6nxU
         CoGyDJ0uwhKx7wPlEqAiAqBwHlIskFI4aGdjZwVEqoCCksyHemkrkA9jS7m4H0M7h3i4
         oByH9G4/JrCeSrfuoIhL/hUBpa258Axk+OcDj7dRobCKkZL4SHD8l3bbGdDfgbaEsokq
         FCQllsuIhpCGSzd75LqM057WasNlA5VGaDhOQ9eQNFXVRotFu7DqHtmGM7W8pFDlMGpF
         wqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tVIUyZe1K8XZ+WdFPHcdsFBxCUN5Igt+uXBRDrDZlWE=;
        b=f/Z4OqHynzR+H9Ymyc+6KantCw5ItxUSgMNlSV7t/IiDaus5BisWMWg16+IEu0Vr9C
         OsoGNBGAla/vwrI7MBH8UMmf/fhparAcW+8r+UCWG7hl/sPwuSXnDtTM/SbHEl8kIO5C
         E9ulGKL5aoZPtF4HcuzYgM7KLS031gUwCpxjiR5QU9SGzP9ApwrAr8NPx6F9K+DIooy1
         aTYOk/J6XBwnFHax6I6h5Jp1lxTgDDEuQUqvHGFZWRfL34uPqR+O4f2B8XRLvuJBRbWS
         szOVRkJQ7WmDbsGmHdxd+OOZTelBf2qToJjXtztIGvK+yaH25fhCkPdzIR4K7U3tCST4
         LiJg==
X-Gm-Message-State: AOAM530yJXoVlBYAoNUoEkXRWGL7ErvZmj52crhCaIlmVXlXdVgwyKRF
        Czw/XWmcStxZ/2mVw4Rc8rtE2c5/b4r4Cg==
X-Google-Smtp-Source: ABdhPJx7tXV7KufYJm5L5rvaDt05s6UtrVE88LDnXjIDMF0Nxw4Ld9XUNphxkTLcDKYvBCBOoMccjQ==
X-Received: by 2002:a7b:c8d9:: with SMTP id f25mr7159186wml.157.1617269992414;
        Thu, 01 Apr 2021 02:39:52 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 81sm7908130wmc.11.2021.04.01.02.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:39:52 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mediatek: fix reset GPIO level on pumpkin
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     mkorpershoek@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210223221826.2063911-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <46f49f9e-20a6-ea3b-a3c2-2249cdd3613b@gmail.com>
Date:   Thu, 1 Apr 2021 11:39:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210223221826.2063911-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/02/2021 23:18, Fabien Parent wrote:
> The tca6416 chip is active low. Fix the reset-gpios value.
> 
> Fixes: e2a8fa1e0faa ("arm64: dts: mediatek: fix tca6416 reset GPIOs in pumpkin")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to v5.12-next/dts64

Thanks!

> ---
>  arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> index 63fd70086bb8..9f27e7ed5e22 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -56,7 +56,7 @@ &i2c0 {
>  	tca6416: gpio@20 {
>  		compatible = "ti,tca6416";
>  		reg = <0x20>;
> -		reset-gpios = <&pio 65 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&pio 65 GPIO_ACTIVE_LOW>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&tca6416_pins>;
>  
> 

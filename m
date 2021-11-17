Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B06454C19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhKQRlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKQRls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:41:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FAEC061570;
        Wed, 17 Nov 2021 09:38:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w29so6151453wra.12;
        Wed, 17 Nov 2021 09:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hlapG0bGMUbnY0IcRNw2GRZiC2RrS20AwBZINoQ1tJI=;
        b=FlYJwh30onWWJi7PWGlWug9KmlF1oYb5LxQW9kZLQ6GndUsLfnUFNqF20a8yqe2qj2
         Kqsx4SNZ8T6QpgMyRQXEm/YkWoEaTX74pz0iDFhMhDaEYqwwTMvQpH3qZGbQnSfkeVto
         CU6XeM6O/zSG0Guh0ygESppvQ1WELJYjyoQ3j+9z4zK+mI772iZcjxebsKMPnShXxcXG
         GrI3/7bMP/mpaC6hYFL0eSB3LjRrjMtlntjymcWVMVZczWIJDPlyeSC0kmxyOxF0t9P4
         578lq0yKFVg/L2kY087vjoYMXbeCqF/5szuBJf5ii+zgFLuhxID5nHQbpLmvzGbHpxXV
         BGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hlapG0bGMUbnY0IcRNw2GRZiC2RrS20AwBZINoQ1tJI=;
        b=pVZ4IHvNLp/AyKdJuqCgzjnVypaZprviTmL5VUkhorj1HRqS2BJHMkN3dv/ZCgm3Yc
         xsLvel2q8PqOVPlxQgU8vaXQ+MtgeadOiX4owL64pYYeyixdwBKe3v/o2bAUIwVkDJ5r
         PHpG+VCF9r+sXH4SeMMrYJds4ZS/rDCAPg1wzN1BZJz3TElF1tr35xOrpdjqolfISfk6
         YJQzs0iJ8N8QFnqTaCFyUmbdbbdTKyfln+jkqdnmFOFjAGX+NDwB5zt6k1vBUlFQGzRh
         G+RDPazQuhM4ZYseiTVh10IXFOOs6f3kWR5BFtfmZyTjq8CPTsEGsIpRzk99MmTXZPbO
         gOBg==
X-Gm-Message-State: AOAM531dopF/0Y+FFDr6qgtKcOl+meDgpXZF/0Q0xfFkh08Qws058KK4
        N2C5SOI1aiHsMv8s9C6tU6Wz7UIxqVk=
X-Google-Smtp-Source: ABdhPJz9P7PAxxJxRNPwbmIJF2yzDhzodKzDZn0xydOi7d/tAEMhYPpoY24kgJ6m5JiWQvvvjsWUrA==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr22175831wrv.12.1637170727724;
        Wed, 17 Nov 2021 09:38:47 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id c16sm455341wrx.96.2021.11.17.09.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 09:38:47 -0800 (PST)
Message-ID: <3171bb96-21c7-c629-4833-27618d4b2551@gmail.com>
Date:   Wed, 17 Nov 2021 18:38:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 1/7] arm64: dts: mt8183: jacuzzi: remove unused
 ddc-i2c-bus
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211110063118.3412564-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211110063118.3412564-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2021 07:31, Hsin-Yi Wang wrote:
> EDID is read from bridge, so the ddc-i2c-bus is unused.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Whole series now applied to v5.16-next/dts64

Thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index d8826c82bcda29..8f7bf33f607da2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -9,7 +9,6 @@ / {
>   	panel: panel {
>   		compatible = "auo,b116xw03";
>   		power-supply = <&pp3300_panel>;
> -		ddc-i2c-bus = <&i2c4>;
>   		backlight = <&backlight_lcd0>;
>   
>   		port {
> 

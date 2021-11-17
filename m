Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3AF454C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhKQRwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbhKQRwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:52:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEFCC061570;
        Wed, 17 Nov 2021 09:49:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s13so6277223wrb.3;
        Wed, 17 Nov 2021 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fiHs8iQnwarpgINjD3LQ7dtBIrw9yKtXyNgpZs7Iakk=;
        b=AtDty0Mm3zDKVilAvvCwgO4E4Q+I09avG4GOJdJYB6Kroa4IQkpgG/AOf493yJc+YA
         HgQS3uno8JyJtEAVclwbe6Jak/vD3wlzx7XzD01h6TaJp/ELBXOeMUdALjEpj1KGBogM
         GN8i8vUPxMHBD6F9uY1WGIRuwoHQVZypgtTRaEWj9uRx7ISS6IPS1YI+kc6xMMJZV2ID
         ub/ETmhxyWPcCjxIF8SSnZvoFmK+4JHOstg1lz1aCAnW0Cp4B8dMYwtlWKRc8EDkMeMt
         pstt+o9puDIjjy2x93xDF5mTMkozEegd1pYeNB4Cxldcpmv44HZRrfcT9AyJaQuxzCWI
         +Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fiHs8iQnwarpgINjD3LQ7dtBIrw9yKtXyNgpZs7Iakk=;
        b=OKyyy0LSCHF5jTcj7TIcRLaiwfMRCQUSpSEyejUPaOlmmE9luQZParJT/LtVq/7nUb
         Lnch6tNf7NaTmpbqDgqhlD6TFR1bkZmNh+7CNxQcZqWfGt1rcoa/ukNmvU+Vzx/N1gJc
         1aC9vEJSvj2ue33sx8V1i0z0mCMVIE5SZSfidg0fZ+rgpqpFqPmtHaDwGcoZdXgahIfH
         f3uOWAWTKtTKFw3m91AwMG0thzEdZuJqTkgHEaQKmvp4tqOU325+kqryx8qTrDyPvXR4
         49Oqm59+HgiW5KXOCgKpYOijgWYfOzQ3fY905aB6JTEbMncT6A7BFnTC3JPZeLqz8YXk
         8SVg==
X-Gm-Message-State: AOAM530AMd7tGeed0h75qFZUYjpOPOYrhLtJ+IuIH2+8z49ccOcqUvXN
        Kmhxr6fRMyK6720jnfy5qw4=
X-Google-Smtp-Source: ABdhPJyEaE48k1laWISx6Mz0Ip2Kud6SQkUsbpKJbrjEpkcvZPop620ByephU9M4Rl2b1ga5zVZwGw==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr21292351wrm.259.1637171362828;
        Wed, 17 Nov 2021 09:49:22 -0800 (PST)
Received: from [192.168.0.18] (static-160-219-86-188.ipcom.comunitel.net. [188.86.219.160])
        by smtp.gmail.com with ESMTPSA id 9sm808343wry.0.2021.11.17.09.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 09:49:22 -0800 (PST)
Message-ID: <003d475d-2dcd-ec24-0b9e-0cfd021f9da4@gmail.com>
Date:   Wed, 17 Nov 2021 18:49:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173: Add gce-client-reg to
 display od/ufo
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20211104135254.580257-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211104135254.580257-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/11/2021 14:52, AngeloGioacchino Del Regno wrote:
> In order to use CMDQ commands on these two IPs, we need to declare
> the appropriate mediatek,gce-client-reg for them.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Now applied to v5.16-next/dts64 thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index dee66e5f054c..2b7d331a4588 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -1212,6 +1212,7 @@ ufoe@1401a000 {
>   			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_LOW>;
>   			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
>   			clocks = <&mmsys CLK_MM_DISP_UFOE>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0xa000 0x1000>;
>   		};
>   
>   		dsi0: dsi@1401b000 {
> @@ -1316,6 +1317,7 @@ od@14023000 {
>   			compatible = "mediatek,mt8173-disp-od";
>   			reg = <0 0x14023000 0 0x1000>;
>   			clocks = <&mmsys CLK_MM_DISP_OD>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1402XXXX 0x3000 0x1000>;
>   		};
>   
>   		hdmi0: hdmi@14025000 {
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43751309C5C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhAaNfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhAaMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 07:06:34 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18BCC061573;
        Sun, 31 Jan 2021 04:05:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o10so9655067wmc.1;
        Sun, 31 Jan 2021 04:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v0b/jT8uow59KRDJ3NK3w5xUygKy2NFbbqo/fYBlRYM=;
        b=uomkcY1jaOREf+Ef0vgvkvxdl4YurWwwzR64z/k4ji+BEHTCZVWR7r5QMvINnPXOJi
         stmoDunj73CQkwRfK4PHC1l6/Dyjm0abVV141PQCoozKW8dhKpNfZf2WDr3ZhUFndqca
         WgxsfaTD/syMU8J9nm6wDdoZrL0aFDIB0HW8na11rJnmCxe8scrd8mltrlqeSxvcptXw
         my8N5Lzj93QvUO7iepzmq/fuXsNMlbKb2zhi7Kit3QzxjkGKekWXd0eLs31fTGVpDA4k
         SUBs3Pmf6aQMnwZp0y6tfV/2zFYNd7FDB3Dhi8TMIPCX+V8eRcw0EpBg6TOAkijbZ0cW
         J8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v0b/jT8uow59KRDJ3NK3w5xUygKy2NFbbqo/fYBlRYM=;
        b=kPyj1vxww/DldvbUBwkjD0f4p+o82nlv3VcPtmRCDrxaRkdY+d9XV8iTeC/IYlmkAb
         6dEqAiiziRzdEgkgYdjIOPTfCgEm6HYdl318jHwFhEtGOrUug79Zrg3L+5FAvjQ0nlga
         sTcF3e8/zHhR0zitGhH9mINqMoTYYbFi5HaKNHlEY6wHHDxT+Lg3SsuBDXHKbkglTBxG
         T4bPgaN22v71ZD6teJ7xYtGYfxM1P6R1Wxffi2xLJRyUFyi0No+Amz/7+yLSxotqrUmK
         avaqfgZdGMa6cn5nn1PXIVlLVTrWj8RBjIXL86rDVByXeoT7b17X/ewuMf0A6BtL+8n8
         mTmw==
X-Gm-Message-State: AOAM530rrceYDFPpLTe8r1hRH8kfhEUVHn1oM+2h9RDF82oUK3PUIbXC
        ZgEfmUCB4plXBIn8wKWWsso=
X-Google-Smtp-Source: ABdhPJxlS07j3c6dLmeXbsN+zp52vVioU438QV2mlNt+EExSKJp8SVHIg+XyGkoUZ6ILauY/Uuy5uQ==
X-Received: by 2002:a1c:ba44:: with SMTP id k65mr1572138wmf.25.1612094710757;
        Sun, 31 Jan 2021 04:05:10 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id u142sm18437559wmu.3.2021.01.31.04.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 04:05:10 -0800 (PST)
Subject: Re: [PATCH v2 3/3] arm64: dts: mediatek: mt8183: Add domain supply
 for mfg
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20210129101208.2625249-1-hsinyi@chromium.org>
 <20210129101208.2625249-4-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6d24fad2-84ac-1cd1-128b-cc36b115502e@gmail.com>
Date:   Sun, 31 Jan 2021 13:05:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129101208.2625249-4-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2021 11:12, Hsin-Yi Wang wrote:
> Add domain supply node.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

Applied to v5.11-next/dts64

Thanks

>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index bf2ad1294dd30..ebd53755d538a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -709,6 +709,10 @@ cros_ec {
>  	};
>  };
>  
> +&mfg {
> +	domain-supply = <&mt6358_vgpu_reg>;
> +};
> +
>  &soc_data {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5b782a4769e7e..bda283fa92452 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -360,7 +360,7 @@ power-domain@MT8183_POWER_DOMAIN_MFG_ASYNC {
>  					#size-cells = <0>;
>  					#power-domain-cells = <1>;
>  
> -					power-domain@MT8183_POWER_DOMAIN_MFG {
> +					mfg: power-domain@MT8183_POWER_DOMAIN_MFG {
>  						reg = <MT8183_POWER_DOMAIN_MFG>;
>  						#address-cells = <1>;
>  						#size-cells = <0>;
> 

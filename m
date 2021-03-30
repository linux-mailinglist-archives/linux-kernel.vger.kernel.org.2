Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C327234E351
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhC3Ikk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhC3IkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:40:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEB6C061762;
        Tue, 30 Mar 2021 01:40:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x16so15371467wrn.4;
        Tue, 30 Mar 2021 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KYFd8n1ROMP/PhNJKCkoXzuKMYVkHaAgxZobxYlBuxg=;
        b=HnYqDSBD571OkJq1AiWFRplK0UjsoINPaNxJpJYh2J8TRi458ayh2fssRYpp9lNwId
         5CN2CpkUyErY1kFHq8IIz/TMBLoknBZuJdKI3BFjn9gboLvt43GduHTe/qk1Pvgtqicr
         mcRpRN9RGv1f7GIb7xFYPpo+PYUYIoCtJy8bC5UgADUooE73MP3KjiDxRIs24MUb0nbP
         aY2wJHx/To2HF/sVeMTlwCLtcF6+P8GU0Kyh+Fxdt69nhDYkgLnRbLtflBax0W0rn/kW
         4eo1e8vYCaT83iAghW+CF5Yhbx8NHkxEfi3OIWo3h4sBBNMM7FT5MIa9sojIqpDUIXVQ
         N2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KYFd8n1ROMP/PhNJKCkoXzuKMYVkHaAgxZobxYlBuxg=;
        b=Hup6V0+f2XE99g+hy+qEuhmDH57L+2NlLx2tyHHu06fqt74kbHUGk3piFksdEHMC93
         NQAIRVXN8byL0p64h0Y0i8cQaLlc3JPzW5kvmrnVYfDiYPbBuF0FNjq5W+M2jfeGpV45
         Ttrx2nMT5g88BOySBEA17f7Ev08q7arU7FqgqNlwBCliwH9HcKXm+8y2YuH42Gwkotv0
         I75dJjKJ2WER8nN/35RGn/zWjSHDUraPFyoS2iFmyobzhA3n90fBho1fMKMEc0sYYgAs
         Cx8+AuuTMCYFIM9IbPVbM8TbClAVSHNa4aZAYRC84QA0jJ+aWviJzi55E5p/uw/3lmBY
         ha3g==
X-Gm-Message-State: AOAM5303/Q5V3B6Rg+OLeTKzrYeQ79AWXivfh/SCdf6Zo9S0thxILZZc
        hWJgErBmfAG2yKl+6EGXqE4=
X-Google-Smtp-Source: ABdhPJyj2XcA7fdSNLk3kTIn/Xyjsh1wmkHsRwu51iJjR0oVgv3IzGhb4J6aBkD0o2pgDPxxbawBXg==
X-Received: by 2002:adf:ea8d:: with SMTP id s13mr32590659wrm.32.1617093608360;
        Tue, 30 Mar 2021 01:40:08 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id v7sm2374395wme.47.2021.03.30.01.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:40:07 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] arm64: dts: mt8192: add eFuse support for MT8192
 SoC
To:     Yz.Wu@mediatek.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Seiya Wang <seiya.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
References: <1612151986-19820-1-git-send-email-Yz.Wu@mediatek.com>
 <1612151986-19820-3-git-send-email-Yz.Wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6dd478f3-d29e-0583-00fd-dc85d5a3a4ff@gmail.com>
Date:   Tue, 30 Mar 2021 10:40:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1612151986-19820-3-git-send-email-Yz.Wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 04:59, Yz.Wu@mediatek.com wrote:
> From: Ryan Wu <Yz.Wu@mediatek.com>
> 
> Add eFuse node to read Mediatek eFuse
> 
> Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>
> ---
> This patch dependents on "arm64: dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile"[1]
> 
> mt8192.dtsi file is needed for this patch.
> Please also accept this patch together with [1].
> 
> [1]http://lists.infradead.org/pipermail/linux-mediatek/2020-November/019378.html
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 69d45c7..4a0d941 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -422,6 +422,11 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		efuse: efuse@11c10000 {
> +			compatible = "mediatek,mt8192-efuse",
> +				     "mediatek,efuse";

We are missing
#address-cells = <1>;
#size-cells = <1>;

Regards,
Matthias

> +		};
> +
>  		i2c3: i2c3@11cb0000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11cb0000 0 0x1000>,
> 

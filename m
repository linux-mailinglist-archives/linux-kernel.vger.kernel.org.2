Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8734D5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhC2RXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhC2RW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:22:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203B6C061574;
        Mon, 29 Mar 2021 10:22:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z2so13648093wrl.5;
        Mon, 29 Mar 2021 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0gRNq2eAkLmvH+yhlKLcp66Rj3Ad23U42HOwmj/mbKU=;
        b=o5L/FHD2NRooZuUKXAkhJ9dRTYHC3RMSTsceG8wztcrJsP7EMSq7y5Crqjv8h2R6Yq
         O4Ugy7Zgk4scwcFGcajgSiAbLMJA4FseEr6YARUzJp5eAVgcBLMp+rbgFbEqNkttrGup
         FkpSJb6BgNvUbIE5GU4AzUoFvmYfQ/N2ufTfkO0IXNuq63NEdjIr6AfJ9L+CUYGhZpgU
         eo6q8qTKyShLEQCJwegudNC13GDvUADhB4ypmDfQnGa///GLjw8LqA3ewBNrDXFSlkQ2
         STj277reA/bn9I862J7kaP+aH/h2SYhPQPstdzPVBGueQpK9eb387ajVZiWI3nC2oUxW
         pyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0gRNq2eAkLmvH+yhlKLcp66Rj3Ad23U42HOwmj/mbKU=;
        b=WdDHrrAPS+IQAQcgs670O3hb5oRE7kGpLvlj51vkLlhS0voyBzK0+2/k40vbX0Sik1
         6OMGsRbpBzps220preLFkLpWtIDQZh+90DKjGz4xi+j96oIGD7Ruwn173b0XFG7oQ0kS
         McawhSOJpKWfVJKR4y+JE6ve4sB5pDcHyMnOrO6DD+ec5iQsUtUmXU6LoH4oi6T1eKFq
         5a0QjeekN/PgwzlnM2mQASFZKYaMIFDIPpgHl4fTYNTIm3zDjRTaJsWDN15cgAaHdRLw
         futK6hjo51oanycvYPX8Au1KlcU2tQpAVap08PdGEryBz8nLP8229ZPyZcfpvc/XxE9g
         6pBw==
X-Gm-Message-State: AOAM533nZsh+GWicNWwPPIAoFINbE83SfwvlZjOV9r4687AhJ4NNFe58
        VKRlePr7dPh6V+SO5xE8Ci4wXpfysTH8XBdQ
X-Google-Smtp-Source: ABdhPJy/EMYWJxvna4g7gKFWJ4d0RX84xR2gk+FxfoXe60VFXgHaTZBcoxtDpG19Q2rIIs8ws980+A==
X-Received: by 2002:a5d:4b43:: with SMTP id w3mr21801254wrs.406.1617038577756;
        Mon, 29 Mar 2021 10:22:57 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id z15sm29379926wrw.50.2021.03.29.10.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 10:22:57 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mt8173: fix wrong power-domain phandle of
 pmic
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1616048328-13579-1-git-send-email-chunfeng.yun@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <55dd47f2-f961-4228-a13a-fa90193f9cbf@gmail.com>
Date:   Mon, 29 Mar 2021 19:22:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616048328-13579-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2021 07:18, Chunfeng Yun wrote:
> Due to power domain controller is added, the power domain's
> phanle is also changed from 'scpsys' to 'spm', but forget to
> modify pmic node's
> 
> Fixes: 8b6562644df9 ("arm64: dts: mediatek: Add mt8173 power domain controller")
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied to v5.12-next/dts64
Thanks!

> ---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> index 6dffada2e66b..28aa634c9780 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -294,7 +294,7 @@
>  
>  &pwrap {
>  	/* Only MT8173 E1 needs USB power domain */
> -	power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
> +	power-domains = <&spm MT8173_POWER_DOMAIN_USB>;
>  
>  	pmic: mt6397 {
>  		compatible = "mediatek,mt6397";
> 

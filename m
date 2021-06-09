Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1533A0E05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhFIHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbhFIHsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:48:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4177DC061574;
        Wed,  9 Jun 2021 00:46:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e11so14136145wrg.3;
        Wed, 09 Jun 2021 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mfF8AjJH5axTBcPP0IxexexYabY3e1he3WLMrp8BjK8=;
        b=IgAZFn/WHkagwnBqkoL0xUnTvaGUW1R+i+upYBkYG/N35EWOwSaMkevwNHWNRqsV29
         DvxkVyuIMfd5rj0rgZDe/gHmtWveCrw1dxdNxy6epxsI9RrkRQXrKs+2/FMm/yCKiP8s
         GBsYM/gc11fh3z5yKSTZ5BTVQhikMHchjNlgN4pYkJbSSpcVQBGUDOAWKlMz+4FnAwWt
         yoEjqp2kHmPfLIrj1TU3vmtpPEadeYiVbq9e2QC67nxTCxWE0HDg6DOZvvy6iAMLXziM
         uFHOJthRSe9goTjZq7o7m7TiaQICvSymXVahJTyP++dum3sWzGw8xhOxYqWhMnELf+UK
         xzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mfF8AjJH5axTBcPP0IxexexYabY3e1he3WLMrp8BjK8=;
        b=VIOwtmDCp6kBkDA9GI2/Lx1pFOW4K+YRx3A9XCB/a13ZcXWGinTBka7fPn1MFWZzxi
         Vok+EFxYblxbLp4QHIMMssIx5FGFXdOEt7v53clE4w88uN2WP1Dslmrop2iWhwthsiyY
         +/eHeOHES86l9sw46EDl2z8WaPGYgxIG8Tyn0o/1Sc7l5ruu5oYAlNTMOkP4KNRRhhg8
         qzjVSEnPzslZrapYhLcLQJ8K+qaDtH9u5j2DwlU8tHhOfUDPb+b14cSj1A6tpzjboTBX
         0kHPYE7ZY3FkNNZYGvJkiy2V5h6he1J+u+SXDKD8m1oZVp0zgRolDnn3oQXo+o2nIhFG
         /rTw==
X-Gm-Message-State: AOAM532JCjMJv08QJY21iNDScEIEfH4meqd0q2XpiV1jLHkhug5UXjxD
        N95+hBi0Slc88RLo4lnDEsw=
X-Google-Smtp-Source: ABdhPJxwaNus7YWPn57nqY0Er0FpsC7q84dR0F9oofTVVONfuhFu7p/dA/7CkWaxhVWRofM1dNEAsQ==
X-Received: by 2002:adf:f54a:: with SMTP id j10mr26111411wrp.383.1623224805989;
        Wed, 09 Jun 2021 00:46:45 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id h9sm5571159wmm.33.2021.06.09.00.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 00:46:45 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: mt8183: add jpeg enc node for mt8183
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com,
        tfiga@chromium.org
References: <20210609044854.393452-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7a96166f-70d9-bc0e-72cc-53a8612741e8@gmail.com>
Date:   Wed, 9 Jun 2021 09:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609044854.393452-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2021 06:48, Hsin-Yi Wang wrote:
> From: Maoguang Meng <maoguang.meng@mediatek.com>
> 
> Add jpeg encoder device tree node.
> 
> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v2: rebase to latest
> v1: https://patchwork.kernel.org/project/linux-media/patch/20200914094012.5817-1-maoguang.meng@mediatek.com/
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index c5e822b6b77a3..fffe0c52909ce 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1329,6 +1329,17 @@ larb4: larb@17010000 {
>  			power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
>  		};
>  
> +		venc_jpg: venc_jpg@17030000 {
> +			compatible = "mediatek,mt8183-jpgenc", "mediatek,mtk-jpgenc";

We are missing "mediatek,mt8183-jpgenc" in mediatek-jpeg-encoder.txt. Would be
great if you could help to convert it to yaml before adding the new compatible.

Thanks!
Matthias
> +			reg = <0 0x17030000 0 0x1000>;
> +			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_LOW>;
> +			iommus = <&iommu M4U_PORT_JPGENC_RDMA>,
> +				 <&iommu M4U_PORT_JPGENC_BSDMA>;
> +			power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
> +			clocks = <&vencsys CLK_VENC_JPGENC>;
> +			clock-names = "jpgenc";
> +		};
> +
>  		ipu_conn: syscon@19000000 {
>  			compatible = "mediatek,mt8183-ipu_conn", "syscon";
>  			reg = <0 0x19000000 0 0x1000>;
> 

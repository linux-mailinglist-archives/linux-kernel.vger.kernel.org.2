Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77B33E0505
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhHDP41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbhHDP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:56:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0246FC0613D5;
        Wed,  4 Aug 2021 08:56:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c9so2792815wri.8;
        Wed, 04 Aug 2021 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gRPELMyvF9vRYWRJ3xMQSU8Idzl0x4DGYrIx0j0yc8g=;
        b=XDrLsgF8UjhNK1nH1zHBglqcihcCEbFJ5ETncYdXTQeOatntskwOoA6XwGhq+Wd5A9
         h2I0IVd7r+WjlvPOLzwjN7P5TcXeixdsCC1q7hSiF/mWS5WkUz9Po7UAscOWT4c0NRCW
         P5SaUDtp3uQMoF7dgIjgFEUB68q/5Lte1ug6zicLGVMO6uZD2n1j9YvgCRvXRNpEEObJ
         ElntYrOX1XsedwvKCRpi79IYbrjsE52/feIsQVUwkufZFEXJ1fpdZblg2XFrVGoVHEHg
         iZmNfusXWGm+dgXSGOZUTqYI7J1oRXilpQ7aVND4Dtur+qEaSje8KdYFkwcEsX2XPmmn
         gdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gRPELMyvF9vRYWRJ3xMQSU8Idzl0x4DGYrIx0j0yc8g=;
        b=QJme+p9SEClaOh55/oj1IYMyMKFMj9DqDOYoQ48s6OKf8bY/N7xBCV6htIJluwW5IK
         2oEVHlQLVyB352Z4+dRHs1tPlpEo/Ze+/qjZRLFJYwZfYBojNZROuDWNaNABy2Q8VDN7
         Xste9YajnOPikV4lWDOM2xEPoaYIDyyFaPZ6MzVCZsD3ltw+j3Omjk79nRpHnRVxM/VD
         aVY47Kvt1OUWWfEuzuaMJqkAL7k3DO9bLOyRb4tuY7430k8dogckPjWHS2u3txPQbBVF
         rhqfIIdruZq5XeC9GFnr21xtOTDIa356WQYVbN/pYqOvm5DWl/sJbLRdnSAQgvWSs4mD
         jqtA==
X-Gm-Message-State: AOAM533WPFeIcodcU43zis3Odb76wDcigDYcYAnBSArBvQqx6uJ8tK6u
        GEFSo+c+7nRPg/gDXzJVpGG+bZwewU2B9Q==
X-Google-Smtp-Source: ABdhPJzT0RsZE0QP/IGJleF9Q/yp0CofsPObSNSKu1mCiX7KGz2wisGPE0W0Y8jIxdNUmg9Ui6IRbg==
X-Received: by 2002:a5d:4521:: with SMTP id j1mr85665wra.44.1628092569603;
        Wed, 04 Aug 2021 08:56:09 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id g5sm6132769wmh.31.2021.08.04.08.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 08:56:09 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] arm64: dts: mt8173: elm: Use aliases to mmc nodes
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        eizan@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210727111502.2506311-1-hsinyi@chromium.org>
 <20210727111502.2506311-2-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <044b85f1-dd05-19c9-f9ee-17e620699733@gmail.com>
Date:   Wed, 4 Aug 2021 17:56:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727111502.2506311-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/2021 13:15, Hsin-Yi Wang wrote:
> fa2d0aa96941 ("mmc: core: Allow setting slot index via device tree alias")
> allows the use of aliases to number SD/MMC slots. This patch use aliases
> to mmc nodes so the partition name for eMMC and SD card will be consistent
> across boots.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index 21452c51a20a8..d5a2cad39c9c7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -10,6 +10,12 @@
>  #include "mt8173.dtsi"
>  
>  / {
> +	aliases {
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +		mmc2 = &mmc3;
> +	};

I overwrote v1 of this patch with this one. Both of the series are now in
v5.14-next/dts64

Thanks

> +
>  	memory@40000000 {
>  		device_type = "memory";
>  		reg = <0 0x40000000 0 0x80000000>;
> 

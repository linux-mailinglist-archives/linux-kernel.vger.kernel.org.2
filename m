Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD213551FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245478AbhDFL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDFL1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:27:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236A3C06174A;
        Tue,  6 Apr 2021 04:27:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso9472877pji.3;
        Tue, 06 Apr 2021 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0nl9ZrgfpiKLj46y+3Cq9Nc86WR3X09T55IAR3qxOrk=;
        b=cGDnYos5h6dADjPplnotwdgqNA/r5PILJu1HlpM8gX87f4BYgPja5MLZlQvxv7LFUF
         X9P0MHPhO1CDSTV4px2eAwE5VPTno2m8mLVwISisGJSlqmsWbBPdIXj9vSpph/fIbBmr
         gzy7kxFtwjRFXJJdXiCHPus98QcMjBSvLnChXkNdS99ECHr4dY1q9oQuucZeFa63fynB
         Itv+i4CLU248afuB0UomQ/YFgQNAQ9I2cTllLr0tJGpNUnfb8V//ZKqrp06nFdB75prN
         LigKWWsRipHhNNZLbWsY7s5TnafimYPnb14M4jULw8uFTsup4K8J7BoGJOQtpENul/xm
         aEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0nl9ZrgfpiKLj46y+3Cq9Nc86WR3X09T55IAR3qxOrk=;
        b=hF3k8Sj8fQHLT4d/sXqV439xFvg7eUTeDZroI6HfsSpS285TPN+uQ2w2lEtMpizV+A
         k49MikxAK0kctEqbTbOR5yc3ckgHQBpxw8+LVH3wr5ttzGIHP4NVD6ZePVbOgU1l9xdj
         6Tyt2RhOo/acN2+mSk77RkoDaKTZo7ldYe+/87T1jhIO0tB16ZCPJ3nRWYFrr5+vk9iw
         fdakMpWpa0uOcYhL68XgUAkCqE3pYLfFBtdsI0QHkghbwFDHjCb+0hhDoeqbocTIHIio
         lVBZXWbm5XFmDcniy1AoOg8XqAI2E43Gc77A7tc8Bv5s7cpZAsAaetSO8ygCXl+rSLr/
         dD2Q==
X-Gm-Message-State: AOAM531Nobl3aXGCC7r+UO5J+U+xsgVFtmiET5Hs3aa4SGlgvjJTB+IA
        Dy/Y7gCNm05REoxknBpywesDKDXx7vjphg==
X-Google-Smtp-Source: ABdhPJyQ6B8vTSf8Z5mEQkYzxaMAT4FMUE2Ck4VgJ7zcWxG1OijT7Vv7Bx/6/xFLSYzuhFp1XdOHUQ==
X-Received: by 2002:a17:902:6845:b029:e4:4d0f:c207 with SMTP id f5-20020a1709026845b02900e44d0fc207mr28463995pln.36.1617708432583;
        Tue, 06 Apr 2021 04:27:12 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id q5sm1939239pfj.131.2021.04.06.04.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 04:27:11 -0700 (PDT)
Subject: Re: [PATCH 1/5] arm64: dts: mediatek: mt8167: add mmsys node
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     mkorpershoek@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210405200821.2203458-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <0cf78980-5e3d-20f5-87cb-cc2488071211@gmail.com>
Date:   Tue, 6 Apr 2021 13:27:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210405200821.2203458-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2021 22:08, Fabien Parent wrote:
> Add node for MMSYS.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to v5.12-next/dts64-2

Thanks

> ---
>  arch/arm64/boot/dts/mediatek/mt8167.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> index 156fbdad01fb..9d765034dfb0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> @@ -125,5 +125,11 @@ pio: pinctrl@1000b000 {
>  			#interrupt-cells = <2>;
>  			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		mmsys: mmsys@14000000 {
> +			compatible = "mediatek,mt8167-mmsys", "syscon";
> +			reg = <0 0x14000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
>  	};
>  };
> 

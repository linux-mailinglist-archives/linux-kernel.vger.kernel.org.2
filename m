Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA1F35521A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245614AbhDFL2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbhDFL16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:27:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F01BC06175F;
        Tue,  6 Apr 2021 04:27:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so7497390pjv.1;
        Tue, 06 Apr 2021 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+rth/nHmUnQf52riud1YrL6q82iGG5PK/8trv5J4+co=;
        b=QTIqZ2H783z+wmwRtAW+O3ePO+S1h2eZwzAdqRclTNeG1gobwoxvN5u1KB+0XkSJ3L
         OI0CIQM+8psTIc9F6J4Lo6rl4YrXY6ahpKJjdRIYJaf3WJEvJmKtJojOGo9RCLJddNtu
         YyTafE463KKoheLn1OuDAtJsgxqrseHlEAhOxxYO0kNbf3EVzpJgN3hcQfKur0YG1Ccu
         RnOdyBeoj7TYnLyk9EVwxK+k/r80jIZqGs2Tt5TILpjrjlxzhgrn473mkPZZ3SKqeoa0
         mInDD4/+7cVG1wr4GFd7h+/7Y1zhtG9GFF7bDMt//OQRlRxXJnJTY5GgtjfkH5cmc9uU
         nzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+rth/nHmUnQf52riud1YrL6q82iGG5PK/8trv5J4+co=;
        b=WyTLE73nqNMzZ7jhFffXUtnTPguB2/NKQpBKXIuJGrYkyZpQ2L6om0jasMNIlxHhwg
         pCMl+On4TvDZAR00RBQwDo+R44JABEUzEPrnsDQKenFwMEJQWNRtv6VPYBDqNKh5ety6
         QmpaLlxp/zK3Qdviem0bLOxjHwaRxcCS8RMmq9W4gz+X5NCpO3RQYCPWEIQSNV3I5N0i
         wenk3mrgCeW2gC1GOzcBQdJafBebKb/F7oWDpNmq3tT0nI1Y6NzMxAD2NZoH5+baO33F
         PzqNqLF+9pZENRFOeoZF19jMQrl0yZ+46w5jaj6RhV5mD6gG5f149ggMGGjApCOsU8TH
         TZKw==
X-Gm-Message-State: AOAM532ZiUDzoCvcbMoSZjM/UWq8ayLfS816yMqE+tgVihG+QOQeRAcT
        cpERIjKC6H97BKtw+9Y1uJsmCxS4/yMssQ==
X-Google-Smtp-Source: ABdhPJyvoEXh04NDqgmeAqYNOK2QcjgSNeGxNjKk7DJIxgYVXlDz44TWqvfoyfnBKXsrBi2y17O1Dg==
X-Received: by 2002:a17:90b:1198:: with SMTP id gk24mr3906181pjb.73.1617708470692;
        Tue, 06 Apr 2021 04:27:50 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id l191sm2330684pfd.36.2021.04.06.04.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 04:27:50 -0700 (PDT)
Subject: Re: [PATCH 2/5] arm64: dts: mediatek: mt8167: add smi_common node
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     mkorpershoek@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210405200821.2203458-1-fparent@baylibre.com>
 <20210405200821.2203458-2-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d3251cd0-784e-da8e-6065-edd2cccf3e9c@gmail.com>
Date:   Tue, 6 Apr 2021 13:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210405200821.2203458-2-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2021 22:08, Fabien Parent wrote:
> Add the smi_common node.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to v5.12-next/dts64-2

I'll leave the others for a v2 of the series, as there a small comments.

Regards,
Matthias

> ---
>  arch/arm64/boot/dts/mediatek/mt8167.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> index 9d765034dfb0..4b951f81db9e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> @@ -131,5 +131,14 @@ mmsys: mmsys@14000000 {
>  			reg = <0 0x14000000 0 0x1000>;
>  			#clock-cells = <1>;
>  		};
> +
> +		smi_common: smi@14017000 {
> +			compatible = "mediatek,mt8167-smi-common";
> +			reg = <0 0x14017000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_SMI_COMMON>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +		};
>  	};
>  };
> 

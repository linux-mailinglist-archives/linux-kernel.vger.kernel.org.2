Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78256309BEA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 13:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhAaL6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 06:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhAaK1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 05:27:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559AC061573;
        Sun, 31 Jan 2021 02:26:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z6so13314734wrq.10;
        Sun, 31 Jan 2021 02:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NaDh0905GAPbuSjX0aob8gywlf+7SCUQGWq6wwIujR0=;
        b=M0pPLORKbh/3wLjb6w21AQTRqovtiZxuylFL5U+2MRUFO10hieXqDPzX/U+2w7b9Ng
         F17dZYh+SqP7A6uPqPCyeiVQmad5EpZrbyC6IFJy7GK7FvdLB/bbBXI6P6B0fDLlyE/D
         r2tk5+1M/9mWVDKc5u9L44dUmI+6AyrA4KkcPbhK/8UDvVIfvX6FMlmMypDpaKmrDJdV
         K+fsfldiVrs+VuqkgaD8Q7GOD6eTBzGnqTXxNpbdYAwhRagfoGMeamdw+r1wkZUNl2gX
         6nUQcJksuaA/FkTLhmuqDp6BO1HcW0Bxo3qvHpQOjK+ulWhDiYFY0JJyUfzYgSyWkAHo
         i9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NaDh0905GAPbuSjX0aob8gywlf+7SCUQGWq6wwIujR0=;
        b=bM9pf7HwgME17UymwiIoN/s1Dpw/Oy0yXYacJWggeZjMaBhbTqjIQYaNt73esfS4k4
         OX+3upYWbCtE/Up+iN0mMsBuJTNlSgjRMA+PMD55CopUL1iT8i2xGJuPjdqoMtfe88bi
         NXWIUerLnIpdnuMvXD7Z60TqdrgADY3A+/Av2jNrKjPUHifbG1eDA6tBwKdrMPF3lmxD
         aKAeZSz3O70p3/ChVxLYp6z8A7jSjAep9DSztySeETeeL4g1pkCwP2RbID/a9W9WZ3ZM
         tctOhcOyxNd3nXRjD8xw3d+R1ZoOE4uY5ZMXITPPy5OgUx3zJ+cS7PF3J9dCSPLS9HG8
         8W1w==
X-Gm-Message-State: AOAM530FLnWWkb1SnXIwDWAs7vRBunEM7N3pZUYVUU3gqU7tdSRrYjWB
        rCATWCr5OYVckuqfWla8yqk=
X-Google-Smtp-Source: ABdhPJwPqCv/KSnVrMQa+fEvnvj2OwSAiy/q0hJWsVjIgka/Vrdny4An1cuW6cGOuxIyRn5wVf0VVg==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr12628137wrw.276.1612088811026;
        Sun, 31 Jan 2021 02:26:51 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id s4sm17642913wme.38.2021.01.31.02.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 02:26:50 -0800 (PST)
Subject: Re: [PATCH v1] arm64: dts: mt8192: add nor_flash device node
To:     Bayi Cheng <bayi.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        srv_heupstream@mediatek.com
References: <1607589283-31225-1-git-send-email-bayi.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <174ae215-38a1-0bb4-ad72-a3f59d35f2ad@gmail.com>
Date:   Sun, 31 Jan 2021 11:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1607589283-31225-1-git-send-email-bayi.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2020 09:34, Bayi Cheng wrote:
> From: bayi cheng <bayi.cheng@mediatek.com>
> 
> add nor_flash device node
> 
> Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Applied to v5.11-next/dts64

Thanks

> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index e12e024..b15b0d3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -379,6 +379,19 @@
>  			status = "disabled";
>  		};
>  
> +		nor_flash: spi@11234000 {
> +			compatible = "mediatek,mt8173-nor";
> +			reg = <0 0x11234000 0 0xe0>;
> +			interrupts = <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>,
> +				 <&clk26m>,
> +				 <&clk26m>;
> +			clock-names = "spi", "sf", "axi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disable";
> +		};
> +
>  		i2c3: i2c3@11cb0000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11cb0000 0 0x1000>,
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E814E309C61
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 14:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhAaNkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhAaLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:39:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125DAC06178A;
        Sun, 31 Jan 2021 03:24:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c4so10755398wru.9;
        Sun, 31 Jan 2021 03:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sPEAzuPd0U46yDR7p0D1tm0palbouXVPREQNLM1oWFw=;
        b=U9hjySODiFdjzCwIcgif1abuJjI54ZesRA0AcXHLKWoXhA/j4Hq6JV5Hu77Fr9fcbp
         Q8bLTSV2nFjzeaGVfHcnSxSHhf7mPCNWtJt7DgArqPi8pkyv6rsCGaXHix+YVe47e9ZY
         GYTAIY9bsWhcobBgIiUzNJRtK6oP0JI3Dazabb1R5z5WL9YiRfnPTXQKm7jeeyAKGOJ1
         48dWBH/liP3uhstF9zLTq35c1YY0F6phwD4hPiy13WkxW4J3DEkle+0OBLUucjUAegga
         M8JVpYHkVObwGlBD847Od8EKHbE3EI9ATSOPTz0eS4mXwE1EkamLshBh3yMtVjz1jl7+
         Phiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sPEAzuPd0U46yDR7p0D1tm0palbouXVPREQNLM1oWFw=;
        b=beXREXleluAT8AnSHM6+piExQx/9TRr4IQYw66d36whzovyg4X9gClCy+uJP0mxF4x
         7GD3vtreG+eZc1lCJxUYbtglaRc9+puGQAzY6yhlhFPvYYfiLkhrUVny2IOyCYcvjR73
         nGTRGRDNPrjdLOPOCuP2idgglZ9ztVca215FM/Uk3L0QseESUhf5XKQ9m2ScU0LLtHKW
         R/uFNvBUEv9oco71SXNER6HnCGuo+5xVSeTVZ1ltg10kC7tTCFSwaH2LiDcNRtDmaukX
         w8KJNNzo/9ABjgP9MA6KIy/onSc54ggHQxyAc17lwIhKV9dkpksn920Z7aUqqLpPvE1E
         wNOQ==
X-Gm-Message-State: AOAM530cM2q+VZ1iW2gJHDSl3sAZ7kZ9OIcHRCdXeQME8QNUCxCSar9e
        Oh1PaxbB2Hq8hgsTFqnd06Brf6bmFj1nqA==
X-Google-Smtp-Source: ABdhPJywD2RlNEGfn4nrsntu2FQvdDtyTnJsz+DOFfYuZswbHI1mWY5nPPrV9RQ0NRrTF7D3sOjkRA==
X-Received: by 2002:adf:c6c1:: with SMTP id c1mr13262458wrh.326.1612092286997;
        Sun, 31 Jan 2021 03:24:46 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id m8sm22899025wrv.37.2021.01.31.03.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 03:24:46 -0800 (PST)
Subject: Re: [PATCH v2] arm64: dts: mt8192: add nor_flash device node
To:     Bayi Cheng <bayi.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        srv_heupstream@mediatek.com
References: <1608697379-22025-1-git-send-email-bayi.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9d395f32-ffbe-85a5-a424-4778e8d8bc1f@gmail.com>
Date:   Sun, 31 Jan 2021 12:24:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1608697379-22025-1-git-send-email-bayi.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/12/2020 05:22, Bayi Cheng wrote:
> From: bayi cheng <bayi.cheng@mediatek.com>
> 
> add nor_flash device node
> 
> Change-Id: I79f0228529bd8a33e5f354b7a861a4ec8d92e9ba

Applied to v5.11-next/dts64
I dropped the Change-Id. In the future please make sure to not include this tag
in upstream submissions.

Thanks!

> Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
> ---
> Change in v2:
> 1: add dependent patch of arm soc
> 2: change compatible name
> 
> Depends on:
> https://patchwork.kernel.org/patch/11713559/
> [v4,1/3] arm64: dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index e12e024..751c877 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -379,6 +379,19 @@
>  			status = "disabled";
>  		};
>  
> +		nor_flash: spi@11234000 {
> +			compatible = "mediatek,mt8192-nor";
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

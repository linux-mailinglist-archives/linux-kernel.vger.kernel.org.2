Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D854309D76
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhAaPXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhAaOcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:32:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65DC061573;
        Sun, 31 Jan 2021 06:32:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 6so13766455wri.3;
        Sun, 31 Jan 2021 06:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u2p9+7+7O3j8QCS3+foDXHLNj+iaoO85V7bwiF9fy30=;
        b=FO08rDicnaTDsxhiB5v/qJIBm3pbFjzH7ETT/pzqZOda5AprJZ3nZeUwQWkDUSg7aD
         Rjc9ShRyP7wI4qWxvxHoGfb6/V9ILwRJvreq15vw5hQW+lAhV2K4PFihRwbyx3Yl9Het
         usGuPNqhiSQR7d3uSi1Oo/4krOQA3LFXIIbgbogMGOx0hrGIyLCclVYcyWHzaWeJeirj
         qftpDW5SUhcEo1OHgbXhLBWEY5hvuGt/2N6qA1MNcjMUp9unwd8tlrrWulWkLR4sf1qO
         cBppl8/Z0+yBbyofi2nlOQCCGitO0WSZ3deezaNoXOx8+vcvrCJgfmKunj2RkNW4N8DW
         XbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u2p9+7+7O3j8QCS3+foDXHLNj+iaoO85V7bwiF9fy30=;
        b=bMXjr/l9fEcRX8SHIOZE26EX12PDYFRrZjky4+K5fEDRCZhg6JPT9TfPVNzqiEX7ZG
         Lvw7cvEPa+rleVuk70i0Do/IQvUriBY0Szeyor+4uWArcE2N2Ts+wzhGO2IWNr6cVUzk
         MOV0G3PdPBgaGufGbZQoworGl2qsovyGQXXAKn88TeTtyooBiLcz5qUVD9NfYjXeQ1AG
         WF3WGbAulO0rvKVI4NgNwsCSEAoD+afjUJf2NS1hGDM/Te+3Htvpp6rdaoH888FqWXgC
         sEQk9x8lEM+qcFEmTWNvGdVeyzP1q7nLxSNd/BqGaNF5+955Uqn3WH7Cqm4GS+ClwyE9
         R2pQ==
X-Gm-Message-State: AOAM532+8PaI9rOs90R+NccogkXwfuNKnPJCSlymbRd3eiGsvmDpmINt
        cZssx301ewtPtzRZiN6PYIR8XHxSThdhgqhf
X-Google-Smtp-Source: ABdhPJzDnMQ5jDcOS5dGgIxQjELPxV7neVGid5dyYDMkcc8+kOxTX34EsMSriWbwZaN8hN7Be0Rn6A==
X-Received: by 2002:a05:6000:1542:: with SMTP id 2mr13905291wry.356.1612103525160;
        Sun, 31 Jan 2021 06:32:05 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id y63sm18399305wmd.21.2021.01.31.06.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 06:32:04 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: dts: mt6779: Support pwrap on Mediatek MT6779
 platform
To:     Argus Lin <argus.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, agx@sigxcpu.org,
        Max Krummenacher <max.oss.09@gmail.com>,
        wsd_upstream@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1609747703-27207-1-git-send-email-argus.lin@mediatek.com>
 <1609747703-27207-2-git-send-email-argus.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <61ed414d-3b93-3620-0075-a75734287e30@gmail.com>
Date:   Sun, 31 Jan 2021 15:32:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1609747703-27207-2-git-send-email-argus.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/01/2021 09:08, Argus Lin wrote:
> Support pwrap on Mediatek MT6779 platform by adding pwrap node in dts file.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---

Applied to v5.11-next/dts64


>  arch/arm64/boot/dts/mediatek/mt6779.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> index 370f309..2c2ca33 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> @@ -189,6 +189,15 @@
>  			#clock-cells = <1>;
>  		};
> 
> +		pwrap: pwrap@1000d000 {
> +			compatible = "mediatek,mt6779-pwrap";
> +			reg = <0 0x1000d000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_PMIC_AP>;
> +			clock-names = "spi", "wrap";
> +		};
> +
>  		uart0: serial@11002000 {
>  			compatible = "mediatek,mt6779-uart",
>  				     "mediatek,mt6577-uart";
> --
> 1.8.1.1.dirty
> 

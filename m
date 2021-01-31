Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87542309CCB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhAaOTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhAaNcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:32:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03121C0613ED;
        Sun, 31 Jan 2021 05:21:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v15so13679228wrx.4;
        Sun, 31 Jan 2021 05:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0BUjyqHXzTahesh3UWBPadF55bKBa14X0UJs8MXGpDM=;
        b=TsVfIMpC8LZ4V9OoZ4aW0FAfHNFvnED7zocoTBRmGfH5m2Yixvoec3qfdRoXOHMt8Q
         h/sgUdoWK+qX1ZF+g5Lg6hsSVGMolMlQHyPG1y8UEOI1+ecQQe+zGmVyZOSPJdaeNX6k
         kA5uqnsdmp33+UcdFBa4hBrUoXu4Dy77X9DRsNeuyZ9T9l0CJLENyefO+RJ9oIDpfpkG
         CSH31n+x48RX7NoGbuZs9qAWxaL4EAiz0VdDaUuqAM7ax22YdHr6ed/Qw6NyhbUN94Be
         IsnHeOWWpUSCsIFwJ527oEWMlZgVvp2I0IVFS/AwXWUqyOqGLfpESL3Qrlc9vHmMdV16
         d2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0BUjyqHXzTahesh3UWBPadF55bKBa14X0UJs8MXGpDM=;
        b=SbHHlqEn/WrFRyKgfHHaBFD8y0FWAal5kf3s/aCzrGsiSZXK2ibrxwcEwcINCjFmyP
         PcHzJVgrnyuDZ9GKSwFuB2feNDLlQbcnRehhXBEHbPZ58snY0xWIqc1YDKZ2bE24Inyi
         xqCz8ZnI+HgSsn+7wWggeE+dHNz0sXt4rHQfe7QSspBpPlL972dpOiN6N1UboQBRPuGz
         3cihQlejco+0iagHV1Ra2askoUm8/26L2vXji+r11WG/80VUNz6R0gDMKMiApLgZjqYs
         nQixDprjfttH8bE+kiyBJ+0Xe/igwyGCC0o1B7t0sHPswLAviOjZ/wZuSOJ4gvC6czsJ
         sfjg==
X-Gm-Message-State: AOAM532FO/cf36Y2oyQRZVUzY6utOmS0FJvOIUWug3FrmJTf9pM99JJn
        iTIjm82yB3PNPBLzZubjuGk=
X-Google-Smtp-Source: ABdhPJy0SaGhOtT7euyMaNJaNg/su8sZasDemn07l/BGd9kdQSCspm6fUrc1tQOVVz01Iul8wBsEpA==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr13705099wry.254.1612099278636;
        Sun, 31 Jan 2021 05:21:18 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id v6sm23001839wrx.32.2021.01.31.05.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 05:21:18 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: mediatek: Add Mediatek mt8192 cpufreq device
 nodes
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     srv_heupstream@mediatek.com
References: <1608521814-13017-1-git-send-email-andrew-sh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c1235c38-55c7-6978-0c92-a94dbe523f5a@gmail.com>
Date:   Sun, 31 Jan 2021 14:21:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1608521814-13017-1-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/2020 04:36, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> This patch depends on [1] and [2].
> 
> [1]http://lists.infradead.org/pipermail/linux-mediatek/2020-November/019378.html
> [2]https://patchwork.kernel.org/project/linux-mediatek/patch/1607586516-6547-3-git-send-email-hector.yuan@mediatek.com/

[1] is already upstream. Please resend after [2] is accepted.

Thanks,
Matthias

> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 69d45c7b31f1..770f7d8833db 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -39,6 +39,7 @@
>  			compatible = "arm,cortex-a55";
>  			reg = <0x000>;
>  			enable-method = "psci";
> +			performance-domain = <&performance 0>;
>  			clock-frequency = <1701000000>;
>  			next-level-cache = <&l2_0>;
>  			capacity-dmips-mhz = <530>;
> @@ -49,6 +50,7 @@
>  			compatible = "arm,cortex-a55";
>  			reg = <0x100>;
>  			enable-method = "psci";
> +			performance-domain = <&performance 0>;
>  			clock-frequency = <1701000000>;
>  			next-level-cache = <&l2_0>;
>  			capacity-dmips-mhz = <530>;
> @@ -59,6 +61,7 @@
>  			compatible = "arm,cortex-a55";
>  			reg = <0x200>;
>  			enable-method = "psci";
> +			performance-domain = <&performance 0>;
>  			clock-frequency = <1701000000>;
>  			next-level-cache = <&l2_0>;
>  			capacity-dmips-mhz = <530>;
> @@ -69,6 +72,7 @@
>  			compatible = "arm,cortex-a55";
>  			reg = <0x300>;
>  			enable-method = "psci";
> +			performance-domain = <&performance 0>;
>  			clock-frequency = <1701000000>;
>  			next-level-cache = <&l2_0>;
>  			capacity-dmips-mhz = <530>;
> @@ -79,6 +83,7 @@
>  			compatible = "arm,cortex-a76";
>  			reg = <0x400>;
>  			enable-method = "psci";
> +			performance-domain = <&performance 1>;
>  			clock-frequency = <2171000000>;
>  			next-level-cache = <&l2_1>;
>  			capacity-dmips-mhz = <1024>;
> @@ -89,6 +94,7 @@
>  			compatible = "arm,cortex-a76";
>  			reg = <0x500>;
>  			enable-method = "psci";
> +			performance-domain = <&performance 1>;
>  			clock-frequency = <2171000000>;
>  			next-level-cache = <&l2_1>;
>  			capacity-dmips-mhz = <1024>;
> @@ -99,6 +105,7 @@
>  			compatible = "arm,cortex-a76";
>  			reg = <0x600>;
>  			enable-method = "psci";
> +			performance-domain = <&performance 1>;
>  			clock-frequency = <2171000000>;
>  			next-level-cache = <&l2_1>;
>  			capacity-dmips-mhz = <1024>;
> @@ -109,6 +116,7 @@
>  			compatible = "arm,cortex-a76";
>  			reg = <0x700>;
>  			enable-method = "psci";
> +			performance-domain = <&performance 1>;
>  			clock-frequency = <2171000000>;
>  			next-level-cache = <&l2_1>;
>  			capacity-dmips-mhz = <1024>;
> @@ -194,6 +202,12 @@
>  		compatible = "simple-bus";
>  		ranges;
>  
> +		performance: performance-controller@0011bc00 {
> +			compatible = "mediatek,cpufreq-hw";
> +			reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
> +			#performance-domain-cells = <1>;
> +		};
> +
>  		gic: interrupt-controller@c000000 {
>  			compatible = "arm,gic-v3";
>  			#interrupt-cells = <4>;
> 

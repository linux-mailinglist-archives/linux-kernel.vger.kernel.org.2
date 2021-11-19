Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF20456DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhKSKlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhKSKlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:41:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40CFC061574;
        Fri, 19 Nov 2021 02:38:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso10104823wms.3;
        Fri, 19 Nov 2021 02:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QtA7B3OppLxMsQFCLEypGqTxZJM9PfVKbPN7FBqSKVA=;
        b=QCKvKb228ZQS/w7qvoX0rrvOWiqVfykx8wBtcJbNxo9kGe91M1urHDE/JENLaW7jMe
         98NakgGsBPzkzMYfgdc5fkfNITEPhp/jRigeBwQeTJ1ZHD2ZAxysUZxcgvbGn9z5diIc
         kyq2hscMGd7CxUyIXilW3QQfp164uVDDt4vUBJebed3E5NIKWCKx3i+HmLo4P62D1hK3
         4vhG5DcEMucRevuswlir07+jvWkrSXk/vKTh48r6HxQRRW38usAog99y0VMe9YExo1T5
         eMwLlbx5MnY7PDWtrFj7APWMGObUgeC3ygJVCk3jABnCNaAjBiQpeUPiCpNAy6ai29xK
         /RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QtA7B3OppLxMsQFCLEypGqTxZJM9PfVKbPN7FBqSKVA=;
        b=btoOYUDqUEdedE/XFaYlr0TSshb/IAYpd+60Svw6CxDYPs+dePvN+TKmG2HNi7g80V
         kpKZRRIGudzg9DaWPnzHyefL0YHzuI5mTqCqS2Xe/F6cYGKidFlWElhhbKrzPtq9n9Uk
         J+0xzIlsRBjgd1dzOVRTcRXUpM91p0Sm/8c7M7SMjtnJcXTu5Rhem/vwCvqt0tZR8e9u
         YQe4BlmWwAV8gnt5/DoaPY3SgyoC/DVfYsLD/5prZCcw8uP+3iFb4KFGzcL4MrEIcATi
         xzdbrCYhtEoD/MzUbFSvuhYDBIRjiTRW1kb64+KU3WwvntKO55ODblgWkYBvP8D0P2J3
         g56A==
X-Gm-Message-State: AOAM5336m2mrPZgljx48AxJp+aDKOCl9tnI6vRJOKCrjZfjn8Z3+Qmfl
        Y5iOSIQaPJzQlNgrVR2OxUs=
X-Google-Smtp-Source: ABdhPJzHgRy4bZNWJW5/fNsaV5sUrjkOLCir646W22JSvcC1grDH5KucDPgbH2KABAbGzf8UdyQzcw==
X-Received: by 2002:a05:600c:1f0c:: with SMTP id bd12mr5513469wmb.56.1637318294484;
        Fri, 19 Nov 2021 02:38:14 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id g18sm14709725wmq.4.2021.11.19.02.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 02:38:14 -0800 (PST)
Message-ID: <e840f54f-ead6-838b-4433-39cfd309d930@gmail.com>
Date:   Fri, 19 Nov 2021 11:38:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RESEND v2] arm64: dts: mt8183: support coresight-cpu-debug for
 mt8183
Content-Language: en-US
To:     Seiya Wang <seiya.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <20211102090230.25013-1-seiya.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211102090230.25013-1-seiya.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2021 10:02, Seiya Wang wrote:
> Add coresight-cpu-debug nodes to mt8183 for dumping
> EDPRSR, EDPCSR, EDCIDSR, EDVIDSR
> while kernel panic happens
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>

Applied to v5.16-next/dts64

Thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 ++++++++++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 409cf827970c..2d36575e7dbe 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -367,6 +367,70 @@
>   			reg = <0 0x0c530a80 0 0x50>;
>   		};
>   
> +		cpu_debug0: cpu-debug@d410000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xd410000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu0>;
> +		};
> +
> +		cpu_debug1: cpu-debug@d510000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xd510000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu1>;
> +		};
> +
> +		cpu_debug2: cpu-debug@d610000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xd610000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu2>;
> +		};
> +
> +		cpu_debug3: cpu-debug@d710000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xd710000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu3>;
> +		};
> +
> +		cpu_debug4: cpu-debug@d810000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xd810000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu4>;
> +		};
> +
> +		cpu_debug5: cpu-debug@d910000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xd910000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu5>;
> +		};
> +
> +		cpu_debug6: cpu-debug@da10000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xda10000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu6>;
> +		};
> +
> +		cpu_debug7: cpu-debug@db10000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xdb10000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu7>;
> +		};
> +
>   		topckgen: syscon@10000000 {
>   			compatible = "mediatek,mt8183-topckgen", "syscon";
>   			reg = <0 0x10000000 0 0x1000>;
> 

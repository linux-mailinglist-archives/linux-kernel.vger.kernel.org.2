Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F1D33244C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCILm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhCILmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:42:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AB6C06174A;
        Tue,  9 Mar 2021 03:42:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id p1so19428211edy.2;
        Tue, 09 Mar 2021 03:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A6bIv+p3szTuEIXXM2XphhkvFikVXUeMFjbmhdY08N8=;
        b=seKe5sEbHQa2kiM0aglI977bXPLc7n2L9EqPWPTJOMEnPVhhuyIHSFyPYkIdVfACDn
         x3mN+QytQkoPj5UiQVGQ2pRd6re8ZDWsyMZDWmEJjYZZbDdm9r/SiArFBrwMrtDPiZ9C
         NzLI/p4c856hviBTwjM5QeoxaovTdWN38ihnqEeqvvxo8W3baQdCRWtP4OROgLu4iNlY
         d5AWq26xMBjIvnfHHDuox2HdbaxCbS4upaUh2jdEhnhGom4IlOuNoBoAMnML8x0Rit6+
         tiyQegUOWvCqZ+YHsX/lEcEAKAfym5Tn0hl+EWuqnUB5KqRGcq1K7aHA6ZI7wR0D9rr5
         KIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A6bIv+p3szTuEIXXM2XphhkvFikVXUeMFjbmhdY08N8=;
        b=UZpJ6XSiGRpaOYqelqyADU6QdL9II1S0Hm/tv6VzeeH8TMHxn5M5GqSacBu7kmVv8p
         +1oZYWXzZ567sBo5evgqfp6TAqt1FEWDhZvF0utyZsd4Qmzy6NYpbBlUnxBbRMahi1HB
         pWEWHDwuVLp9omzKtMyrJ8kqn+ceUMsC5d9dFMQBErMXUT49t/zh1XliUt/D6TDww7KO
         y25nOCo45tE3yldU++QyO/7wVJaDFX6ZxEGeNz3x+cppDETS04tg6u/iiiH9dvPWXZG0
         RzvxpFqX18hKQPY0KwyXEJC6pv0cnQ8Qu+fBueh6dCyfW5Dj1oVqTlb+Fio2IsHWhkGY
         SqlA==
X-Gm-Message-State: AOAM530bBvnrDs92V1kldsAuHn4ePfa0yUOdSTWY0sxBIKBhNmALccqY
        Txee97RzS5d2vIITBOmvX0lGmullvzLh5Q==
X-Google-Smtp-Source: ABdhPJxZEHCNsHJ/oZO4KUI9IfkOvyl87o8wDz3iKGCTcntvjFUWE1J5tlAp4nXyDD67Iv0XoGbqUQ==
X-Received: by 2002:a05:6402:12cf:: with SMTP id k15mr3458170edx.192.1615290163721;
        Tue, 09 Mar 2021 03:42:43 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a22sm8397139ejr.89.2021.03.09.03.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 03:42:43 -0800 (PST)
Subject: Re: [RESEND PATCH v5 2/4] arm64: dts: rk3399: Add dfi and dmc nodes.
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210308233858.24741-1-daniel.lezcano@linaro.org>
 <20210308233858.24741-2-daniel.lezcano@linaro.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <9c36893a-6ca8-dade-e203-890a4071bf50@gmail.com>
Date:   Tue, 9 Mar 2021 12:42:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210308233858.24741-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Some comments. Have a look if it's useful or that you disagree with.

New nodes should be verifiable if possible.
Especially with so many properties.
Could you convert rockchip-dfi.txt and rk3399_dmc.txt to yaml instead of
changing old txt documents?
Add rockchip-dfi.yaml and rk3399_dmc.yaml before this patch in version 6.

Nodes and properties have a sort order. Please fix.
Some goes for [RESEND PATCH v5 3/4].

(This is a generic dtsi. How about cooling and dmc ??)

----
Heiko rules:

compatible
reg
interrupts
[alphabetical]
status [if needed]

----
My incomplete list:

For nodes:
If exists on top: model, compatible and chosen.
Sort things without reg alphabetical first,
then sort the rest by reg address.

Inside nodes:
If exists on top: compatible, reg and interrupts.
In alphabetical order the required properties.
Then in alphabetical order the other properties.
And as last things that start with '#' in alphabetical order.
Add status below all other properties for soc internal components with
any board-specifics.
Keep an empty line between properties and nodes.

Exceptions:
Sort pinctrl-0 above pinctrl-names, so it stays in line with clock-names
and dma-names.
Sort simple-audio-card,name above other simple-audio-card properties.
Sort regulator-name above other regulator properties.
Sort regulator-min-microvolt above regulator-max-microvolt.

On 3/9/21 12:38 AM, Daniel Lezcano wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> These are required to support DDR DVFS on rk3399 platform.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index edbbf35fe19e..6f23d99236fe 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1937,6 +1937,25 @@
>  		status = "disabled";
>  	};
>  
> +	dfi: dfi@ff630000 {
> +		reg = <0x00 0xff630000 0x00 0x4000>;
> +		compatible = "rockchip,rk3399-dfi";
> +		rockchip,pmu = <&pmugrf>;
> +		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru PCLK_DDR_MON>;
> +		clock-names = "pclk_ddr_mon";
> +		status = "disabled";
> +	};
> +
> +	dmc: dmc {
> +		compatible = "rockchip,rk3399-dmc";
> +		rockchip,pmu = <&pmugrf>;
> +		devfreq-events = <&dfi>;
> +		clocks = <&cru SCLK_DDRC>;
> +		clock-names = "dmc_clk";
> +		status = "disabled";
> +	};
> +
>  	pinctrl: pinctrl {
>  		compatible = "rockchip,rk3399-pinctrl";
>  		rockchip,grf = <&grf>;
> 


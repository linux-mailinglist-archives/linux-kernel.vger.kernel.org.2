Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7253E0352
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhHDOdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbhHDObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:31:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B7C061799;
        Wed,  4 Aug 2021 07:30:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qk33so3997995ejc.12;
        Wed, 04 Aug 2021 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jJgUENKtq1Xqry9IKjcIj2rKDWLQw2yb8qZeXDYhYJ8=;
        b=BxCJNFoC7AHZbsvmMXQ77Va5cgAhXPrXZUq2mUPzzDCMytHKjRwVlsHHQ0aKhqgfXB
         ik3ENUgR0qekgQ425+ZwpllnLbbRBpcpRIKyU3cah6GNIy3bgGin7F3tMKDgYUj+av8k
         UsKhUQeaNC4wnfHsIfTadhWp6HNP4sQApoyF4vThm4Lhi3Y3c+7wrx063eoJSvy/kqtq
         JyyR1Afw97kQp6xoFQlbcPC9tTVVvhfSndZyeYJg1w6J880LAnlyiiNXny4J+54MiFu1
         5T/lXZzFjEut45x/fb2OfVA11isRllpEHNVdJI3FfW5ZJ1gJTJOVWSSqCX0IDHoxknwo
         zIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jJgUENKtq1Xqry9IKjcIj2rKDWLQw2yb8qZeXDYhYJ8=;
        b=Yl/lttlJBAwi9qbttdKHMWI+5VhyhRWmZXA+J1VSSaFVBg7lbuhV5q8gEHNCuP+tYg
         MeMXX5O4u7kqx0DAcXUz/9AOeshfJb67XdnOTZD+jShmDThLcylfKMOPMSGZbROKNPwK
         rWEtm4ZQqimJwLprum27Pr9f0jx1Ex9chguGXe58mi59FmEVnldZG7592aAFeOGJqx8R
         /FIE82g1p7D8RfCYNn8hdgtewN/Gb2L3D11cad2PyOYcfZT9Fl5oKv0ua3rTMB4qm87q
         xG4iVFMVxKUtkX2I7d3YDWm7tGKiEEJjsLD1Yu+KGcN5A2D1UN/Fdv6gejvLn0LXKQ6N
         +3Bg==
X-Gm-Message-State: AOAM533syn0gE5FJrlpQahLsZ8hdZH9GAA08wz0CWm5eh9P/DAwvpsXd
        GMOy3TbmNFqwf9vTtCh139o=
X-Google-Smtp-Source: ABdhPJzzx6YRfIY5C2gP75MtSmovcieYN4L31YhhhxGDjBoJ+z2nYGnWfs6H0nZp4nj5gvII+MUf2A==
X-Received: by 2002:a17:907:7251:: with SMTP id ds17mr13062822ejc.43.1628087455004;
        Wed, 04 Aug 2021 07:30:55 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d23sm1026971edt.39.2021.08.04.07.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 07:30:54 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] arm64: dts: rockchip: rk3568-evb1-v10: add node
 for sd card
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>
References: <20210804130625.15449-1-michael.riesch@wolfvision.net>
 <20210804130625.15449-8-michael.riesch@wolfvision.net>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <aa16ee55-e1de-adc8-51f0-8ceed136b911@gmail.com>
Date:   Wed, 4 Aug 2021 16:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804130625.15449-8-michael.riesch@wolfvision.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Could you add a commit message to all patches in this serie?

On 8/4/21 3:06 PM, Michael Riesch wrote:
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
> v2:
> - rename alias to match convention
> 
>  arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> index ed96f27c64a3..c4da6436059d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> @@ -17,6 +17,7 @@
>  		ethernet0 = &gmac0;
>  		ethernet1 = &gmac1;

>  		mmc0 = &sdhci;
> +		mmc1 = &sdmmc0;

mmc aliases are sort on reg address based on availability without number
gap.

	sdmmc0: mmc@fe2b0000 {}
	sdhci: mmc@fe310000 {}

>  	};
>  
>  	chosen: chosen {
> @@ -353,6 +354,20 @@
>  	status = "okay";
>  };
>  
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +	disable-wp;

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;

pinctrl-names below pinctrl-0 like the rest of rk356x.dtsi

> +	sd-uhs-sdr104;

> +	supports-sd;

Check mmc-controller.yaml, rockchip-dw-mshc.yaml and
synopsys-dw-mshc-common.yaml for properties.

> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
>  &uart2 {
>  	status = "okay";
>  };
> 

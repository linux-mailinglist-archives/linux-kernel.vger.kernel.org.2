Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2773E0868
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbhHDS5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:57:43 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50166 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240401AbhHDS5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:57:38 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mBM4t-0002da-UO; Wed, 04 Aug 2021 20:57:19 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: rockchip: rk3568-evb1-v10: add node for sd card
Date:   Wed, 04 Aug 2021 20:57:19 +0200
Message-ID: <36612273.XM6RcZxFsP@diego>
In-Reply-To: <68c6c548-ff07-da79-f75c-afb6a9846932@wolfvision.net>
References: <20210804130625.15449-1-michael.riesch@wolfvision.net> <aa16ee55-e1de-adc8-51f0-8ceed136b911@gmail.com> <68c6c548-ff07-da79-f75c-afb6a9846932@wolfvision.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Am Mittwoch, 4. August 2021, 20:49:45 CEST schrieb Michael Riesch:
> Hi Johan,
> 
> Thanks for your comments, I'll try to implement the requested changes
> and prepare a v3 tomorrow.
> 
> On 8/4/21 4:30 PM, Johan Jonker wrote:
> > Hi Michael,
> > 
> > Could you add a commit message to all patches in this serie?
> 
> Well the short commit message (i.e., the subject line) pretty much wraps
> it all up in my opinion, hence no need for an extended commit message.
> Is there anything in particular you would like to see or have explained
> that requires an extended message? I would like to refrain from adding
> an extended commit message just for the sake of having one.

it's just a matter of style, and yes having a non-empty commit message
is preferred in most parts of the kernel.

Even if it's just a simple one-liner ;-), for example

"Enable the sdmmc node on the rk3568-evb1 with the 4 lanes connected on it"


Heiko

> 
> > On 8/4/21 3:06 PM, Michael Riesch wrote:
> >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> >> ---
> >> v2:
> >> - rename alias to match convention
> >>
> >>  arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> >> index ed96f27c64a3..c4da6436059d 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> >> @@ -17,6 +17,7 @@
> >>  		ethernet0 = &gmac0;
> >>  		ethernet1 = &gmac1;
> > 
> >>  		mmc0 = &sdhci;
> >> +		mmc1 = &sdmmc0;
> > 
> > mmc aliases are sort on reg address based on availability without number
> > gap.
> > 
> > 	sdmmc0: mmc@fe2b0000 {}
> > 	sdhci: mmc@fe310000 {}
> 
> I'll turn these around.
> 
> >>  	};
> >>  
> >>  	chosen: chosen {
> >> @@ -353,6 +354,20 @@
> >>  	status = "okay";
> >>  };
> >>  
> >> +&sdmmc0 {
> >> +	bus-width = <4>;
> >> +	cap-sd-highspeed;
> >> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> >> +	disable-wp;
> > 
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> > 
> > pinctrl-names below pinctrl-0 like the rest of rk356x.dtsi
> 
> OK!
> 
> >> +	sd-uhs-sdr104;
> > 
> >> +	supports-sd;
> > 
> > Check mmc-controller.yaml, rockchip-dw-mshc.yaml and
> > synopsys-dw-mshc-common.yaml for properties.
> 
> I am afraid I don't quite follow. What exactly should I check? I am
> pretty sure that the properties I used are described in the mentioned
> yaml files.
> 
> Regards, Michael
> 
> > 
> >> +	vmmc-supply = <&vcc3v3_sd>;
> >> +	vqmmc-supply = <&vccio_sd>;
> >> +	status = "okay";
> >> +};
> >> +
> >>  &uart2 {
> >>  	status = "okay";
> >>  };
> >>
> 





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97C33B701C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhF2Jcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:32:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40196 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232614AbhF2Jcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:32:51 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lyA4J-00023X-AF; Tue, 29 Jun 2021 11:30:11 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, Levin <djw@t-chip.com.cn>
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Kongxin Deng <dkx@t-chip.com.cn>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Marty Jones <mj8263788@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 2/2] arm64: dts: rockchip: add support for Firefly ROC-RK3399-PC-PLUS
Date:   Tue, 29 Jun 2021 11:30:10 +0200
Message-ID: <3771996.aKNjEaI27c@diego>
In-Reply-To: <149c2171-471e-343e-8126-38394746b044@t-chip.com.cn>
References: <20210628035402.16812-1-djw@t-chip.com.cn> <20210628035402.16812-3-djw@t-chip.com.cn> <149c2171-471e-343e-8126-38394746b044@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levin,

Am Dienstag, 29. Juni 2021, 11:15:59 CEST schrieb Levin:
> Hi all, is it possible to turn on some codec mixer switch in the device 
> tree?

I don't think that is appropriate and/or/ possible in the devicetree.

Instead I think you want an Alsa UCM profile for it, see:
https://github.com/alsa-project/alsa-ucm-conf/tree/master/ucm2/Rockchip


Heiko

> 
> 
> Currently, to hear to sound, we need to run the following commands from 
> the user space:
> 
>    # turn on mixer switch
> 
>    amixer -c 1 sset 'Left Mixer' on
>    amixer -c 1 sset 'Right Mixer' on
> 
>    # raise volume
> 
>    amixer -c 1 sset 'Output 2' 36
> 
> 
> If these settings can be embedded into device tree, and set by kernel as 
> initial ALSA path settings,
> 
> user can hear the sound with zero ALSA config. That'll be great.
> 
> 
> On 2021-06-28 11:54 AM, djw@t-chip.com.cn wrote:
> > +
> > +	es8388-sound {
> > +		compatible = "simple-audio-card";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&hp_det_pin>;
> > +		simple-audio-card,name = "rockchip,es8388-codec";
> > +		simple-audio-card,format = "i2s";
> > +		simple-audio-card,mclk-fs = <256>;
> > +
> > +		simple-audio-card,widgets =
> > +			"Microphone", "Mic Jack",
> > +			"Headphone", "Headphones";
> > +		simple-audio-card,routing =
> > +			"LINPUT1", "Mic Jack",
> > +			"Headphone Amp INL", "LOUT2",
> > +			"Headphone Amp INR", "ROUT2",
> > +			"Headphones", "Headphone Amp OUTL",
> > +			"Headphones", "Headphone Amp OUTR";
> > +
> > +		simple-audio-card,hp-det-gpio = <&gpio2 RK_PA6 GPIO_ACTIVE_HIGH>;
> > +		simple-audio-card,aux-devs = <&headphones_amp>;
> > +		simple-audio-card,pin-switches = "Headphones";
> > +
> > +		simple-audio-card,cpu {
> > +			sound-dai = <&i2s1>;
> > +		};
> > +
> > +		simple-audio-card,codec {
> > +			sound-dai = <&es8388>;
> > +		};
> > +	};
> > +
> >
> 





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843403B6FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhF2JSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:18:39 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:45410 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhF2JSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:18:34 -0400
Received: from localhost (unknown [192.168.167.130])
        by regular1.263xmail.com (Postfix) with ESMTP id A7FA71C5D;
        Tue, 29 Jun 2021 17:16:01 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED2: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 1
Received: from [168.168.4.18] (unknown [183.57.25.242])
        by smtp.263.net (postfix) whith ESMTP id P12976T140334009423616S1624958159864211_;
        Tue, 29 Jun 2021 17:16:00 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a0ef72e31076ad47cd5fe2cc15cf44d0>
X-RL-SENDER: djw@t-chip.com.cn
X-SENDER: djw@t-chip.com.cn
X-LOGIN-NAME: djw@t-chip.com.cn
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 15
X-SENDER-IP: 183.57.25.242
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v0 2/2] arm64: dts: rockchip: add support for Firefly
 ROC-RK3399-PC-PLUS
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Kongxin Deng <dkx@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Marty Jones <mj8263788@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210628035402.16812-1-djw@t-chip.com.cn>
 <20210628035402.16812-3-djw@t-chip.com.cn>
From:   Levin <djw@t-chip.com.cn>
Message-ID: <149c2171-471e-343e-8126-38394746b044@t-chip.com.cn>
Date:   Tue, 29 Jun 2021 17:15:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628035402.16812-3-djw@t-chip.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, is it possible to turn on some codec mixer switch in the device 
tree?


Currently, to hear to sound, we need to run the following commands from 
the user space:

   # turn on mixer switch

   amixer -c 1 sset 'Left Mixer' on
   amixer -c 1 sset 'Right Mixer' on

   # raise volume

   amixer -c 1 sset 'Output 2' 36


If these settings can be embedded into device tree, and set by kernel as 
initial ALSA path settings,

user can hear the sound with zero ALSA config. That'll be great.


On 2021-06-28 11:54 AM, djw@t-chip.com.cn wrote:
> +
> +	es8388-sound {
> +		compatible = "simple-audio-card";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hp_det_pin>;
> +		simple-audio-card,name = "rockchip,es8388-codec";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,widgets =
> +			"Microphone", "Mic Jack",
> +			"Headphone", "Headphones";
> +		simple-audio-card,routing =
> +			"LINPUT1", "Mic Jack",
> +			"Headphone Amp INL", "LOUT2",
> +			"Headphone Amp INR", "ROUT2",
> +			"Headphones", "Headphone Amp OUTL",
> +			"Headphones", "Headphone Amp OUTR";
> +
> +		simple-audio-card,hp-det-gpio = <&gpio2 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		simple-audio-card,aux-devs = <&headphones_amp>;
> +		simple-audio-card,pin-switches = "Headphones";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s1>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&es8388>;
> +		};
> +	};
> +
>
-- 
Best Regards!

Levin Du




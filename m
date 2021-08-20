Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EF93F251F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 05:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhHTDH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 23:07:27 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50479 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234797AbhHTDH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 23:07:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id BAF9F580B19;
        Thu, 19 Aug 2021 23:06:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 19 Aug 2021 23:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:from:to:cc:references:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=I
        lerJjWUqSWBzViZOJOeuXDWDQWsYdqr5JwrgNXZwvo=; b=o4OKaKqK//qd839Mp
        i8YyXQnx/x1M2g8FhiJVmiiRMcn+Kow/sX8nz3AZrI5SRz0NgTEpmHVb1+HizD/8
        jwxSIfLxCYTBzTm0/wuplCkX+I0wBHjEThOiWbnd0uVVlEaB+mUliiM/yVANjpH5
        fStzj72dDMo68cr1NvDYyJNI+hn0k1MMogn9kwFs6UNrWdhhnmonHeUWsyvVB1/k
        97XrrKA5ztI0h/bAr1Tgr5PtovxGiTmg1JXFaeHbK7MF0UEoZ2v3Z0f10Dsh24dc
        4YeWsUlYuiMxwg82PS9ySdIr8+ZZ1rW3OIwCQIRkGAhtTqvLnnGaBmNHyYsLP3RA
        7Zmdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=IlerJjWUqSWBzViZOJOeuXDWDQWsYdqr5JwrgNXZw
        vo=; b=YO5JTEP891EXRHlUkLLRaszdF/OFo81WtmdaSQRVMgEC5nanddmnU/gC4
        YraU8UxLJyq3JPIK/UG58PwKBTmNh8xbz+FXTqnSQhwce0ONsH7mfXTtACA0noxY
        DLmFQaIgB47TVB+JvY3rhDwZsm0tS2dw87ewaMGLcCU2JpZoBU9dk4h1wEw+1QQr
        DfQkgsNKRdxOXeiF42D/0keezL+z/ax3wvSGeYiHpn1g42/FyCn9gG3QZZmSHtrr
        YLPGpgnwaX6xrbS2lAr/u9o5+XCY6bIOGJ+dONo2ALb6etK4AvU6nJxn1+cOpKvO
        cBki/gf4Sslj6aIwWb6OdKUb5VLeQ==
X-ME-Sender: <xms:RBwfYbqh0-Sh364KHOeraVodPLeBO0Yrg7pJJjYC5DzpW8wPQML66g>
    <xme:RBwfYVoU1zy4TaHaaN7l04r8vBlRGI3qwl27K2tJSxZoUwLOgYAuApNEFPIVFSP4H
    ukam6xyLQSeomhIRA>
X-ME-Received: <xmr:RBwfYYPeNOopaIjNYSYihtWdz32lZeUGTpYliK2KlWgDX3d8C-m0ae_5FkxUTI4tX6Q586kBw5wAcqtzKB3qiWK8AiesJwUItfKkLj1TOFv0r89E71ouA5mAfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleekgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuhffvfhfkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefhleefudegleffgfdvleelvddtgfetfeekteegvedvhefgveejueel
    veejuddtheenucffohhmrghinheplhhinhhugidqshhunhigihdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhh
    ohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:RBwfYe7bEzjOFx1jWXGpAQ-TOYevTzaI53uSEm5ZsOnlUKcPz3WHCw>
    <xmx:RBwfYa48uBe5mFMZn0mAC2JqbWh22ueYP8VB1Nab4RjbylN4L0kt-Q>
    <xmx:RBwfYWjGRPXkE-UyCAUFYtm14gkwLhcH0yPHw_zVPe3G23CRKjfOlw>
    <xmx:SBwfYShDufXMWGBWrlY9vpBkcObchl7n_B8Yl1m9A2csobw1e72kEw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 23:06:44 -0400 (EDT)
Subject: Re: [PATCH 15/17] arm64: allwinner: dts: add DTSI file for R329 SoC
From:   Samuel Holland <samuel@sholland.org>
To:     Icenowy Zheng <icenowy@sipeed.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-16-icenowy@sipeed.com>
 <20210818090139.rllz4fvvq3pzdkls@gilmour>
 <74F51516-2470-4A49-972B-E19D8EDD9A3D@sipeed.com>
 <75ae9ef8-496b-68ca-214e-e8b270648a50@sholland.org>
Message-ID: <8e4a49b8-8f17-d659-0952-0c96b0098139@sholland.org>
Date:   Thu, 19 Aug 2021 22:06:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <75ae9ef8-496b-68ca-214e-e8b270648a50@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/21 9:32 PM, Samuel Holland wrote:
> On 8/18/21 4:15 AM, Icenowy Zheng wrote:
>> 于 2021年8月18日 GMT+08:00 下午5:01:39, Maxime Ripard <maxime@cerno.tech> 写到:
>>> On Mon, Aug 02, 2021 at 02:22:10PM +0800, Icenowy Zheng wrote:
>>>> +		ccu: clock@2001000 {
>>>> +			compatible = "allwinner,sun50i-r329-ccu";
>>>> +			reg = <0x02001000 0x1000>;
>>>> +			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
>>>> +			clock-names = "hosc", "losc", "iosc";
>>>
>>> Do we have a clock tree for the RTC? Is it the same than the H616?
>>
>> Nope, it's the same with H6 because of external LOSC crystal is
>> possible. (Although production M2A SoMs has it NC for cost control.)
> 
> It is not the same as the H6, either. The clock tree _is_ identical to the D1,
> which has three diagrams on pages 363-364 of its user manual here:
> 
> https://dl.linux-sunxi.org/D1/D1_User_Manual_V0.1_Draft_Version.pdf
> 
> Compared to the H6, the R329/D1:
>  - Loses the LOSC calibration circuit
>  - Gains a third mux input for LOSC (not external 32k) to fanout
>  - Gains a mux to choose between LOSC and HOSC/750 for the RTC clock
>  - Gains an SPI bus clock input divided from the PRCM AHB
> 
> Compared to the H616, the R329/D1:
>  - Has an external 32k crystal input
>    - Gains the IOSC vs. external 32k crystal mux for LOSC
>    - Switches fanout mux input #1 from pll_periph0/N to external 32k
>  - Gains a mux to choose between LOSC and HOSC/750 for the RTC clock
>  - Gains an SPI bus clock input divided from the PRCM AHB
> 
> So the R329/D1 RTC has three^Wfour inputs:
>  - SPI clock from PRCM
>  - 24 MHz DCXO crystal
>  - 32 kHz external crystal (optional)

Whoops, I missed one here:
 - Bus clock from PRCM

The SPI clock is new for R329, but the bus clock has been around since H6.

> and four outputs:
>  - 16 MHz "IOSC" RC oscillator
>  - 32 kHz "LOSC"
>  - ~1 kHz for RTC timekeeping

Even though this is internal to the RTC, it is still useful to model, as it can
be used to correct for known RTC drift. (For example, HOSC/750 is 32000 Hz
instead of 32768 Hz, so 2.34375% slow. But that is better than IOSC, which has
unknown error.)

>  - 32 kHz fanout
> 
> (Arguably, since the 24 MHz DCXO can be turned on/off from the RTC registers, it
> should be an "output" and not an "input".)
> 
> Regards,
> Samuel
> 


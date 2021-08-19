Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC33F1068
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 04:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhHSCdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 22:33:35 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35535 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235558AbhHSCde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 22:33:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 30E41580E2A;
        Wed, 18 Aug 2021 22:32:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 18 Aug 2021 22:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=x
        LbvSMTiMYZxTLYR1GQDqD2mHnthLeMTRU2Ref6bLNg=; b=P1vDTC0GO6P646SRK
        RgvJ+yN321l0O6+4AYHye+w7yBEYLku7DDMSD3wn/pXwl0BV7OehuGUeaeI6Hy0r
        wfKP3jd6OUuaQbWDcAotmcIk5uPciX0c1jUAQ0wwg243ZFh35hKMZ+lUPmxyjywL
        tlHQXD52C4C+o77T003wmsfacqTuYnIZd4Mkpa2lekgafD7LqR6L/J+l0IfKcNae
        M4/P4zXvl68ROdbFYdty/SRt5frGGBQnwTLqMDvijrMmjhN03Ti0jOJRFvWaO8iP
        jPHURjWP6mEPvnvVloerwcwNWUO1igDn6KWhLt6waj0wUQR5tF14sFWXXUc6KmuS
        31kog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=xLbvSMTiMYZxTLYR1GQDqD2mHnthLeMTRU2Ref6bL
        Ng=; b=jpr8X/jlaa5vaZHNgVIaxcxIkezN2cH0bk/pU+l+fGP9YfwBOa5Q3wAZF
        Tqp2NeXw5B7n/Nnxbjdf/+pvtpiYJVPvYV8j8u1L641e4QbfIObaUqCKlmrI0zYu
        jGqHYpZSyhs/GszrIJ90UJ/n/ZCtZZXCFI6ZBxSIqeo+n5cLU/y933NIEm0CHyK7
        7DH4sB20TgeoYRI0tSxfcpYAJPaNZaUflJiaYDc02Sn7+kKCu0BLpTOND/1j9clM
        OJIr6NqECNH2SsUxSXM+V3NEMZPwtiO3kWu7wYLV3hViMQa1GS7CcqmAvRKgee1M
        Au1kBq2GZPDt6gQKGL1sk4lAy8GJQ==
X-ME-Sender: <xms:18IdYcH1rEoazMwVkcAHiEu7UZwy1Xz6Zue5C6yNoxnw3VpzfLEcLA>
    <xme:18IdYVUlUmQ0hiyCoMButDKbcnezZk0UysnlIQmUfwcapbFkVQ_HT6Iye3ZLxl7px
    koUAa1Sz_jwbI-9MQ>
X-ME-Received: <xmr:18IdYWKbQJxc7HJgvyghJ7KtOdAJkdWzQi6cxjcagZL4F_PhFZ1ibBHR8RwmFLCqMxitFNorZhU_zLgxcTyGPfllHU07gVTPfWR8EvN3oO00gL2pRc6chE2kPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekteejfefggfefgfevudelhfelhffghefgueelhefhleejjefgueej
    tdeglefhkeenucffohhmrghinheplhhinhhugidqshhunhigihdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhh
    ohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:18IdYeGgVxLwjsTBoSb1fMu30CXWqq0tKVRfreCEOtX19b7yEcwf7w>
    <xmx:18IdYSVqiTMIPjh6MrMcfv-6vW2Cc83lER6nuLYNGmg_f4vMTnt8SA>
    <xmx:18IdYRMM4tfAzuPVdAq6onaeDNF6C8JZMU_zQQQu40Hpjvx-NCN9ow>
    <xmx:2sIdYZNJr2uDoTnSglROrBEDU1Ju6fEft51F1e-uft0mlhRH-1GZ8w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 22:32:54 -0400 (EDT)
Subject: Re: [PATCH 15/17] arm64: allwinner: dts: add DTSI file for R329 SoC
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
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <75ae9ef8-496b-68ca-214e-e8b270648a50@sholland.org>
Date:   Wed, 18 Aug 2021 21:32:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <74F51516-2470-4A49-972B-E19D8EDD9A3D@sipeed.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/21 4:15 AM, Icenowy Zheng wrote:
> 于 2021年8月18日 GMT+08:00 下午5:01:39, Maxime Ripard <maxime@cerno.tech> 写到:
>> On Mon, Aug 02, 2021 at 02:22:10PM +0800, Icenowy Zheng wrote:
>>> +		ccu: clock@2001000 {
>>> +			compatible = "allwinner,sun50i-r329-ccu";
>>> +			reg = <0x02001000 0x1000>;
>>> +			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
>>> +			clock-names = "hosc", "losc", "iosc";
>>
>> Do we have a clock tree for the RTC? Is it the same than the H616?
> 
> Nope, it's the same with H6 because of external LOSC crystal is
> possible. (Although production M2A SoMs has it NC for cost control.)

It is not the same as the H6, either. The clock tree _is_ identical to the D1,
which has three diagrams on pages 363-364 of its user manual here:

https://dl.linux-sunxi.org/D1/D1_User_Manual_V0.1_Draft_Version.pdf

Compared to the H6, the R329/D1:
 - Loses the LOSC calibration circuit
 - Gains a third mux input for LOSC (not external 32k) to fanout
 - Gains a mux to choose between LOSC and HOSC/750 for the RTC clock
 - Gains an SPI bus clock input divided from the PRCM AHB

Compared to the H616, the R329/D1:
 - Has an external 32k crystal input
   - Gains the IOSC vs. external 32k crystal mux for LOSC
   - Switches fanout mux input #1 from pll_periph0/N to external 32k
 - Gains a mux to choose between LOSC and HOSC/750 for the RTC clock
 - Gains an SPI bus clock input divided from the PRCM AHB

So the R329/D1 RTC has three inputs:
 - SPI clock from PRCM
 - 24 MHz DCXO crystal
 - 32 kHz external crystal (optional)

and four outputs:
 - 16 MHz "IOSC" RC oscillator
 - 32 kHz "LOSC"
 - ~1 kHz for RTC timekeeping
 - 32 kHz fanout

(Arguably, since the 24 MHz DCXO can be turned on/off from the RTC registers, it
should be an "output" and not an "input".)

Regards,
Samuel

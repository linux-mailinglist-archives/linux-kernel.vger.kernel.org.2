Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7376C33CC98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhCPEgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:36:01 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33723 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229972AbhCPEf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:35:28 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1A50D5807B3;
        Tue, 16 Mar 2021 00:35:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Mar 2021 00:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=s
        ZyhAcTCkCrINPeM1EDpvNypDpkGEOBvU+a0UsEG4ng=; b=Jrp59v8o/gxPG60nv
        oTnV5NzPUn/zL281biS8kg1u2tJUlSsKnD9XN8noIG7lWqrhEV+E7cF9RICYR+TL
        B0CKEgkkhiXJhhlDpmMw3U/00SKLDDSbqZyfvnMGn56ZsYLcMfP4zadIejkXxFMf
        8A3XTtz9y6D82boygMm0vJqm9OdpB+nk/4ujQlYtK10h8rnxGTQ6HrFDDXAsSMuv
        T4T1kxGuU99FgUaugCzEwuzF8bbxy/YYlfrjx1esiRj+f+hXpx2Q/C2L0UFtIjck
        lnq+PT4bnOIGbG2TAcJJPc4WrrO1u0UWjd0GJDrb9WRgdLk6I3H7w9izvb+ETyza
        R+JRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=sZyhAcTCkCrINPeM1EDpvNypDpkGEOBvU+a0UsEG4
        ng=; b=iBWmB1eE6DsIEoJtZMSQdnDuk8dFjpYGx/SbcY09YVZ/OTbyTmCA9NuTl
        dqAN+DVar+UcZvGpWZNsXgoBC5eF76ZkTA00tGhJkAgiTgrf4GoIObrb+7ZQ6sZO
        I06C93jJvHrQo4fm+iufSGmkgitDlFRaSJINVzTLxeA6csGD1GBAAQ30RDA6Ziiq
        0z/jApqhCqH8SOvKGyrAAzzE0MzYqwT2gmsz60aWExMYihs9BPwJr1tkhH0JDRcC
        izZCa7aCPTXBadiu/1+ai2idq0KiZuZHyRktpduType5lEd+/8pL39aijYlKrzR7
        uYjywJlJR8LEURrlyYEuVAEkBWAMA==
X-ME-Sender: <xms:jTVQYPJ3HY9bPCti7mrJHndCOK1bixBS4gKpp0rFHlNaJxb4Hv8Gzg>
    <xme:jTVQYDKaXSAl_py3cmYOLBQerdytVVNWvMTQxXrlKvuk9EEzMbxIsYT8zCP-5x3WC
    EZRbgBG-5hTZriLRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefuddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfelkeduveejtdejhfeiledvhfeggeeiieeklefhfeefffffffeg
    udetteelieejnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:jTVQYHvr21nW1sbegQZ8IWDuL_nNrwqtTOYLrDfvbPjvcyPNtjXfEw>
    <xmx:jTVQYIYxe9yIwLrK511j2BUlW1oezJ3HL3ueM7qaGSjNGSc7i3HcPQ>
    <xmx:jTVQYGY-vqb5BNAvD70iHSrHAG9lhvXUowu8w-CR1bV63NjaRyOsJg>
    <xmx:jzVQYMOoGJQLyn661zaV9zSXhGm0CqKmYCZFb1trdsInfpG0B3JYtw>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4CC4324005B;
        Tue, 16 Mar 2021 00:35:25 -0400 (EDT)
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: Add sun4i MMIO timer nodes
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210315043250.45095-1-samuel@sholland.org>
 <20210315043250.45095-5-samuel@sholland.org>
 <1897259.uecf0MpyRy@jernej-laptop>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <43b4d9e5-55c8-c844-069f-c8f8290c20e2@sholland.org>
Date:   Mon, 15 Mar 2021 23:35:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1897259.uecf0MpyRy@jernej-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 1:32 PM, Jernej Škrabec wrote:
> Hi!
> 
> Dne ponedeljek, 15. marec 2021 ob 05:32:49 CET je Samuel Holland napisal(a):
>> For a CPU to enter an idle state, there must be some timer which can
>> trigger an IRQ to wake it back up. The local ARM architectural timer is
>> not sufficient, because that timer stops when the CPU is powered down.
>> Some other CPU's ARM architectural timer can be used, but this prevents
>> that other CPU from entering an idle state. So to allow all CPUs to
>> enter an idle state at the same time, some MMIO timer must be available
>> that is not tied to any CPU.
>>
>> The basic "sun4i" timer seems most appropriate for this purpose due to
>> its moderate rate, balancing precision and power consumption.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi  | 9 +++++++++
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi   | 9 +++++++++
>>  arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 9 +++++++++
>>  3 files changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
>> 33df866f6ea9..64e8b4a372cc 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -905,6 +905,15 @@ uart4_rts_cts_pins: uart4-rts-cts-pins {
>>  			};
>>  		};
>>
>> +		timer@1c20c00 {
>> +			compatible = "allwinner,sun50i-a64-timer",
>> +				     "allwinner,sun8i-a23-timer";
>> +			reg = <0x01c20c00 0xa0>;
>> +			interrupts = <GIC_SPI 18 
> IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 19 
> IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&osc24M>;
>> +		};
>> +
>>  		wdt0: watchdog@1c20ca0 {
>>  			compatible = "allwinner,sun50i-a64-wdt",
>>  				     "allwinner,sun6i-a31-wdt";
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
>> 62334054c710..9ba3b30e11fa 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> @@ -332,6 +332,15 @@ cpu_speed_grade: cpu-speed-grade@1c {
>>  			};
>>  		};
>>
>> +		timer@3009000 {
>> +			compatible = "allwinner,sun50i-h6-timer",
>> +				     "allwinner,sun8i-a23-timer";
>> +			reg = <0x03009000 0xa0>;
>> +			interrupts = <GIC_SPI 48 
> IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 49 
> IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&osc24M>;
>> +		};
>> +
>>  		watchdog: watchdog@30090a0 {
>>  			compatible = "allwinner,sun50i-h6-wdt",
>>  				     "allwinner,sun6i-a31-wdt";
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi index
>> c277b53f94ea..ff55712ce96e 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> 
> This file does not exist yet upstream.

Right. I will remove this section for v2.

Cheers,
Samuel

> Best regards,
> Jernej
> 
>> @@ -128,6 +128,15 @@ ccu: clock@3001000 {
>>  			#reset-cells = <1>;
>>  		};
>>
>> +		timer@3009000 {
>> +			compatible = "allwinner,sun50i-h616-timer",
>> +				     "allwinner,sun8i-a23-timer";
>> +			reg = <0x03009000 0xa0>;
>> +			interrupts = <GIC_SPI 48 
> IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 49 
> IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&osc24M>;
>> +		};
>> +
>>  		watchdog: watchdog@30090a0 {
>>  			compatible = "allwinner,sun50i-h616-wdt",
>>  				     "allwinner,sun6i-a31-wdt";
> 
> 
> 
> 


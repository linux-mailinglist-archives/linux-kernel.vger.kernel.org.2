Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3064001F5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349660AbhICPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:22:18 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50105 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349655AbhICPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:22:15 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5653A580AA5;
        Fri,  3 Sep 2021 11:21:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 03 Sep 2021 11:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=Y
        0N7oM6dRDQR8Rmd/jesZW+rQHwZCpQ3qcTW6TwuJYs=; b=jPbVywF+6na90WQPo
        qeKreZA40pfwqQygvLunDJbTNub1BiDqSbtwY0WNLj34gfncXZizSrlGIUYevdSG
        gTIdmXmmD62EuN6uAR5EZaHzDOwLJ420w9D1vwVUYwwSZRk01hF/WhnpIZH5C8s3
        r0KgF4yfA8rsiKQ7ctRGJ6UwwzkBkvJN8zuwZH+rv2GkbABr6NKQ9etp8M+UnTUl
        YkfrjkDJpsZRcRi6SenR5GdE539P12xZv5UfCB4LOj3hj//AnzED4zVZ2MCQzZLt
        xU4h0f+GzDH/FD1/4uFNcd0C41KjLLdZ8dgx9vxzSrsBSuj4yiC5TdbgswOauMDa
        kyISw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Y0N7oM6dRDQR8Rmd/jesZW+rQHwZCpQ3qcTW6TwuJ
        Ys=; b=Bk6hzej+JtMyUT+mdvkAp7lojXdG0saAcMI+sUqDu/nfdXbCMJj6XGLKz
        2uNxsYAFXt9qIpwmNVNyXgCCxQryjKXUxPmc0qAJK1Jepyu9cy4XJpKbjpBU+e/c
        cNxUxgagRZN3Vymtku4IC879wDo7gEYQSNtse6uhgTtD4W/e0YuZFzjAimCEEr+J
        fLHZr8QV0Cwp5H+Z8TqQyxIGV11f+Qc7laZJtKlUal6XzspVRvWvG7b7Iww+yRt1
        lkQq1UGyNmq3DtWi89rdFfNMknSqcCX3d2rVg8APrhtJIM4jShHFwxNOAGD2vvWO
        5aNwhrqlbwWOdHu8B1YZfT1bTuPGg==
X-ME-Sender: <xms:aj0yYTASpcK6Z5JJgnhJiL43t56zvIG2ZFSzn35_0usk8Lj-pEUvbg>
    <xme:aj0yYZj61donCp5HYD2FHQNa-ARcAmYLbFDdz7R_sWnJ5axMX9F5j28wULwskRsEL
    24rl7Qf54leVjQ-5g>
X-ME-Received: <xmr:aj0yYemawDcUOdQuZlpftXODzOvNK26V5Sb8ud6l0v7ILrndop8DeucCExP1GrJL9L113k_tj6DIQJduyNozg2w8JQOKx9qZ61mHVUk8-Gx2HohuwWAUByc-Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefheenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheejgefhudeffeetleeigefgheetveeiteeuffehhfffkeeuvdff
    veffveetudefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:aj0yYVy33uk9Xri8RxyrHM5J6EpGm8ffk26KAT92SQiKeasXs0_5XQ>
    <xmx:aj0yYYR-pLl2P3V9iHfOG_RBChXF_DPPL3jZA74WjH_iZDxck-SGsQ>
    <xmx:aj0yYYYSS28xuysGQsnqbOyLouAQaJWTgYphrHiQaQGeHPIRjMN7yQ>
    <xmx:az0yYR9nwNFVPx6DCtUsdokl6NQfq24biuHlvtIz1Q62xNN70GjPwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 11:21:13 -0400 (EDT)
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210901053951.60952-1-samuel@sholland.org>
 <20210903145013.hn6dv7lfyvfys374@gilmour>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [RFC PATCH 0/7] clk: sunxi-ng: Add a RTC CCU driver
Message-ID: <4a187add-462b-dfe4-868a-fdab85258b8d@sholland.org>
Date:   Fri, 3 Sep 2021 10:21:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210903145013.hn6dv7lfyvfys374@gilmour>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 9:50 AM, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Sep 01, 2021 at 12:39:44AM -0500, Samuel Holland wrote:
>> This patch series adds a CCU driver for the RTC in the H616 and R329.
>> The extra patches at the end of this series show how it would be
>> explanded to additional hardware variants.
>>
>> The driver is intended to support the existing binding used for the H6,
>> but also an updated binding which includes all RTC input clocks. I do
>> not know how to best represent that binding -- that is a major reason
>> why this series is an RFC.
>>
>> A future patch series could add functionality to the driver to manage
>> IOSC calibration at boot and during suspend/resume.
>>
>> It may be possible to support all of these hardware variants in the
>> existing RTC clock driver and avoid some duplicate code, but I'm
>> concerned about the complexity there, without any of the CCU
>> abstraction.
>>
>> This series is currently based on top of the other series I just sent
>> (clk: sunxi-ng: Lifetime fixes and module support), but I can rebase it
>> elsewhere.
> 
> I'm generally ok with this, it makes sense to move it to sunxi-ng,
> especially with that other series of yours.
> 
> My main concern about this is the split driver approach. We used to have
> that before in the RTC too, but it was mostly due to the early clock
> requirements. With your previous work, that requirement is not there
> anymore and we can just register it as a device just like the other
> clock providers.

That's a good point. Originally, I had this RTC CCU providing osc24M, so
it did need to be an early provider. But with the current version, we
could have the RTC platform driver call devm_sunxi_ccu_probe. That does
seem cleaner.

(Since it wasn't immediately obvious to me why this works: the only
early provider remaining is the sun5i CCU, and it doesn't use the sun6i
RTC driver.)

> And since we can register all those clocks at device probe time, we
> don't really need to split the driver in two (and especially in two
> different places). The only obstacle to this after your previous series
> is that we don't have of_sunxi_ccu_probe / devm_sunxi_ccu_probe
> functions public, but that can easily be fixed by moving their
> definition to include/linux/clk/sunxi-ng.h

Where are you thinking the clock definitions would go? We don't export
any of those structures (ccu_mux, ccu_common) or macros
(SUNXI_CCU_GATE_DATA) in a public header either.

Would you want to export those? That seems like a lot of churn. Or would
we put the CCU descriptions in drivers/clk/sunxi-ng and export a
function that the RTC driver can call? (Or some other idea?)

Regards,
Samuel

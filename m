Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC5541BDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbhI2D4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:56:16 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34519 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244064AbhI2D4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:56:10 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 30E56580E57;
        Tue, 28 Sep 2021 23:54:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 28 Sep 2021 23:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=/
        fz2xDmGvnVOv6nmGoPaDrmEwWr82udufb63/AmiMe8=; b=YfDdo97RhokBFNvMz
        ImWhirnQy0nIl1TaEPKmE1HRb9R1rMZu8yR2Q93McjWprNkNNr3EzfXcV5yOoI76
        zNk02KygJKgfr9JtpsUnaVoPCZ974tSBbS8YfzyeN6Ph6CIwN53eLaJlcnVMrauj
        hy2uvDNglliwdAkZ9154x4UfvhQTpg8QCDJEw0cmzGkxunCnYQEUDUv/MBEHLmNB
        z1VX8+J0TqD5DdRmqOn4PhSPD886e8/tnDMKzEG3b51ln3hxrlQMmCNdraSnlSFE
        XFO0dfo9epTcMG3jHtFh5gVGUbJ/J1VukF8RL+aHYNGSVPPwpeuHNq/CJ2XU8HfD
        l5n/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=/fz2xDmGvnVOv6nmGoPaDrmEwWr82udufb63/AmiM
        e8=; b=oup3cklh5OZrUL36ojjnMb5SRVL1GVBtY+Fx30n9bu7dVWrCwDZNwUz2R
        BVz4huTwpafnlFN3Iqul/vUPVemG7hQ6MCKDtXHFeEUx+vM504FDd6JZ+OXcFZ56
        pnVkBohD07XWG4vzquXtQzkpS3nPFWxRvO36V7iOeKNib39UrSqqkXJJdxrFrCCi
        X14H3KM9MuNeVBPc8ok4QpNZtIqME6gnS8p/Ea3EFkaCmVeSYbc2VameVKfdElxF
        EP7LnjW5x2EvSLmuslnAyw4DLKq8zScUwTvoymWY9HXCisme/NF8OeM/FI53VM+e
        Jtwg77n5Zdl19Yz4+Z756r4M+CmVg==
X-ME-Sender: <xms:dONTYQaxgontc6TT9gcWD_hpAW_bSY41ISXOJ0TUhTABwJQQy0qTRw>
    <xme:dONTYbbfLqXfZGvH7IpnbrFTtokxbUS0Z-oM1rmwuhPxmc8Bb35aIUON4PhW_whoO
    8OXmUw6poPJk6NXWg>
X-ME-Received: <xmr:dONTYa8cG3mR_A429D2GJL949JFxtWO6dC_r4YFzdQKxMUl2mcj8jsh6gFYWUjXsVA8I1jbhDGppvpiXndisqZde2TDI74kE1-4ozuMjo70wb25V4pN-g4nvIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:dONTYarch2QM-59eaZoBQB34aRxdWh0RNrBBI1msx5ectgeld_SkIQ>
    <xmx:dONTYbp0FfM2rmkQaLm699JXCxLn2741Uqo0vNfHN2P6QhbiyjX3Wg>
    <xmx:dONTYYRrYC83eLuYGF2DiEBRaupYSq7LoK-f1Y_XliuKzrDfKnRYtw>
    <xmx:deNTYe17VXBKCbrCRwL5wWAtdx-9PmTwKqACewr1yfKZtgdCRjo-ag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 23:54:27 -0400 (EDT)
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
 <4a187add-462b-dfe4-868a-fdab85258b8d@sholland.org>
 <20210909084538.jeqltc7b3rtqvu4h@gilmour>
 <c910527d-e2d7-31ca-efd9-1915db62d85d@sholland.org>
 <20210928090625.rq3atiaejaq5kcbx@gilmour>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [RFC PATCH 0/7] clk: sunxi-ng: Add a RTC CCU driver
Message-ID: <bc338f11-9867-2394-ceaa-99314ff67660@sholland.org>
Date:   Tue, 28 Sep 2021 22:54:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210928090625.rq3atiaejaq5kcbx@gilmour>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thanks for your reply.

On 9/28/21 4:06 AM, Maxime Ripard wrote:
> On Tue, Sep 28, 2021 at 02:46:39AM -0500, Samuel Holland wrote:
>> On 9/9/21 3:45 AM, Maxime Ripard wrote:
>>> On Fri, Sep 03, 2021 at 10:21:13AM -0500, Samuel Holland wrote:
>>>> On 9/3/21 9:50 AM, Maxime Ripard wrote:
>>>>> And since we can register all those clocks at device probe time, we
>>>>> don't really need to split the driver in two (and especially in two
>>>>> different places). The only obstacle to this after your previous series
>>>>> is that we don't have of_sunxi_ccu_probe / devm_sunxi_ccu_probe
>>>>> functions public, but that can easily be fixed by moving their
>>>>> definition to include/linux/clk/sunxi-ng.h
>>>>
>>>> Where are you thinking the clock definitions would go? We don't export
>>>> any of those structures (ccu_mux, ccu_common) or macros
>>>> (SUNXI_CCU_GATE_DATA) in a public header either.
>>>
>>> Ah, right...
>>>
>>>> Would you want to export those? That seems like a lot of churn. Or would
>>>> we put the CCU descriptions in drivers/clk/sunxi-ng and export a
>>>> function that the RTC driver can call? (Or some other idea?)
>>>
>>> I guess we could export it. There's some fairly big headers in
>>> include/linux/clk already (tegra and ti), it's not uAPI and we do have
>>> reasons to do so, so I guess it's fine.
>>>
>>> I'd like to avoid having two drivers for the same device if possible,
>>> especially in two separate places. This creates some confusion since the
>>> general expectation is that there's only one driver per device. There's
>>> also the fact that this could lead to subtle bugs since the probe order
>>> is the link order (or module loading).
>>
>> I don't think there can be two "struct device"s for a single OF node.
> 
> That's not what I meant, there's indeed a single of_node for a single
> struct device. If we dig a bit into the core framework, the most likely
> scenario is that we would register both the RTC and clock driver at
> module_init, and with the device already created with its of_node set
> during the initial DT parsing.
> 
> We register our platform driver using module_platform_driver, which
> expands to calling driver_register() at module_init(), setting the
> driver bus to the platform_bus in the process (in
> __platform_driver_register()).
> 
> After some sanity check, driver_register() calls bus_add_driver(), which
> will call driver_attach() if drivers_autoprobe is set (which is the
> default, set into bus_register()).
> 
> driver_attach() will, for each device on the platform bus, call
> __driver_attach(). If there's a match between that device and our driver
> (which is evaluated by platform_match() in our case), we'll call our
> driver probe with that device through driver_probe_device(),
> __driver_probe_device() and finally really_probe().
> 
> However, at no point in time there's any check about whether that device
> has already been bound to a driver, nor does it create a new device for
> each driver.

I would expect this to hit the:

	if (dev->driver)
		return -EBUSY;

in __driver_probe_device(), or fail the "if (!dev->driver)" check in
__driver_attach() for the async case, once the first driver is bound.

> So this means that, if you have two drivers that match the
> same device (like our clock and RTC drivers), you'll have both probe
> being called with the same device, and the probe order will be defined
> by the link order. Worse, they would share the same driver_data, with
> each driver not being aware of the other. This is incredibly fragile,
> and hard to notice since it goes against the usual expectations.
> 
>> So if the CCU part is in drivers/clk/sunxi-ng, the CCU "probe"
>> function would have to be called from the RTC driver.
> 
> No, it would be called by the core directly if there's a compatible to
> match.
> 
>> Since there has to be cooperation anyway, I don't think there would be
>> any ordering problems.
> 
> My initial point was that, with a direct function call, it's both
> deterministic and obvious.

I believe I did what you are suggesting for v2. From patch 7:

--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -683,6 +684,10 @@ static int sun6i_rtc_probe(struct platform_device
*pdev)
 		chip->base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(chip->base))
 			return PTR_ERR(chip->base);
+
+		ret = sun6i_rtc_ccu_probe(&pdev->dev, chip->base);
+		if (ret)
+			return ret;
 	}

 	platform_set_drvdata(pdev, chip);

>>> And synchronizing access to registers between those two drivers will be
>>> hard, while we could just share the same spin lock between the RTC and
>>> clock drivers if they are instanciated in the same place.
>>
>> While the RTC driver currently shares a spinlock between the clock part
>> and the RTC part, there isn't actually any overlap in register usage
>> between the two. So there doesn't need to be any synchronization.
> 
> I know, but this was more of a social problem than a technical one. Each
> contributor and reviewer in the future will have to know or remember
> that it's there, and make sure that it's still the case after any change
> they make or review.
> 
> This is again a fairly fragile assumption.

Yeah, I agree that having a lock that is only sometimes safe to use with
certain registers is quite fragile.

Would splitting the spinlock in rtc-sun6i.c into "losc_lock" (for the
clock provider) and "alarm_lock" (for the RTC driver) make this
distinction clear enough?

Eventually, I want to split up the struct between the clock provider and
RTC driver so it's clear which members belong to whom, and there's no
ugly global pointer use. Maybe I should do this first?

Regards,
Samuel

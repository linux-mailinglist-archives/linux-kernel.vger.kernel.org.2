Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA2441AA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbhI1HsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:48:22 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:34901 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239462AbhI1HsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:48:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 90F0F2B015A7;
        Tue, 28 Sep 2021 03:46:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 28 Sep 2021 03:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=d
        tm6+SCKQFDhqHajeVv9mlgo//hwfhw0+BsVjCXiKJU=; b=gfWQKwKRnbVVOG5uT
        ZVsSIduZk65knrnWjTQ/i50fugQaOiTFwcSx+SD4h8dm2Xf/5dYP9tYM7QCIbcLj
        6/DRPEPWfVKCifTBfv2j007+Nvrtx69bXAu+rd3Ietc4SqzBXVtP998v08uAnx4x
        0pq3yWFc3QxJWq6W/MMtNv6+IuaXmpPGorIeDEDBhuUtDVZnZtW6t0L5hWCug6Vr
        MDtjQRekx4Y7e0+rruLdlRlO2heW/6zkcwfXJOaR67coAL0sf+xlBra2l3aQehJz
        AZayE6DDjHwAihcfzM2D+kIGel1B/spEDopSmrIRmtBvt4PpuixiCLto+L1LoKNA
        4wQ5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=dtm6+SCKQFDhqHajeVv9mlgo//hwfhw0+BsVjCXiK
        JU=; b=r4wM3dhpzOGmjMQw05l+XvQucQK7ERRBNELDW4xNv5ooyZXkxYiUNKArX
        ypguFps/Kfw8hDkBfCgMIZA6UuHJGP9H/zz39nMO1mEmbyDkjSgPLeBNYWc8sGCg
        HhMGV4NG4FEWaZ6damMJU+PcwFDLLA/Fz13QIDVHJQu5d4CQHpNZ85Zo75ZmkjBR
        pziE1YV8T4hZRVFBmCerupDMSU0SBCx8JD2tIQL2GQDBgQ9xmJvSvILdAGhEfWvL
        cbAT3TyUSZlB/tVlYmYq9vhnO6CLbRChbwmEvQM4jtU2xW90TqySnthsIT2QvB/X
        zFrLw9k3msAQVDxnFEuQ0lU6zFnig==
X-ME-Sender: <xms:X8hSYRLbcnZ3tEhKIDYzmSFliMXtzNfGPo6oBKV8PBrL5HdT3cQT6A>
    <xme:X8hSYdKOR3imuXyqpjDbMwBvPdHFig7Ihnid5CeAfApO2M2Kh8snqFw2n7JGpEcNY
    sweepnTxKfvjz2bWQ>
X-ME-Received: <xmr:X8hSYZvTwD0R5xuKeoCZYhTH-QQhPfH1G7fczje1R9bYWm6354ZnW8DPArrioRsbBOp8iloubYcsXPeefy2kUZtMJF9SsawN2cFkQBz1X_HA-Q6PvWQGxFnCGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejledguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeehnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeehjeeghfdufeefteelieeggfehteevieetueffhefhffekuedv
    ffevffevtedufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:YMhSYSbH_ko5olpDd9-v6slgV-fBRWPEuXSD2KQrXNyeeaNLU8Msyg>
    <xmx:YMhSYYazspyFDFsplobTh50mhHQdZ7_DOg2kUBW2ZYfYTKl84pOwKg>
    <xmx:YMhSYWBwz3nQ4juf-e3PybVWvoTcLqCbUsA5iJyVvaHkDGh7_9EZ-Q>
    <xmx:YMhSYWn9i6Jqm4_iYidDaM8pM5n5LyzY6ersnviICcpU7-XhjKdUGMVOYoY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 03:46:39 -0400 (EDT)
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
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [RFC PATCH 0/7] clk: sunxi-ng: Add a RTC CCU driver
Message-ID: <c910527d-e2d7-31ca-efd9-1915db62d85d@sholland.org>
Date:   Tue, 28 Sep 2021 02:46:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210909084538.jeqltc7b3rtqvu4h@gilmour>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 3:45 AM, Maxime Ripard wrote:
> On Fri, Sep 03, 2021 at 10:21:13AM -0500, Samuel Holland wrote:
>> On 9/3/21 9:50 AM, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Wed, Sep 01, 2021 at 12:39:44AM -0500, Samuel Holland wrote:
>>>> This patch series adds a CCU driver for the RTC in the H616 and R329.
>>>> The extra patches at the end of this series show how it would be
>>>> explanded to additional hardware variants.
>>>>
>>>> The driver is intended to support the existing binding used for the H6,
>>>> but also an updated binding which includes all RTC input clocks. I do
>>>> not know how to best represent that binding -- that is a major reason
>>>> why this series is an RFC.
>>>>
>>>> A future patch series could add functionality to the driver to manage
>>>> IOSC calibration at boot and during suspend/resume.
>>>>
>>>> It may be possible to support all of these hardware variants in the
>>>> existing RTC clock driver and avoid some duplicate code, but I'm
>>>> concerned about the complexity there, without any of the CCU
>>>> abstraction.
>>>>
>>>> This series is currently based on top of the other series I just sent
>>>> (clk: sunxi-ng: Lifetime fixes and module support), but I can rebase it
>>>> elsewhere.
>>>
>>> I'm generally ok with this, it makes sense to move it to sunxi-ng,
>>> especially with that other series of yours.
>>>
>>> My main concern about this is the split driver approach. We used to have
>>> that before in the RTC too, but it was mostly due to the early clock
>>> requirements. With your previous work, that requirement is not there
>>> anymore and we can just register it as a device just like the other
>>> clock providers.
>>
>> That's a good point. Originally, I had this RTC CCU providing osc24M, so
>> it did need to be an early provider. But with the current version, we
>> could have the RTC platform driver call devm_sunxi_ccu_probe. That does
>> seem cleaner.
>>
>> (Since it wasn't immediately obvious to me why this works: the only
>> early provider remaining is the sun5i CCU, and it doesn't use the sun6i
>> RTC driver.)
>>
>>> And since we can register all those clocks at device probe time, we
>>> don't really need to split the driver in two (and especially in two
>>> different places). The only obstacle to this after your previous series
>>> is that we don't have of_sunxi_ccu_probe / devm_sunxi_ccu_probe
>>> functions public, but that can easily be fixed by moving their
>>> definition to include/linux/clk/sunxi-ng.h
>>
>> Where are you thinking the clock definitions would go? We don't export
>> any of those structures (ccu_mux, ccu_common) or macros
>> (SUNXI_CCU_GATE_DATA) in a public header either.
> 
> Ah, right...
> 
>> Would you want to export those? That seems like a lot of churn. Or would
>> we put the CCU descriptions in drivers/clk/sunxi-ng and export a
>> function that the RTC driver can call? (Or some other idea?)
> 
> I guess we could export it. There's some fairly big headers in
> include/linux/clk already (tegra and ti), it's not uAPI and we do have
> reasons to do so, so I guess it's fine.
> 
> I'd like to avoid having two drivers for the same device if possible,
> especially in two separate places. This creates some confusion since the
> general expectation is that there's only one driver per device. There's
> also the fact that this could lead to subtle bugs since the probe order
> is the link order (or module loading).

I don't think there can be two "struct device"s for a single OF node. So
if the CCU part is in drivers/clk/sunxi-ng, the CCU "probe" function
would have to be called from the RTC driver. Since there has to be
cooperation anyway, I don't think there would be any ordering problems.

> And synchronizing access to registers between those two drivers will be
> hard, while we could just share the same spin lock between the RTC and
> clock drivers if they are instanciated in the same place.

While the RTC driver currently shares a spinlock between the clock part
and the RTC part, there isn't actually any overlap in register usage
between the two. So there doesn't need to be any synchronization.

Regards,
Samuel

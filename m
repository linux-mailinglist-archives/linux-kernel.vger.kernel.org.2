Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F64001B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhICPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:08:21 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:41511 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229589AbhICPIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:08:19 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6BFCB580AC3;
        Fri,  3 Sep 2021 11:07:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 03 Sep 2021 11:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=z
        5mHCFNJVJQnwxyX2kp+n3o7aK16eTMxU+sV+5V4RFk=; b=NyZ5IZM4jWZVqGE/L
        7qIdkLFQmRUJc09UK8U9+gykMm+Qk8Kg/3ri27BGEdoAO2r91LapiN403sqA3mUf
        mUHMd2KAseQpBBP68hLlz9ObG9SzX4kScWqLl8+QvSeGT0B/eAxua6H4AJUvTz7w
        7z4t7uPZL6l8smsm3oGFIufhRR9DqF15GfLH5UZk/0y39wMhcoR6+C0t1ONHNQ9Z
        VXEyOON2wz1yev0zAwJTYxC0zoov11UOiFTka2wZblBUfDBFPrfj/X4fetcGFsZo
        fZamwOZ8FaDItHeFW2YPB5LoK965FSF7eVQZZSq/9vib8rBtk/3zm4DGK5D/VhNC
        2ZNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=z5mHCFNJVJQnwxyX2kp+n3o7aK16eTMxU+sV+5V4R
        Fk=; b=jHHOJzg5zlxvduOl6u57EdlTxDfil7hU4f4K/DbnGnHXBgvo9gNPaWAKd
        IQRPx2vY11pDJBxugbk6QKP9vWW9pU35lljMpvTBCvRdNYOrNRZghjBNTJjjlQf3
        rbDkosNty7b+d+35tijA/ToZr9gFM5R1tpmrMTDVlxQtn4mUHo/iVrHotKAgb5Bs
        STgkcRopw2CSN4aKbWwwZPMXr4BmNxrAcBa0lp2QyIuGkkQPp2GOYi9feo6nLKKh
        FmVtP4EOLAM7nag6kSxHSa2yAkr64W0K2zvO6DNFN+HD8gJAHS3mDw+2PxnC5VEM
        gl25U/n2Akb5XSNW4PzreV0LRT4zA==
X-ME-Sender: <xms:JjoyYXl8-sMdSABXTc0sB-aIfnl4rLRbz-WMeginmSGcnDeUsDVWEg>
    <xme:JjoyYa3R_XLb2O7v3xTfBTelioQWUPnaWY9IcJM9gm77-bq_9eIjtA2sX8pqwIhII
    WJilP3wpWw3yJb6lg>
X-ME-Received: <xmr:JjoyYdoMUEkq_yMVpfDQOoJqqtyszwhSrz9zutcZ8-_pj7UAALdpLhS_57fymeKJ55ON6fvkGcaQzmnE_vMEv1TfP84Fit9KgRBhTdl2RAXrJbpZz5Qy9A6uxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefheenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnheptedtkeeivdegteefleeuudehffdthfekheeujeevhfdtvdffjeel
    uefhuefhveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:JjoyYfnAfEz28o-Tl_Ldg8LsByMgCWY_ZFhIzC-hpHZcH_HhLQHItw>
    <xmx:JjoyYV2kTbZnwfPP3Q9K2iQdYAXWUraQk-4u_14Ro2QQZ0worY0F_A>
    <xmx:JjoyYeslXQ3-1IKO10eP22UJvaX7M8JOrmnvrbcOpYDcAK9vZl_-uQ>
    <xmx:JzoyYfwRGFPkanDkBGtvIQJG4Bj7F8y4a5DOePtbClvkEC-IdVAkag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 11:07:17 -0400 (EDT)
Subject: Re: [RFC PATCH 6/7] [DO NOT MERGE] clk: sunxi-ng: Add support for H6
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210901053951.60952-1-samuel@sholland.org>
 <20210901053951.60952-7-samuel@sholland.org>
 <20210903145120.lfb3dkq66m7fpfcv@gilmour>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <8aaa98ef-39ce-6d2c-2b0f-7633aacefe0a@sholland.org>
Date:   Fri, 3 Sep 2021 10:07:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210903145120.lfb3dkq66m7fpfcv@gilmour>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 9:51 AM, Maxime Ripard wrote:
> On Wed, Sep 01, 2021 at 12:39:50AM -0500, Samuel Holland wrote:
>> H6 has IOSC calibration and an ext-osc32k input.
>>
>> H6 has the osc32k mux and the rtc-32k mux, but no fanout mux.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  drivers/clk/sunxi-ng/sun50i-rtc-ccu.c | 49 +++++++++++++++++++++++++++
>>  drivers/rtc/rtc-sun6i.c               | 17 ----------
>>  2 files changed, 49 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
>> index 1dfa05c2f0e9..9603dc0d3d7b 100644
>> --- a/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
>> +++ b/drivers/clk/sunxi-ng/sun50i-rtc-ccu.c
>> @@ -227,6 +227,16 @@ static SUNXI_CCU_MUX_DATA_WITH_GATE(osc32k_fanout_clk, "rtc-32k-fanout",
>>  static SUNXI_CCU_M_FW_WITH_GATE(rtc_spi_clk, "rtc-spi", "ahb",
>>  				0x310, 0, 5, BIT(31), 0);
>>  
>> +static struct ccu_common *sun50i_h6_rtc_ccu_clks[] = {
>> +	&iosc_clk,
>> +	&iosc_32k_clk,
>> +	&ext_osc32k_gate_clk.common,
>> +	&osc32k_clk.common,
>> +	&osc24M_32k_clk.common,
>> +	&rtc_32k_mux_clk.common,
>> +	&osc32k_fanout_clk.common,
>> +};
>> +
>>  static struct ccu_common *sun50i_h616_rtc_ccu_clks[] = {
>>  	&iosc_clk,
>>  	&iosc_32k_clk,
>> @@ -246,6 +256,21 @@ static struct ccu_common *sun50i_r329_rtc_ccu_clks[] = {
>>  	&rtc_spi_clk.common,
>>  };
>>  
>> +static struct clk_hw_onecell_data sun50i_h6_rtc_ccu_hw_clks = {
>> +	.num = CLK_NUMBER,
>> +	.hws = {
>> +		[CLK_OSC32K]		= &osc32k_clk.common.hw,
>> +		[CLK_OSC32K_FANOUT]	= &osc32k_fanout_clk.common.hw,
>> +		[CLK_IOSC]		= &iosc_clk.hw,
>> +
>> +		[CLK_IOSC_32K]		= &iosc_32k_clk.hw,
>> +		[CLK_EXT_OSC32K_GATE]	= &ext_osc32k_gate_clk.common.hw,
>> +		[CLK_OSC24M_32K]	= &osc24M_32k_clk.common.hw,
>> +		[CLK_RTC_32K]		= &rtc_32k_mux_clk.common.hw,
>> +		[CLK_RTC_SPI]		= NULL,
>> +	},
>> +};
>> +
>>  static struct clk_hw_onecell_data sun50i_h616_rtc_ccu_hw_clks = {
>>  	.num = CLK_NUMBER,
>>  	.hws = {
>> @@ -276,6 +301,13 @@ static struct clk_hw_onecell_data sun50i_r329_rtc_ccu_hw_clks = {
>>  	},
>>  };
>>  
>> +static const struct sunxi_ccu_desc sun50i_h6_rtc_ccu_desc = {
>> +	.ccu_clks	= sun50i_h6_rtc_ccu_clks,
>> +	.num_ccu_clks	= ARRAY_SIZE(sun50i_h6_rtc_ccu_clks),
>> +
>> +	.hw_clks	= &sun50i_h6_rtc_ccu_hw_clks,
>> +};
>> +
>>  static const struct sunxi_ccu_desc sun50i_h616_rtc_ccu_desc = {
>>  	.ccu_clks	= sun50i_h616_rtc_ccu_clks,
>>  	.num_ccu_clks	= ARRAY_SIZE(sun50i_h616_rtc_ccu_clks),
>> @@ -318,6 +350,23 @@ static void __init sunxi_rtc_ccu_init(struct device_node *node,
>>  	of_sunxi_ccu_probe(node, reg, desc);
>>  }
>>  
>> +static void __init sun50i_h6_rtc_ccu_setup(struct device_node *node)
>> +{
>> +	struct clk_init_data *init;
>> +
>> +	have_iosc_calib = 1;
>> +
>> +	/* Casting away the const from a pointer to a non-const anonymous object... */
>> +	init = (struct clk_init_data *)osc32k_fanout_clk.common.hw.init;
>> +
>> +	/* Fanout only has one parent: osc32k. */
>> +	init->num_parents = 1;
>> +
>> +	sunxi_rtc_ccu_init(node, &sun50i_h6_rtc_ccu_desc);
>> +}
> 
> Indeed, that's not great.
> 
> Maybe we should just duplicate the sun50i_h6_rtc_ccu_desc (and
> osc32k_fanout_clk) to cover both cases?

Right, I could split osc32k_fanout_clk like with rtc_32k_fixed_clk and
rtc_32k_mux_clk. Then H6 would use osc32k_fanout_fixed_clk.

Regards,
Samuel

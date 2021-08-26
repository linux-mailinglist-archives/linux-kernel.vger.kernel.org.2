Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEE43F7F43
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 02:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhHZAVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 20:21:47 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:57661 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231210AbhHZAVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 20:21:45 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id CAE0D580CEF;
        Wed, 25 Aug 2021 20:20:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 25 Aug 2021 20:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=5
        ujsR+nWOM34qVhCf5iPx4BoztRKl0Ef/LKi3phS+UI=; b=cBa9ZeCTqXipij9Qf
        L+kzwosi2cv1djoF6kzDSrCZ030qkVzOB2pEdiBiTRcCsq2mdpCES4fSY7ivS4Eg
        tg7eOEQEMPbt5mZHHSRyaMPh12vCd/scNQ0LZaCWNV4gWgjdEju8qcrA9v0SU6w2
        W0BcIzF3txTM6xNCNCjqrSnpRkrg32speLWFa3+NUZjXusf5769X5lQxUoxy2VOA
        /IATrEJuBTX7zEa3JY2pF6ko1gvGlOwSbZy5/H21Kkz5QKmxHN92NX7yyjPSwj9C
        I70BvUW1SOKX60m5SbC3k5TMw/TCKfg6FlBylws7S9uz9gNGu+kXTJhvZ26jdhwl
        Jf6Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=5ujsR+nWOM34qVhCf5iPx4BoztRKl0Ef/LKi3phS+
        UI=; b=Q1tYLPCHfF/cdUS1nRjZFN0jAYRwejRNYXLaW6uYu2pEIoaFCZYkOU2DR
        qvCx03Zm1YtPixX6zEexSA9G5XvMARuf0VLWdOqZCTZQ885eqlX2LGOZAO6y4w51
        KyheuycgwFmA7kvHJWsU8xcm2XJaR5APWSYfHdJGttjij+gtIx/IsZmJg5vzlnEN
        hN7/prKy2RzW1gBBM43XkPtuCepSR2Q2IS8Mdq416gkja6ZUe/AaapPG3ZlGLwFa
        nN+8YwkcZgkSJS8JuiqK8/IlaYFX+HMxcZMQfyBZzRIlP4hPCGlp92DLm9/tgD0B
        W7aNNQ8HN0nfJcRUxJxnDD8349faQ==
X-ME-Sender: <xms:Z94mYZWspjgS2bHXeI6po_VqnVEsm5DW-i2FIZT7Wzu1EJNTA2abBA>
    <xme:Z94mYZl1V3WlGHQXeTsOjULiw3ZZXstJy-157_uHIQMJnKShOuQkc7AE9tg_kX2XI
    oPHJEm-CEahJuoKQQ>
X-ME-Received: <xmr:Z94mYVbgUJhpyDYS_RjuQm5I1LITDLJTPtqFrfMXEEaMPnVI1ts1d-myqwFJKPcqZD7ItTx0fQGCn3QzxD7s9HV83P4_PAfE74kEBXJCf1t-wPcdWGzGmYEPSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddutddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Z94mYcU0KCy-dkAcySGlHKoP0cpFiIvscZ2p7ihOFG5R0YLBkNnZ2g>
    <xmx:Z94mYTk6Z6RwqrCd0iQAZb8_RuZti-XC29M-R4KTYvLU0FArk9ESGw>
    <xmx:Z94mYZectVkQdWOuKpgzFdtYn8CkgY0Nrhps96G7WDYBR8Oj7aF5UA>
    <xmx:at4mYRcDWAVTM-2c03H53IysZ2KzsyU9QizwW323f5vyNw6dDv6J-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Aug 2021 20:20:55 -0400 (EDT)
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@sipeed.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-11-icenowy@sipeed.com>
 <99a74950-fdc0-ecfe-e5f0-ba4a7d8751f0@sholland.org>
 <5432230.1UTMcGJKg4@jernej-laptop>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 10/17] clk: sunxi=ng: add support for R329 R-CCU
Message-ID: <5d0489ac-0693-f1f0-17d5-bfe9ca5df0ff@sholland.org>
Date:   Wed, 25 Aug 2021 19:20:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <5432230.1UTMcGJKg4@jernej-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 11:34 PM, Jernej Škrabec wrote:
>>> +static void __init sun50i_r329_r_ccu_setup(struct device_node *node)
>>> +{
>>> +	void __iomem *reg;
>>> +	u32 val;
>>> +	int i;
>>> +
>>> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>>> +	if (IS_ERR(reg)) {
>>> +		pr_err("%pOF: Could not map clock registers\n", node);
>>> +		return;
>>> +	}
>>> +
>>> +	/* Enable the lock bits and the output enable bits on all PLLs */
>>> +	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
>>> +		val = readl(reg + pll_regs[i]);
>>> +		val |= BIT(29) | BIT(27);
>>> +		writel(val, reg + pll_regs[i]);
>>> +	}
>>> +
>>> +	/*
>>> +	 * Force the I/O dividers of PLL-AUDIO1 to reset default value
>>> +	 *
>>> +	 * See the comment before pll-audio1 definition for the reason.
>>> +	 */
>>> +
>>> +	val = readl(reg + SUN50I_R329_PLL_AUDIO1_REG);
>>> +	val &= ~BIT(1);
>>> +	val |= BIT(0);
>>> +	writel(val, reg + SUN50I_R329_PLL_AUDIO1_REG);
>>> +
>>> +	i = sunxi_ccu_probe(node, reg, &sun50i_r329_r_ccu_desc);
>>> +	if (i)
>>> +		pr_err("%pOF: probing clocks fails: %d\n", node, i);
>>> +}
>>> +
>>> +CLK_OF_DECLARE(sun50i_r329_r_ccu, "allwinner,sun50i-r329-r-ccu",
>>> +	       sun50i_r329_r_ccu_setup);
>>
>> Please make this a platform driver. There is no particular reason why it
>> needs to be an early OF clock provider.
> 
> Why? It's good to have it as early clock provider. It has no dependencies and 
> other drivers that depends on it, like IR, can be deferred, if this is loaded 
> later.

Another reason is so the driver can be built as a module. Each of these
CCU drivers has 30k-70k of data in it (lots of pointers, plus lots of
relocations). So it saves some RAM to only load the ones you need,
especially if that is none of them.

Regards,
Samuel

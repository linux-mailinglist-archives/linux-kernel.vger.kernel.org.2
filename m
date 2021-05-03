Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8078437112C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 07:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhECFKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 01:10:11 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42345 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232918AbhECFKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 01:10:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 274F15C018B;
        Mon,  3 May 2021 01:08:10 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Mon, 03 May 2021 01:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=eKcsIACmrK4wAg4OAkYo77TNYonA7V1
        j6yg8h3K+bwg=; b=RnbzLX1SFivCa36c8XPklHIzndeRpbPVxkEvtI5OuB1y3Mj
        1ogruIaQchXUWnjuqqMqYCr6WOO1+K3bGxZyvOzmbNIieDfhZtkG66DD8W7iVF36
        LczfsuP1yXGB5OTk37Ip2HjSzl7HdK6Cvk6R3/L02uM6+tFOdgfsn9Mcy24hYCyu
        4sOgACozIYjWDMR6eH1dsT8hcfei9SK0Ocbv+dHMBFgwqS9FKwcOIdZnyY11wUfd
        nYnFDZHX/cn182W7FaibvBQOWdqq/M4rY16glNl1KGsAKjaJxSVgNzbq5zp2CCCX
        e08Zc2rlBAAchzPgeIbE3C4M8mf1E9n2H4vw0vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eKcsIA
        CmrK4wAg4OAkYo77TNYonA7V1j6yg8h3K+bwg=; b=MjRnYEdNFY0f5JJgv8Sj0E
        77nXxGpl+L3XH1u4msaoMmRVL/DX/CL5q6n8ALdEDdobzPOVGm1fBnFOOvG9ajtO
        iYh8oYsWHtH7QiMbjQ/E/KiHNLXMMhZYPoodoEAHZZyfhcpTcuuwEBIvsgb+uMkO
        j2CF8F0eteoGJEsYWLC6CH7D4lI0+T4vyDi7zwGjlaXFfS4RjslzFdNGFNeUBazq
        lU3ZOQ8avKZHZqZtcDlwJfkqdb9zcEFaCr5/YvcqDxugwo6k3EKQSThThuMysQsL
        rv7v6T5HCrf9iDhnRE6WnszQMvlK5TXihXe8Xi0Gjg2TC0kr9wAI4h8z090+h1JQ
        ==
X-ME-Sender: <xms:OIWPYIheEL-K2-8n6PujesqIqSPQYY2vByDrI5x_DIykwLTQBSlMEQ>
    <xme:OIWPYBCMPGwpP6TYj4YSCxP8t8riNA7j6wPEu83UUJ46xCxzKwr_XR9Kb1z7vg8oP
    iOgBpw5sUUWPBPaAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeffedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:OIWPYAFbvnHlNC--BcDHp0tY2yVFgKarY0vnqZtzwtdpC8Qr1k6lmQ>
    <xmx:OIWPYJQRn3uauxFoFfS62utu_Sm6HXRQCGBLLbG2bmGLzEBuIYjzeg>
    <xmx:OIWPYFw4OVXW0I3AAaxMreP-ODDVihFqVdaRVX8wcKePfQMTgYodjQ>
    <xmx:OoWPYEw6IV5kb6uGK6-OQccqtf-14si--YGTedFmcqLw1XO15WyCMg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8A94CA00079; Mon,  3 May 2021 01:08:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-403-gbc3c488b23-fm-20210419.005-gbc3c488b
Mime-Version: 1.0
Message-Id: <f237a53e-ad61-469a-a19f-8a1e52c6cfba@www.fastmail.com>
In-Reply-To: <20210503014336.20256-3-steven_lee@aspeedtech.com>
References: <20210503014336.20256-1-steven_lee@aspeedtech.com>
 <20210503014336.20256-3-steven_lee@aspeedtech.com>
Date:   Mon, 03 May 2021 14:37:47 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Steven Lee" <steven_lee@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        "open list" <linux-kernel@vger.kernel.org>
Cc:     "Hongwei Zhang" <Hongweiz@ami.com>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_2/3]_ARM:_dts:_aspeed:_ast2600evb:_Add_timing-ph?=
 =?UTF-8?Q?ase_property_for_eMMC_controller?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Mon, 3 May 2021, at 11:13, Steven Lee wrote:
> Set eMMC input clock phase to 3, which is more stable on AST2600 EVBs.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts 
> b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index 2772796e215e..7a93317e27dc 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -102,6 +102,7 @@
>  
>  &emmc_controller {
>  	status = "okay";
> +	timing-phase = <0x300FF>;

Please use the existing binding for phase corrections. The existing 
binding is already supported by the driver (added in v5.12).

Andrew

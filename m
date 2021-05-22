Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC1138D631
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhEVOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 10:47:54 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35787 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbhEVOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 10:47:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D0EE0580548;
        Sat, 22 May 2021 10:46:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 22 May 2021 10:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=l
        +A4yTvicWmupzboZaUYCZiVaO0UIe5ScpESUsU9qVg=; b=mwHxG35kMgCv7LB1q
        m93yPspC9iIzIASxKMhRZY1PR8SrosB/MEsjWl4gSBI/JdqPGpa6FuMTsgIiAfmI
        YzcaAdan8ZtJ62q+q/Bc6u6WLJFy7Ll3nD2//RqnaI/LmDnQT8d9FUxr4KBtH5Aq
        kSMzbC1/IrxXkwWEG9gttRmEfB5uMoGPeJB89QCsKnUmrgUzWgHid8s0UGjDJQah
        DZ8K9q4ZO3+k0U9XkySSvPnwGVYHaDFLT6/2iS6ozm6Kice/zU7Lx8LOts5JfRr+
        VkU0qSgF5vxQNvueWpEe6+Erc+razb106C0+GvS6uySIgG//rx3sPaAxshpkP038
        s8sAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=l+A4yTvicWmupzboZaUYCZiVaO0UIe5ScpESUsU9q
        Vg=; b=iyAe4uF97inD6q5ixipJ+wohnSaIU0vpOgaqTbb9qhER7he1xfsSQsST5
        FfTT471rBYOLmhMPq50VrLdjulb+EWRly8UVHItfjEPTtOJwgvzmRCwreiC+XnnR
        dT/ZIwssiN+AvtoTBh+v+oV0u/hijmmhJYHxSFXbEPAyF8Ln4UaE4Y4LaZBFJuNK
        788Cto/lEqgvKlIPBsUHC15V8fRKixJhUQj5sbRM6l4maXDlHpyvwCr6A45dMECF
        L/cDdaaNlZ7vWKmidBmIPRV9dPBD5YMgRpP49qUgSDSPKbDSgVDht1/kYFRp/l+A
        /fX4qA43zzt9GdPhLrMtAj7dU+kHQ==
X-ME-Sender: <xms:QBmpYJjkpcFS2_wmtrqZSvtpo3bySRLsojU_b8LHqP2TTcUaPhogZw>
    <xme:QBmpYOAAGVPZMl09HHqrIcap2pjOC_232fNRDnZUdN1-E4IYv0bijB8LmqPWtRxSN
    Ms_ZhJ03KB0u3JefA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejhedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppedufeeirdefvddrieefrddvgedvnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:QBmpYJH3Tt5O3b2M96vRFL50wX_Wt_3hlqUzCXyvK8IX6sDkYXFHCA>
    <xmx:QBmpYOQam9bpn4SgZ4Ah3aUlcHYFuOhrgdTWld995fbQ1VODx1qCCg>
    <xmx:QBmpYGwPp3iT1KdpmG90bNgtnGAhN5X2Q3tDhsu5UtdE2gjYwA9U6A>
    <xmx:QRmpYLpU4P3ia9SLLd4VKUaYzW3tpJvYn37TKMBl2XKtPL07Hy5c5Q>
Received: from [192.168.18.153] (unknown [136.32.63.242])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sat, 22 May 2021 10:46:23 -0400 (EDT)
Subject: Re: [PATCH v6 01/17] dt-bindings: mfd: axp20x: Add AXP305 compatible
 (plus optional IRQ)
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
References: <20210519104152.21119-1-andre.przywara@arm.com>
 <20210519104152.21119-2-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <7ebfaef7-5cf2-e60c-99ef-4275c873e72d@sholland.org>
Date:   Sat, 22 May 2021 09:46:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210519104152.21119-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 5:41 AM, Andre Przywara wrote:
> The AXP305 PMIC used in AXP805 seems to be fully compatible to the
                  ^^^^^^^^^^^^^^
Typo? Do you mean "used with the H616 SoC"?

> AXP805 PMIC, so add the proper chain of compatible strings.
> 
> Also at least on one board (Orangepi Zero2) there is no interrupt line
> connected to the CPU, so make the "interrupts" property optional.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 4991a6415796..4fd748101e3c 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -26,10 +26,10 @@ Required properties:
>      * "x-powers,axp803"
>      * "x-powers,axp806"
>      * "x-powers,axp805", "x-powers,axp806"
> +    * "x-powers,axp803", "x-powers,axp805", "x-powers,axp806"
                   ^^^^^^
This should be x-powers,axp305.

Regards,
Samuel

>      * "x-powers,axp809"
>      * "x-powers,axp813"
>  - reg: The I2C slave address or RSB hardware address for the AXP chip
> -- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
>  - interrupt-controller: The PMIC has its own internal IRQs
>  - #interrupt-cells: Should be set to 1
>  
> @@ -43,6 +43,7 @@ more information:
>  			AXP20x/LDO3: software-based implementation
>  
>  Optional properties:
> +- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
>  - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
>  		      AXP152/20X: range:  750-1875, Default: 1.5 MHz
>  		      AXP22X/8XX: range: 1800-4050, Default: 3   MHz
> 


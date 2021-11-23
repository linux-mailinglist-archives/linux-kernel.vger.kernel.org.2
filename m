Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA27145A215
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhKWL7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:59:55 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40715 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234881AbhKWL7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:59:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A40575C0190;
        Tue, 23 Nov 2021 06:56:46 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Tue, 23 Nov 2021 06:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=JPbgvbtJj9eTbsDi9kr3t/yTaBzv
        KOloHJCm1F/slHc=; b=RJr/98uODB+qsu7zoJ/qli/XMe5ViKA0VMd+uukriHLF
        fKKNygR4S1Kcdl6I6QKBUbr6MUvRCt4idtGgeHtbMA1yNAse8kPcQnVjQZDGVj4Y
        nm3m7QWKzylrdVssGyIHbo9GH1M+rLt140br5f/wQ8AoWbc4wJfeMDF2MvlToS8n
        t+mrV9eW5g/x38/4DOb/ayz+SXPY5R//2D+g+8rFEPmKEvmGClf2OQyPflO0NklG
        dmI73vdjnSBGL7pQGjEqnCEutL82j/TN5jVMqzNUhR9t5rAPDWEYM47KBN116keE
        v7ks+nWxDhE5LjcoE5WYhHgI3iks5YGpnLBRSq+Gww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JPbgvb
        tJj9eTbsDi9kr3t/yTaBzvKOloHJCm1F/slHc=; b=dUUKhjhoIZl1MotiW35D0H
        wvdQAsyQFn8mOExti5L4ifeCBBex9I2regEusYpI0xhd1wTRDea1VyHonSd4XtGe
        r5kcY0j14NfxUkVWvBtjAB2JMRCY70X5gaB93a1IyA7lcEM6UfI/G1WWoh3iCjI2
        LmTt5LJEZWepg0pQF9urYVmwJgtcykoFlfjVmcnXzX9XbfUdYzlaAu3wAJTHLTFC
        CojzIr8riniG1d9pDH/h/NZ6yvWX69vx868ShcolRPChf9Za4LQnNyBt24Auxqwk
        YvVyJu1SHTLmImi++t1xu/NbvKs1khxmV8sK8wA5311sGMgW+Gl8Rr1ZU53DNr0g
        ==
X-ME-Sender: <xms:_tacYYffuEMqXRvUwtZk9v_Mlg2oI9G4ORNwKKBM9_S5gcXSjl0TWg>
    <xme:_tacYaOS9Fiw_ave2sakeF_oUavFrj4DXTMQ6Tifx-lgGw54eYrXdCije7QQVYe12
    cknghezaBzPfIejfvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:_tacYZg5hRu8jZdgEe5sWjrOjuPEIto9EiE-y8lQKFOVju85vijs9w>
    <xmx:_tacYd-Be5aDYzWerrBKNuE_l1aEYIeobwR4V-9cMQdiF3aQFemGBA>
    <xmx:_tacYUtqHGEn1zuU7AnRVSrko-ejOQe6rhVHbXtZPWga_HG02WdnMg>
    <xmx:_tacYWL1jTSORaDg71MfueI_dMKCNAYxj8HQ0DnzRtjjx-i7o7RdKA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 75ACE2740616; Tue, 23 Nov 2021 06:56:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <f1fefe77-2d19-434b-9fd4-d1c51e46cd5b@www.fastmail.com>
In-Reply-To: <20211122225807.8105-5-j@jannau.net>
References: <20211122225807.8105-1-j@jannau.net>
 <20211122225807.8105-5-j@jannau.net>
Date:   Tue, 23 Nov 2021 12:56:26 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Janne Grunau" <j@jannau.net>, "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] arm64: dts: apple: t8103: Add cd321x nodes
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Nov 22, 2021, at 23:58, Janne Grunau wrote:
> All M1 Mac devices have 2 SoC connected USB-C ports and use cd321x USB
> type C port switch and power deliver controllers. I2c bus and adresses
> configuration are for all devices equal.
> The iMac (24-inch, 2021) has a configuration with 2 additional USB-C
> ports (j456) using two addiotional cd321x controllers.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm64/boot/dts/apple/t8103-j456.dts  | 18 ++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 18 ++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apple/t8103-j456.dts 
> b/arch/arm64/boot/dts/apple/t8103-j456.dts
> index 7267e069355b..c6b8c28455f5 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j456.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j456.dts
> @@ -21,6 +21,24 @@ aliases {
>  	};
>  };
> 
> +&i2c0 {
> +	hpm2: tps6598x@3b {

I know that the tps example in the binding uses tps6598x as the node name
but I think that these names are usually more general. Maybe usb-pd@3b
instead which is used in arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
and reflects the function of this device.

With that fixed:

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Thanks,

Sven

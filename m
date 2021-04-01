Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04A3510CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhDAIXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 04:23:22 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35053 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233258AbhDAIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:22:54 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A1FFD2D64;
        Thu,  1 Apr 2021 04:22:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 01 Apr 2021 04:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mFxFZVk7Wi/iNITvlOKppk48zHV
        IoNvH1gnqNHIDvps=; b=arHCLQaxq3JBbz+8aKUOen66gJi5QFuJbHnh+o0flr1
        msyTbECUujvTzYBS6kYQ5I403WMb5e2hl8fGt8JPujlLv43qpeUzzCv4b09cRknx
        EkHMEtjiuO7uNSiPawtW/1EIPQWNQlLC5wvC139apmsgDUz9NHLEBmFUZGYt3Gbb
        BGXfMap0YewlNxYGh0CytlW7EarMZmnw7vAb+H2MeS1pDI2guYV7DWMR9KrnWFTX
        iz3qoEjZkYB/cWDGN7g6NO+xp1eOBDAc1SVa9Xic047rkY1tc/O0t5sUASD2w4OZ
        vWlcJh8+swvrQ/EdKmC9XWVkxkFWSL1AdlXgsryXBhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mFxFZV
        k7Wi/iNITvlOKppk48zHVIoNvH1gnqNHIDvps=; b=hAQMtW8Mmhk4LKxCLhtleT
        a+5+GUC+ARmU5o0SZxDZYxu7/hSPURAw0m6piwuHQ1gHt5nSUo9PuSn/FufDI/9H
        LARR5pSCFLa/Va/OynuELqyF1uqspG6/p4OMI7C/eBjwVulw8wtqS297SoZjJddj
        z/G2e0NLbj8pI4MJmoNDfQnWioWQAq7Es6XVVswQ3NN1pumv1ItfIfqdkf6BWhZl
        UvFyMI1I5a/+7R0gULiBafxvbR6mwYxfcpJfqmOn3+GDFR6jf10bWIqe2fnLoBTJ
        dAbLF3FMCESLc4Pc3hCYTZojU7v7VrRL80h4yXjN/RB0Ap430zO8qHi9uaJptWNg
        ==
X-ME-Sender: <xms:3IJlYHkLZixJ00zl_SQzHNhdPnjzgX4hjefvLqzzeB0ha9hOumrBxw>
    <xme:3IJlYK20Q18t53C4CqCOx-57Rbz9d8XF1ccWcp-GBKOdjx3GUdK5lmoettzZyg7pL
    RDMQM-eZUd7wyMUi3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeifedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdej
    vdfgveenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:3IJlYNqzA_GLs63No2neyANK5i6TXzLWcFNBbC2b5VmyVKJcPwLvow>
    <xmx:3IJlYPnbBBCUx8LTDt-1ofAJ0g1XdLrFFr5pk0yMqKGkAjpMMbrzuA>
    <xmx:3IJlYF0jgyMdfXAlmmHDQls_Z0WXJ9FzYoce70jEQZ_tli63sKgJIg>
    <xmx:3YJlYN_bt5OaulYyGohJ4BH5KW-JwxS3VHq2H_HyM_YVDjYokCFKrQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2988108005C;
        Thu,  1 Apr 2021 04:22:51 -0400 (EDT)
Date:   Thu, 1 Apr 2021 10:22:49 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH] arm64: dts: allwinner: h6: beelink-gs1:
 Remove ext. 32 kHz osc reference
Message-ID: <20210401082249.cga2nxbh7rdsr5gz@gilmour>
References: <20210330184218.279738-1-jernej.skrabec@siol.net>
 <CAJiuCcc4hs781Hz_=tehcm4S2nci8e0DEJKeUY5ck=bpcgNUbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sahzod6j66lhpjug"
Content-Disposition: inline
In-Reply-To: <CAJiuCcc4hs781Hz_=tehcm4S2nci8e0DEJKeUY5ck=bpcgNUbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sahzod6j66lhpjug
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 31, 2021 at 03:43:37PM +0200, Cl=E9ment P=E9ron wrote:
> Hi Jernej,
>=20
> On Tue, 30 Mar 2021 at 20:42, Jernej Skrabec <jernej.skrabec@siol.net> wr=
ote:
> >
> > Although every Beelink GS1 seems to have external 32768 Hz oscillator,
> > it works only on one from four tested. There are more reports of RTC
> > issues elsewhere, like Armbian forum.
> >
> > One Beelink GS1 owner read RTC osc status register on Android which
> > shipped with the box. Reported value indicated problems with external
> > oscillator.
> >
> > In order to fix RTC and related issues (HDMI-CEC and suspend/resume with
> > Crust) on all boards, switch to internal oscillator.
> >
> > Fixes: 32507b868119 ("arm64: dts: allwinner: h6: Move ext. oscillator t=
o board DTs")
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> Tested-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied, thanks!
Maxime

--sahzod6j66lhpjug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYGWC2QAKCRDj7w1vZxhR
xdRUAP98mht4QDA0E+GvBBBjnbwPTWapaHzCmloS9QKs5nt9DwEAqMaEtKS1lKR7
EKzh7XaCvKOipYOo8p2v3Vy6jfbTFAI=
=z+KP
-----END PGP SIGNATURE-----

--sahzod6j66lhpjug--

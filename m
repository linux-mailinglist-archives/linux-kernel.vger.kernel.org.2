Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FE3403562
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350141AbhIHHay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:30:54 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44091 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349905AbhIHHam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:30:42 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 07F5B5C016C;
        Wed,  8 Sep 2021 03:29:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Sep 2021 03:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ks8gtlQeP8tdbqgc739lJC7l4dK
        PElX86y7rDiTVIP4=; b=0QOaESaPPQFPd1h08xZwPDIfeTuD2LTmZFEx+AHxLwv
        UdQv2aaKxFrE/pjnsweDVmuBwzxF5SL0sgO9C6GwnGNOq9ULVTaWhApvhmEWSj32
        bwM1xLFRwpvj0ZbAOZlZ+wTELPNymIwL434TshbXSwUjASZRw9holGALtZ45OlDK
        d9AOG/LRBDPO+uVLB0SXz5mONnGJgHlzx8GWGKtW0sZWpxiw6+EO7JS4MdM2WIwZ
        2iR669FCf9itJMEwpDkOM6tBYrs9IGaTtcr+r3MLbjXaS3PkC9d9DgMO+CQaheqR
        keMZgQ58oy+N0EF9F+yeBTgK0Gem89k/iCGliVB2Zww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ks8gtl
        QeP8tdbqgc739lJC7l4dKPElX86y7rDiTVIP4=; b=PVSq1MyIPDyZnykik95y15
        DBXsa/dJQBLvf4aKU+VDpHp0gjptWeF0Y0KshhHRBggUkbqTBTHiCPqGgEFqMlPH
        CRf8/mldpvYjU/Tx8DzHMjjp8uMhj18S4+GGvQqix68b1wLh6RLq2jO8X6kRkFvN
        IhFdcB8xRxhiO5Oopc/wE8B2QElShHOSK+A1G0Hjs/NSZOgTZXnmkZkTGMdxTESz
        FDqkRs1tSSbrAKpps7SMxw+S2vpzMTlRdXx07BgiQlOSNhD9aKUADNdr7o26m5fr
        vq/nff+S6afPDEsxcyn6vqtDzfXUAzvz6OvU4w16+nQjC5QJn307+urVDmJCyugA
        ==
X-ME-Sender: <xms:XmY4YTNnaMyAsG7_Z1Pi4t5VPP6ZEpfyKhKh2dJbtcHKX8SkVJkcVw>
    <xme:XmY4Yd_eJXonZv2tfXDhaloDOX9EngglVB2TuEMMV9Qj_Wmaiq_hxMYTDCs8Ktubq
    5csm4PA4CxIwgFhXT8>
X-ME-Received: <xmr:XmY4YSSXUNepVyXP42R-2iu3mnXGnPlkYcQcgjX7TUG7iUUAZow2o89m4PYMu8KI0MpymssUppYd9kEelgZHfG5lQ4dtjrH_mqGa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:XmY4YXseLucRRLn5iOr3RMkdhA8PnrHOvZifzQ1WiSnfNb67N3CxMg>
    <xmx:XmY4YbdArd1MQDPEQ0wxAcJiS9tf_p-oj3b6xZDQAV6MIVK7hjTn0Q>
    <xmx:XmY4YT2Ug-aclQlrH4xDO5-AXIsHMeo0wFQAVErvrovMeiPk4HWyGA>
    <xmx:X2Y4Ydve0N6Bkqh8yg6ogoYaGkHIp2sgKrTw-xBZZ02tflZI-r65_Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:29:34 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:29:33 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun9i-a80-usb: Make use of the helper
 function devm_platform_ioremap_resource()
Message-ID: <20210908072933.2tgoy2iywfyaeli2@gilmour>
References: <20210907085250.4917-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xc4j7jpn47app7gg"
Content-Disposition: inline
In-Reply-To: <20210907085250.4917-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xc4j7jpn47app7gg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:52:49PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--xc4j7jpn47app7gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmXQAKCRDj7w1vZxhR
xd42AQCpQ9lSxU0lgIhgoiC2yPBtsI55CKtyELIHCq2gVAW8AwD/Zae4psWo5e+5
dvSkeM+1+JA0jPoxApNtOn0tov0yKwQ=
=yiys
-----END PGP SIGNATURE-----

--xc4j7jpn47app7gg--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA0E45F1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbhKZQbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:31:16 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:58085 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238745AbhKZQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:29:15 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 531283200708;
        Fri, 26 Nov 2021 11:26:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 Nov 2021 11:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=4KvT7F7q5WrSih8F9Cj3xPKgOTO
        OwUquNqv/1YHmL9o=; b=jgpZfPPMtK/uXoQuaI36Edf/rqbtl9imkG06XWyd+bE
        D60ZdPewQmjR2CEVrp/L7w/zf09NogA/nShU+/ghBQ9PgrDLdBYpSE74kuQmTyXX
        0iuXIGVYwRNzPLva9AfjI2FUdGo4N+cQfu01Tu+8uNSRXa5ldKOQMUrjnLJUZI4X
        rABTI3+UxdoYIELe4Qij2TDvpBFKV5DACyZdG7lMBz04sA/r/ZwZuXgOhmY8E52y
        CYRjRPfFrdo/+5lBy1mICW6pk+xi9drJ22fqr0Lnd1wMbgu0hShkuJb2PuRhIczw
        e1WXX+k7JE/ALsSzF3cyUNajzgtk+oEIg4GVXIw42IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4KvT7F
        7q5WrSih8F9Cj3xPKgOTOOwUquNqv/1YHmL9o=; b=aRyQ6rISli5+xM8/omVIS0
        x2tSsOu1ma/NPIC+wEQqQUAu1XjoNC3T6dPZtOUietQ4+lckSdP7owX/EQUFDVnh
        hkAHZNcSPlZap5GmhB90rC1KBkJrb+zTkiduWAJhnKh2UNAKVYVCPc6OVpJxrPqW
        PpbQ1BHX2rugDXcBKLvX26q5TNCLVcAysGiYF9TndGfMNzH0uWxvOdYsT4D6zQJt
        tlmql8J8CVqTnpDkK0Qpo7nRXHXfpRFMxXxeRTW0IcBd/aLgLtBc4FLFapsOkbjC
        vrUFSEGmq9e92DyiZdS9T2k7E+T+OMfy2gy31Cu2wBJrrQkH3LZesphOX62/5I2w
        ==
X-ME-Sender: <xms:mAqhYYR4OxrqAdUfIClPwmvo3ei0YKAFAr89dTc_BBsDzUpf54kbEg>
    <xme:mAqhYVwEP3PeoSORyJM5cd9SlQGqg8vBw4CLsR_tu7_bt2fwl6ZJwUJB7O3xSd0QV
    pl-DzsZSde1p77ya10>
X-ME-Received: <xmr:mAqhYV3b73Oy461TOUwWgVwUxA9o9fIwoKG21jXxtLK8cxpfDWwbok64fl6kA7wC78E7IL_be6eDOTtuYlsCvlPLAVwnIrT3b90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrhedvgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeeutdfgjeeuudehvefgvedvtedtudelfffgffekledtffekgedukeejueevieeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:mAqhYcBg1QBsCDHz76Q2HJN07EFw2kWTFFMe0W9ci2FGAtYJlujU-A>
    <xmx:mAqhYRh2Cv1rOjdXWSFeZKwagNgh9mPv0i2Umz1G8wHT51WlE8QPAg>
    <xmx:mAqhYYp0lFJOnu2OO7DdXAg_hNMbRM5elzbP2ldugzpuKKLDFYLphg>
    <xmx:mAqhYcUGSOewK6cIkqgvVaxXwrbmdMBPNTS6nfcDL8CLWG8nXPualQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Nov 2021 11:26:00 -0500 (EST)
Date:   Fri, 26 Nov 2021 17:25:58 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michael Klein <michael@fossekall.de>
Subject: Re: [PATCH] ARM: dts: sun8i: Adjust power key nodes
Message-ID: <20211126162558.5wkiy2bdmeutn7e7@houat>
References: <20211122213637.922088-1-jernej.skrabec@gmail.com>
 <20211123103219.4y2pjywt2uxunc5s@gilmour>
 <3138437.aeNJFYEL58@kista>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wgw7urj4luna2nuu"
Content-Disposition: inline
In-Reply-To: <3138437.aeNJFYEL58@kista>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wgw7urj4luna2nuu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2021 at 05:42:55PM +0100, Jernej =C5=A0krabec wrote:
> Hi!
>=20
> Dne torek, 23. november 2021 ob 11:32:19 CET je Maxime Ripard napisal(a):
> > Hi,
> >=20
> > On Mon, Nov 22, 2021 at 10:36:37PM +0100, Jernej Skrabec wrote:
> > > Several H3 and one H2+ board have power key nodes, which are slightly
> > > off. Some are missing wakeup-source property and some have BTN_0 code
> > > assigned instead of KEY_POWER.
> > >=20
> > > Adjust them, so they can function as intended by designer.
> > >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > [BananaPi M2 Zero changes]
> > > Signed-off-by: Michael Klein <michael@fossekall.de>
> >=20
> > This looks a bit weird. If Michael is the author, then his SoB should be
> > here first and mentioned either in From or Co-developed-by.
> >=20
> > If you are, I'm not sure why he's mentioned?
>=20
> I'm main author and Michael just adapted BananaPi M2 Zero DT based on my=
=20
> changes. What is preferred way to mark him as co-author?

Co-developed-by would be the way to go then

Maxime

--wgw7urj4luna2nuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYaEKlgAKCRDj7w1vZxhR
xW5WAP0WFEwnYvZgjWkUDwvcnRL73xLfaKOfHHLNS//l7TDeIgD+K0F3/JIve0OB
PzUsICsxdi6aTGapHmnL1iuJDxmxwwc=
=Q2RU
-----END PGP SIGNATURE-----

--wgw7urj4luna2nuu--

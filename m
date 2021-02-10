Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2C316400
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhBJKhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:37:33 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:51503 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbhBJKaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:30:17 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 33B34C41;
        Wed, 10 Feb 2021 05:29:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Feb 2021 05:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=oIa/2Qot3nAjg2o97/YX6K/oHZE
        bZ3WonfjT0JArODs=; b=l8yfqApM7aybXQ/4V2KFaP0E8A08zx33dGddvnt5mh2
        t403i7nKaKwXtlDbCAR1wHi+u+MoJ21lS/BDZagY0aHVbK4BoeYQAm9/Z+wNng3T
        f6mDzoYKJMa/ldtlFCOJt9e9I1e+THvpdYO3Q6+bOvQ8rMofoeHW+reWrLfL7z8G
        e+ZQpR3LyVktM4wBDIZ3lKDDQo5v93GuUHq1FshVSe4qJfhsPpLcgT7Wk17wZOIe
        EIOytHwRDWJGW9TnyjNiqvS0nkTeUUeeS0jCr7B2+av1jGKmyVmZawnvicmnoKs6
        cPxcx6YD45xX2OcXVHHbrun8oShgDs1cA4zCyLgWxJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oIa/2Q
        ot3nAjg2o97/YX6K/oHZEbZ3WonfjT0JArODs=; b=aM80EBujFemviFs1HPNFQX
        +Dj+kJ2DV1N5xzs/62T0zZz/Dm3el+9WiJJrbZZ626gdrfnVV3cGa7JoNNiClur0
        KcnwczuUpKG3r05qNezT99p3U7QsENJ2OKVAOwij4k7p3/sjU9bxZ/uS9Io3VxpR
        7MvOU3oqqvZPuVOrDTntwIFBOjHiNv6eUdbY5URSk848SxlmX+uYcHLiMl8Ok4Uw
        UQAJAe4QpriUpY2gSnCDk6k9mV3iyX6/Gu5WmYPH+5aiAMAEA6kYre8sDVtz5BNA
        aYR7xEvkk3HqttkA//76ff01rB++M3EOP7+M3ofNzZtyfsB5PnHU5Cn+KvCkVtYQ
        ==
X-ME-Sender: <xms:irUjYBUsfZ_5cF0rJ9gEAt0Y0N7DdXwxShcdimiPJDJGLUccF5GRAQ>
    <xme:irUjYBm_OH9ecLMV3vmUX2-BJPuI1fkN8Z3UNw8Y9qWxT8vwbmeatZiqaUK7oS58n
    Ikc3cyWN3Hqe7rIRso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheejgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:irUjYNYrRvdNSP7YW5A97BdTjmmZ4rosV4OmpeK86JZlorouK8LOWw>
    <xmx:irUjYEVabpaVHLFA7weG2AERutHpRqp0UcZkPTUdkIttQu7bbWtiGw>
    <xmx:irUjYLkx9nvHGORe_6ztSQmRUQ2PbMWRIklj-PpnM1U06ktoFZBWng>
    <xmx:irUjYN61z6kV13tJ8QyntRarhdV3c7JYPwxZuhW-vKhwGnhA7sOQWR6v134>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 68119108005B;
        Wed, 10 Feb 2021 05:29:30 -0500 (EST)
Date:   Wed, 10 Feb 2021 11:29:29 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 0/5] sunxi: fix H6 HDMI related issues
Message-ID: <20210210102929.mkmxrwyku3js2zvp@gilmour>
References: <20210209175900.7092-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ju3jwli3ct6v5xkf"
Content-Disposition: inline
In-Reply-To: <20210209175900.7092-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ju3jwli3ct6v5xkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 06:58:55PM +0100, Jernej Skrabec wrote:
> Over the year I got plenty of reports of troubles with H6 HDMI signal.
> Sometimes monitor flickers, sometimes there was no image at all and
> sometimes it didn't play well with AVR.
>=20
> It turns out there are multiple issues. Patch 1 fixes clock issue,
> which didn't adjust parent rate, even if it is allowed to do so. Patch 2
> adds polarity config in tcon1. This is seemingly not needed for pre-HDMI2
> controllers, although BSP drivers set it accordingly every time. It
> turns out that HDMI2 controllers often don't work with monitors if
> polarity is not set correctly. Patch 3 always set clock rate for HDMI
> controller. Patch 4 fixes H6 HDMI PHY settings. Patch 5 fixes comment and
> clock rate limit (wrong reasoning).
>=20
> Please take a look.
>=20
> Best regards,
> Jernej
>=20
> Changes from v2:
> - use clk_hw_can_set_rate_parent() directly instead of checking flags
> Changes from v1:
> - collected Chen-Yu tags (except on replaced patch 4)
> - Added some comments in patch 2
> - Replaced patch 4 (see commit log for explanation)

Applied patches 2-5, thanks
Maxime

--ju3jwli3ct6v5xkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYCO1iAAKCRDj7w1vZxhR
xWI+AP9LVKht587rKqqvDF5OHytZ7rTIv7TkzV5PorCdpAl6CwEA3VVGL21fGO9l
0TtgdjhXMuTi5mmSoIsj/QQyNtubVQc=
=9wps
-----END PGP SIGNATURE-----

--ju3jwli3ct6v5xkf--

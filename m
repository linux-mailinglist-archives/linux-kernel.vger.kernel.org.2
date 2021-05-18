Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D08387C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244913AbhERPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:21:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53757 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241047AbhERPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:21:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F1BDF5C00EF;
        Tue, 18 May 2021 11:19:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 18 May 2021 11:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Bg35GN0ZhCQVHsx5IejDv04M0j1
        KJHlRwh2BZJwGWXc=; b=mVyxrJqucxXMD5waU12alEP3Jn/dY/INCZOWGH3iazE
        mL0ElsYtIsO/LP0lSV4MHERugJjQaZ+1EvNs5fYj3hlN6iANCmwWWmehqWYv24Ic
        UDvhBewsHXmvngT5X3ibP40u5+G7nPXHpcgMLbwevvJYPmD5hmmTcuiTaESqHFhz
        HRQ0MZdhpw9JCUIHKLwvVtQWEvbAXX09EoswktQ/gcujApuUSOLjL5fUy6iZtNWi
        I5zrHr6Z6UA7yMXtNsciSnvbY5p3ZLsDk3jZLjTQTqVR3LkEVIeqXDMtuUYxp4os
        zXSN3w8rEjQ2DexxhoVr61X29w7s2BNocM1qx2eqCTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Bg35GN
        0ZhCQVHsx5IejDv04M0j1KJHlRwh2BZJwGWXc=; b=ckc3XLAmPlRgfGM8RxmqBP
        y/9sckb+GfuZAaYGVYhxHoKy9dDqtwrs7DSiPdR7Utr8T1x3S4OivEjWtelqinhe
        n4TWmMSRYB/HmuvTdqOvAmUs4Ps/jsgpuIwdQ4rp3KGaN5ejNUNaKhF+7B3acVVK
        P0G9E3A8m6K4xtkoi6lZ27Dcfab8Xo9/BC8WyS+tnRyIw0uNHVZLsxF3U2i/TGc5
        FxNtw472tdQ5gLHvPEmn/2PVdDa4uB8pkZdd5muDhOcAvVugzqeFSs/CqxoI11u9
        TUfFAlpIdTN8AwWo6x3CcjTb1OI27c5u6I5dTfOKmvbcp5SMPndjxL5dPXBvwcfw
        ==
X-ME-Sender: <xms:EdujYKfcH4U6dqsn7hLEEybmlNEOlbTIJNqHZs2dskxBJA4cFnujYQ>
    <xme:EdujYEMZudLL6Gce6WSk48rGQCRmww0COvySvUuBPZ88GMYfhJtY1lQz9mPv6chaJ
    mCoHgIqqb9YdREU1pU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:EdujYLhLpmB2_w675zfUXxlHRQPdSX7PHU9WpaAyydh69rlCFDJZRQ>
    <xmx:EdujYH_5WDES3YiKWQqScXK3zfZHQkQCoLegCmh7bLdT01iXtlrdvg>
    <xmx:EdujYGsZYlJHBVqs4MI2AKftxdYU4fmR7I26UvEaoTazdusBrRtvGw>
    <xmx:EdujYIViHhLx318V_NMTuVp61a9GiMxr1UhEV4bmodGd_lRzaAj0vQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 11:19:44 -0400 (EDT)
Date:   Tue, 18 May 2021 17:19:43 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Add missing peripherals to Allwinner V3s/V3
 device trees
Message-ID: <20210518151943.ph3n3w44qqx26zj7@gilmour>
References: <20210514134405.2097464-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l264fse6vzsa4waz"
Content-Disposition: inline
In-Reply-To: <20210514134405.2097464-1-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l264fse6vzsa4waz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2021 at 03:43:58PM +0200, Tobias Schramm wrote:
> The Allwinner V3s/V3 SoCs feature quite a few peripherals that have good
> driver support but yet are nowhere to be found in the SoCs dts.
> This patchset adds the DMA controller, the relevant DMA properties for all
> peripherals supporting DMA, the integrated analog codec and - for the
> Allwinner V3 SoC - also the I2S interface.
> I've included all of those changes in one patchset since they do all
> depend on addition of the DMA controller.
> All changes have been tested in a recent project of mine using a Sochip S3
> (a rebranded Allwinner V3) and are confirmed working.
>=20
> This is v3 of this patchset.

Applied all, thanks
Maxime

--l264fse6vzsa4waz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKPbDwAKCRDj7w1vZxhR
xY0WAQCV7/VauSWEXOlSuakfZQB3sFd/tyrdFL9SfmP0Y/Z1igEA4fTW0AUNU0U+
FtE1oA7O1UuMNIqlD9jAOCwO1VfDZgQ=
=O1/J
-----END PGP SIGNATURE-----

--l264fse6vzsa4waz--

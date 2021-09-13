Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62FA40853B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhIMHUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:20:01 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55427 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237561AbhIMHT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:19:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 35F935C0097;
        Mon, 13 Sep 2021 03:18:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 Sep 2021 03:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=0MoBU2TKSI3he66YNKrDniJl3da
        Z8O9OnUCh+6ULEkk=; b=tlK1Keon5Htn3wN0R6+4/ELID4kLFK7Oer/E1nUn907
        M2fNkePNKDfEV0BlPy2231Lis3p+QaRBGTDjPU8K0wDLey5x5hCbPbWbCLAC2h59
        bGrE6Af9MVTrMDFZU7amMWAnolkttPSle3MkLzu5YWgOhbbyCFlSOquasn6JsxHH
        oeOvwo2vN8q9P4xr4zIEbOAPQFxUKNyYUGNZNNZKvbEMTjJ+X/etUgEVRFVpf2wN
        OKgj/4ijCvsI9t2685uqhspn3rPwN42T7w9kxtdqDfbthxjyfULmlM+5qqNFqISA
        3Xjz1fjKKKKm1WbBbCnjcIm33G9s/VkHw6PTJqav0jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0MoBU2
        TKSI3he66YNKrDniJl3daZ8O9OnUCh+6ULEkk=; b=jbeo/dTjKFGneETVcvSqdu
        yeTjXpGDCQLwcJUPX9nEem1RM7Ry2BJMsvpTjpidh4SRPmd0+kKtSFsKGqauP8Tj
        M/9iTB3U3sTvqICwvcmfKOCLlAVWnUwvdJ1qyUw+0Qr1HxWM1zq3V/5zOikPP2nh
        uQ7IrduCTyGxY8ohEbk4Nw+SUwK00ZXPad2IFGoU/m/kuKEkfanyXSbAn3+XDL+B
        u0xvoQhr5RDoTSM7GF8ZMvuzjAaA1fyMrLI24ywRH8MSCvikoZKdj0pht3qTxcgI
        IEqdGoajuVAVWu5LtCj+GDsS3IF+syo/+fqIb3o5X0PMUralfmbJm8JW/LRfPi6A
        ==
X-ME-Sender: <xms:U_s-YV0PZ2o0ubeJdo4CWJ1myBwJBqDqwZ6YdOGss2P0jFjZ9PILgA>
    <xme:U_s-YcE0Yf1B2pTdDbN4Z1MLV54NL4SwhB_ZqZduKtZYKOEilnhci2JWvmbYXHzaY
    vgrxeW5OEVKuhaTE_4>
X-ME-Received: <xmr:U_s-YV40FS8WT_in2H-hV7AElUCMy-tR6Ldr1mD23IcMRFFMK3W886vIgKRwuyJqBGIbV-YtC6Y6LsZy99mZ83D8Gb_D1m95K1P1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:U_s-YS0snyhnyvGiWxcX0fyrRdoM5JmLMKActwOpCWjtSrFRecLuRw>
    <xmx:U_s-YYEBNkmUQWEzikfjmQtMIJ_Z8zQBvh-IV0YDGmfOG9jKuFBy9Q>
    <xmx:U_s-YT8mK3P3LDHtDI1zlUM_KL948vC4XO5t05TwANu41voLbwWMEg>
    <xmx:VPs-YdN1y5VuU2Op6GZ-I8ZNNwXSuZl2nXrEEBhwyp3PNmjNF7mRFA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Sep 2021 03:18:42 -0400 (EDT)
Date:   Mon, 13 Sep 2021 09:18:40 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add GPU opp table
Message-ID: <20210913071840.cy7ujx35sckcptf5@gilmour>
References: <20210912095032.2397824-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="saqxio7jzpaoxodf"
Content-Disposition: inline
In-Reply-To: <20210912095032.2397824-1-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--saqxio7jzpaoxodf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 12, 2021 at 11:50:32AM +0200, Jernej Skrabec wrote:
> GPU on A64 currently runs at default frequency, which is 297 MHz. This
> is a bit low in some cases and noticeable lag can be observed in GPU
> rendered UIs. GPU is capable to run at 432 MHz.
>=20
> Add GPU OPP table.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks
Maxime

--saqxio7jzpaoxodf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYT77UAAKCRDj7w1vZxhR
xcwkAP9HOibW1BQNC/e0SEAa2jqU3A6FXJUzfNJeCjEEXpHQLAD/YoLQvRhxoajx
B31oMZtohKUNcpd6qarqGHoExL4y6g8=
=c0XN
-----END PGP SIGNATURE-----

--saqxio7jzpaoxodf--

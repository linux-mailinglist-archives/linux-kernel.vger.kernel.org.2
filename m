Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C130233378D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhCJIk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:40:29 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56841 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230449AbhCJIkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:40:01 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5AC0B5C0113;
        Wed, 10 Mar 2021 03:40:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Mar 2021 03:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=UWYa6L3xNrTqeLtZgTGVhaunhWu
        w8dTIJzklNZwMjO4=; b=ovyv+4ZqGxtSsKxVtasS9nYx1VEJF4QSmqS/iloSgly
        bJNZXUFBszx3YTCXgQ5fYLJKPEgyRxTjbu6ArJcBV384P1iNIN8DAQp6aGDHV5nh
        MDVi7VphC3hZHGYPwXNh06MDV+62og+c2lXb6DpEp9Kfqn9lqaZS5fXEln9+Vqyf
        tGbHfP3rdWQxYuy3OrCaWfEKUAE2Y0KdaOpMYLfuyiPNdWreRnztEWB3RYgw/rX8
        bC72Xv46iLB/MolqSRgU1OT6WRddtABNcYa98MpfaB9XJBUrAf4uRpR/BNJXlCzG
        3t8xvpOuK5DbJjc4mlBIzcEfdOXzIomUClLNiJmS6dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UWYa6L
        3xNrTqeLtZgTGVhaunhWuw8dTIJzklNZwMjO4=; b=mpyOwkLsr7NfXQr0aU5jNp
        2fMuDaKTK7RzYk80JGCOkSup5PvjfFn4ioU0hIp/2M2SRNIjE8HB/hInSs4xlgcZ
        OUaymUPkMmP2kCC9be7FKAsJUYOgjnxRyk/U19btfCFzyGEpTdhQBBt1zKaWWeHP
        YRuXWaZjU1OqcasugG09TwOeazWJfwuVAYCHQKTz2/AleHLelkUU+rZ0XBK3e557
        oZhjMLwL6B7Wap8YwR2z6wzRCNec/W7xL8sdhPX3YqIBylR2bLHoTNYd+G04bRrb
        C6lCoFT4XXMnPolHXy57DeMxWbxBLIIlhKeTbSTQpWm+ObQe5pmUnZp8TWrkdzig
        ==
X-ME-Sender: <xms:34VIYOdoFqqNPCLc2RnHsokglfTUDry16c_mLNDHvOqCrj0PKtcgwA>
    <xme:34VIYINQtNzkaYHIsjDy8H6NwWiuupyd1Na75FamU56qTdQ4n5q3ovFTGYXSTZ1jv
    _ZSW5q6Dw7Qxt_7Qtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddujedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:34VIYPhRQMNJEyxCz0B33IzYevco3NTq1JfurQa8hyCzmlginiZzPQ>
    <xmx:34VIYL8ii9HOg5jJVsETEPpBcLi3OSFwuFTNGQgZzw0PaSeRbhfHug>
    <xmx:34VIYKspzR-gxjWEd_c5niiL2GMCuIRcbCdxZjUGgcUuJHwiZfmqVQ>
    <xmx:4IVIYOJk-vqaChUNT9Lxsql7FrN8DAzH0z5sJ9WYgd466333jruGiw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 598911080063;
        Wed, 10 Mar 2021 03:39:59 -0500 (EST)
Date:   Wed, 10 Mar 2021 09:39:57 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] net: allwinner: reset control support
Message-ID: <20210310083957.utmn7twsm2qgksfp@gilmour>
References: <20210309012116.2944-1-boger@wirenboard.com>
 <20210309012116.2944-2-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uizhoovv4z7qhw72"
Content-Disposition: inline
In-Reply-To: <20210309012116.2944-2-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uizhoovv4z7qhw72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 09, 2021 at 04:21:15AM +0300, Evgeny Boger wrote:
> R40 (aka V40/A40i/T3) and A10/A20 share the same EMAC IP.
> However, on R40 the EMAC is gated by default.
>=20
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  .../net/allwinner,sun4i-a10-emac.yaml         | 11 +++-
>  drivers/net/ethernet/allwinner/sun4i-emac.c   | 65 +++++++++++++++++--
>  2 files changed, 70 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-em=
ac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.ya=
ml
> index 8d8560a67abf..27f99372d153 100644
> --- a/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml
> +++ b/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml
> @@ -15,7 +15,12 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    const: allwinner,sun4i-a10-emac
> +    oneOf:
> +      - const: allwinner,sun4i-a10-emac
> +      - const: allwinner,sun4i-r40-emac
> +      - items:
> +          - const: allwinner,sun4i-r40-emac
> +          - const: allwinner,sun4i-a10-emac

There's no need to handle the fallback case, it should have either one
of the two, not both.

The good news is that it simplifies the binding here too, since you can
use an enum

The DT binding modifications are usually in a separate patch too

> =20
>    reg:
>      maxItems: 1
> @@ -30,6 +35,9 @@ properties:
>      description: Phandle to the device SRAM
>      $ref: /schemas/types.yaml#/definitions/phandle-array
> =20
> +  resets:
> +    maxItems: 1
> +

You should make resets required for the R40 compatible too through an if
clause.

It looks good otherwise, thanks!
Maxime

--uizhoovv4z7qhw72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYEiF2AAKCRDj7w1vZxhR
xWf+AQCWKzhut6ZPGHD5e8P7IIIhhkd7RuiPg8Dkq0nZaHFZqwEAwH3hAqMwcQ8U
GKPOy+EvneB2MZR+8Ry5N/mB9HicQwg=
=t6wL
-----END PGP SIGNATURE-----

--uizhoovv4z7qhw72--

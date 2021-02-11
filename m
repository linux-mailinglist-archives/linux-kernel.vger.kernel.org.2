Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51095319143
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhBKRkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:40:03 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53929 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231927AbhBKQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:46:41 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id CB0E55C0101;
        Thu, 11 Feb 2021 11:45:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Feb 2021 11:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=wtqbOGzta9M177pSJSqcwXLiv9t
        cri+slKWbRQesdkw=; b=b+Yp8sHDZDGAQfChbuZuG5lbeD94iiudNAkuYGNjaIo
        MeR9FRrXu0jba0AfDGt/RBs4V7W7x9elh20KN7LiUSd3xMy9Btd4RcNkAwvhRD4Q
        FPWayCY88l6+euWqQhu00tphBjS5iz5hSrt9iqyj5eqMTl3CmItXeG2KhaNEpZAw
        m2ESaRYucIPNl+B+eCuP/TDQh0HBZBwK2PWzdhMNBPL+cHMz1zBcqLyn+MN0giBV
        79Z+kg79hlvl5Yy7CdnGeGtz3C4xOIIaqtb1XBcpCX4caLRI12xGYXD+Kgz4ONJT
        fRuKZetskfVT0dZiUl5WK2XkMyg+GfIld64HM63lQ6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wtqbOG
        zta9M177pSJSqcwXLiv9tcri+slKWbRQesdkw=; b=CIvy4FE5KjS1QohfsfelQi
        x58mP92CNbZmOqsXVxcs6PgQD58yQJNDMl7cMwO9phKIBShebP2EWVPOdAHLE2TD
        setTRUj99/o51JboWdjJy0E3AzGkcH4ohRtYWZIW/wpTysEcGyjW+qkNNuSZMmgq
        NjZ7Y+teyHTvsNd97e58A7N/mh3tLQJUVXNv1qc6d/3EyLwaFBWLivyIo/zPWCxA
        yVYVtZDHTNppV5TFR0d7dveEp2WA6W4BjVr8cQq3S/go999PAhdO3qqS2gz3cYrT
        EuHZHVaOY+DcLoxr6dGe8oc3GINZAkFxFyfWpH7X6F0ExqXnUIVKnixeZH7nIIvA
        ==
X-ME-Sender: <xms:KV8lYAHDMns51cy4hqrU02R1iJX64h8QY9ARcEhUskItqQ-Ef3Yj-g>
    <xme:KV8lYC-gUI6jWUJkf-x5JpRlMAcNOGUMxVEovSaYjn6J1f6bhIEoFHSPSW3jKckJa
    4C8hdzze0yNmAblHt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheelgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:KV8lYKJlZCdE9w0S3DE1lIzcdSLi0kP222J5SA8rzykBkcL1TKTvxA>
    <xmx:KV8lYFba5FqPd_EYO-N9F7iC2P9slHM74v16qCDm64b1Kj3Pp5Awxw>
    <xmx:KV8lYEK-rBOUpcSnnbVTjRbY_aqNLp7Cy6hMiiCushVE1XtdktG1qg>
    <xmx:Kl8lYEDn5FnWVzVQARwfL2IHHImfWhvoUk8mK7FGJnBrYhBVz4_h8Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3873F1080063;
        Thu, 11 Feb 2021 11:45:29 -0500 (EST)
Date:   Thu, 11 Feb 2021 17:45:26 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm: dts: sun5i: Add GPU node
Message-ID: <20210211164526.6n66ozyu7pcuigqq@gilmour>
References: <nGyI_fodh-zDD7vDOH3sqaiGbOQprYmljxEKSlTdu9Ju5OcpUcLBIHndYSnzQKT0n6Yh4H4VX8ss-XPyuBMU6n8nX5Oag_4LrqrryrZaqx8=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ufx4mccggtpm5zqb"
Content-Disposition: inline
In-Reply-To: <nGyI_fodh-zDD7vDOH3sqaiGbOQprYmljxEKSlTdu9Ju5OcpUcLBIHndYSnzQKT0n6Yh4H4VX8ss-XPyuBMU6n8nX5Oag_4LrqrryrZaqx8=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ufx4mccggtpm5zqb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 11, 2021 at 03:25:23PM +0000, Yassine Oudjana wrote:
> sun5i has the same Mali 400 GPU as sun4i with the same interrupts, clocks
> and resets. Add node for it in dts.
>=20
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Unfortunately we already merged a similar patch for 5.12

Maxime

--ufx4mccggtpm5zqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYCVfJgAKCRDj7w1vZxhR
xdJsAQDWMP0NzuJynQroY3M3P0zkseK1FDwCfz9cLp0og84lDQEA77MjjALXJ0dY
mJlFoN3QDzyi8TE2WxIbPwa9DHOSJwo=
=nwOc
-----END PGP SIGNATURE-----

--ufx4mccggtpm5zqb--

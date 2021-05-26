Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41491391FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhEZTAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 15:00:14 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33229 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234468AbhEZTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 15:00:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id ECB4B14AC;
        Wed, 26 May 2021 14:58:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 26 May 2021 14:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=NpJ6naHFWYIcg14MtZ0okynKQF2
        220L3LTilX7Fdt8Q=; b=R0eOAu2588DReCV3yDnjTVD/7iy/lT10ZQjlQaaqAWd
        I1W3HuDiLTlk2dq8tAU7Om3E9ZUQAKasaOGDMKuS6D6P8ywD6ky35W86vT67IVqY
        xYrbB/1XsO9lFOi3j3Ve71CEdOva15l6MvYmve8nAUEGkVD9ghc0+u+HIz0+d7Oo
        22twzpmJpgq8PrRsYSD/cpMFKDZ4IOQtS5IX10JfwE7j2bMzYNkg0EKCPdp/nG26
        3dHXDLwrtQ3BHW0+Qqz48Fdr3qPjsQKyUzuATiPy+refXKPQID666SYQn6zSqdh2
        WomQF6sQ7GPcDLZz3X7xf4H25SLI52QPHoOdvxAJajg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=NpJ6na
        HFWYIcg14MtZ0okynKQF2220L3LTilX7Fdt8Q=; b=KCod5VY+SFjIvXis6BiXqb
        5JiJ0LmCxiuA8AVri7G8awU9nyLV2JYvoOjljsRLAMzrMcs/pKsmMIX/uYGqNyf8
        cESxUGgEFQVoDx87ex2FqymwDyoUeNr+PuKI4rgVxKzXqpsIZIWIG61uBrfIgjfZ
        DtYFAmPkudm+a7TArlU9oc/BxAp9kzR5+vj42g/6kfvl6JtuPQUEq7abCQs0nPcn
        u7k/TRdFfhj3vH+VP117XTnVME0M4M0YkerqujiLtWdrYate6e88PWWvYVG5p2h1
        DSq0ll1YA7qEbCf6edteCWEWm3b7IjjYEZ4GWOqMv//oyRXmSKiUHZ6utKGUWxYA
        ==
X-ME-Sender: <xms:XJquYLLd8OpLqnSf8uGuaMcjt2qtxtHoexgisrvSs83es1Wk5ABYbw>
    <xme:XJquYPJsynOt4rcR_6QIULM1gkFtxzBV7-HkMFIMbflFTTE7TbMWHDlyqmMLgws0h
    LYAa2PbY_i956SNO8k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekfedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:XJquYDsnim2Y_qES1CNl2qQ5wXSrQJ_WzMMQsAVQlVe7rWrc4tZ4RA>
    <xmx:XJquYEYiWVx5Iqgb4e7gjQY_ryD_6m5eFKSv3h5gIWszUXmspSuUew>
    <xmx:XJquYCZAiu-lL-CrtPMyMx91wQlvKy1hgoFO8x2bGkip_OeHs_1aog>
    <xmx:XZquYHMT-WhuIlpBa-CxmxBpFCKqgjt_edcy98WDpPdNM8ywUwVstw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 26 May 2021 14:58:35 -0400 (EDT)
Date:   Wed, 26 May 2021 20:58:32 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v7 0/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210526185832.zuyllkvzrt5shok6@gilmour>
References: <cover.1615713499.git.wilken.gottwalt@posteo.net>
 <95e93676-cfcf-1aed-1741-d69b72286033@sholland.org>
 <20210525180744.24187bb1@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6wsauybj7svw243"
Content-Disposition: inline
In-Reply-To: <20210525180744.24187bb1@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6wsauybj7svw243
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 25, 2021 at 04:07:44PM +0000, Wilken Gottwalt wrote:
> On Mon, 15 Mar 2021 23:33:31 -0500
> Samuel Holland <samuel@sholland.org> wrote:
>=20
> > On 3/14/21 4:30 AM, Wilken Gottwalt wrote:
> > > Wilken Gottwalt (2):
> > >   dt-bindings: hwlock: add sun6i_hwspinlock
> > >   hwspinlock: add sun6i hardware spinlock support
> > >=20
> > >  .../allwinner,sun6i-a31-hwspinlock.yaml       |  45 ++++
> > >  MAINTAINERS                                   |   6 +
> > >  drivers/hwspinlock/Kconfig                    |   9 +
> > >  drivers/hwspinlock/Makefile                   |   1 +
> > >  drivers/hwspinlock/sun6i_hwspinlock.c         | 210 ++++++++++++++++=
++
> > >  5 files changed, 271 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/hwlock/allwinne=
r,sun6i-a31-hwspinlock.yaml
> > >  create mode 100644 drivers/hwspinlock/sun6i_hwspinlock.c
> > >=20
> >=20
> > Thanks for the very thorough testing!
>=20
> So when will this end up in mainstream? Or do I have to somehing to get t=
his
> triggered? This is not my first driver and back then it was included into
> mainline without anything special on my side. I'm a bit confused. Did I m=
iss
> something?

No, you did nothing wrong, I'd expect Baolin, Bjorn or Ohad to merge these =
patches.

Maxime

--d6wsauybj7svw243
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYK6aWAAKCRDj7w1vZxhR
xQagAP92zLkn/Uw/LxUwJdMvFc8A0KDx0/pX3G3XMhPjmG2FJwEA84Ts+BKmpTPT
/lhZUimvtCIrnvjWTI0J/QIUHw9Mtwg=
=clXK
-----END PGP SIGNATURE-----

--d6wsauybj7svw243--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC1367B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhDVHnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:43:20 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:41605 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbhDVHnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:43:19 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4E26F5808C4;
        Thu, 22 Apr 2021 03:42:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 22 Apr 2021 03:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Y2uZyI8L7mwBH4ZmTva04VcYrJd
        +Avrdul1smc1+xDU=; b=O1qhOriDbg1gc4HHAc4LQZEB5FlAuVIRZA1P2QVYVl1
        nkBF0QbnVRi/Be1gUFeU52n/e4G7OBbHv+QzfByoWzzKUbWqpFr9exCSACw8Hoim
        nBH4qETCaUlAyChOEzo+1VoQVPoQfJRMG7VUOmIi9sKNI7nWb0tfMyKk4xsLkR9u
        xlhc8ajJvFph1raQcvy8z6HOeUz8EDlnz03uaeULJiTNJx6wpQn+LcVwiZt+YvmE
        FADH03hmt7/g+r5Ds2a3PQ6j6WrUsWXmowGYzPiaCrDKfWcCFSN11Ee55NMkXAdG
        Fme+jD2tYXlU3f2xba90ADpoaO0FqWze/0qpDVEhXQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Y2uZyI
        8L7mwBH4ZmTva04VcYrJd+Avrdul1smc1+xDU=; b=LWe32drje09tH+qtrZUhcp
        VauMDfWuIRNIPo7rDUSiCpbMsQt6OdiLtKiiEf0UMHtaXZsaY+HpMW6GKUOiqMbD
        H6O8PD9xDiJ/LFQKZQdP3Ook3LbmYQpRQbJpc/bEvXs6JgQS8TkmkeLtvDis/kcD
        AMVs+KbC3EXKm0ExthMWXmbb+n1nz0FgcJUFJp1vEk/gs4zyMn/0G0PTLcN5i1Oh
        Nuqj8wpQZz/VLAXUU0gzJNJcdsJJ8kBBoAgwN7Vhm3n2sOiOxN0nfpM7l5GVfmxX
        yWZBN3GrSfjITdT9ejkBGhEFctyRgX3MWl8uP4gzLh0yVw1BHSU7TIgNuMiuoPYA
        ==
X-ME-Sender: <xms:8yiBYBmgcVOEK30AItgrb5u2YuoCYOvYe8IO9edgFGeUfkPz7nNH1w>
    <xme:8yiBYM28OSpMHe6y3hAk8_2cMSkkySwnL1oeRpTZRrHxVBMG6qyOk8aoebj8PXuHF
    wl0HcZhfvlB9mAVhQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:8yiBYHrpkaTBRZ0kkF_vYFh-FN5d7YybFgN39LYBUBC1kIjn82fXXg>
    <xmx:8yiBYBlxP3dD9DWWcCGAJwvodFbPp9iiCGh8_RAaXVK9-3wG3X-JTw>
    <xmx:8yiBYP1h7_Lfq1VL-G_eurYOnnftj2ioC4yEQvLRglqSjm4Eh_LjyQ>
    <xmx:9CiBYIIk1q-kVgL96nL0dW6efvzQrv1r0eTioBpsb-K2fllp3pbEVw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 01E8024005B;
        Thu, 22 Apr 2021 03:42:42 -0400 (EDT)
Date:   Thu, 22 Apr 2021 09:42:40 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rob Herring <robh@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Document the Allwinner H6 DWC3 glue
Message-ID: <20210422074240.c6gw7uckmceplksw@gilmour>
References: <20210421042834.27309-1-samuel@sholland.org>
 <20210421042834.27309-2-samuel@sholland.org>
 <1619009508.513542.967209.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7q4kh6ll5bnzmjiv"
Content-Disposition: inline
In-Reply-To: <1619009508.513542.967209.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7q4kh6ll5bnzmjiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 21, 2021 at 07:51:48AM -0500, Rob Herring wrote:
> On Tue, 20 Apr 2021 23:28:33 -0500, Samuel Holland wrote:
> > The RST_BUS_XHCI reset line in the H6 affects both the DWC3 core and the
> > USB3 PHY. This suggests the reset line controls the USB3 IP as a whole.
> > Represent this by attaching the reset line to a glue layer device.
> >=20
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >  .../usb/allwinner,sun50i-h6-dwc3.yaml         | 75 +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/allwinner,sun=
50i-h6-dwc3.yaml
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

I dropped these patches then

Maxime

--7q4kh6ll5bnzmjiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYIEo8AAKCRDj7w1vZxhR
xazoAQCH2L/UHNa/dYDNOcBIPNJ0uLjrS3c1pZ3tepsZE6QEogD8DmQJhj3u0qZG
oeNpiUsd/Vcks00432AVFH2gYuQuLwQ=
=yve1
-----END PGP SIGNATURE-----

--7q4kh6ll5bnzmjiv--

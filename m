Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57B3476E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhCXLOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:14:08 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42147 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230307AbhCXLNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:13:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 02025580097;
        Wed, 24 Mar 2021 07:13:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 24 Mar 2021 07:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=o9oWdRzn1ukVQjFJLSfIzEKJeHo
        GiQ2BllQeXFSqlYo=; b=pFJsH2+8lG0GWrQpNRVAr/Zi2fhmhsSLoYcjtvAjWWB
        HCTsBGLdzJOSr20lKeO3YBjph3lYV0VwwZzUp18OqYfH1UP0Q/W4IAfwZ1bzaxvi
        H/2Kp9jyiTyNRRe5LCdO5IvmmBGZ4n3yaQegX2dvssNgZ+aJUFSO1nqtg1Q2v3Ro
        J+3t5VXbWK8fm5sZKRaO+bCl2rKPAnDyG6XJmxTBV5L8kMGafsEzcAhMV0czo9h+
        OsydDWvirhBdeco/EAPm4PtnUnl25itZ30CJ2edV10gGmy1tgdCQGtYq9OkN/ifB
        yK6ChaflyzjoccBLWFqaBbf9lWn7W9QgBdmavBhHVFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=o9oWdR
        zn1ukVQjFJLSfIzEKJeHoGiQ2BllQeXFSqlYo=; b=I3cbQl6/DVf/WTzM8g5wE4
        N1/GROebfctLIN+vUQ+qWb/mFpYYEitrj80kexVmBmVZKZHsqkh9duafV9nfHdEq
        qesnF3dZGQK88P5fMCWMfmJbzD8WIQSNqt2VSlkubllLJL4bZCSNExFX3CViJSd3
        Qoj8Tj9nBlsOfQuJMD0TBtCRF5pd3OFXX+k2BE1t7OzjUz8u/oH2YJ/f3eOzSx3H
        SDOG6Com1izuL2lfRZn6qEVDkUvUc+qn4mpVzcRmBk+rI9AnoUICdkHrU/UvD7U9
        0DvHf469G4K/Yh7raS6QHLG8zYpiamn+bzKi/9Vex92nki9P+14O8Hb8xVZKcA+A
        ==
X-ME-Sender: <xms:zh5bYIiRfM6seLnsXAdo_-L6jGwCzxo1DqdgnpGrKlbF590t2BdmUQ>
    <xme:zh5bYKrZvsqg7IhAsGKVH5WCm6qUUkPn3dYDGgg8jqx6R8hsIPSMkFzJbB00WRg7u
    qUg02ur_BednRu-mdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepffetteevieejteeuhfffgeektefghfeileehhedtuddutefhhfejtddvtddu
    ledvnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekle
    drieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:zh5bYAFhW5FKRRwBTmc-Grqpfiik4NmOknU9-nganhNM1zuQzxad8Q>
    <xmx:zh5bYMk7eXyFsQeUdUIkiAWIc_cB3WjWhBU73qxtlZuWJV6g1_XugQ>
    <xmx:zh5bYDmOaz_x_6m8KFZeuNuJM5dsrjVewqFsx8eqwB6PZAqeO0JPmg>
    <xmx:0B5bYA-q1Uc1-MGXk3gVg0t5k0Y-X-emSbQTV7rmTzCwvUF4v4x1CA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AB0A91080057;
        Wed, 24 Mar 2021 07:13:18 -0400 (EDT)
Date:   Wed, 24 Mar 2021 12:13:16 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/6] dt-bindings: display: add Unisoc's mipi dsi
 controller bindings
Message-ID: <20210324111316.ggo5deacaoecu27q@gilmour>
References: <20210222132822.7830-1-kevin3.tang@gmail.com>
 <20210222132822.7830-6-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d7arzn7bk7izxksl"
Content-Disposition: inline
In-Reply-To: <20210222132822.7830-6-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d7arzn7bk7izxksl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2021 at 09:28:21PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
>=20
> Adds MIPI DSI Controller
> support for Unisoc's display subsystem.
>=20
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/sprd/sprd,sharkl3-dsi-host.yaml   | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,s=
harkl3-dsi-host.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-=
dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3=
-dsi-host.yaml
> new file mode 100644
> index 000000000..d439f688f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-hos=
t.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dsi-host.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc MIPI DSI Controller
> +
> +maintainers:
> +  - Kevin Tang <kevin.tang@unisoc.com>
> +
> +properties:
> +  compatible:
> +    const: sprd,sharkl3-dsi-host
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  clocks:
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: clk_src_96m
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ports:
> +    type: object
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      port@0:
> +        type: object
> +        description:
> +          A port node with endpoint definitions as defined in
> +          Documentation/devicetree/bindings/media/video-interfaces.txt.
> +          That port should be the input endpoint, usually coming from
> +          the associated DPU.
> +      port@1:
> +        type: object
> +        description:
> +          A port node with endpoint definitions as defined in
> +          Documentation/devicetree/bindings/media/video-interfaces.txt.
> +          That port should be the output endpoint, usually output to
> +          the associated panel.

The DSI generic binding asks that peripherals that are controlled
through a DCS be a subnode of the MIPI-DSI bus, not through a port
endpoint.

Maxime

--d7arzn7bk7izxksl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYFsezAAKCRDj7w1vZxhR
xTfqAP0R/ENVmkMPaplYpkicA6NmHxb4jEGSWiW4sNhQVOzUKwEAwqgd3fOhDSab
NkYiJ+6NDuqVwcblxdamZBIJFpUZtQk=
=U2Vq
-----END PGP SIGNATURE-----

--d7arzn7bk7izxksl--

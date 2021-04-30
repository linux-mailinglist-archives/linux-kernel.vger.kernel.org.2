Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8098636F7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhD3JN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:13:26 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51635 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhD3JNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:13:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5904A580502;
        Fri, 30 Apr 2021 05:12:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 30 Apr 2021 05:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=avsxOVAtvbPgpF3DzABnelX9YGb
        evrpv2itbsc94Fxc=; b=adg5wJCsVVgihT85I8rgAiVZdtHlmUD9snVJH+ToKk/
        lN5fdL5r5nF7GTYMMRqXXUuKeGJ6uZIKFymcxKkGIN9rcsyVhItpT3hGp7EpJrxj
        +Ay0SpQQzCkQS5+DpDTd6RWoE8Q6byZKa7b7Ukguh8DvCReDKwQ1tMfqJgviydem
        ierjDG5cPCBB1CBko/IpaxCOfJYgEaSiPwEFieOC/y3aSkxUtbMy0xS426TowTD4
        vgj4v8KEA0n6wIrOBO4vFogxehWGtvU8PAwTOkXFUKOI6BX9d9fXpxAnnL5KcLuA
        AQLZMOfF2vmXZFSiNSgwXjBgSzE9Enc/C9jNJoRQavg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=avsxOV
        AtvbPgpF3DzABnelX9YGbevrpv2itbsc94Fxc=; b=KbFhzd8UzYblygwuCVG4Z7
        tdr0p+teLymQzp13X6JLsDXehFi2DM6rzv1mJ8Dv+e4Pdh+xtrjEWSwAdPkn2O0S
        zT4JjTv3zwQx61mKUKqZY7oAwq4akVaozeE75esk9N+/4s+W7O/tXvGLzPmRUaoc
        b5OJD9QATKhsr132uLgcH6CaGaCGddF0Wa3Y1WnUo6lxpkXZqCU8Oz8m3VbqC4xd
        5oXR4W9x9F1Zt5QJ354wMTsREuNfrdIxMok53Hi0H+w/WVu9ofKNcsqw3mXYp8BJ
        FMXa5X+tlxnpnxfIl2ggTv+5xDk/ebAhA4LpVN6gwBIbl8oskB/MXHSW7M36EZxQ
        ==
X-ME-Sender: <xms:_8mLYK_OBfykP08KuhxKXvQi0z9rLH9Tdz8l80ZVGixoMz_aBbUQIw>
    <xme:_8mLYKtWdBkTKQ2w3tu_uf0CdzhMSlQkOzQjnbJYnaMRfju5u2XbEBXwG_rtMdhoD
    073F-pKjFYaRg_s7L8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddviedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepffetteevieejteeuhfffgeektefghfeileehhedtuddutefhhfejtddvtddu
    ledvnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekle
    drieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:_8mLYADhaoPQYlwmqfm8kiS12OGqDjJmS9r34F16kGCsGz6jj3h6Sg>
    <xmx:_8mLYCc5i6s85hL5HinjpGBLOPlPJqiJXz6Tw5v4lcZc2JnHVGnyeQ>
    <xmx:_8mLYPMj2N35ExUd7FPFwB4q-uVUeXHPI6cTTl1wjWfN7VlbxWC75A>
    <xmx:AcqLYKrxjEdT7Jqmi_bR9cylNl54Rmas4Jjymt0cZsOvGZAQR1Z8-w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 30 Apr 2021 05:12:31 -0400 (EDT)
Date:   Fri, 30 Apr 2021 11:12:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: display: add Unisoc's drm master
 bindings
Message-ID: <20210430091230.5gf3jzhd7hjmxjnq@gilmour>
References: <20210425123607.26537-1-kevin3.tang@gmail.com>
 <20210425123607.26537-2-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ckdz3meppmjafuxn"
Content-Disposition: inline
In-Reply-To: <20210425123607.26537-2-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ckdz3meppmjafuxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 25, 2021 at 08:36:02PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
>=20
> The Unisoc DRM master device is a virtual device needed to list all
> DPU devices or other display interface nodes that comprise the
> graphics subsystem
>=20
> Unisoc's display pipeline have several components as below
> description, multi display controllers and corresponding physical
> interfaces.
> For different display scenarios, dpu0 and dpu1 maybe binding to
> different encoder.
>=20
> E.g:
>   dpu0 and dpu1 both binding to DSI for dual mipi-dsi display;
>   dpu0 binding to DSI for primary display, and dpu1 binding to DP for
>   external display;
>=20
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/sprd/sprd,display-subsystem.yaml  | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,d=
isplay-subsystem.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,display-=
subsystem.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,displa=
y-subsystem.yaml
> new file mode 100644
> index 000000000..3d107e943
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsyst=
em.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sprd/sprd,display-subsystem.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc DRM master device
> +
> +maintainers:
> +  - Kevin Tang <kevin.tang@unisoc.com>
> +
> +description: |
> +  The Unisoc DRM master device is a virtual device needed to list all
> +  DPU devices or other display interface nodes that comprise the
> +  graphics subsystem.
> +
> +  Unisoc's display pipeline have several components as below description,
> +  multi display controllers and corresponding physical interfaces.
> +  For different display scenarios, dpu0 and dpu1 maybe binding to differ=
ent
> +  encoder.
> +
> +  E.g:
> +  dpu0 and dpu1 both binding to DSI for dual mipi-dsi display;
> +  dpu0 binding to DSI for primary display, and dpu1 binding to DP for ex=
ternal display;
> +
> +          +-----------------------------------------+
> +          |                                         |
> +          |                            +---------+  |
> +  +----+  |   +----+    +---------+    |DPHY/CPHY|  |   +------+
> +  |    +----->+dpu0+--->+MIPI|DSI +--->+Combo    +----->+Panel0|
> +  |AXI |  |   +----+    +---------+    +---------+  |   +------+
> +  |    |  |                  ^                      |
> +  |    |  |                  |                      |
> +  |    |  |      +-----------+                      |
> +  |    |  |      |                                  |
> +  |APB |  |   +--+-+    +-----------+    +---+      |   +------+
> +  |    +----->+dpu1+--->+DisplayPort+--->+PHY+--------->+Panel1|
> +  |    |  |   +----+    +-----------+    +---+      |   +------+
> +  +----+  |                                         |
> +          +-----------------------------------------+
> +
> +properties:
> +  compatible:
> +    const: sprd,display-subsystem
> +
> +  ports:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Should contain a list of phandles pointing to display interface po=
rt
> +      of DPU devices.
> +
> +required:
> +  - compatible
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    display-subsystem {
> +        compatible =3D "sprd,display-subsystem";
> +        ports =3D <&dpu_out>;
> +    };

Given your diagram, I guess it should be the dpu input?

Maxime

--ckdz3meppmjafuxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYIvJ/gAKCRDj7w1vZxhR
xTq6AQCqZKEHkztnHiklozfzjR7wJ4k41aVx8gMmXSmNJExpHwD/b88xdl0VmOY9
M8CsGWdBFk3WsY4AoPfSrFwxwgFr5Qc=
=G+SR
-----END PGP SIGNATURE-----

--ckdz3meppmjafuxn--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B84089EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhIMLNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238383AbhIMLNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:13:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4253260F46;
        Mon, 13 Sep 2021 11:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631531516;
        bh=OYAJ6dqKcszI0F7Ps07XpeMuXLTtjPt2OWp/s1gxtVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNAhPNLS4Au5LtRq6PQ7W2fr7JlS//Zy/r4bbrVrUx/I4FkDcprS7mXhOBKhZO7Po
         bLYi1s3dQm0GgV0GncGDZHp4qDVPQQ3WVeCWBl2UsHhzTM9SVeIdWQ5e/d8CuV/VGu
         L3/FRUZpcdKmRZRPOMTeh2fuCIWZc9vr7KDt8N55tuCS5ZqIs9Qog8CzyAJP0jsXqy
         KGX3ggosf5YKtfh6+7p35kaaS8F5Mjm3AmlkR+ZSal2qtBaBp5RQAB08GobdvlyXgD
         UMjjkiv+Xm/O1IX0rpSG8L/am0dpu+gEuzzRWKRgg9566QB9rkq8j+ZRMw3EETT1C3
         zDnhbY0RBD4Bg==
Date:   Mon, 13 Sep 2021 12:11:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: sun4i-i2s: add Allwinner R40 I2S
 compatible
Message-ID: <20210913111117.GB4283@sirena.org.uk>
References: <20210912072914.398419-1-jernej.skrabec@gmail.com>
 <20210912072914.398419-2-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20210912072914.398419-2-jernej.skrabec@gmail.com>
X-Cookie: Above all else -- sky.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 12, 2021 at 09:29:13AM +0200, Jernej Skrabec wrote:
> Allwinner R40 has 3 I2S controllers, compatible to those, found in H3.
>=20
> Add R40/H3 compatible pair to DT bindings.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE/MdUACgkQJNaLcl1U
h9Cu9wf/VM+++mQxRG5zosD+5PVPxZ/AZqZuv+WaB5dknktVNI6nZJ0rCgeR9Zgf
bmMVexYZgmNnRZe07t6gs6XUbiI+6EqJyAkEtlOQ1EpcYG99HnT50qD+3712psjt
9/UvpRSZkiOschuvInRtGnecT0PbCizK9ExxrLayvHfQpzk6mQTtrVRX3S1uQFZk
6BlB5/9EQmNxoVGM6bXA1mCcHp9DMEzYoVHkAy13Ci+YfxaJUJHpxHjCa7Qww61h
Wrp2LKZQK+Y5XRJU1N0JI/ibWMc0PcVPHylkXWH6ZNB7jLZzvwcEK0I2RKw4cY8n
bbJCpgXED2/vnIDglnysrHHfeB9HXw==
=h6F1
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--

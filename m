Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8175F42F8B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbhJOQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241642AbhJOQxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:53:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FA4861151;
        Fri, 15 Oct 2021 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634316666;
        bh=RIPWXigVIiL/KIysb2frOp/h0Gpodru2TBwLYvNjvA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rbd82HI+29vw+xRsqztUngZmVZeuHdyB7vrE01gYHgutD5HGl0byYQvLpvLFUJl8k
         2FYL4ZH/3AKsuT0Eyk00tiNajdw3REjKzscPv1u8xe304cDLJzUf844ENqu5ot3vdR
         PgAwlGxY1fTwo3IYhGdRGKnUH+aWjPvjEmQo8S0ZeNfYHPJp+b1TI5hpaJNl1blfDf
         RNnif/yBnhXH292ZHR49Y6d4EigmYDd+Gw7kOwcjBnMyEzz9LWpLTCTkVKsX3c07+M
         vHLIfXIW8RAA5pCEBurGfuJmV40L6Q6xEdBs+fgrMllofDT1oAaoC/a/unbhDQXa+m
         XotdnzWNMFU+g==
Date:   Fri, 15 Oct 2021 17:51:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     George Song <george.song@maximintegrated.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.song@analog.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com
Subject: Re: [v2 1/2] ASoC: dt-bindings: max98520: changed signed-off-by
 email address
Message-ID: <YWmxd/tnHRXUEAxy@sirena.org.uk>
References: <20211015072709.3167-1-george.song@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qnzJ+0DBWvYa9boS"
Content-Disposition: inline
In-Reply-To: <20211015072709.3167-1-george.song@maximintegrated.com>
X-Cookie: 1: No code table for op: ++post
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qnzJ+0DBWvYa9boS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 15, 2021 at 04:27:08PM +0900, George Song wrote:
> changed signed-off-by email address to maximintegrated group.
>=20
> Signed-off-by: George Song <george.song@maximintegrated.com>
> ---
>  Documentation/devicetree/bindings/sound/maxim,max98520.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This file isn't upstream - it looks like you've sent an incremental
patch against a previous posting instead of revising your patch?  Once a
patch is accepted upstream you should send incremental changes but until
then you should repost the whole thing.

--qnzJ+0DBWvYa9boS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFpsXYACgkQJNaLcl1U
h9AIIQf6A8SeB3TftCfbbOY4e0oQWkqlTMdDLv3LOQlzGhIShHYNBDgOZzOkaZ0F
T622F+iBFCT/en8TD/TJbZDS1SiYE21A/hEBnsXbXcxfUqsl01gy2IomMp4XQq86
QiXj1QmxCrZ5KvFaFv2cwgRgJaFx5QpMaVjmJJyXlczDJ9NiZ7WmXzhaPXRtCGkV
F1npJhwp70tIpSDiKtcCctctH/8gcc9KaTnC5dyoWHrBITlu3+JP3IuNRvRAvVGg
DcJ/APxrWHLrsh47n32PM0sHjD6SZNnmbI3Qj8XIhMnsNddqR6mDlHIqDSOKKbfU
ZDb612znVSVnEUHCLtSGoK7YnW0o0A==
=aMTI
-----END PGP SIGNATURE-----

--qnzJ+0DBWvYa9boS--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3DE42555C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbhJGO1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233375AbhJGO1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:27:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ABF960F3A;
        Thu,  7 Oct 2021 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633616721;
        bh=QLMrq3g519DOhev7cHZxqX4kVWD1Aqd3nGFjxucK0K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mkOT9IFJkprLhu9+asztn0C2dwX0LKrJ0FCSTg85Cj2mxJHjXndLCiUywviwwAE54
         py8MlMHoHOQBSF7SIAuCNTaoMUy2nrAcNTqi5Gsofi+fgUx3eGZWHtMrNxSC6Qo7Sk
         5LbmiQF1zQb7z2pKBSLqCXjTr9W3O8gG1Mfrql3Fd9bZGCcTjtZMxx8UfRlREWMgor
         JNKCmKNcoSpKJJdduuB+WPJTk242NUVQfobqAAcntrCLghB2TIZts2fimF3wI+bAob
         7NPzQ+jwJAJyI6ITftssa+/P8BthU0R9lkBV2Fkx457joWAK8V6L0x4ffe+NKXEvWz
         BBDc3Bx9DMd+w==
Date:   Thu, 7 Oct 2021 15:25:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] rk3399-nanopi4.dtsi: enable sdmmc regulator on boot
Message-ID: <YV8DTqA/6XI9KZmK@sirena.org.uk>
References: <20211006160817.13808-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/deUtXPj4/UYU6Qr"
Content-Disposition: inline
In-Reply-To: <20211006160817.13808-1-twoerner@gmail.com>
X-Cookie: Colors may fade.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/deUtXPj4/UYU6Qr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 06, 2021 at 12:08:17PM -0400, Trevor Woerner wrote:
> @@ -71,6 +71,7 @@ vcc3v0_sd: vcc3v0-sd {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sdmmc0_pwr_h>;
>  		regulator-always-on;
> +		regulator-boot-on;

This shouldn't be required for devices that can read their status, the
fact that it's always on should cause it to be powered up if it wasn't
already when applying constraints.  I'm therefore confused as to what
this change is doing and there's probably something else going on here.

--/deUtXPj4/UYU6Qr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFfA04ACgkQJNaLcl1U
h9CKsgf8DQCEbECuQKPWS9ndwd61Y16UyarKnvFC4c5PxqpvK+JlBp3FNej5teoE
NbuCbz/NwF3yjH89C7T17S4WLOLZHdO4xF2jv0RWqnXwaJcUyxsVI4ObRynR0uSM
kwIE1eLF1DiFS49Qzf3ixMDRf4/zvCay886DBmrPlr2qbG0Wzo0+TwWidtfnFNQq
0Ft+Jw41rLh0WXaAszI1py3/e00QGoDbZbskfXJ5Bhxy6Qi9gaA5vs2l3F/5D9wg
skwZFR04rsBn5DHeRUzn8iPlMheoHivYXPTrOtu9HE13VCqsVemmPbessKehwmv5
si1hms2u9hOiplV/pzRcNX5GIpqWbw==
=nFkn
-----END PGP SIGNATURE-----

--/deUtXPj4/UYU6Qr--

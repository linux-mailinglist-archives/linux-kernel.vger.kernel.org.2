Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CAD3AE92D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFUMh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhFUMhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:37:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D5D260724;
        Mon, 21 Jun 2021 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624278909;
        bh=/dPp1ND781uk4HC3Khf8WVu2noGkvLSaWwiJMOBrZRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUFIKyPlk8yymXr+s415ipewyzmT6ZbsogqdxsXNp/fmsVEqMRFV/ePigFnAaPfyJ
         KiIMGhS43TWip9ALGGnHZ0XhOv/j0TnHRYCuer62raCHJxukWcphLyDo0NcHH0k4pL
         ej7ezgg2ME5MYrS7yhOwoA2Q8GwM9SLwL+emW0l0NXspYvhhpQk3NnrDwhiJiXieK6
         5rv5wyjr77l/xSbZt1QuvtwB3FaxDirfSVKhKjxS8fEm5w0ySdiRPjy/Fx7TEwilOZ
         tSBTNSU3TjxdLp9HT2X5Ekg1S2YBTX7TFPqLXz9k0/Qz8F0FwtwXOAWHwYLjHZTjzL
         w+0T5YFmfVKfw==
Date:   Mon, 21 Jun 2021 13:34:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regulator: core: Add stubs for driver API
Message-ID: <20210621123447.GH4094@sirena.org.uk>
References: <20210619124052.1354-1-digetx@gmail.com>
 <20210621114659.GE4094@sirena.org.uk>
 <5dd6145f-046f-9ed5-9f8c-58cf096287ab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline
In-Reply-To: <5dd6145f-046f-9ed5-9f8c-58cf096287ab@gmail.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 21, 2021 at 03:04:30PM +0300, Dmitry Osipenko wrote:
> 21.06.2021 14:46, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > Why would something be registering a regulator device without a
> > dependency on the regulator API?

> For example if regulator device registration is optional in the code. We
> don't have such cases in the kernel today, but I decided that it will be
> cleaner to add stubs for the whole API.

It doesn't strike me as the sort of thing that should be optional TBH.
It seems much more likely that not having the stub will catch silly
errors than that the stubs will make something work that should.

> If you think that it will be better to add the dependency to the coupler
> drivers, then let's do it.

For coupler drivers it's not clear what function they serve without the
regulator API being enabled.

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDQh2YACgkQJNaLcl1U
h9DNqgf9H2EO8XonlkE2W4Tm+DJqEVTbhNJDun/PgwBebP+peFh1le33KSyFVJbc
Fw344+7FuxqC72pX7yYZt9x6DLA6rDTC38/0Td2HEq7SLY2hvyOwb3ncvwkHt2mk
/u/JPrDRE5L8sV715JxEJlBif3MG+kpTwp0vfoxgadtmaE/vQ+sObbLeB7aGhAAC
efEMqH4wCGZYY86ivfGcUM3EEj9LSQWBz9tLzTtSueHeHn5p84TOQOVhOAb6DUrv
Ca39lUpzQlbd+Wvy7I+WwWOEJkt53kP4sUNdjaBlVfEkZWzKCLs9lLeJ3bPYDm40
hoIf4P1rg2IVw/FUUwcNH22+RPUnpA==
=Gxr0
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--

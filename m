Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620B53AE856
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFULth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhFULtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:49:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E25DB610C7;
        Mon, 21 Jun 2021 11:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624276041;
        bh=CiX+CXk6RiU3QbMoN5880NBvuZUPsyX7PzUv68uHbco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtK6FVG5x5/uXcdW5K2aWi37a8FkSZbe+DKv0jjOYJGk2oKylrvfrnYtLHuzaQ0nj
         sHwZG3UieuTadNaB3MrtqpMyGPyyhJrOh7gf6XkaLm6cteaX3lsqEhUp3zT4hdOiGX
         BfRKy3yfy+kAebMp/8qMsNrjiU1x+AKT5Y4dXcOTFaxVTwWjWJiz5b42OevIIIyZ8H
         qr+4ee36TLiiNXfEsnJ79rpzNmUw0R+k+2R2giIb3s/5b1b4gph5HeZPyN53SybjMV
         AO748WBz8tNo/TXIr7YIrMBCQJVaLo3Wk37BrKhhM7tG+mohZDWSRTp0St2mv8NKWM
         X9+8BKma5xAOg==
Date:   Mon, 21 Jun 2021 12:46:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regulator: core: Add stubs for driver API
Message-ID: <20210621114659.GE4094@sirena.org.uk>
References: <20210619124052.1354-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <20210619124052.1354-1-digetx@gmail.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 19, 2021 at 03:40:52PM +0300, Dmitry Osipenko wrote:

> +static inline struct regulator_dev *
> +regulator_register(const struct regulator_desc *regulator_desc,
> +		   const struct regulator_config *config)

Why would something be registering a regulator device without a
dependency on the regulator API?

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDQfDIACgkQJNaLcl1U
h9DdPQf9ElTh2sWyiNhXLAnJ8H+OfJsVr0lfqntDPXpldSeGIBOkC6tHexy0MYLN
yxglIZ/fPzrb6cc+LeLrm8/OPpjso4MK3w512xN/6DsU9GC+3iUs/L2rclvaXPcw
kXL6/B+ezA3JyPxBpfpf1oHx3gs8dZJi6HBeZ4RwJrcgQTca88cz7bVT6O2wOaKR
X+8vMgzaIoEyJ1jQ+EYIcTZeRlZHmqjb3uGzqRevSkEuvm9gmXFXsIvi9J4XSGhT
7K5kNFIOxUuN6Y1qy0S5z/Kvj1kzOdfVnyVJM20yU1a+prhB9vAd5ygjyRIbHhQO
bgA3pzijcHvxZt4tWLEwtOu/dYHdEQ==
=lzg0
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--

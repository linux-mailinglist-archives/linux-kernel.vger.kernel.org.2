Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7904E3D58D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhGZLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233699AbhGZLHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:07:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20B3F601FD;
        Mon, 26 Jul 2021 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627300080;
        bh=l8v5lSsUSMTlqG/sB46EgYt3czOPr+b+BEd8Zf5u+MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGipXLAIlPGnfh15+eBg7GkWRidY2KSBtFjZYFGiiA3PY9fk4jOHHiesA8369gIsC
         8LUATQ0OU8aGrpHxQIQVKzK0cCVdlVq+UNVcR4Gxuqas3ZE09g/lZczmEaPJ5gOMNL
         vzt4cxHoVi4TbbZXoUtxpk9JsNkQJT4W/eAGhw/PF+ql/ynhmXCVJuHrn0ryPUO98o
         8c7b9oPX/sTsg7IELvCRpaS0Q9S0S9bD3unR6qBuUaobey0wkV+qmFUFKK526RIgqN
         bC/M1v1aeYHwDtNBvVb9guuV0AhSJzVoNxeCJJDq4bVEaK8Ci0q8qRxJMCnbmL1txg
         7oD8cxTQH2qIQ==
Date:   Mon, 26 Jul 2021 12:47:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: do not call regmap_debugfs_init() from
 regmap_attach_dev()
Message-ID: <20210726114751.GE4670@sirena.org.uk>
References: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
In-Reply-To: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 26, 2021 at 09:36:27AM +0200, Matthias Schiffer wrote:
> regmap_debugfs_init() should never be called twice for the same regmap,
> as it initializes various fields of the regmap struct, including list
> heads and mutices. A visible symptom are messages like:
>=20
>     debugfs: Directory 'dummy-iomuxc-gpr@20e4000' with parent 'regmap'
>     already present!
>=20
> This happened whenever regmap_attach_dev() was called for an existing
> regmap. Remove the call from regmap_attach_dev() and change
> __regmap_init() so that regmap_debugfs_init() is called exactly once.

The use case for regmap_attach_dev() is that there was no device when
the regmap was initially instantiated due to it running very early, we
want to attach the device when we figure out what it is which includes
setting up the debugfs stuff.  Whatever is managing to call this with
the same device as has already been set is clearly not that use case.

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD+oOYACgkQJNaLcl1U
h9A1xwf+KhllaKuCR+0eiR+aFqT12X5eXhI1N0wuLPuD7o713TqcbTDtP7NSJEUI
/Nw569My3AE0WYNeXdW85br9cTh+0qFTUdm5EEXYsY0a8fcFgf5QPpQ4SrHSM2BX
+PvuQjZHBlcrl/OpoaKkdAmGWEsvgraBg9Y7obmUOfHhW0CljEB1q+vqpLaAoahA
ov4wJEN50LcsNAnzPDWt+kZAZ3ArScN+0uGI12f9yu8ORXdpHbAxyCU6sbm4TzV6
8h9MeF1XYuPrA5dELuXjxZ6pO6+TUVPQtNTw8euH+rRouYgXlr8IQeqd83d1zNVU
Qh6AS6a+qODGv7TvBa1SKcTIV9HjCQ==
=DQ6A
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--

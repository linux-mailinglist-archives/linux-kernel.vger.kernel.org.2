Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996F03D590A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhGZLTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhGZLTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:19:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14E3960F22;
        Mon, 26 Jul 2021 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627300822;
        bh=3VetRwrPdfVNkTCSyDxeJog1I+BWUCJ5ZzUQXf61mJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8ID//VXw+CdwAedoAkA68zA8lm6KJ1lECu7v7yqI9PhAcsmERR+ojwCXy3q5FQAZ
         FBfEIYhal3hTgxREkDXTGqQ5jOirYwTXyO1/m5KN1YpNymA4SSmyfRAyWcrlrOgtr4
         tM+8lovRQ16LsHfCsxDOqcq890ITR9c1JstUeHRlWmI1UxTKI160AmbEh03DHkkh9d
         6ZJNqdgFJ9RQT87CBQYFVb5+28HwaFMI9qTG0D+1D6MjjW2msFbeIVlg72+6aKfha7
         hsC7dBPB/Dq8G1wT7lIydHfhKSSXR+dDvrcRWrG4BaOid3aOM7ExviMeJl7V1n/yoQ
         M0gCqHXYk34lA==
Date:   Mon, 26 Jul 2021 13:00:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: do not call regmap_debugfs_init() from
 regmap_attach_dev()
Message-ID: <20210726120013.GF4670@sirena.org.uk>
References: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 26, 2021 at 09:36:27AM +0200, Matthias Schiffer wrote:

> lacking) understanding of the semantics aside, the fact that
> regmap_attach_dev() is setting fields on the shared regmap without any
> kind of locking is at least suspicious.

BTW there shouldn't be any harm in adding locking, but we're really
hoping that it shouldn't be required here as the caller ought to be
doing coordination which means things are single threaded anyway so we
didn't bother.

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD+o8wACgkQJNaLcl1U
h9DMMgf/Z1lGVAc7mWRioSdQkmo29hm96hCkbR5zWKj0SWGrjebq9patPGV85aw5
W1B4n6/n0dEqr21nylJ5zFmkQ4NsNPY7Jkk+FQObJkFbrTQIKsbA1zOfc9CYtSO5
Xp8hUIX59Kh69VEr32Y4uetbUDMSgw/XmPe8tqbRT0RWZHZkX0Lvyfz4orfIgbp4
WPYhIX/bcDIhtMoR2hkMx+zIsr/z5nLQdXevlTTTyUXxV6VcVz0enxBYctDkYwFG
kvYVb+FgPBngytvVsIgSjv02OIvk6gQnNbLDUuImGjJZV4bMZy7Pix7cyvSvLwoz
+i8D9LM6r39xx08VLmmP3aKA5ZPX+Q==
=zz/F
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--

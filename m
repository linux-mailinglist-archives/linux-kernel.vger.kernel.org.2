Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7551132AA87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836107AbhCBTnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344182AbhCBRPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:15:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D05F664F23;
        Tue,  2 Mar 2021 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614705237;
        bh=rTa+VFMAdGMoFocARiaHSEJ8fY06Ra7RcO+lNs2jNXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQ/OzDT+b7dShEf/PIDOh13OgJoQyXN0RZ9nYKUZgJ4Lnnbn8dGFKL3BJLkuPmfDl
         d6PxsAwIPwbbHvNvkOFnzqUu+BAc5tGg8Eqa1Lh1bTRvN0AbneHOanvqs7STcj4jAt
         9PzjFFn4LWF6CjEPjNHXrPROUGKh3lZak2afQNaH7aHHDNYtzyTtXLMBN66mvhCyho
         ge7BsaSZAzbz6HRm0nvMQSvyZgzuAIuqIndmMHQ1lhyjlj08rKQMKFoBTmyG9Uf2HF
         B+7/tZShZVnQue4BSD8PkTxWe0T+QYIv3gbUv5xcC7IhTyAxXW4bXycpobSJMiRnSe
         OBqgU+Wets9HA==
Date:   Tue, 2 Mar 2021 17:12:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] ASoC: cs42l42: Remove power if the driver is being
 removed
Message-ID: <20210302171250.GO4522@sirena.org.uk>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
 <20210302170454.39679-4-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
Content-Disposition: inline
In-Reply-To: <20210302170454.39679-4-tanureal@opensource.cirrus.com>
X-Cookie: Friction is a drag.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2021 at 05:04:42PM +0000, Lucas Tanure wrote:

>  	/* Hold down reset */
>  	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
> =20
> +	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies=
);

Are you sure the device is always runtime resumed on remove?

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA+chEACgkQJNaLcl1U
h9ATtgf+MNQsl9DYDnA0IuhXNX2UYO8ULD6URRUWSQVUwauxN/xqFUhK/7QkRhbv
+uc58aCIkAOTNnd476FGA34BwivjGOt2M6QSpgYywV79rh0zSHaX1g25S8Mbm9I3
arknamPvzPz6hcU9KFCl4zlfhJsUosEuvYmWeUqxrFNUiuYeHjgS56vOVBSatD6z
GXEccn3VXpV395tMc2Sp8lUJpZ0RwKdKs1BG5weoSQgDpRiViMweIaLnSUaSUFp5
FB/o91xSAj/NVTkPOGZA9Xcj3rZzQ0VSjE3I/FFvh52QpIQstsTgqn/5TKRunKWD
u5g8WGYF/S+1q86m4bpHyShOseqGnw==
=Re6y
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CABD3D64E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhGZQNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239852AbhGZQLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:11:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BC6B60EB2;
        Mon, 26 Jul 2021 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627318293;
        bh=9wY+vK8pU8J7omIu+pjegU2qRU8KinU8TvumD7+FnYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1Upm1SMxQcZG0iZgig5cay6fQ3MmbTYQGqCpn5tQk1HdV/AeHhn4Qj/ON9J3inyC
         +Q3zJaZbfa6UWk031xegXgo3PQHyIwr1QzVQcrqj4vFlnm5wfsB0teOpk35ZEWF4lP
         kmf/d/yEOTGV57ZSQWgAuzwAEp2lg+qZY3+dkcV7t3T/tcSsPBvwFbHQHVasBFNDcF
         lCZ+BiODNMQuv5okFo3lRJdPZyaVL4UXbhQtN2j8mjck393jXIz0m/Za0iWdyuOVZH
         Bh5RL3cuuV67VVTyWj4i6SYFkA3YlnntkAfMNgL2kGGuw4AK+AeIKhRRRaJJ27HvJm
         t3Qlzi5sFt/Nw==
Date:   Mon, 26 Jul 2021 17:51:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] ASoC: cirrus: i2s: Prepare clock before using it
Message-ID: <20210726165124.GJ4670@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-7-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline
In-Reply-To: <20210726140001.24820-7-nikita.shubin@maquefel.me>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 26, 2021 at 04:59:54PM +0300, Nikita Shubin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>=20
> Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> to Common Clock Framework, otherwise the following is visible:

Acked-by: Mark Brown <broonie@kernel.org>

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD+6AwACgkQJNaLcl1U
h9A6Dgf/Wm+8EbWA4QXnD1gSbW2Zlde8S4f+YIjYt2M+qV9LmDgwZP6bDSkRXepv
s8ddt8h+D7mYcN4N82bEPlQVcPqzM3yi2DM8Ba6Vp6FWL7kLME2tRDhN2YH63Chv
PDeAvO3ThrXmd2hOOy40WgiR+oRG7URiDCbUYxbU2Ce1l/MueeeRwJohgOfp4S5a
SDt3IoRGZH7cfa92Sybcvrj4cs86jYEa+SzotUYElkr4X5pZISG24t3rchwZuM6+
5vVbpkCSCIhCH+QH3OlRgf3GLxrI22ExJTBdaeGh/Mo8ZQ2eJFYDcmO8BJVOZmvk
MPRriHL+0E+GfcG+2S7Rn6gaDmut4w==
=5Q4y
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--

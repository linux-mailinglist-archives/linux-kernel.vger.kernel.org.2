Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A58632AA0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581531AbhCBS6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:58:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1449112AbhCBQPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:15:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C071B64E7C;
        Tue,  2 Mar 2021 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614701626;
        bh=XcaDjWsURv/8uZujGdas5wp5M1JZxAMhhXQc0wmkd0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMdaxma/dPA8gQWX512Tik+zy7s5XhBA/c3U6rfgto/T+dowq5GR7QoNwNlgJtmt+
         pRn42HIPQeCSPnqb+0ZGZfA+D4sTTN37fgPCB2+fFB+RBCsKt+O+SNkaGlWkMcORZ6
         YcJBK6kC5WlqOP1WLs2urMyZLKwPVlhxjphw/wi/kpnSU7DWHQiRKhsCuUpjMMo/af
         ibld2EvNF/AjyFkXJAhEIijJxJoEZg9vgBFdHsT9lBNTNn2t7HdAKPeqUWnzaAVhw8
         rTIfSQAcYXobOMi96H7vpWqbCeSxvFoQFWm1Uwrv/i6BcKy4ahkt/oyK5U33ZCgBRv
         WjAepb457Ne5Q==
Date:   Tue, 2 Mar 2021 16:12:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Rob Herring <robh@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/5] ASoC: audio-graph-card: Add bindings for sysclk
 and pll
Message-ID: <20210302161239.GM4522@sirena.org.uk>
References: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
 <1614276364-13655-4-git-send-email-spujar@nvidia.com>
 <CAL_Jsq+9esDGw7ZCLnZS_KLmLUFyVenz83ohgNKFK3bdPD2ouQ@mail.gmail.com>
 <0ea5b885-2610-8f12-569d-15a8eff50c10@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline
In-Reply-To: <0ea5b885-2610-8f12-569d-15a8eff50c10@nvidia.com>
X-Cookie: Friction is a drag.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2021 at 12:33:04PM +0530, Sameer Pujar wrote:

> This was targetted for external audio codecs. Their internal clock
> management is not exposed with the clock framework. Instead ASoC provides
> callbacks to set this up on Codec side. There are many references where t=
his
> is followed with some hardcoded settings in the drivers.

> Are you suggesting to instead expose codec internal clocks and manage via
> generic clock bindings? Would this mean each codec driver has to implement
> these clock APIs (for ex: set_rate()) and program registers accordingly?

Yes, that's what we should be doing.

> For a platform, different audio cards can be plugged in. In that case, ea=
ch
> codec has to be updated to follow this. Wouldn't it be simpler to use
> available ASoC callbacks?

If we want to use standard DT to describe things we need to use standard
bindings to do it. =20

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA+Y/YACgkQJNaLcl1U
h9Dfkwf/VV5E+1E4QxiC9xMRf7CW6kQ6uOQUAIFgRWw7AeHnhEAPA0LxXX+G9DuH
AYLLxx8/XoQDfbuG6WC+i7VomWK2rYpg4jo1G/f93iHFiG7AhXmr4crkEUXnKoUF
6Qou31wOajsXqhh2SlOGM3EEcA73s6eMksiGFuvazFjRHQKk7V91PcAmlujX9qUA
tsn+gsy6ebjriTqxMJ0atPeKsawOlaTYvDQkefn+3DV6RtjHA7i6x+0IKxdPhbV9
ZVKc/q+sAdXJCjnGln9qDe1dRCoS3CYVvgZvteN4MH8+AC49Wm9DEIW+UNvS2XE4
eWrZTbtnc4Fqg3WqfsVOAM70RK1+cw==
=kyqj
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--

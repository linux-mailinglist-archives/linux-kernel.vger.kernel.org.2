Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3757633D47D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhCPNAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhCPM7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:59:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F25F65054;
        Tue, 16 Mar 2021 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615899595;
        bh=qwBm7m6FV8Asv3SjFX/QnnnbKfOuU9r79opiM9sj9mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKEMIhQCaVn3lLwByE24nqImVHqNJUT+/8j9sbtM2chyG0jSLvPAZM8F4f8axyuJC
         jybxzpe172SfZXs7qpx2d8s4Qd5wugn26nfNH9T8evegc5LjBsgS2HufHzR6sTDVbG
         XE8PdCmwfF0CKowDN3d9zh5QtPEsWcllXIT3CrmHYj0QgSFwxguhxamKYdfrEhKFFt
         vDR7CBPirXnx8k3GpIkjLMNLO6/XIPxcQXLP0WO1rx+gJW9TtC8HNyXPboNaw2UziF
         4VETN9iyh3qPO+vDqK5V5c26AkvUZqHeW+EwMVuLTZ7pw5Q+9opRUb2vB2Dx5hS5N6
         UA0XsjjW8xtpw==
Date:   Tue, 16 Mar 2021 12:58:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: remove reset code from dai_probe
Message-ID: <20210316125839.GA4309@sirena.org.uk>
References: <1615886826-30844-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <1615886826-30844-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Results vary by individual.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2021 at 05:27:06PM +0800, Shengjiu Wang wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
>=20
> SAI software reset is done in runtime resume,
> there is no need to do it in fsl_sai_dai_probe.

People can disable runtime PM in their configurations - do you not still
need a reset on probe in case there's no runtime PM?  It'd probably make
sense to factor the rest code out itno a function though.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBQq34ACgkQJNaLcl1U
h9B1lQf0DcB6TePE9N4R6M55ENvpw+3OXeo/AocY7jVKhtvhyr3WBZe8nDwnwbMQ
m8jPvvIuRx2l6ozvCdpJkIWkjGLEdOG0q/+n7HGEV8EFPa20tQPSkWRt/3zPKaAD
oSJP/xemNE7Gt9DnZXM+kgI4NxgXXjbHGt06YUPy/h9SGjgpoaggkdI+zwGdWYJZ
BoJjaI5+cAnAXzp3RFnVmJGwIWER8vF/Mv4vIdbEz5lbamaVpG80yJEiyJOn8GmY
ZA5Wc/4wOBLOpdCCXklTQi7YU/nJpgCflBrsXtqT9WNUH1OIqYc4oqiMb9acw/G2
L23Zg+uzwL3ZBYsq5CyQU74jmCTa
=M0pT
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

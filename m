Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C233FB466
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhH3LRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:17:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45678 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbhH3LRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NyYyKNuQkuQYhHpyfihpNQPI/JcjzacTLjVC2LrlJ98=; b=iO3Ttje7TRC+xHw6IJi+90271Y
        Cow65rC3yqKmeEfYxVCcbb1w5gKRQWum8EgB7HmIRK3QsdZD6hN/TpAN31jcODTKMB1gqPfTbvHrm
        SzyDGfpoW3RRRkxcYSQOaqlYP+a8iLb1V9Wze3AzT5guyLCXqlhVU+EYCm7T1zEqGzBo=;
Received: from jack.einval.com ([84.45.184.145] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mKfGF-00H3kp-88; Mon, 30 Aug 2021 11:15:31 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9A40AD1B485; Mon, 30 Aug 2021 12:15:35 +0100 (BST)
Date:   Mon, 30 Aug 2021 12:15:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Mark@sirena.org.uk,
        Brown@sirena.org.uk, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, Jaroslav Kysela <perex@perex.cz>,
        vkoul@kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        tiwai@suse.de
Subject: Re: [RFC PATCH 1/2] ASoC: soc-pcm: protect BE dailink state changes
 in trigger
Message-ID: <YSy91xTP/5oSedrZ@sirena.org.uk>
References: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com>
 <20210817164054.250028-2-pierre-louis.bossart@linux.intel.com>
 <163000225499.699341.16303629557242399115.b4-ty@kernel.org>
 <27b9fe7a-18cc-61ee-1e4d-72282d8eaa82@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KbF+CK+GgO/eToBg"
Content-Disposition: inline
In-Reply-To: <27b9fe7a-18cc-61ee-1e4d-72282d8eaa82@linux.intel.com>
X-Cookie: I can relate to that.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KbF+CK+GgO/eToBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 26, 2021 at 02:24:19PM -0500, Pierre-Louis Bossart wrote:

> Ah sorry, there were still some issues in this RFC, we did more testing
> and came up with a lot of improvements. The intent of the RFC status was
> also to make sure it wasn't applied before the merge window.

> Can this be reverted in your branch Mark?

Ugh, right.

--KbF+CK+GgO/eToBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEsvdYACgkQJNaLcl1U
h9Aqrgf9EqS8ghLiE431Ff8LEj0Cc56w0GFY5ljKjEOBU0VDBAZ+jQIoCJLMvImw
AeOd2roO7f1P1CFWm6Dn3Nd2aCfcemNX9SmUmwZNa1Frhr6lvo8/StQjezz8ReIU
gHMsUafvjtwXpg+utcbwOmekXrwWtJ1PfMyNR+4HHjEbk1WZ7FFw3Podk/NTOkMR
L0p8YCV2JoFyjm6Q30sOehuud4a2PX8FTumfSW+iC271IT/gGitBE78F1fmrJ1P+
BxPOSdO0EGUhZPjTDRKaIz/ZvnGTCzqO5vIE7RZb+JfYlj9rUd5nnJys7B64YeO4
Y11z5mNXeRi4jwFznwao3mR0xNRfNg==
=wzKS
-----END PGP SIGNATURE-----

--KbF+CK+GgO/eToBg--

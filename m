Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737FF390386
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhEYOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:10:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44722 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhEYOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:10:36 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 10:10:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pJL83TGl0mX04nFFBoTwiq0XD/0RboBicSXs5ma3mwg=; b=jmeaga3+cisqWvTamaQfrtT5sJ
        0BZ+PSNAZSnPIDtUOnJugy8lNJeV+TO/j6RYV/Lk1ULVlsxbyLvtdwy0yaIpVcOoUTHHerNvaxoQl
        ILJ9r6bJ6qAXkm/EmMbfL+HvCgRQFHaYXm3lZnNcj55CnESVYK1ExxjtMJwY9PoqBCqI=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1llXjm-005l4l-ML; Tue, 25 May 2021 14:08:51 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8195DD00386; Tue, 25 May 2021 15:09:24 +0100 (BST)
Date:   Tue, 25 May 2021 15:09:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: cs42l42: Fix 1536000 Bit Clock instability
Message-ID: <YK0FFJOOalQZKl1q@sirena.org.uk>
References: <20210525090822.64577-1-tanureal@opensource.cirrus.com>
 <d71d321f-1467-f8d6-4d1b-529723404d3c@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ED9N/z5atBV0RZe6"
Content-Disposition: inline
In-Reply-To: <d71d321f-1467-f8d6-4d1b-529723404d3c@opensource.cirrus.com>
X-Cookie: The wages of sin are unreported.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ED9N/z5atBV0RZe6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 10:12:39AM +0100, Richard Fitzgerald wrote:
> Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>=20
> On 25/05/2021 10:08, Lucas Tanure wrote:
> > The 16 Bits, 2 channels, 48K sample rate use case needs
> > to configure a safer pll_divout during the start of PLL

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--ED9N/z5atBV0RZe6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCtBRMACgkQJNaLcl1U
h9BkRAf8DQK0EW13T9xELk3PoeaZqHPbZt7haB9ejlDgKLlMXqpQ6vC3509HUk/O
voRWJA7yr4Yt+jXhDXyU5t8pjfb0ImEpRw2+NHOBduU2DQa8E6tWG1i/pX3mnryj
KJEFPnkltiioD6htW6IfJDa48Sg8QQchInpp8buEK70563OSa17FDw01qRNwFfkl
w+gdE4EG31pVd6rvM45R0mwzYwLBKLGiIyx7YeD/NjR/NkqWW31g5WXMEBvXfrdi
jI9ZnVMBWG+oMQ8SBmU5vmxyjDVaTb6kVQBDiUJ73+hjHVS/imJFMPl9Krn7dDYm
JOaBbZqSv896Y+l7GUkS7IXlcCQwiA==
=Jd8O
-----END PGP SIGNATURE-----

--ED9N/z5atBV0RZe6--

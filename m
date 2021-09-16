Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F45340D861
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbhIPLVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238088AbhIPLVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:21:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B8C761279;
        Thu, 16 Sep 2021 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631791197;
        bh=hkZogoYNPdYEtUjvYmWScZnXUuf2kqU4pXAbkQUNBO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XG8Tfc7onQvd2XyZMTAZ/HhFjxz7fUBZIWzDGZeDEFEQ+JBkULgs90G2RkcqhYhdT
         FGUhY7ievLcyjv0rrS5mjFT0Fe+rSMK8Y2bJlU+j27Z8dULF0qG2ViDgYlQxdJQoPd
         ZzeVR60GzeTeRKolRbZYgifIexM4zRzGSLmhsWDuMeMRCyQ9MHw8z4po6yF+8Zn18W
         XOS/i5a/mH+pzQ2xtKFiI0zldFGcj2gN5yZJWyxR4v7VR2PjKxM3VbD2oRnZzG5E6J
         JgmBxQWmzxAdqz/ulkHXFIoMmqqqt8/yvPxvjQPDts4ZndELMsn+Eja18gJQpjeL+I
         FhfeBMTtzpohg==
Date:   Thu, 16 Sep 2021 12:19:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] ASoC: cs42l42: Implement Manual Type detection as
 fallback
Message-ID: <20210916111916.GA5048@sirena.org.uk>
References: <20210916102750.9212-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20210916102750.9212-1-vitalyr@opensource.cirrus.com>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 16, 2021 at 11:27:49AM +0100, Vitaly Rodionov wrote:
> For some headsets CS42L42 autodetect mode is not working correctly.=20
> They will be detected as unknown types or as headphones. According=20
> to the CS42L42 datasheet, if the headset autodetect failed,
> then the driver should switch to manual mode and perform a manual steps s=
equence.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFDKDMACgkQJNaLcl1U
h9Cg0wf/ZsdUfPPGnZrzV/JsuLORkQwmvOzzohe6dj+8bh0wk8j8oRhC7yzFw/mU
a9qvBLRTH1/8MFoEKfkb+kcHVYxscEyKhtNATEafbmJLznUziZmHPYTokvdhROSK
ZzGbDi+bF+NoyMTWoYwEdvze9PVBDLqb4cEZGC8EUHC9TiS/oLN1rPtPWP8lReuR
Q3E9jHfURI8F6rbIaJxRiSckYnSWR5X/0BlTeW/rckVq1kQY7Ng/ym/dbLdsr9s4
LaIQ8ibQ2kBUV5xynK2fhnvO/uLk9b2ydBniwd5jgcu/g9wtljPwAkTs/aNmOLu2
9C+YyScgVKLycZHwu1cfT+y4cfpOyA==
=IgJP
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

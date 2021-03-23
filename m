Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B09346947
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCWTp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhCWTpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:45:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48EA66188B;
        Tue, 23 Mar 2021 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616528699;
        bh=4fXIxe9zfop6mXnfzzcQom9W2hjlywJZkIUs6q3SfnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Etq4KelkoyUcpl8voEtVDT7Rg0CXBNiPvjNoLHSptKJjkGYX8s6G7GHTdE85tBmMs
         fn0zKiIex+2Gvykn0ffnY4ooOHqDYK0ad+Hpt3GhIkEzPfZpE3AjGgwv7MQuwM6cb0
         pt9FAL9bkEt8py24W9t1dqj1GJp5gI6At1iWd9K0dFVSbksHbhSnPQV34CCRA9UHgZ
         wCg0Q9Orstqg/ltugF9RM+BP16riKdwYDG9p76rFcLaS5vL0JDDutTPNn+ycgo8zpm
         ZwlPbgG/0nxPO6xCe0JDCjx1cbAIYxkKbScqzPetSvgDZBMbOM/CQmX64Oa8hDIjmH
         vh6fGud6zH6Ig==
Date:   Tue, 23 Mar 2021 19:44:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210323194452.GF5490@sirena.org.uk>
References: <20210308212952.20774-1-andreas@kemnade.info>
 <20210310094821.GB701493@dell>
 <20210311184033.GJ4962@sirena.org.uk>
 <20210322145925.GY2916463@dell>
 <20210323171143.GA5490@sirena.org.uk>
 <20210323172002.GY2916463@dell>
 <20210323174841.GD5490@sirena.org.uk>
 <20210323185254.GZ2916463@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline
In-Reply-To: <20210323185254.GZ2916463@dell>
X-Cookie: Formatted to fit your screen.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 23, 2021 at 06:52:54PM +0000, Lee Jones wrote:
> On Tue, 23 Mar 2021, Mark Brown wrote:
> > On Tue, Mar 23, 2021 at 05:20:02PM +0000, Lee Jones wrote:

> > > My question is; should these functions really live in the SS?

> > Perhaps we could avoid using that particular abbreviation.

> Too soon?

Sadly there's still people who keep it relevant around.

> > Like I say it depends on how common this is - are we seeing other
> > devices with the same problem?

> I'm not witness to any.  If this is your first encounter too then
> maybe just leave it where it is.  At least for the moment.

Sounds reasonable, if more turn up the code can always be pulled into
the core.

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBaRTQACgkQJNaLcl1U
h9C6RAgAggpQ08T7gTohbyX8qDtjndCCRDFeLdTltugN8DD1Zkw6CMCYdwCR42Zu
YoW+1VPOfas6BddiKrOfBP3OKC1Tinu5W/NeGJg2uaxdAo2Cj4ihifjMKqqqf+qm
G1UKsZcD50Be+t+fBXK5bczaOu2J/WhWdlZLq9W4+I6XQMcfHWYztSIPMOiCpXd5
ktMtxRCvRq1/3zqNzBQxSduTN78tTN3hFug/AvdHiA4avvN/fI3kElb8stQBN1gj
iF5HEZWYMCHNhtV9rb60wSjNE6kbnRKcpnj0rLed7pnH3aFPecDj2Uhv4PQcV6zu
TOe0zgjAguK225kcv4xRkHNLrO5O7Q==
=bBpd
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--

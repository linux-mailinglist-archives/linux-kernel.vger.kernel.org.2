Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF273BEAAE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhGGPcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232050AbhGGPcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:32:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43BF261CBE;
        Wed,  7 Jul 2021 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625671814;
        bh=EvKCrrNYIqUwqp4azeFISHn9XNSNveAjy9rdEMTGYR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYnH9IxZJjFxq1nDZVDCSEthpAIx09mYpmIPQrIzKCyStC+DsKCE1uqF+m1eUbd4G
         Iogm6tivT9KQ8b5JpWmpvrLapSchQ6KKh5u2ifzYZiZD/o68KOaiY7dixtj3rqeK8T
         nsGHrWKMk0izLdtiw12EapJmkC+pyrrl2xdjwLf9NlQGdqVvkLxH+Mk9eo5iwDlV1I
         Thp8tfCmgxZuFb5Zq791erHRPJUwmNmqfHZONQWuCBRF8j0fF/KcmkR2unTN/YOfHh
         RYPNlWUlBLM/jZhTgkGqwm29ScFNXIsR9LIDh5VCbiC2xz8HM9qe6A7W2CfxmGaTOa
         LgMi604/wrLlQ==
Date:   Wed, 7 Jul 2021 16:29:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "embedded (VIVAVIS AG)" <embedded@vivavis.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Voltage and current regulator: usage of 'regulators' parent node
 in device tree
Message-ID: <20210707152942.GD4394@sirena.org.uk>
References: <a8700cd3e056423cac4e209b8f740595@vivavis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <a8700cd3e056423cac4e209b8f740595@vivavis.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2021 at 01:09:25PM +0000, embedded (VIVAVIS AG) wrote:

> Should I avoid the parent 'regulators' node?

You should ask the DT maintainers, I don't really mind either way TBH.
My understanding was to avoid the parent node but can't remember why or
if it was important.

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDlyGUACgkQJNaLcl1U
h9Ax8Af/QBgIHdTGVnECno3tH0X7GfNqamMKqRJwaEJkHhd10BLBUG7fu3tlxF5S
vMbGThZDcf/CKWLwgXMPY9IOo8jxnNqYW0n7nmKAKAk4YefreGxMpcEW/6joxJKG
XQKK7mrnJodm9jO3sPkukQPC4eFOq6XLc1Xc3Ek48JklMmEUD82AqIIeJGzuVxxX
gOsBmZI4OqWSKQlbeoll3c3Gh1P+Z7PsV7tSwIlQX2nKslRkpZXgq35aSqduQGeG
tzkoGbPSS03tTV+YMFeexhTxvDV8+nr90nouw7t6IcywcynXGAp11H1QE+xFM/nH
moVVqN6psz3BYJFISFeLpClUpmKVMA==
=vEbh
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--

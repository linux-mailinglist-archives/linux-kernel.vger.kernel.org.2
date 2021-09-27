Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2690E419BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhI0RVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236702AbhI0RQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:16:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4496161206;
        Mon, 27 Sep 2021 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632762681;
        bh=YIj1ttTgSoJXrNem4LCwjOWEjR6amIHkBClahFPqxCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQpDrq44YdtHSTvkRChK+pqC47EzUI7ZnD4oL00JGKT33Qh/Pkbvl4z2RdNK62AKc
         YeJ1pY7WhZckso1550bSxgeLJ0r7PDhOG4pPgctajdWKxELzDyh36ficRuBkmqEidE
         h6kLnYXUj0M91IT9atxCCR8Vs6ZZdViovIKstvJLRfcewf/0p+1/yaec79p8vqQA93
         wddJnDJH7KEBkTLLVYdZbU8xOh7J8ex/lrGw0IRVtMrS3YUpQ/1H0Ntpa6e4EU0onP
         lkC4SeM+xHLEXecYQkh4cqlhptFqOs1T8vGZXvfUaZrKFwbKCGt9UfwBGv6SVvV7yc
         giILeUx6mEyvQ==
Date:   Mon, 27 Sep 2021 18:10:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Ryan Lee <RyanS.Lee@maximintegrated.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "guennadi.liakhovetski@linux.intel.com" 
        <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] ASoC: max98373: Mark cache dirty before
 entering sleep
Message-ID: <20210927171033.GF4199@sirena.org.uk>
References: <20210924221305.17886-1-ryans.lee@maximintegrated.com>
 <1b21bbf1-12c7-726d-bff8-76ec88ff8635@linux.intel.com>
 <SJ0PR11MB566107A6AB3D18ABDEDCF245E7A79@SJ0PR11MB5661.namprd11.prod.outlook.com>
 <20210927160622.GE4199@sirena.org.uk>
 <7b8c3875-3f12-f3cb-7da8-4e850e59ee2b@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
In-Reply-To: <7b8c3875-3f12-f3cb-7da8-4e850e59ee2b@linux.intel.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 27, 2021 at 11:48:56AM -0500, Pierre-Louis Bossart wrote:
> On 9/27/21 11:06 AM, Mark Brown wrote:

> > More specifically what it does is make the invalidation of the register
> > cache unconditional.  It doesn't really matter if the invalidation is
> > done on suspend or resume, so long as it happens before we attempt to
> > resync - this could also be done by deleting the first_hw_init check.

> Mark, that's exactly my point: if the amp rejoins the bus, we will
> *always* mark the cache as dirty, before the resync is done in the
> resume sequence.

Ah, yes - I see.

> I am really trying to figure out if we have a major flaw in the resume
> sequence and why things are different in the case of the Maxim amp.

> Instead of changing the suspend sequence, can we please try to modify
> the max98373_io_init() routine to unconditionally flag the cache as
> dirty, maybe this points to a problem with the management of the
> max98373->first_hw_init flag.

A quick survey of other drivers suggests that this pattern should be
factored out into some helpers as it looks like there's several ways of
implementing it that look very similar but not quite the same...

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFR+wgACgkQJNaLcl1U
h9A6bgf/cTWeKoYgzRvwlZJiKiKpOgHaFh+QmrmyBmmUJXA6VH6m0Fze8+zv238K
RxgyPpu8fmSAZ+7QuLhbVl6G9dUKV1WSQM7QirWFidSndmUBEUmHfrkREVMn0N7I
vWYkFVrWqlbxCPbh8s4H3bwFKZCbz4HQDnhKJH/Q5VhAMVSKEt22ybcZDUEvCzrB
z+fu8ayfDdfbUeJ+/mQJIUdOm9vC9/iHZz5K2EU7Jh1JFQyOsKM7h+pVh51DMe5e
p+GuZtmivYRLr7OA74wKxRMwstKwPJ0oZClBxdKvMZfZ4j3n+BET+28YxSMZMZXB
yUa/XvmUfCcybDNwVsFuVnqVjug5aQ==
=gqsX
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--

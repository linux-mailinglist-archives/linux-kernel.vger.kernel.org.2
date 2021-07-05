Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6263BC1CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 18:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhGEQxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 12:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhGEQxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:53:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EB8D61278;
        Mon,  5 Jul 2021 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625503872;
        bh=E2qKGlOmNIoto35uDuCrhW5NXTON5UvLxqC9khTS49E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIr27ePdACHbDgmGGKZRXNMTZR0fs8kzbIbnKjSrBctZlnzNQu/B/y/jt8juXVE3+
         qbstEEJjRtBNUNOisLCh+1iIeh+66mL1hZYZRJATzH+AvTaHWGeiIUHqAs7amuWI3s
         k31sxNPe0M8JNzu61SiHPQoYJ0aBmReEAVAIes9vEbT0i2nZSr7J8PTj9qEhFZrGib
         CVhwSlRCJr9u49QMY5ynCfgvKJXPow86xhoJ4/uvA1+3j4EzONLqoQ+5Ado1b/DmmM
         xK/IV2BxSJJ5hhUXKErlVibAdkY9Q4BtAyGKd4/yPddT36ysJoXJPgTN+Kzy+bsJkt
         qrFR2hd0D2o/A==
Date:   Mon, 5 Jul 2021 17:50:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     pierre-louis.bossart@linux.intel.com, rander.wang@linux.intel.com,
        shumingf@realtek.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: Revert "use component prefix when checking
 widget names"
Message-ID: <20210705165041.GC4574@sirena.org.uk>
References: <20210703125034.24655-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <20210703125034.24655-1-rf@opensource.cirrus.com>
X-Cookie: Star Trek Lives!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 03, 2021 at 01:50:34PM +0100, Richard Fitzgerald wrote:

> That commit breaks all users of the snd_soc_component_*_pin() functions
> because it results in the prefix being added twice. It also breaks code
> that correctly uses the snd_soc_dapm_*_pin() functions.

> Use the snd_soc_component_*_pin() functions if you want the component
> prefix to be prepended automatically.

> Use the raw snd_soc_dapm_*_pin() functions if the caller has the full
> name that should be matched exactly.

I'm not sure the analysis of which function to use when is correct or
what we want here (though it will work ATM), though looking again more
closely at the patch it doesn't look entirely right either.  The way
this used to be done, and the way that older code will most likely
assume things work, was that the DAPM functions would first try to match
on the local DAPM context before falling back to doing a global match.
This is what the fallback loop is intended to do, and the dapm functions
are passing the "search other contexts" flag into dapm_find_widget().

I'd not expect the distinction you seem to expect between component and
DAPM and we probably have a bunch of older drivers that aren't working
correctly like the Realtek driver mentioned in the original fix.  I
think what needs to happen is that dapm_find_widget() needs to be
checking both the prefixed and non-prefixed names, and that the
component stuff shouldn't need to bother and just be a convenience
wrapper for users that happene to have a component to hand.
Alternatively we need to do an audit of all the non-machine drivers to
switch them to use the component functions exclusively (and possibly
some of the machine drivers as well), most of the CODEC users look to be
a small number of Wolfson/Cirrus ones.

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDjOGAACgkQJNaLcl1U
h9B8VAf/fT+qkZLFc+06JxvhI5ChgxVl1SJI25mXkIlwItayArYD9CMLMTN4Lz4F
Y0l+VvAZmO98kht/uXvfnDbkawHzriFTxw86eBZdr6Aina6p5QWzlPS5xQmBTpx0
g0tvysXnfGbLqCXLZlee859ie7HRTAFzgZRixwXlwtTC/WEbKF4G7rZCtHeUqTMq
4syKhV3yEwz+L0RHEDxLfJ2pL3Y3af1xpi0I/0aLPMDEwRa0dm0p6DSIbyHMS9ig
C0JJfFZumjq74rNS1+8darm8IS9bxI8eAq11vNm866DhNPsIMY/abeukUj1ap1t9
7VdteccabI50+pM4wz1lKLkKwk3Rgg==
=t9wF
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--

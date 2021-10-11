Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8C4296F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhJKSbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234517AbhJKSb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:31:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4149560E90;
        Mon, 11 Oct 2021 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633976965;
        bh=diBqlvKGtEl8DB+wDdHMTYgQ2IHF2EbrhLa15A4CP2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/d+tF0DJkxtwnH29uUnvvLqm5k0JYUASoFRsNCx5L9lbsdvGqW+iRpGiQWHjVR3+
         wXT9VsHVv0KdfZwZp4OIcA14WgAcjIYNsdl1hhwBohwU+IeaPd8drIjtwmIFAr5hQg
         SMrunPn+Nc7clyp8hgM5dy6vVp6/LX7ERE0kgXHS4wo0i1R/32sOgvX/CSL9XKCfJK
         IFpQU/E/TCKr7ixArsVbsljlgFWLbKJ7NWKk8lH3jeJby9oVe60rRGOkVEpM7Zjh9I
         fPFAKWeMoe22+RY8AO2pVtSNxltMnaTLPYzAGsL+mWouxUwRFB6VMZQVX2g4Bo//+z
         YZPhXp+TKi/wg==
Date:   Mon, 11 Oct 2021 19:29:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Sunil-kumar.Dommati@amd.com, David.Rhodes@cirrus.com,
        wtli@nuvoton.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoc: amd: create platform device for VG machine
 driver
Message-ID: <YWSCg2Nzi8lRDiIE@sirena.org.uk>
References: <20211011184715.61573-1-Vijendar.Mukunda@amd.com>
 <YWR5QH1lYqiT1cX+@sirena.org.uk>
 <57f313fe-fb8e-8b4b-8839-d9d8653880d1@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eCPTkh53x3R1J0l+"
Content-Disposition: inline
In-Reply-To: <57f313fe-fb8e-8b4b-8839-d9d8653880d1@amd.com>
X-Cookie: May contain nuts.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eCPTkh53x3R1J0l+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 11, 2021 at 11:48:40AM +0530, Mukunda,Vijendar wrote:
> On 10/11/21 11:19 PM, Mark Brown wrote:

> >> +		pdevinfo[3].name = "acp5x_nu8821_cs35l41_mach";

> > This appears to unconditionally assume that any machine with this
> > hardware is going to have exactly the same CODEC/amp combination - that
> > seems like it's going to go badly at some point.  Shouldn't there be
> > some other check that we're instantiating the right machine driver?

> we will make the platform device as generic one something like "acp5x_mach".

> Currently we have only one target platform with above codec combinations
> for this APU series.

> When we get new codecs combinations to support, we will address it in
> machine driver by adding DMI checks for distinguishing codec combinations.

If that's the case then this machine driver that's being instantiated is
poorly named, and I expect you're going to get issues with assuming a
default here and trying to instantiate this machine on unsuitable
hardware.  It'd be better to at least put a bit of the framework in now
and positively indentify systems that can run this machine driver.

It really would be good if ACPI system vendors were to adopt a more
standards based approach to platform enumeration, this really isn't
good.  Something more standards based like DT has would be much more
scalable.

--eCPTkh53x3R1J0l+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkgoIACgkQJNaLcl1U
h9COMQf9GXDFZZME1KoLuEwkKs23hk5x6Yd5pCtMgh9arW9h8qHb5Kbfn9adyQW+
GsGdxXCgHv9MTOFWBeKgprtt4WbMqkp3vJEu+sV0ma3kFKM+0HupofMliz+fJ33t
aUYZTPWGvdPYUeQHL/g4dqMj0Vg6o8pZsEEbk46NL0pOddaP3o/tt7ficxzS8Jpd
2bbcA7oIRFi7IZJPHf9QvcSU98M406lgjAzO8bapXs579BATkM9B2y8VupQuGzS2
+Yfzqzg0Yz42FUVKpBlB9Iol0FSUt+DX9TfquoWIhmWNhHm06itGiXWi79R2FfQS
yfMXsfdEh2KPPxx+0Nh3CAriZpHCAg==
=15Z3
-----END PGP SIGNATURE-----

--eCPTkh53x3R1J0l+--

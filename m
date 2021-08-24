Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B583F61AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbhHXPdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238060AbhHXPdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:33:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5BD661265;
        Tue, 24 Aug 2021 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629819159;
        bh=useLE5bRaimi6Kd/BLq7pD9m3sUa/LB25LdOW1tuUa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HejrD8UYIOrPlQGN8MRhEgMLf8UMem1Tdl6Wexbdow2MWDWML+WlVo9Q42tua7LYz
         YDbd8ufOgQcdWlRCZsSLPrH//U3QXqaZnk5FBLzx0poUyQfiZDnzICRPgEMaP//1VV
         q8kfPtLvpLDpCtgbceNA+eUJc31JSCZgGjTWn6bCHOcNuxjsoE3ZGbO1X/CFtmu7oi
         kCLSVUa1xidLlOqz+M0DaR4eyn2Gc12P0GmbJcG5pJSUu2rtWWOM8UhFwuf/Qvw7DM
         E6jUtXHeERRM8iYHbO09tnz7a9Cg8CQDI2ARM2gc7o5pP1L8bvXJtTYQBbwQ4hewLo
         65t+fDM+NOPbw==
Date:   Tue, 24 Aug 2021 16:32:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
        alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, mac.chiang@intel.com,
        lance.hou@intel.com, brent.lu@intel.com, bard.liao@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        mark_hsieh@wistron.com
Subject: Re: [PATCH] [v2] ASoC: Intel: sof_rt5682: Add support for max98390
 speaker amp
Message-ID: <20210824153211.GC4393@sirena.org.uk>
References: <20210824132109.1392-1-mark_hsieh@wistron.corp-partner.google.com>
 <a2cb1661-328f-81ac-813b-7629a28ed766@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <a2cb1661-328f-81ac-813b-7629a28ed766@intel.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2021 at 03:59:44PM +0200, Cezary Rojewski wrote:
> On 2021-08-24 3:21 PM, Mark Hsieh wrote:
> > Configure adl_max98390_rt5682 to support the rt5682 headset codec and max98390 speaker

> Unsure if line-length for commit messages has been extended to 100 as it was
> the case for code parts but this line certainly exceeds default.

There's certainly no reason not to wrap this one.  Even for code it's
not something to actively aim for.

> > BUG=b:191811888
> > TEST=emerge-brya chromeos-kernel-5_10

> Are these two tags meaningful for upstream kernel?

No.

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElEPsACgkQJNaLcl1U
h9AARwf7BfAXV7Wkz0THiqAGF4w7gvMC27/IySbGoRAIhO2uzfCPnsbe/tV9vDao
TU77q+FporDjyxLMA3nBquq/5Wzu/byNIhLtF3Y3QUqMeUiLr3OpLjxUcaxStlVS
2tWbDEHPfMC2SGht+q2iVE+Nt4uUNM+vcF2vAn9h9DFpX9EarZGz0z9N/MZw42J6
EU0ryLqTeJHLVaQRdHu9W4qMkLEOXuoKup2TMW/8W5WkQBqgg66NW9kpV1ReR3l8
uWJhSW351c7UCkRL5mOYdjvgi3We94RwfjwOk8bTK9007ymJkAPhIrztK8LPgzVR
N9vY6z1Cnq3V4OWgltULn+MI9Mjweg==
=um1i
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--

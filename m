Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87FF30F35A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhBDMpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236050AbhBDMpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:45:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0E7064F53;
        Thu,  4 Feb 2021 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612442664;
        bh=lYGILFsu+f+q0RdjIDvSHd90eLEEs8nJarEafHO9Z00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNWa0dN7cb86kuJ+PnpetujDkEAl8u+r8uGe9eHcfmw4j0hK5Xxg79IICZVmaw6Gb
         FTG+uocXt43p5GCDOf8t9pJPrevTPrR7TuS35rCcDeRYs30DRGiUBc05CkigzO+5J3
         oevC0LKjGIWIiv1jAqln53fjZ83aHcN27FIQgBVzu/EJxFbxUsrd+NwjsLyj9qQrP7
         BmcnvTld49fTZ4HCkjrhKAlbS/E6nyKdNVtzjbxlKTrsy3+cueq6HaXjy/xYkIXEUj
         /9lGc7H8/vHlbjLB8xKDNNw4tbuG02gMk8PeZLRUQFZhnnJQDoSaVTvO0LEHxJobwp
         2Oz2tpRhci3zw==
Date:   Thu, 4 Feb 2021 12:43:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards
 with WM5102 codec
Message-ID: <20210204124335.GA4288@sirena.org.uk>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
 <20210204105748.GD2789116@dell>
 <7f53dede-946e-c38e-e871-3df1119f1faf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <7f53dede-946e-c38e-e871-3df1119f1faf@redhat.com>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 04, 2021 at 12:07:49PM +0100, Hans de Goede wrote:
> On 2/4/21 11:57 AM, Lee Jones wrote:
> > On Thu, 04 Feb 2021, Hans de Goede wrote:

> >> series are both ready for merging. All patches have Reviewed-by and/or
> >> Acked-by tags now.

> > I don't think they do.  You're missing ASoC and Extcon Acks.

> Right, what I meant is that the patches have been reviewed by other
> stake-holders, including the follow-up series being tested by the cirrus
> codec folks (thank you Charles).

> But yes the actual subsys maintainers have not acked these yet;
> and I'm aware that you will need those for merging this through
> the MFD tree.

The usual pattern here is that the MFD patches get merged and then I
pull a shared branch in for any dependencies - at this point the series
is now on the backlog of serieses where I'm waiting for the MFD to sort
itself out before I really look at it again.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAb6/YACgkQJNaLcl1U
h9D8Lgf+Pi3CfEF5amMyjiN4ouAm/0226P7cog22WyeZblm7uzHaMac+47A3uf1q
O3o5u6qf6R0Y+MK9KwwJPtcjjZUH9sRFAs8bP/h72z3R7bKZ8cxqeyMYf2EYaBat
ekm/tx3vOH5YuCgTwQ0zNoWQ6ruHL9PecqdOcFSzIl+rMysbEFfVpXW20AJPv2P4
WhnRrCVjB8zHnzjL2Yc/yuLnjz/Hd04bhf7qkd2Zp/VwxYhA6Gah3PMZVWoHWvKD
ob0TgT7NiI6Cj8p0AQM8QlzzSa9nUdWa7RUalfe20dd5qEB5bB/vbb37wgwWsgVm
fx+XBsqFLELGnM7ISxgqtjCTxpN8zw==
=7WEp
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

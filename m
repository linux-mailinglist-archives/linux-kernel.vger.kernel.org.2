Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2328830F49C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhBDOIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:08:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236579AbhBDOFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:05:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8353864E41;
        Thu,  4 Feb 2021 14:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612447499;
        bh=T9Wjfp0nkMYzfgwxsEYPdGsTSxUKhcebtGuX0N3yML8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0l7NrF+NqT/pgu8V6fdXC7kjVgYP/AzQIwHu7Yvp8lsRLuXP0wYVb7G+5KzNlQpp
         ncIZMZknnuuxfr/OU3JhK1s+itMDr05kVTWIqnE0EH5oC2IoxU+MI9xaITeIjBIgLD
         tFTIpMgtP2CyHg/M4M2DLWxAzp3EEnWDGJVpSnMdTLVcKxpNU6F4mn3iUgxYDgi4/K
         MQ490+ojomi0F2wOk75rTy18vQEx9HSQ62lV762/GNhDBC8/sCWmily1vjmXo7Yt3t
         OimwgMYaroduyjOBlYYAbS8VL9ml/5YqVcG34qFPaVTDcmvagmuZUa/fFrEmzBHSFW
         W57uM5kNJC77Q==
Date:   Thu, 4 Feb 2021 14:04:10 +0000
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
Message-ID: <20210204140410.GB4288@sirena.org.uk>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
 <20210204105748.GD2789116@dell>
 <7f53dede-946e-c38e-e871-3df1119f1faf@redhat.com>
 <20210204124335.GA4288@sirena.org.uk>
 <e646cd26-f61c-8414-c3ae-15fb5d5cc21d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <e646cd26-f61c-8414-c3ae-15fb5d5cc21d@redhat.com>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 04, 2021 at 02:18:54PM +0100, Hans de Goede wrote:
> On 2/4/21 1:43 PM, Mark Brown wrote:

> > The usual pattern here is that the MFD patches get merged and then I
> > pull a shared branch in for any dependencies - at this point the series
> > is now on the backlog of serieses where I'm waiting for the MFD to sort
> > itself out before I really look at it again.

> I understand. But this series is somewhat special, if you also take
> the follow-up series into account:

> "[PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec jack-detect support"

> That again has some MFD bits, and some extcon patches and ASoC patches
> which depend on the extcon bits and this series.

That series is drifting along in the same way AFAICT, and it's also got
the extcon dependency so it'll need to leave it a bit longer for extcon
review (unless some happens sooner).

> So it is really hard to merge all the bits through there separate trees
> and just merging it all through one tree and then pulling in the end-result
> as a shared branch would IMHO be easier.

Most of this for me is just about not wanting to have to repeatedly look
at the same series as it goes through small changes due to changes in
the dependencies.

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAb/tkACgkQJNaLcl1U
h9AbXQf+IJXwgL9aqdbY7YPKi9HW6BlM45qGQPYXshOPD3G4m5KThMbpwP9+xGth
PotG/vJy6aMyrfA19UQeZkmgIuOCOiqEfpaZZIn0EgAxkNq67io33zYcn2gf8kdl
niWKxu9rjM16bvt54XYL+qYkZcKr79UBfJ3a+hKIg11KGIHtCjYfqXnLrkc8I7sN
bKT33ehRSjUvEvWlIMPKJRaaMFiX+eZ4D2I73/BRH4bL6RwuiDnbUmAJI5V+1CQ3
p6C31kc3mUiP/bwGUT0SVltxqHSSB9LzeeQZUIuu9NvyPof7C2RuSzXUrmFC2JD3
7VbIH/BjxYNzvIAB+LL16h+2JVNTbA==
=/cMg
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--

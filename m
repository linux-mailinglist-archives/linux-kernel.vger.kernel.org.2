Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0E530FD2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbhBDTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238886AbhBDTno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:43:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A56CF60235;
        Thu,  4 Feb 2021 19:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612467783;
        bh=K6zzFQwByG159V3DD7+Xq+g4YvUvY6Eq5d6htqC0DaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UR9y/wGNg6qFrctsqJzWp0yItbg7LYRFeabLTW34G4Lk0lws4oPB76lP9q9sc1XxP
         YG9B0NfveXLxAPtewkuquu0YB3CQ6+/yp8fHMlAP2eeCZvNTQ3GMVIbxD8HeTgDQNK
         anZ3PUQqG2xuNVhZEy3Q9lkMtTgYbrEximNvHqZ0iGV6AiK9k/OIlSWs+jPUz7vmD0
         jmr2/a9od5U2al36S8A1yyU4qX+P5evJapi4EE0HER9B/SoioAXDSvBfw6F8ncvo2V
         f6jyW3NUkgDn/xJaN6Ge82vWQ5wDav3IRuM+XjDa8CN2MVItUg1UGGKt8bjEc48Wcj
         M+uXGeSRm9PLA==
Date:   Thu, 4 Feb 2021 19:42:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 4/5] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
Message-ID: <20210204194213.GG4288@sirena.org.uk>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
 <20210204140515.GC4288@sirena.org.uk>
 <20210204150456.GN2789116@dell>
 <20210204151139.GE4288@sirena.org.uk>
 <20210204154058.GP2789116@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RDS4xtyBfx+7DiaI"
Content-Disposition: inline
In-Reply-To: <20210204154058.GP2789116@dell>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 04, 2021 at 03:40:58PM +0000, Lee Jones wrote:
> On Thu, 04 Feb 2021, Mark Brown wrote:
> > On Thu, Feb 04, 2021 at 03:04:56PM +0000, Lee Jones wrote:

> > > This set has all the Acks we need to proceed.  What's blocking?

> > There's the subsystem maintainer...

> I assume that was a question and you meant "where's"?

> Pierre is listed as the Maintainer.

I'm fairly sure you can see what I meant here and why there might be a
concern.

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAcThQACgkQJNaLcl1U
h9B1Ywf9E/3EKLtrge4u3ytiqPKWEIZ68r8kgrzF9eK/ble/g5DnM9lohh5782WZ
Ddf1o8ZIqYQ1qH16DOdHmnLUNPsKfpVZ04iTzvsKhmuqr8RH4Iijg2BRws62403e
IL0/xf4YcPOAew+cq0HCPj9b9cNwxz/m6CV9iSh1X/yHzmCDm1DJ9thnsKCq6aXD
KPhEzfhXzpVOdis10EzO0fulu9RKIKcDjqbbBfYQOGXXo6+rhZp5wCRj4zThN+Dp
UGusn39LEfPICkgySk0N6/S7utZRKcEw5GAazb3ILg4x1AUJOpHZ8KeCPEREurZK
B0IqsY2iHC+EUW8QXgW1TOKPqjQF1A==
=4Db8
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--

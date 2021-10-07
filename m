Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9D4254FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbhJGOFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240542AbhJGOFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:05:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60D0161040;
        Thu,  7 Oct 2021 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633615435;
        bh=FxCAFLlGgK49/2COjsXgG1rVtjEcAsgaFojdvABsXqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvUZI27JoscBZGdZ9A6RfsjyOv7+5yiC9bYrhS1AQRCBO591YKc8EM+uKvl2wnBHm
         sGtXsUs8Dvb/gSQbVcLjLyKOG82Xkis8mSpmlz6ZvQ8w/yWRLcmht/4duU4PpSNi8T
         YH+OldYxh6AF6hTEtWHyDBJTPzsxQMfZwomxEbBUjM5+HpV7p3pkDWrX22K6nqMWVJ
         n6jCaedFT//3P7hUkfHRm1BTTF+Dp2SoRYpSnj8le6f96QykH6Cnufzufs41ij+/mO
         qEEWoTTnq4CRCMSlkwWyvofuwg8cKJ+HTW3QbHMksGyAXOXwvVnktUSotjrr9rP0vB
         +6qOIaczWzP+w==
Date:   Thu, 7 Oct 2021 15:03:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: sound: max98927: Add reset-gpios
 optional property
Message-ID: <YV7+STMCR9VwVwzH@sirena.org.uk>
References: <cover.1633572679.git.atafalla@dnyon.com>
 <5004d52da527bf1dd9e5b17e20b2ce50a0b57b5a.1633572679.git.atafalla@dnyon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NUQMgpiVZHupYbGL"
Content-Disposition: inline
In-Reply-To: <5004d52da527bf1dd9e5b17e20b2ce50a0b57b5a.1633572679.git.atafalla@dnyon.com>
X-Cookie: Colors may fade.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NUQMgpiVZHupYbGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 07, 2021 at 04:38:58AM +0200, Alejandro Tafalla wrote:
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--NUQMgpiVZHupYbGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFe/kgACgkQJNaLcl1U
h9CPCQf/c8ztQc827+7duxObGTk551NtNF0ANN+oi7Jj8i4cc12kZNRdnATusEp4
87+//IPw49XR2ecA1z/7vRO6nLWN82hYJg8+maq4mYyC6Iz2jzuyA/Z1EutvNuC3
jerDjqtvT6UPH5B6p46l9gwdsJQJ9JotNz8jo/YeQBTeTevsa8KG23UqE2dpv3vc
yz1wpRMo5+IygDns+PbkwaZnTtCSA6y0Fb/wF0YyAn8yt2I/EnRV6FSyO2nxA3Cf
4loSR5+Lqf5v6TrnZy2wOJ3PyNH0eYqg59Pj7ZQEqEc+91Af1xFm236cuHTajczr
sevuM75gVsXBmFbhoYu/QBc1eJQHTQ==
=Ulyj
-----END PGP SIGNATURE-----

--NUQMgpiVZHupYbGL--

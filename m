Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F422A325040
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBYNRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:17:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBYNRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:17:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C13E564EC4;
        Thu, 25 Feb 2021 13:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614258997;
        bh=y4q7DSUGlBQUICw0FwSwYXtR63BB8Vic54PlMbyGgxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulimUF6brK0QCnMrCWNDuFuqQZVnD54Ifk6Rc4FzYX3HfTBgIxS5OG4sgFEFm29x6
         dZUTU3/tRBWwbUJYD3MyBQ7N8iOsTlcln+m41OU6f2N6uLJk3Tk0MFlaFzRzUZZtWy
         qtNIBO+TkCKVp5gdhewL4/42fARp9Jp4wL1nMjVm+Q1q65//nh/C2mRkd73ZIykNV2
         VBNjGqrbq4LBHzYbbyESzqyFOLaT8+aN0sz+NPCpZSp1c5+VyuVmt3n9X487FUf+Ab
         kd86ffax9/jQDOhKSu66ZPxCr8k7npPDcS4ZZdNDySYrTNvYGhtYcHt2QjeKu4IYMC
         uolvmY4VgsVFA==
Date:   Thu, 25 Feb 2021 13:15:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, stephan@gerhold.net,
        guennadi.liakhovetski@linux.intel.com,
        kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: simple-card: Add dummy dai support simple sound
 card
Message-ID: <20210225131533.GA5332@sirena.org.uk>
References: <1614254912-15746-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <1614254912-15746-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: A fool and his money are soon popular.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 25, 2021 at 08:08:32PM +0800, Shengjiu Wang wrote:

> If sound card doesn't need specific codec device, just
> dummy codec is enough, then we can link the dummy component
> directly.

This is a big red flag - what circumstances are these?  If it's a simple
CODEC with no control then the general approach is to provide a driver
which announces the capabilities of the CODEC and can be bound to as
normal, the dummy component should never actively be used.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA3ovUACgkQJNaLcl1U
h9B75Af/RM+n9PtBClq9XnVctQ5C+2rTjwsTw5SWRQpJKoGqV+BZ19XdE5atakxV
poNqc+zVttDIfzRisPmKrc+2d+YwqqlDoyeONNTcvvW2P8dxIRbchVAl9mOFlw8S
JYTsZKt7XeHC3oPJja6Zv0wOg8IazlKy8gVKIJwSc5SsRdZOmofZolKlLvuPwHss
q4iFWA5veqiV5cECEUAVbdGasY4kr0us/pXu/akJK/dL8MH15P6OyejrZgRCwYzf
8Y8B33i/n/H3iT3J4AFbnDumStuAHcYUVjWI2BzP44YCXFj3+657ODLb/FuFL7Fi
3bi/Uo7UlU7lRPxqteaOYji9ECZ9TA==
=gnCO
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

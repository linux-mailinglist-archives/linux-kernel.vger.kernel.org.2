Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B7E446730
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhKEQoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233829AbhKEQoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:44:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E46006125F;
        Fri,  5 Nov 2021 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636130517;
        bh=ocA+aw4pirZGTHGgqV169WIEms5jSzs7du1qenb+eZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0CrHeWXPSgOGxW1ABfOZe5F7iB9LiCCXc1YpXOPxUUw6gyKyCvDhXkyyWXCsSaz/
         Nc22Q44HTYx2dW5mblxoy0pSUOf3OexNeLYU7GnugM5i6eXQG+7mJZ4hP41FkdnDrl
         TsPFi3OY02thxiKa4A5MWAIcUwM/PsakN08TPiLuRddw6NmojaF8HzOnQrlun07jZR
         s2FXx4uO1+suYZlEYeC1T1a1BvfjNK1CHdLodhUruXzUXElsDVo9ntdWcw3RbPRxTp
         7CIcxE6ghriTf1J3ZpSnt3E0Z40dgJbskVanPYkGje0Nk9UGVl9SjxPUFZLt59PElG
         ncqqOIWv351HA==
Date:   Fri, 5 Nov 2021 16:41:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Trevor Wu <trevor.wu@mediatek.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, yc.hung@mediatek.com,
        matthias.bgg@gmail.com, daniel.baluta@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] ASoC: mediatek: mt8195: separate the common code
 from machine driver
Message-ID: <YYVez/V9ocCXhYmg@sirena.org.uk>
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
 <20211103100040.11933-4-trevor.wu@mediatek.com>
 <YYP+l7tMofYoB+aC@sirena.org.uk>
 <b4360ea17c3045759e85ee13fa9c001afe73c93c.camel@mediatek.com>
 <YYVQC7KLZx8oxdXT@sirena.org.uk>
 <e404d241-0685-643b-4b9d-d85bb8783385@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xu7RSJUInac+5dPD"
Content-Disposition: inline
In-Reply-To: <e404d241-0685-643b-4b9d-d85bb8783385@linux.intel.com>
X-Cookie: For recreational use only.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xu7RSJUInac+5dPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 05, 2021 at 11:16:05AM -0500, Pierre-Louis Bossart wrote:
> On 11/5/21 10:38 AM, Mark Brown wrote:

> > We shouldn't be requiring people to load completely different drivers
> > based on software configuration, what if a system wants to bypass the
> > DSP in some but not all configurations?  Can we not just have controls
> > allowing users to route round the DSP where appropriate?

> It was my understanding the card relies on separate components

> - a SOF-based component to provide support for DSP-managed interfaces
> - a 'non-SOF' component for 'regular' interfaces not handled by the DSP.

> this was the basis for the changes discussed in
> https://github.com/thesofproject/linux/pull/3217 and
> https://github.com/thesofproject/linux/pull/3236

So it's actually supposed to end up as two different cards which can't
possibly be interlinked?  That doesn't seem to add up entirely given
that there's stuff being moved out of the current card, and I thought
these systems had a fairly comprehensive audio muxing capability.
Trevor, could you be a bit more specific about what's actually going on
here physically please?

> But indeed if the same interface can be managed by the DSP or not,
> depending on software choices it's a different problem altogether.

> We've looked into this recently, if the choice to involve the DSP or not
> is at the interface level, it might be better to have both components
> expose different DAIs for the same interface, with some sort of run-time
> mutual exclusion, so that all possible/allowed permutations are allowed.

Yes, if the interface can optionally be completely hidden by the DSP
that's adding another layer of complication.

--xu7RSJUInac+5dPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGFXs4ACgkQJNaLcl1U
h9BRSAf/SkjWUf/cCKGy0zPR/tNt3CMqLlX0YCzYqYiswj6dKfU0LWjOlsXEClp2
xvBonvHD9Ni048rh/n5re028LssK5IYCcxqNfi3WMM+g1nTe7msKcRWanYElCx1U
vmZUv5k7H/1aYktEU5/KjPhz6YlGi4eJqGPLl397gC0fQX9GReu4b9tdipO+AJ+p
UzDeHJ+pP/rvbpSiUcRKxA4MrFXYq17gd0xaRuUbrdOvNH6yKUfaeDcz8MBW29ex
c5gA39zLIqFq9VsEmww6uDWqX0WattYGTzErTm2y2unLpvoxVdsidUgEESNtimpS
AXlgO4XPiIZSX96+ACgiOB/MBzFFsg==
=iro5
-----END PGP SIGNATURE-----

--xu7RSJUInac+5dPD--

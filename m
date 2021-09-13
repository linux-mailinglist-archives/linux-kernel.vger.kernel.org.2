Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007D640975E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbhIMPer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241887AbhIMPem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:34:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C236F6103B;
        Mon, 13 Sep 2021 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631547206;
        bh=BVrxRWHKyUrGv+35tc6x5b7RGSJFUHhIxAEhdcNdIKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FakgeYfeGaCUOVDhuplPOuxzkueMRigaWZPbFMdFaWzXE1bGfIIOH1Mm6EF0NCgJX
         Iluf7pmOjapb/XnI4+xibPLH3PNTzPQtwjQ1G+hkJcJfOmoWXgsYh9StzqKB3c5B0l
         Z58aIJ3VTZ8ov0dWfyQjkfnEQ0+E5nZoZ68DRIznchEDUSgnv9OjoUdbDRw5mZzfLD
         zYi7sK5wyxfa4wT+OBkNYTjBRRZVXRPio/dHjMwWBat9Aer4OgGDt55PZngQ0+SPUf
         IfaLvfbRcezowcvk0kZoz1CaRIS40SwyTYzT6x0TImW6ksMk4RdDCn3AQARF/azmqn
         gddnu7nozISGw==
Date:   Mon, 13 Sep 2021 16:32:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v2] ASoC: mediatek: common: handle NULL case in
 suspend/resume function
Message-ID: <20210913153246.GI4283@sirena.org.uk>
References: <20210910092613.30188-1-trevor.wu@mediatek.com>
 <20210910102358.GC4474@sirena.org.uk>
 <5fa1e99f1b9097336a3e610dc383170f09036b14.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Content-Disposition: inline
In-Reply-To: <5fa1e99f1b9097336a3e610dc383170f09036b14.camel@mediatek.com>
X-Cookie: Above all else -- sky.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 13, 2021 at 01:55:38PM +0800, Trevor Wu wrote:
> On Fri, 2021-09-10 at 11:23 +0100, Mark Brown wrote:

> > It seems like it'd be better to just allocate the buffer at probe
> > time
> > and fail in case we can't get it, I'd be surprised if there's many
> > platforms using this hardware that don't also end up suspending and
> > resuming.

> Thanks for your suggestion.
> I agree it's better to allocate the memory at probe time.
> I think we can still keep the implementation in the suspend/resume
> function as a fallback solution if user doesn't allocate the memory in
> probe function.

If you can't allocate it at probe time you should probably just fail the
probe.

> In the new mediatek SOCs, regcache has been used to handle register
> backup.
> Do I need to add the buffer allocation on probe function to the
> platform in which mtk_afe_suspend and mtk_afe_resume are used?

I think you should have separate implementations if you have both regmap
and non-regmap versions of this.

--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE/bx4ACgkQJNaLcl1U
h9Arhgf/YT4zF+AifPO22fnvUWMW7ps029xRsDBaUGwyRl4XFu6O90vmI7jjaogy
2fFfMzXc8EoOGWfhZhrhZqkIogzIol1wDrEnHtWLDpdnWBOgejqTG6jh3hbIU4EI
PRKbvL3qTXlzfhz23Qb+BjG4SQaDbVfRbb+e+nE4Om9qw5b199MIDht8Mye8KMgE
Wqt+y6alWGPcl/1RsdRJ8pVWASpQyYmwwbaHnVtGEarrdVOZzmiEL2offMAwiW4G
NDRcFOJcCrpu5eECoF2RM5XeRwzwJ8CxIvKMtlbhbniPDRyBPaLZ2zPGEUfInaoe
8lGIdpFSBHHvIq1QE7w6VAoqpmER4g==
=eZc7
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--

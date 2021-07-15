Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9123E3CA0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhGOOmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237344AbhGOOmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:42:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C0C46120A;
        Thu, 15 Jul 2021 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626359984;
        bh=6akoi+UJGcbUN77Z7m34HFx3H3/898DwcnDi5HQu9ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQZo14/g4bjGzV1e9ydnfwm1XkNE6JXNRMd3FFVbhiFENrMTsq8zLTkovG25lAXOZ
         QyencD0xWzkxmEhYsGEwlDcrJ7kTOYQIG8P7x7VSVE2GZ5fO3rLmWqyK1K65eKLOig
         SyPSXLpdcY/yjISfbihek6DdqQihr8dpDW1BKEa70BcWZgPgchwWixphKMur6xA3+j
         CXHzG4EivWAURbB2WRI7Hd3CJXs+QGk9ETcRQlQ5ymtxvUt+PzvALlUXpXbFK0jUQi
         HWV28zMHIsFs+He7haB8jhCpXH5rIEDpEmD4PAz0mj+5rdwuyfzEuMinSNn4FdErqs
         d5cROUgxlihGA==
Date:   Thu, 15 Jul 2021 15:39:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, daniel.baluta@gmail.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 1/3] ASoC: SOF: Parse fw/tplg filename from DT
Message-ID: <20210715143906.GD4590@sirena.org.uk>
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-2-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <20210715141802.880911-2-daniel.baluta@oss.nxp.com>
X-Cookie: You look tired.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 15, 2021 at 05:18:00PM +0300, Daniel Baluta wrote:

> Introduce two DT properties in dsp node:
> 	* fw-filename, optional property giving the firmware filename
> 	(if this is missing fw filename is read from board description)
> 	* tplg-filename, mandatory giving the topology filename.

These sound entirely like operating system configuration which I'd
expect to be inferred from the machine identification.  What happens if
a system has multiple options for firmware files, or if the OS ships the
topology and firmware bundled up in a single image to avoid them getting
out of sync?  What's the benefit of putting them in the DT?

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDwSIkACgkQJNaLcl1U
h9DkVQgAgXVsnrjYjHZv6DFTtjzttDEGUumT8BnNgP9bXTZrpIO/TVCEoHpZM7Xo
KWysYdzD9T4ORCegCUnRzYk6oa/jo1lXstVKrbKS+MwoOMJwKCmvOjCR6HGCt3KH
De9cA5mDbj34gMitq/qf+EA0etGkqu6hM6/luOtF1r0Lp/xhSMr7xSzawHqreGzZ
xUuijk+KIJ9ft1TnPfZOx+5xxSGcuLetzkbd8k2eHNDrXJK7pXTa/szi38GbGXJv
8QNZfGSechBpl1NvhMQ+GE/jfUFHb2IfjYJRLChkMnemGNFGf+6/g7MUy1JNYANg
XEf4GhN05GgRYC4y9Dt/kz4gcqccuw==
=XWt7
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0617432802C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhCAOAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:00:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235994AbhCAOAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:00:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCF2664DBA;
        Mon,  1 Mar 2021 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614607219;
        bh=OmpZzXM86SCw6KvwZBFkal/KrHkDjOkOhMSXg23gA1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz+RIQqEcKcabTnYefP2KyzutZ9gwtDnxjOXrUUKm1dVtHesShkQb4cLE1tPISt99
         el7uumkcEbXj6D4KVRyiBAbEuBibG2CVw0id3u9GM8HN7WVK3IaZ4tS8u5Ia5k0+QT
         bLodgT48Iz8f2dWonQ2r/3mq8rCy55xJfS3BJ/fj5x98x6zzRDCLsdJL7JwXxy0bin
         WNy7eZCDjuOM+sSgLAjnaNTRYB09ri28Q5Y6ZtHzAL0ZP9lrZUxkWTCJnZrTLJ5opn
         PL2KLX5bBYDRxzNGB3EUfVSsyqb8w9omlbnniVK7rXNA7zDH5u1YPmIa7tqIjm/IBD
         n1kg852kZGhqg==
Date:   Mon, 1 Mar 2021 13:59:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz,
        tiwai@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Subject: Re: [PATCH 1/7] ASoC: convert Microchip I2SMCC binding to yaml
Message-ID: <20210301135913.GD4628@sirena.org.uk>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
 <20210223181929.444640-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <20210223181929.444640-2-codrin.ciubotariu@microchip.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 23, 2021 at 08:19:23PM +0200, Codrin Ciubotariu wrote:
> This patch converts the Microchip I2SMCC bindings to DT schema format
> using json-schema.

Please place any DT binding conversion patches at the end of patch
serieses, there is a frequent backlog in reviews of those which can
result in everything else getting held up.

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA88zAACgkQJNaLcl1U
h9B+qgf/TOlF0xRZSjua7srE7OysMc4fe8jYg7NVzdr2jr8nGIb83dJvgNXcBEO6
CQ+qYQhNsNw37nXAwN+OxgmLUudoM5MkTgKK3bs0KHHh+Pbkr6Ayznv3jOf2fKRF
gwR7oKGPR+rHVvzErYf3mMKeKtiJ9i6rmbCDk2h6UaQzRxYKpl9Fju6nXniK/IaS
fQcjxFdc7af5EteVjJETYasx0Uz2rsAqZUesXGj4QWTnawdNwNkb+IN223R3/fX5
oolLe3p2hSWMNB7kA5Wmc7/VtLW5GfvQ50KfmlYweeFB2mxn/PaZsorTEI+Atuf3
ZPI2gPeaZjGTcY02x7idYxqyfbZQrw==
=RV3G
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--

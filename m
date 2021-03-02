Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5495A32AB4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836586AbhCBUUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:20:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347035AbhCBRgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:36:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C44DA64F14;
        Tue,  2 Mar 2021 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614706323;
        bh=NlcAM5Aogt3gM4mWTWDu8X0fG511lhYUImn5GGC0ybU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Feu7pMkJs+pIBDi3Bse8WsRg7wuHnzIf99DXDMOy+aB/qN4mjcW6uJi2Ztn9RnPh2
         /6SNid8TEDYwaQ5daZNp/odMK6/IBHl5kFEHr5T/EabU2g0pj/jtkqS71nAl9/k5R8
         zkfa2fYDR+GaAnRwGs+tw9dYM2u0yy91P7BAk5C86G2VTtjbOKwmHLjX6+crQxUDnw
         r/Onp+jxRxpcvejgZjfIRsN2EbGdrhsavgpk7QTshZOssoCZc8zcDe78wPaSJ183+g
         uzZhZRKqqZImaKWR7IiwI2nDXgSrNessc7p9c0H5jWE8eK4WkmOIEgv7/NeTtshJ+D
         FE9Zfdz2c2b+Q==
Date:   Tue, 2 Mar 2021 17:30:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] ASoC: cs42l42: Fix mixer volume control
Message-ID: <20210302173055.GT4522@sirena.org.uk>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
 <20210302170454.39679-16-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9g2r9e2kvGs7M7R"
Content-Disposition: inline
In-Reply-To: <20210302170454.39679-16-tanureal@opensource.cirrus.com>
X-Cookie: Friction is a drag.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v9g2r9e2kvGs7M7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 02, 2021 at 05:04:54PM +0000, Lucas Tanure wrote:
> The minimum value is 0x3f (-63dB), which also is mute

Fixes at the start of the series please.

--v9g2r9e2kvGs7M7R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA+dk4ACgkQJNaLcl1U
h9CWSgf/b0RC5UXxZcufu3vrMuRm8vblSh339svCskkTE++2NNILSXWAu271P6gv
bRriKvyOHwXw0SshXxHW+dzA2pmwGTxtIjjrQXe3m9vfy1NPpDZg2X+gbxHriPnQ
eMjvCzKsKRxRxpp+P20XB15CmxbrwYjzmHtIRvQvHgNTtzDzB6wlsMTRciGqhNf1
4qbs7Lfmwf8xNoI0fsSCYggZBfFIcI6EJb6NfOc85ST8gomwfBwC0GhPT0Lzs9pE
JuwZVdQNkpRKe2cEHnvWtkGSPYkjBRMVePU1rL1buaTy2IxLHz0hQIcePg1sJFAc
/PBq4LsaJSYkQV0JsvxNrZKxxZlVDA==
=rdnJ
-----END PGP SIGNATURE-----

--v9g2r9e2kvGs7M7R--

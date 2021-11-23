Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A174C45A77B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbhKWQYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235718AbhKWQYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:24:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F289E60F45;
        Tue, 23 Nov 2021 16:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637684472;
        bh=bJYjfg3uF8xpjDJDnVOnd9oh4bBoBvzobz3Nkp3BsQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2ik+NS/T8/u/VUDLTMx8c3Xi2fWxkrsX4zTLF+0abK/WRFhogX2KFZ0yJ1diguJz
         Z5ZTHYsSXb3VYOdg/WROi0NNLhtyhJFcLPMXVWxbrPHn+wEIleMnzQWpIL4+oDr2T5
         wtOUM/rN/rivWBscFjOfCTqUQZLjhjCraLXp9TeTlG6VKCxtj2DZusOxIJUi+OerHe
         tjsdPhbkUrubDnvXqi348bGpH1BTjhjXSMT1ZYMk64xNaW471DkdPadvGUpsLP+lA5
         /f+KC7Z+LAkNcu9o3Kogn5CcMJ0Kwc3r+NaARwoWfB1RYwJ9vwpTWnO0ME14+Mhljb
         /L4R+UaLGRMww==
Date:   Tue, 23 Nov 2021 16:21:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V2 3/3] DA9121: add DA914x support
Message-ID: <YZ0U81fNDD8DyNTS@sirena.org.uk>
References: <cover.1637679551.git.Adam.Ward.opensource@diasemi.com>
 <c633042a3bac4e8a6e522222c4b9eeced961c184.1637679551.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dPSfVzQQljMNqUpw"
Content-Disposition: inline
In-Reply-To: <c633042a3bac4e8a6e522222c4b9eeced961c184.1637679551.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: A closed mouth gathers no foot.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dPSfVzQQljMNqUpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 03:09:26PM +0000, Adam Ward wrote:
> Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--dPSfVzQQljMNqUpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGdFPMACgkQJNaLcl1U
h9BGDgf+KyKasZpbEU1/GRgqZfPoF9TBE/1Io24xqXt4d2+S/PU6qpSdn1/9cGqK
NXMUMuxNMXrxHie/Lc8Zl5ionB8OOpSkDEBhyDgaXrfn+dXTSJjcH45dHbmSoEl7
L51znnhZq5Eda3rJcw3lzU/Hd8svCYxKuH4TQzEvF1waaSUjFGRLN3Dh9Z8MFMOp
b+YWtVWSEMCBNmg+sLVSpCoF8CQ7sThLRQeTUrUFY0cOkmRYuDspGDSD+Oqfbvcs
HGeUvjKLy6+c5o1bhBS4rQqWoYDnr2sK7kUEmNfMpjL9nkjjGlqjx3VZeXyzGc7O
zTq2OkZue5G9DFNT/29fLJldGYwEZg==
=YUaT
-----END PGP SIGNATURE-----

--dPSfVzQQljMNqUpw--

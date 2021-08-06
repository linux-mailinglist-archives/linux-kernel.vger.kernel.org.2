Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA103E2026
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhHFAqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhHFAqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:46:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 068F160725;
        Fri,  6 Aug 2021 00:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628210775;
        bh=TeFmqVyGxWQDZ/rgW2rRFKouG7Wsb42tgFD6/C9/vmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DklIGuS4Il4+uh6iQTqCRxNxSixSuTjIfWH0IqYatKkzbYvxwtYlwocJB5+Opegjx
         PB70yEBYyy8T2FdiOhCQ9HKSsbZloqheprxDWwr2oKKFZ0VVkgA/ReIm3pGdDygrIz
         /hGwk7dqiJMZayWwolfFPzkoUXQAbv8opd2VvN1Opf/vtZhgs4XgnIM7cS7dcnXvha
         PbWFHUP6NJKA6bFBInBf7ylmFalolscI6j48x2q+1LaR3e3hm74p1G7gU44E+NNmh8
         0ikkMoDeLyjmV1XCbR2CMFhNhhrikTlonZBtAzgR/CgOwFxzvbXqlzjyCYgBFySTQB
         zAlpyUzIzEM2w==
Date:   Fri, 6 Aug 2021 01:45:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] ASoC: cs42l42: PLL must be running when changing
 MCLK_SRC_SEL
Message-ID: <20210806004558.GT26252@sirena.org.uk>
References: <20210805161111.10410-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X9hp/qFlD/MyfJCu"
Content-Disposition: inline
In-Reply-To: <20210805161111.10410-1-rf@opensource.cirrus.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X9hp/qFlD/MyfJCu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 05, 2021 at 05:11:04PM +0100, Richard Fitzgerald wrote:
> Both SCLK and PLL clocks must be running to drive the glitch-free mux
> behind MCLK_SRC_SEL and complete the switchover.

Please provide a cover letter for serieses, it helps give an overview of
what's going on and is useful for tooling.

--X9hp/qFlD/MyfJCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEMhkYACgkQJNaLcl1U
h9AIpAf+Jth8Ifl65n0DvVX24GXQht7YbCgxmupcceczqyDoODTp2w3y6sEREHP2
g1bFpkb10yaqxBupQtWVw9Gzv7QGsciHzJZuGmhnXJUQNs5l5laDsxZg5R62OLTU
B1A9CsgwRROsDHkZwxFK8CWBTmsLFlrnNonuMHcEDRmQzbtzBolgQ9wNiMoeRlc8
GCUPpxXOdGCprUvH24StHM6+ERFL7UrfAX6inxG29aoa5fa4dwV7cosTXLNxoYD+
dIRZ6GMa4dezT6nUFeK1ehUpLOPGheuf1SdA6mxLiIqWHu+8nfcMgBEENOXoGWIs
t1pQjT8w8mpARqdWF0eOxNd7KS8d3w==
=kbc2
-----END PGP SIGNATURE-----

--X9hp/qFlD/MyfJCu--

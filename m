Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86382320E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 00:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBUXvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 18:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhBUXur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 18:50:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D051364E08;
        Sun, 21 Feb 2021 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613951407;
        bh=wXko/iNr1ukArvR4Rnyr4nOhQqcduBCN36YlmjFpMwE=;
        h=Date:From:To:Cc:Subject:From;
        b=jScCAt/CadCfsjNPAadO68NazZY09us2F8gUWPRfsO0WJ3ayElnB7y5QBYM/qdCtS
         1fclEGvAFweAFLxnv3+Kek+0WwTBVWlNA5RJF4R4/WNWAGBMYHBNlLmJONAMTjr1jR
         MK0sT4Kg+gCxai8eZKN5P3Xvtf3q6K13++uTB+PZ5jPl2gmbic09NHX4Xj2vKR/tIQ
         GIu5G+2OLTezWLC4U/S66pky/bNh0u6FXexdjgllVrxHn+G7BbhBxeB2Q18anVbPvr
         yAN43FcrwfmAy+oq+7Oj48UWDmYj4jdZIkOuGhEb0bFG/dznG4CsPJR3WSw3xp+LjV
         3bU6GaVcx9eIQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 340903C0C96; Mon, 22 Feb 2021 00:50:05 +0100 (CET)
Date:   Mon, 22 Feb 2021 00:50:05 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for 5.12
Message-ID: <20210221235005.5cy7swj6g4kfpwgt@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t5uaf76gvassv3u2"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t5uaf76gvassv3u2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.12

for you to fetch changes up to aa57e77b3d28f0df07149d88c47bc0f3aa77330b:

  HSI: Fix PM usage counter unbalance in ssi_hw_init (2020-12-29 23:57:06 +0100)

----------------------------------------------------------------
HSI changes for the 5.12 series

* runtime PM usage counter fix

----------------------------------------------------------------
Zhang Qilong (1):
      HSI: Fix PM usage counter unbalance in ssi_hw_init

 drivers/hsi/controllers/omap_ssi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--t5uaf76gvassv3u2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAy8awACgkQ2O7X88g7
+pqTug/+OgdsSXfsvSYVWBcvtZBREgbzQcZIoNnGmb6fo9FwmMJsOTqGCDLPnMm1
XRnK2Hc7IZz5PYc7iAQYPg3OcR/Q9K0jghaRP9JQwP75HCu5DI8GZaaqEoFX+qu8
Zpcq5DbadcpeUFN8mdCKRreL6mTpob5pHOJBg9Fln9sM8k5HKu4o6DmVeiEgh1L1
SXErWSNNBl1UBZXUvSlvL4khpkgt929Ddd76t2u111HAS46qHsTAYwPXjLsBXE2f
BlrbEdE4Nx9P2nF/VQw7N6TV8zP6RywvTvgs5bkojyQQXFcLre3DxJrfKveIjqgC
jhF1DzwZJ1rEw/qiOG8Fu63nwf4MsCIDSpYmzR9cX6ThojqZ6Q3Ie3uUMB1uZCfg
jfsSt7pdfdQioNh9fDHyro7Gz3zz9vZq4sqgtZNzInvS2g2riZ+fDqfj6Alqwync
CVyQk2ZgRsJ8W+d+f6X+0nnLID3fzV0O1xon3sFa+BHoyuxL4M+3gGTUm8KXoGjp
SqXT+r5auAktybJ4KimLSHqzwB+UDMIPirMyRUaUrmZ/jCU4Zfq7JjfQ5XKgHPUV
LozVbjVH5/uwsarpelfeo5DXFMNCMcEVfaOa3hDbFZHKzAmtmDWZFZQEnLJAiXbm
SeXUMvzXGPevzTG3UbFJlu9VhAXqxaSrbSGiW8XmwK7dMjAsMjY=
=cpcx
-----END PGP SIGNATURE-----

--t5uaf76gvassv3u2--

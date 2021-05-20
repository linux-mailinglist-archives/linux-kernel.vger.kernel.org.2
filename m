Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0172389F12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhETHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230339AbhETHpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:45:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5A5160FE6;
        Thu, 20 May 2021 07:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621496650;
        bh=lqLzPDKL4ipblaaoCPqkYvpTc23hgtIbN1FbtWWpSr0=;
        h=Date:From:To:Cc:Subject:From;
        b=L6sDvDAAwbA+tDbYs5qfBbT8MgDiW8jvk5zj75VYMoZZ3be99F+ww048wc2ZVR08L
         tmxGDps34RDsKVer3iThcwkOCTZ5Il9bnAnROLYOhHGPvPiias5Z75zWZUTXIU4BnV
         qIaRhvVVwfOsX4kOoYcrQocjzGyCwbD0itfLu1UEj3lPVBEGQrt9+Virnv0nFYds31
         9pLJmJtLG4bNSuA6Y7CAJ+euqEkhQwfvc+nDLWugng233u9+m7wM/lXGYnhwUbCQ8e
         T9v0vtEvMDXlOq/hx6VlrDlv580vxjaVGMGwfoec3sVaijt/23F6c3xpayskMjxoPW
         j3sb4n20SD2iA==
Date:   Thu, 20 May 2021 13:14:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire fixes for v5.13
Message-ID: <YKYTR+oPW1XEBIi7@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D/m+Mx5ygU/zaSUH"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D/m+Mx5ygU/zaSUH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to recieve the fix for v5.13. This is one patch fix for
regression in qcom boards.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.13-fixes

for you to fetch changes up to da096fbccd52803db3edd9dd0c5ae4079d31c456:

  soundwire: qcom: fix handling of qcom,ports-block-pack-mode (2021-05-13 1=
1:14:13 +0530)

----------------------------------------------------------------
soundwire fixes for v5.13

Fix in qcom driver for handling of qcom,ports-block-pack-mode property.
This fixes regression reported in DragonBoard DB845c and Lenovo Yoga
C630.

----------------------------------------------------------------
Srinivas Kandagatla (1):
      soundwire: qcom: fix handling of qcom,ports-block-pack-mode

 drivers/soundwire/qcom.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Thanks
--=20
~Vinod

--D/m+Mx5ygU/zaSUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmCmE0YACgkQfBQHDyUj
g0cM0RAAqgd6E9hnO3LcDPo3zh2/rzIeQzSHmwKq/ZawON37Ugpg5hXVDHBoGA1U
guldveQOKDsPIUXxcJYCfQjgbzgBoO0ZmRq28t7A1G6zJZTfNrRH47Hyn+rqydmJ
J1MD3UWJOjF9gEookjUt8ACM0haARi4TZgxf+X3MjagWj17+KlFLo7GUekV8gkoj
0MU1fxWp3jpQ6DsjjSuJZK1jt3PfotBJuJc4TMaQTcWOm5FvGYT7E4HtO/z8LI1N
4tsYIvR8fVnGPM7FdKSKwYanYkZOchh2W2aFy0QgOVkST1GOhf5lk2vPWzamn2WK
mZcAIeEvnH1VLppDhSE+RXC2wNBJ+/ZRTkdXQzy4YEP+CZKFPyzU3xie46aWu8Xr
EV/FEa2uL4z9ynHGe30yGUG6Ou/jl9GgNtI0zUqEEe3Tc9VlJ2PhKxMWetUlzNzE
7LRb2jjn1RZy1Vel9hNX0nEuWZek/PMpplaEctJ4atxHP3+gVg2ITChGb/g4Qk+h
yYo7xWPzXZz+X70P2xDBUEsFQ3cFghvKbh5Taol0fuYc2uw6ClyvvsU0AkAXPkuO
b2VsoDppgteiZCZU2QtsjV1mbGzNgJ+86QRE3h1Y8njZBCXY7l5kjJjehVXKLYV5
W7KGlFcps3OCg3jpAEDIkUJlS2TLoGEmXO8j/SDLFTJvGHde9FM=
=4r6M
-----END PGP SIGNATURE-----

--D/m+Mx5ygU/zaSUH--

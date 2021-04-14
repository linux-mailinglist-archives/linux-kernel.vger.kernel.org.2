Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445EF35F77B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350443AbhDNPSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350372AbhDNPR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:17:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8758761090;
        Wed, 14 Apr 2021 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618413457;
        bh=v8Xbl+/XiWU8+Qjdj9ZlACtpEdUTj7rXvqg1K4XJsMg=;
        h=Date:From:To:Cc:Subject:From;
        b=PSL6YZi/FSK7VEzsN5ckfAEd1p8ExkQl71+MCcO9yAqcbCvSmI9Nuj1FosNXx0b8u
         k9HrXNlVKkMqCdxsGLexut/J/+cWyivvjVKTrTZa0dV8kAnyKTrdXhpAl6aR5hi/Ed
         sGM6IiaWFuwH5vPVZFwxTRKJSjd3YJrn3Hnq4c/+M9+VZy9Qw0IiaaVeird3WlYMHb
         +wgIoxiKYAbeUhx6PQRcQLYN4UcRa0Y4LEYqIqTLL8rmlP6PxizSJWGokc3qJsRKWu
         Efj091ZGewkSMDKhsy5JNlURafPv4McZLY1Ubi892W7Cb2Xlip0ctqUiiLeRpCqaAO
         tLaLueM0Cxi3g==
Date:   Wed, 14 Apr 2021 20:47:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL]: Generic phy updates for v5.13 -second round
Message-ID: <YHcHjYv8HIaODa5t@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iOBHsqrKwZ88MQYQ"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iOBHsqrKwZ88MQYQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

As promised, here are some minor fixes for earlier pull request. This
includes fixes which came in after the request was sent

The following changes since commit cbc336c09b6d6dfb24d20c955599123308fa2fe2:

  phy: fix resource_size.cocci warnings (2021-04-06 10:39:20 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-5.13-second

for you to fetch changes up to 8a6b85b14f082d266b0312562f7372e1a8f5dfb3:

  phy: Revert "phy: ti: j721e-wiz: add missing of_node_put" (2021-04-12 10:=
35:05 +0530)

----------------------------------------------------------------
phy-for-5.13 second pull

Driver fixes for:
  - Revert wrong of_node_put patch and add missing header for ti j721e driv=
er
  - use-after-free fix for twl4030

----------------------------------------------------------------
Shixin Liu (1):
      phy: ti: j721e-wiz: Add missing include linux/slab.h

Vinod Koul (1):
      phy: Revert "phy: ti: j721e-wiz: add missing of_node_put"

Yang Yingliang (1):
      phy: phy-twl4030-usb: Fix possible use-after-free in twl4030_usb_remo=
ve()

 drivers/phy/ti/phy-j721e-wiz.c   | 2 +-
 drivers/phy/ti/phy-twl4030-usb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Thanks
--=20
~Vinod

--iOBHsqrKwZ88MQYQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmB3B4wACgkQfBQHDyUj
g0fHdg/+KifY6R3l4DswCvw9fV/fv564wV8NQUit90aAxXI5Jj6eV9v64DpmR69C
hWRByQnbcfUzBo2BRgyz3G7RdL9HA9z2NU+jl4qg5hsEengktZZxDnJ0NxlqYMEe
ZSgRiDpb2HAjmNvFwshG8x5bdlS9Tn+qLm9yNBsrqcf1Y5Bpmkg9+TvVGzep2Wx2
LNgz2Jny14Ne+BvPvLeiO7/Kt5yFydyRoUXwUhpy65pZeOhD+PPk9M91YjwUmjD8
bgIKcjhk9DI9N9X89dnLcC/3Ne9Dbf21gGHiNMzSHjTxN91oN/QPp+8YlbeZxWFe
UWMKIQb8BX0knwLVEpAXuUP5vNkHRqSyskUMcxyDGrKhU29felMQaZy6h44b74kx
Eqypz887nDUDNpL+mtIGUYHbzo2ki1vZeAy5lOJLX0xMAGcJZoeCDHxZZGBhmRCz
ctmD8CuAa38wTNA+/+MMI9WUVRQyXgY1xkEj7RsBqFndU0niHg5dPtMotm4KsonS
qSe/4j3g02kW78yETIhzeTswjJE4OunpeSISeN0SR8BfeOuuK+rczonHPMuyLY2M
NVba+mfUXhpl4vRfX5rCgexcXv4+KKTYfHBUPrUW5pOuskqpgjPYwgjbRqiBBcHE
EtLatigD2SdBE2k3y4MVRO8b5qlhD2DO6b4/v8T7JoqUoqgxpSQ=
=+bj7
-----END PGP SIGNATURE-----

--iOBHsqrKwZ88MQYQ--

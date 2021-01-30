Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D91309542
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 14:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhA3NQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 08:16:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50522 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhA3NQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 08:16:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10UDECvx011905;
        Sat, 30 Jan 2021 07:14:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612012452;
        bh=XFymvdCm4O53NxcLqDM99zA8H+6HJ83huZq37r3iRCk=;
        h=Date:From:To:CC:Subject;
        b=u/WjIbL9/5cK3i+lfz3CS2fB0bmK1+VQ7tj23FMJu22LWTE4e1rlHKHE8tAZ6DGvP
         oGPdQfv7lJgENzW4oL15yhpI86pmzPenBg8MTh/LvhOMK8Ov3vGv0IHTtGwsu+CmFh
         VUK+CehysLzKu9OVf+RxLZKkqSwXl5Y7XgfRNGfU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10UDEC1k105703
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jan 2021 07:14:12 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 30
 Jan 2021 07:14:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 30 Jan 2021 07:14:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10UDEB3Q020590;
        Sat, 30 Jan 2021 07:14:11 -0600
Date:   Sat, 30 Jan 2021 07:14:11 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL 1/2] MAINTAINERS: Update to TI maintainer for v5.12
Message-ID: <20210130131411.afna4wj72r7xscqn@skinny>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gicpp6a64sa3muot"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--gicpp6a64sa3muot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull the following MAINTAINERS file update for v5.12 cycle. Made
sense to send via ARM path since the main PR path was for TI platforms.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git tags/ti-k3=
-maintainer-for-v5.12

for you to fetch changes up to 2672b94d730c4b69a17ce297dc3fa60b980e72dc:

  MAINTAINERS: Update my email address and maintainer level status (2021-01=
-12 07:47:13 -0600)

----------------------------------------------------------------
Maintainer changes for TI for v5.12 merge window:

- Tero switches to kernel.org address

----------------------------------------------------------------
Tero Kristo (1):
      MAINTAINERS: Update my email address and maintainer level status

 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--gicpp6a64sa3muot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmAVW5wACgkQ3bWEnRc2
JJ3W5Q/+LP/xOm51phhdMlrCBpXa4epd3z2NZRUt//bp/ObWcF6VtSliPxLOHfUI
7ro89eDzNj0ZtBIXEbipnOjlCvBSMsABs/d6jb3IxjiSdxrllj+IOfM+s4m7+50Y
7qgYBNIRLCOctY42QWaffkCuYAS/IFaFKgZv4HmZSoACdwoRVPSPkeDu9+vPAMtb
RRzvcQo19WwtkYEgvHUMSg4WU8YLd4XQES9tXxHuc9CG5P+THkXk/JDkpMIC9Ky8
sSo0k54JFgcJ+T9Cg1/bePMLP5cs9E/vkdf3bcsYAufjjTQh/MThQk6pBeH5h/ic
xrvlrRPteUjSyuzzhUIfUflnungio5+Q4oWIbUrxOpCaKt/6aaBOEmbvG3x3lzd5
rZUWP2LIkOjO4NYdMWGsLkIo0x9OmaiJRIDws8NqXN+XXLZQrw4eUQa9XBA8Mx1f
S7w6FXoGurGFRibMmMJ0N6HqmFyWoEus8YytSfx+1LGDZ4/CricNvXmzpVAGtZ7S
SHAWzK82SyFB00Fv6G87bBqFhSwaJHN5CnlzPLic13lrp2EWcCfgLuUvpQJv92Xk
+rgF6itAHf7uKUFmJ8JRG/uXpN7yTA0NIIkvwx7yagBBh6ITdlYjA0LtKtL3Qzyr
TZGoCaIdEe8Qg9fjgxfdnJ40tlLXTSYTOwMAwzmTsizg0j2Q/hk=
=bgUI
-----END PGP SIGNATURE-----

--gicpp6a64sa3muot--

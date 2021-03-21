Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E15343370
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 17:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCUQ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 12:27:53 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33592 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhCUQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 12:27:26 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 237001C0B82; Sun, 21 Mar 2021 17:27:24 +0100 (CET)
Date:   Sun, 21 Mar 2021 17:27:23 +0100
From:   Pavel Machek <pavel@denx.de>
To:     kernel list <linux-kernel@vger.kernel.org>
Subject: vDPA: explain in Kconfig what vDPA is, capitalise it consistenly
Message-ID: <20210321162723.GB26497@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Not everyone knows what vDPA stands for, explain it in Kconfig.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index ffd1e098bfd2..8cb37b3dd279 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -3,9 +3,9 @@ menuconfig VDPA
 	tristate "vDPA drivers"
 	depends on NET
 	help
-	  Enable this module to support vDPA device that uses a
-	  datapath which complies with virtio specifications with
-	  vendor specific control path.
+	  Enable this module to support Virtual Data Path Acceleration
+	  (vDPA) device that uses a datapath which complies with
+	  virtio specifications with vendor specific control path.
=20
 if VDPA
=20
@@ -38,8 +38,8 @@ config MLX5_VDPA
 	bool
 	select VHOST_IOTLB
 	help
-	  Support library for Mellanox VDPA drivers. Provides code that is
-	  common for all types of VDPA drivers. The following drivers are planned:
+	  Support library for Mellanox vDPA drivers. Provides code that is
+	  common for all types of vDPA drivers. The following drivers are planned:
 	  net, block.
=20
 config MLX5_VDPA_NET
@@ -47,7 +47,7 @@ config MLX5_VDPA_NET
 	select MLX5_VDPA
 	depends on MLX5_CORE
 	help
-	  VDPA network driver for ConnectX6 and newer. Provides offloading
+	  vDPA network driver for ConnectX6 and newer. Provides offloading
 	  of virtio net datapath such that descriptors put on the ring will
 	  be executed by the hardware. It also supports a variety of stateless
 	  offloads depending on the actual device used and firmware version.

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBXc+sACgkQMOfwapXb+vI/MACgoWX0vXXuBFUuMzULOY3c68Sd
Y1gAni8t2XiMB4sCQO+neA9JMWOsIGKV
=FXby
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA2334A399
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhCZJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:02:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52898 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhCZJBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:01:55 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 14D201C0BB9; Fri, 26 Mar 2021 10:01:53 +0100 (CET)
Date:   Fri, 26 Mar 2021 10:01:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@osdl.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH] remove Dan Murphy from TI from MAINTAINERS
Message-ID: <20210326090152.GA21828@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Dan's address bounces, and has been bouncing for some time as he moved
to other projects.

I believe TI should be more careful with this, and should assign
alternate contacts for their drivers.

Anyway what we can do now is to remove the obsolete address.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

---

(I'm sending this directly; you can also have it as a pull request for
late -rc or with the LEDs in next -rc1... but I believe applying it
directly is easiest).

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..11d83c30b737 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10030,7 +10030,6 @@ F:	scripts/leaking_addresses.pl
=20
 LED SUBSYSTEM
 M:	Pavel Machek <pavel@ucw.cz>
-R:	Dan Murphy <dmurphy@ti.com>
 L:	linux-leds@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git
@@ -10905,7 +10904,6 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/radio/radio-maxiradio*
=20
 MCAN MMIO DEVICE DRIVER
-M:	Dan Murphy <dmurphy@ti.com>
 M:	Pankaj Sharma <pankj.sharma@samsung.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
@@ -17846,7 +17844,6 @@ S:	Maintained
 F:	drivers/thermal/ti-soc-thermal/
=20
 TI BQ27XXX POWER SUPPLY DRIVER
-R:	Dan Murphy <dmurphy@ti.com>
 F:	drivers/power/supply/bq27xxx_battery.c
 F:	drivers/power/supply/bq27xxx_battery_i2c.c
 F:	include/linux/power/bq27xxx_battery.h
@@ -17981,7 +17978,6 @@ S:	Odd Fixes
 F:	sound/soc/codecs/tas571x*
=20
 TI TCAN4X5X DEVICE DRIVER
-M:	Dan Murphy <dmurphy@ti.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/tcan4x5x.txt

--=20
http://www.livejournal.com/~pavelmachek

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBdowAACgkQMOfwapXb+vLV9ACfQprMciq0UhJYUBVhJHrSC3sQ
1u4An2M8c5y9raqhIyxA7vfMnG5SslG4
=Uwfh
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

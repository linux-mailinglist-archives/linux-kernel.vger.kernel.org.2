Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE4937984C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhEJU2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhEJU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:28:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:26:57 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lgCUR-0007Cw-L1; Mon, 10 May 2021 22:26:55 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:5dca:2b47:47f4:4cec])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C9002621B02;
        Mon, 10 May 2021 20:26:54 +0000 (UTC)
Date:   Mon, 10 May 2021 22:26:53 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Subject: global-out-of-bounds in move_module
Message-ID: <20210510202653.gjvqsxacw3hcxfvr@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z3ddcakcx2sjlesu"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z3ddcakcx2sjlesu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I just noticed on current net-next/master b741596468b0 ("Merge tag
'riscv-for-linus-5.13-mw1' of
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux") on 32 bit
arm, that modprobe of a module triggers the following KASAN bug:

| [  110.241783] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| [  110.249600] BUG: KASAN: global-out-of-bounds in move_module+0x58/0x208
| [  110.256253] Write of size 69632 at addr bf030000 by task modprobe/290
| [  110.262789]=20
| [  110.264361] CPU: 0 PID: 290 Comm: modprobe Tainted: G        W        =
 5.12.0-perf+ #7
| [  110.272373] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
| [  110.278977] Backtrace:=20
| [  110.281537] [<c150df20>] (dump_backtrace) from [<c150e430>] (show_stac=
k+0x20/0x24)
| [  110.289245]  r7:00000080 r6:80010093 r5:00000000 r4:c24c20a0
| [  110.294981] [<c150e410>] (show_stack) from [<c151e794>] (dump_stack+0x=
f0/0x118)
| [  110.302407] [<c151e6a4>] (dump_stack) from [<c1515770>] (print_address=
_description.constprop.0+0x58/0x210)
| [  110.312205]  r9:b6e0720e r8:b6e08200 r7:c0273980 r6:00000001 r5:000000=
00 r4:bf030000
| [  110.320023] [<c1515718>] (print_address_description.constprop.0) from =
[<c03da2b4>] (kasan_report+0x11c/0x140)
| [  110.330088]  r7:c0273980 r6:00000001 r5:00011000 r4:bf030000
| [  110.335820] [<c03da198>] (kasan_report) from [<c03dae54>] (kasan_check=
_range+0xcc/0x1a4)
| [  110.344039]  r7:000001ff r6:b6e081ff r5:bf040fff r4:b6e07210
| [  110.349772] [<c03dad88>] (kasan_check_range) from [<c03db6e0>] (memset=
+0x28/0x44)
| [  110.357386]  r10:cc6a3ef4 r9:f0f1ef18 r8:f0de8740 r7:cc6a3ee0 r6:00000=
000 r5:bf030000
| [  110.365296]  r4:00011000 r3:c0273980
| [  110.368943] [<c03db6b8>] (memset) from [<c0273980>] (move_module+0x58/=
0x208)
| [  110.376116]  r7:cc6a3ee0 r6:f0de8880 r5:f0de8884 r4:bf030000
| [  110.381850] [<c0273928>] (move_module) from [<c0274314>] (layout_and_a=
llocate+0x1bc/0x290)
| [  110.390233]  r10:cc6a3ef4 r9:f0f1ef18 r8:cc6a3ef0 r7:00000039 r6:cc6a3=
ee4 r5:cc6a3ee0
| [  110.398138]  r4:00000000
| [  110.400743] [<c0274158>] (layout_and_allocate) from [<c0274734>] (load=
_module+0x34c/0xbe4)
| [  110.409125]  r10:cc6a0000 r9:b88d47b8 r8:c165cb00 r7:f3f3f3f3 r6:cc6a3=
e40 r5:cc6a3ee0
| [  110.417031]  r4:cc6a0000
| [  110.419634] [<c02743e8>] (load_module) from [<c0275248>] (sys_finit_mo=
dule+0x110/0x178)
| [  110.427760]  r10:0000017b r9:00000003 r8:cc6a3ee0 r7:004762d0 r6:00000=
000 r5:cc6a3f80
| [  110.435666]  r4:b88d47d4
| [  110.438273] [<c0275138>] (sys_finit_module) from [<c0100080>] (ret_fas=
t_syscall+0x0/0x2c)
| [  110.446565] Exception stack(0xcc6a3fa8 to 0xcc6a3ff0)
| [  110.451708] 3fa0:                   004780c0 00000000 00000003 004762d=
0 00000000 00477cd0
| [  110.459983] 3fc0: 004780c0 00000000 98560c00 0000017b 0210a3f8 0048a09=
0 0047544c 0210a360
| [  110.468246] 3fe0: b6c91978 b6c91968 0046eb0d aea934f2
| [  110.473388]  r9:cc6a0000 r8:c0100268 r7:0000017b r6:98560c00 r5:000000=
00 r4:004780c0
| [  110.481206]=20
| [  110.482769]=20
| [  110.484329] Memory state around the buggy address:
| [  110.489199]  bf038f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| [  110.495812]  bf038f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
| [  110.502419] >bf039000: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 f9 f9
| [  110.509021]                                                   ^
| [  110.515018]  bf039080: f9 f9 f9 f9 00 02 f9 f9 f9 f9 f9 f9 00 02 f9 f9
| [  110.521626]  bf039100: f9 f9 f9 f9 00 02 f9 f9 f9 f9 f9 f9 00 00 00 00
| [  110.528231] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--z3ddcakcx2sjlesu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCZlwsACgkQqclaivrt
76mqpQf+PWB4ncXjQJ4uSTx7xjhEAArm1mp+JUvMgMDlCLvdEwf9uXchlmkjtt4m
9YGfpYZ6Y/jID0MxNxqPgu+7IaG9X8bat6bavFmuLwhNZ/ZogUUs72glWpvtHimw
SHCCYwYMmF1Pg/UVZ1TFmK69w17wDiM8NDYt8qHyzRqvvkjWDmatrG7623YwGIhw
8bPhPZaVAX9PNfE1iU6Q0/A3b+ry0mN/AoobtQQHkB0uy618umBa6hBrHAiOiJmB
5fktekj6V1s8O1WuiVvEesy+OomUMxlowUvRQl0ugcTgM3I8djRydPvAs0LFlcEi
Wir1ytYaoo+am4TGj9Etf+TKkFGgrw==
=E4v7
-----END PGP SIGNATURE-----

--z3ddcakcx2sjlesu--

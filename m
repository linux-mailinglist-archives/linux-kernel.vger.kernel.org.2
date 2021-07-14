Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3043C91CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbhGNUHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbhGNUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:04:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA20C0A8883
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:53:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m3kwn-0008Nu-P4; Wed, 14 Jul 2021 21:53:33 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1d5a:f852:d9c2:1ad3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E3E8B64F5AE;
        Wed, 14 Jul 2021 19:53:31 +0000 (UTC)
Date:   Wed, 14 Jul 2021 21:53:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2267:16: warning:
 taking address of packed member 'hw_tx_obj' of class or structure
 'mcp251xfd_tx_obj_load_buf::(anonymous)' may result in an unaligned pointer
 value
Message-ID: <20210714195331.gr4lmltpcdtjm3iv@pengutronix.de>
References: <202107011516.MsGsARqy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dd6rdoeq7clnjxwp"
Content-Disposition: inline
In-Reply-To: <202107011516.MsGsARqy-lkp@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dd6rdoeq7clnjxwp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2021 15:25:24, kernel test robot wrote:
> FYI, the error/warning still remains.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   dbe69e43372212527abf48609aba7fc39a6daa27
> commit: eb79a267c9b3e608e7762a1b221428f37ace3aa3 can: mcp251xfd: rename a=
ll remaining occurrence to mcp251xfd
> date:   9 months ago
> config: mips-buildonly-randconfig-r005-20210630 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8d21=
d5472501460933e78aead04cf59579025ba4)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Deb79a267c9b3e608e7762a1b221428f37ace3aa3
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout eb79a267c9b3e608e7762a1b221428f37ace3aa3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross AR=
CH=3Dmips=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>    In file included from drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:1=
9:
>    In file included from include/linux/netdevice.h:37:
>    In file included from include/linux/ethtool.h:18:
>    In file included from include/uapi/linux/ethtool.h:19:
>    In file included from include/linux/if_ether.h:19:
>    In file included from include/linux/skbuff.h:28:
>    In file included from include/net/checksum.h:22:
>    arch/mips/include/asm/checksum.h:195:9: error: unsupported inline asm:=
 input with type 'unsigned long' matching output with type '__wsum' (aka 'u=
nsigned int')
>            : "0" ((__force unsigned long)daddr),
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is unrelated to this driver.

>    In file included from drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2=
6:
>    In file included from drivers/net/can/spi/mcp251xfd/mcp251xfd.h:14:
>    In file included from include/linux/can/dev.h:21:
>    In file included from include/linux/can/skb.h:17:
>    In file included from include/net/sock.h:61:
>    include/linux/poll.h:142:27: warning: division by zero is undefined [-=
Wdivision-by-zero]
>                    M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
>                                            ^~~~~~~~~
>    include/linux/poll.h:140:32: note: expanded from macro 'M'
>    #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOL=
L##X)
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
>    include/linux/poll.h:126:51: note: expanded from macro '__MAP'
>            (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
>                                                             ^ ~~~~~~~~~
>    include/linux/poll.h:142:39: warning: division by zero is undefined [-=
Wdivision-by-zero]
>                    M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
>                                                        ^~~~~~~~~
>    include/linux/poll.h:140:32: note: expanded from macro 'M'
>    #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOL=
L##X)
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
>    include/linux/poll.h:126:51: note: expanded from macro '__MAP'
>            (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
>                                                             ^ ~~~~~~~~~
> >> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2267:16: warning: takin=
g address of packed member 'hw_tx_obj' of class or structure 'mcp251xfd_tx_=
obj_load_buf::(anonymous)' may result in an unaligned pointer value [-Waddr=
ess-of-packed-member]
>                    hw_tx_obj =3D &load_buf->crc.hw_tx_obj;
>                                 ^~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2269:16: warning: takin=
g address of packed member 'hw_tx_obj' of class or structure 'mcp251xfd_tx_=
obj_load_buf::(anonymous)' may result in an unaligned pointer value [-Waddr=
ess-of-packed-member]
>                    hw_tx_obj =3D &load_buf->nocrc.hw_tx_obj;
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
>    4 warnings and 1 error generated.

These warnings are technically correct, but the driver never
accesses this pointer directly, see below:

[...]

> eb79a267c9b3e6 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c Marc Kleine=
-Budde 2020-09-30  2266  	if (priv->devtype_data.quirks & MCP251XFD_QUIRK_C=
RC_TX)
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18 @2267  		hw_tx_obj =3D &load_buf->crc.hw_tx_obj;
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2268  	else
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2269  		hw_tx_obj =3D &load_buf->nocrc.hw_tx_obj;
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2270 =20
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2271  	put_unaligned_le32(id, &hw_tx_obj->id);
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2272  	put_unaligned_le32(flags, &hw_tx_obj->flags);

use put_unaligned_le32 instead of direct assignment

> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2273 =20
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2274  	/* Clear data at end of CAN frame */
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2275  	offset =3D round_down(cfd->len, sizeof(u32));
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2276  	len =3D round_up(can_dlc2len(dlc), sizeof(u32)) -=
 offset;
> eb79a267c9b3e6 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c Marc Kleine=
-Budde 2020-09-30  2277  	if (MCP251XFD_SANITIZE_CAN && len)
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2278  		memset(hw_tx_obj->data + offset, 0x0, len);
> 55e5b97f003e85 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c Marc Kleine=
-Budde 2020-09-18  2279  	memcpy(hw_tx_obj->data, cfd->data, cfd->len);

memset() and memcpy() should be fine, too

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dd6rdoeq7clnjxwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDvQLgACgkQqclaivrt
76mGtAf9F6YJKTBhnqgu/SWO69/xUwxK3NTIVzOR2Q/j1btfJJ2j/UowSn5mVbyj
YBaZ0nkkv7EzpmQIabhzztsYAa488TquSLPebpZu/vVnU04Gd2CSjaTBuyHe8qC9
dYvIgqdmnunVJK0ZO+1dPtYkzFKusZAYZ7we68TyR4u6/QheJ+06v2ZPwHCTxRQt
Hyod76ruWgaY2Q8c/675e4VI5lFqg5I9h4rdBolXiZaiuKCJQAlO+2+Sh2RKfX1/
yFhbeYk/L9fhlkjQTuMgPiGtn+k5caauXwLcWUxgYSZkoEEkBQ1qij/mngLkjSiS
5l2O5BHwjTt7/YvXOvu52EYb+DXTAg==
=kOn3
-----END PGP SIGNATURE-----

--dd6rdoeq7clnjxwp--

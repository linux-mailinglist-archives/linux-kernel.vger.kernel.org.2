Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C5133A3F6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 10:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhCNJpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 05:45:10 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41242 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhCNJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 05:44:48 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7B9C91C0B76; Sun, 14 Mar 2021 10:44:47 +0100 (CET)
Date:   Sun, 14 Mar 2021 10:44:47 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     min.li.xe@renesas.com
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mfd: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <20210314094447.GA32368@duo.ucw.cz>
References: <1615653747-9372-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <1615653747-9372-1-git-send-email-min.li.xe@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
On Sat 2021-03-13 11:42:27, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
>=20
> Add support for ClockMatrix(TM) and 82P33xxx families of timing
> and synchronization devices. The access interface can be either
> SPI or I2C. Currently, it will create 2 types of MFD devices,
> which are to be used by the corresponding rsmu character device
> driver and the PTP hardware clock driver, respectively.


> @@ -2131,7 +2158,7 @@ config RAVE_SP_CORE
>  	  device found on several devices in RAVE line of hardware.
> =20
>  config SGI_MFD_IOC3
> -	bool "SGI IOC3 core driver"
> +	tristate "SGI IOC3 core driver"
>  	depends on PCI && MIPS && 64BIT
>  	select MFD_CORE
>  	help

This probably should not be here.

BR,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYE3bDwAKCRAw5/Bqldv6
8t15AJ41wGk/Ub4HG7LkeDjq/v99mVRLkgCcDbhxiwnqLsG5iPuTk2VXHVFn+z4=
=JUd3
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

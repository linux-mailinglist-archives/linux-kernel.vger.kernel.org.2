Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3DE3CFC67
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhGTN4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbhGTNlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:41:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68441C0613E6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:21:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m5qc5-0000zJ-57; Tue, 20 Jul 2021 16:20:49 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3120:e42a:5796:3403])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 080B9653070;
        Tue, 20 Jul 2021 14:20:47 +0000 (UTC)
Date:   Tue, 20 Jul 2021 16:20:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/6] arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
Message-ID: <20210720142047.mfqssyj4lwh3yi2k@pengutronix.de>
References: <20210720141642.24999-1-a-govindraju@ti.com>
 <20210720141642.24999-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lno6xybtxkozywqs"
Content-Disposition: inline
In-Reply-To: <20210720141642.24999-2-a-govindraju@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lno6xybtxkozywqs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.07.2021 19:46:37, Aswath Govindraju wrote:
> From: Faiz Abbas <faiz_abbas@ti.com>
>=20
> Add Support for two MCAN controllers present on the am65x SOC. Both suppo=
rt
> classic CAN messages as well as CAN-FD.

Thanks for the patch!

Why don't you disable the CAN cores by default in the dtsi?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lno6xybtxkozywqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD227wACgkQqclaivrt
76lfTAf8CuSBH1I3YSqAKp6bbdBKrNfa1K2i3yyNHZ1vmZUT6iHjLpBVt1426uz8
7zJ8cEBKcdypSEgZgu4oCSpP2VFXHEdPVmmX8ze4MlJPmlww6jw1CY8BCKEU+P8X
FPjqwgTgXGdoYu7F/jR9K22XZ5aUpAVh02IQHs2XFYbNnJ2y7QB2JpDHBFzMiJnS
pCQHVLeBt0j/SsnNHY7qTGzRZNk9Jl+IGd9sVJoApAk7EMLup19JjFuhzznrdvGh
E90sAU6/hq7XanlcWMd5gnKXoMI4xkin01on1vxP0O4j+shFoXTrkJsJZMjb0Hhm
kbxssqxS4MkHLulkPTzxQ13RAYQz5Q==
=rgf8
-----END PGP SIGNATURE-----

--lno6xybtxkozywqs--

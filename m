Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5C378DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348708AbhEJMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:54:46 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55888 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbhEJMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:16:58 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B317B1C0B79; Mon, 10 May 2021 14:15:52 +0200 (CEST)
Date:   Mon, 10 May 2021 14:15:52 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 083/299] usb: xhci-mtk: support quirk to disable
 usb2 lpm
Message-ID: <20210510121552.GE3547@duo.ucw.cz>
References: <20210510102004.821838356@linuxfoundation.org>
 <20210510102007.670979126@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline
In-Reply-To: <20210510102007.670979126@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit bee1f89aad2a51cd3339571bc8eadbb0dc88a683 ]
>=20
> The xHCI driver support usb2 HW LPM by default, here add support
> XHCI_HW_LPM_DISABLE quirk, then we can disable usb2 lpm when
> need it.

This is only needed with corresponding DTS, and I don't see such DTS
entry in mainline or stable.

We may not want this in stable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYJkj+AAKCRAw5/Bqldv6
8kzMAJ4kg2KzjWLJbEnG3gBsjKHuF3lC3gCcDcfC7g1seoGNAyf05vcMuDRPJRg=
=NEYC
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--

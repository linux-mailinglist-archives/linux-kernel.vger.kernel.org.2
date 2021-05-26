Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281A43914FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhEZKhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:37:19 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:34376 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhEZKhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:37:16 -0400
X-Greylist: delayed 1838 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 06:37:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=11rVPzFnJkl/p+9EOEW+pvbWPdKb5D/ypNLYBEtv/0k=;
        b=mAXd47xPAuFxPUDV6llZq9Fc9F+lsHY9d4QicB9DBsIT3+DYV/crMl1IaaenTopvjIN+YPC9LOiZsVugUZTZQGPbwtiDNjJncMsPu6KE+hF03HRXMfOX+4qHeX1zKE4QxNas/Aslp0IuikQdOu9S7qb8nzaSKU3HTSoGdYpciaADBKOud9ic1Um5M6B7yDdDTiklkM3bi6Wf0ZAtzdzGbLicgjyvLvn2H4oRFTA9jHQTrPW+g5siKcHHMFOt+S/9mYP4XZbfXRgjQEr4IpL8ow6IyNkNjzhhPxOGhEBrhQiG0skvzFS9tRhkIKAc5PpB5N+72QTsPSo0JDNf4ZDyUg==;
Received: from 1.pool85-50-22.dynamic.orange.es ([85.50.22.1] helo=[192.168.1.120])
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1llqPA-0002rB-Kj; Wed, 26 May 2021 12:04:49 +0200
Message-ID: <c00938c1e634340663e145b51c5989bd4a20f326.camel@igalia.com>
Subject: Re: [PATCH] ipack/carriers/tpci200: Fix a double free in
 tpci200_pci_probe
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, jens.taprogge@taprogge.org,
        gregkh@linuxfoundation.org
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Date:   Wed, 26 May 2021 12:04:28 +0200
In-Reply-To: <20210524093205.8333-1-lyl2019@mail.ustc.edu.cn>
References: <20210524093205.8333-1-lyl2019@mail.ustc.edu.cn>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-DLbZsM2hAwmpALcT3MJO"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DLbZsM2hAwmpALcT3MJO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lv,

Thanks for the patch!

Patch is,

Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>

Greg, Would you mind picking this patch series through your char-misc
tree?

Thanks!

Sam

On Mon, 2021-05-24 at 02:32 -0700, Lv Yunlong wrote:
> In the out_err_bus_register error branch of tpci200_pci_probe,
> tpci200->info->cfg_regs is freed by tpci200_uninstall()->
> tpci200_unregister()->pci_iounmap(..,tpci200->info->cfg_regs)
> in the first time.
>=20
> But later, iounmap() is called to free tpci200->info->cfg_regs
> again.
>=20
> My patch sets tpci200->info->cfg_regs to NULL after
> tpci200_uninstall()
> to avoid the double free.
>=20
> Fixes: cea2f7cdff2af ("Staging: ipack/bridges/tpci200: Use the
> TPCI200 in big endian mode")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
> =C2=A0drivers/ipack/carriers/tpci200.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ipack/carriers/tpci200.c
> b/drivers/ipack/carriers/tpci200.c
> index ec71063fff76..e1822e87ec3d 100644
> --- a/drivers/ipack/carriers/tpci200.c
> +++ b/drivers/ipack/carriers/tpci200.c
> @@ -596,8 +596,11 @@ static int tpci200_pci_probe(struct pci_dev
> *pdev,
> =C2=A0
> =C2=A0out_err_bus_register:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpci200_uninstall(tpci200=
);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* tpci200->info->cfg_regs is =
unmapped in tpci200_uninstall
> */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpci200->info->cfg_regs =3D NU=
LL;
> =C2=A0out_err_install:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(tpci200->info->cfg_reg=
s);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (tpci200->info->cfg_regs)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0iounmap(tpci200->info->cfg_regs);
> =C2=A0out_err_ioremap:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_release_region(pdev, =
TPCI200_CFG_MEM_BAR);
> =C2=A0out_err_pci_request:


--=-DLbZsM2hAwmpALcT3MJO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmCuHSwACgkQf/S6MvF9
w0POUxAAn3hUK31LPLBVYo0S2O7LHtXeXErQtheZq94fgacZBX4P4zkDwneQ5pA6
dn/913TZXl2Mw4jmjp8MjUduRNzjVSuFlu1XeHa/z35f5X3OlLrP/aePVCVyNf30
vwohnegHeHs6Dx4Lx20Puj9YGlJ3i2OWKe9C+GRPQKnlOJEXWrbfwlGFwAFJJMrN
wBD3PwcL0fqUqbjw6qFWl6nVTBvsNbGUh5A2SUY4VhWWJ7hrgUuAPRkL1FbragyV
wyx6yZgAsEGNiGGmflkwle9SkiwXd/oC14ewhcz3l3Qnwle4VqvtlmIRAM3c4MPr
GmNAPt9udg3i+R9H784GYJOjkIzTP7JoCmKr6NsstWQ16hzjHtZB6ddJk1Cui7GQ
3N2pvxMwGZwrOJAspnhtC2s6D80JhBPPOQU+oJkZwe7KAwzSzr3N+ez0GLBRFzTp
x+JiKogHZHlxXsO0o3Ba0uUhjFKi0ejEusjHSRQsPkh/4Vxvv6ht9LDtCJLyttLk
I2xMQBIurNEC98NYKvKGMdJpIRd/YcxMJNgStNXUXvBLiT9CXR9mMLUsFlQdWlgT
TlPYhpiPSWXFKC0s530smkmw+FVYHZd4YukLUK70eDJcGkxnPyBIaRz+PZCs517O
Qnc8aTrSbYx1fAbPQvbEn0/EzzMGX5FlsjNgRkgUOB3jtN+EDqE=
=D2sN
-----END PGP SIGNATURE-----

--=-DLbZsM2hAwmpALcT3MJO--


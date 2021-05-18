Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4580387546
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbhERJii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:38:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:45199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241065AbhERJih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621330625;
        bh=AD1ds06VVPVYGYLP8IB2Xh0Qsqb8Ho9cPxzhed8QWaw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XVhbMhvJbTuxiTl+ii0FgbH6Ib0+xf7jtpRrjVMaCPWpO1jFqWss4fPVG0bjMKBi1
         8+CHh9xsyLVtEfHSWJE8+dFXuFaH7Nbtw4zLNZr0Rye0uuoBsoyN+oFHjtpzvS4amx
         +gUuKTzkdPDL6N7Fi8wCXV/EwA0i/gWnG6pUNXTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.126]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzfG-1lrHsY3rNK-00R2p9; Tue, 18
 May 2021 11:37:05 +0200
Date:   Tue, 18 May 2021 11:37:00 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Fair <benjaminfair@google.com>
Subject: Re: [PATCH] ARM: npcm: wpcm450: select interrupt controller driver
Message-ID: <YKOKvAyu6/9Kw9DP@latitude>
References: <20210513165627.1767093-1-j.neuschaefer@gmx.net>
 <CACPK8XdVNfjbs+KmhT8g899d74t7M8b6iBuGC_3=DEBy+A_VHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BYjp4V8dNL0PBJME"
Content-Disposition: inline
In-Reply-To: <CACPK8XdVNfjbs+KmhT8g899d74t7M8b6iBuGC_3=DEBy+A_VHg@mail.gmail.com>
X-Provags-ID: V03:K1:2COAoMhLWQVx8aCRC/QXgo9P1rGf9+93jz4L87EPcEABP2qGG5Y
 V0PG61LnPavihULoCj0j9DvVtmkZ1xoQ7x8+XtCkWu4AjoW1L8Xdd375v2H9pjK/vRbmVzW
 ElgFP2Em3awvT5UvjFis4sXVyeq4vb6YdWWvKWszxo6WoK7LBavX5Sr5QvY5+yN3nvg2mKr
 TxTbwBbOoFhf58DMwwUhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ilwcagYyRqU=:S1mS64YVhO7cKuHY6rwEUa
 NJLxhf2q1BnBZKnX8SwDaISBnxsMwcXgwxlQejP4oEQSZuplbKKGyH6Gv6eXj4hY9mgQu+pkW
 TC4/Q96abW4BiKItbunY7SOyUG+SF4u8KBIK9qYomijy75E6c+2O2JO3aGpy4V8KW/OfEBmrx
 /uqB+z/TGb08bTMQFlulAttIo8wSTcKMAMOSUastW4i14e4TkX+Fnmd8aIPb3H9jKYspWuopR
 DPj2fzvkibeKcaX2kzI3d67ZrenowFsQPfR1IVoYo1gmgcIbxxXI2WeI6xKso9+2rvnSYWfo8
 +SknaPDoOofd9WxW8S40nZ80KU+1rC5jqCRzapV3kT5oRbRElNqaUJv9YqILE9YcoOJzzPBP5
 A+k6Xr/5+TTjimPMD16VXJDhsWOPdfiggRP+Mdf5//Ul3yEi7eNIGUA+SKF6ox1QVOIVqK/nu
 6TbDk4IOPDTN3ipveOzO7GyyQX5G2s3YLB/+AP3y4/AxKX8ZNY+yB3FVe/P2MpdbfZd5rFtIB
 lUjlItlhEUc4kPNPlxrgFitUQwfKXlBd55BA3uXJ9NppeMfWR9bvo5wEEmgVbA94wdrz4NAFS
 6eHKCnIwRrc+3oXSyF4sUWLDKRuK7/ZOYmy+p8qOiV7D/FX/shsb/VAOYQiJguMtcVz0MB+1v
 zCXSccDysq1eBlquf+VH+yUyaxnpBmYuOs7s4ZSbqvuX+rh0LyqAMBVBbicKuVAFsK3keVpg7
 2LTX52odu72pV1u4xnUX45mSv888uu1QsmO1eIfN7EEyqoJlyuhD+Y4EyY+gqKZuUgRyEdVSq
 /Wb4X86reKLXHqNSTiHp+tb5plcRyrE5uvRpMgVLf7HvbVzpH9bieA9kmgFNw0ajyIo8qoZji
 d1Sxhc4fs+c4uKcjwLkAklzlw4u8Zxu4FmhRvD1diTFC5C3p3pZhQvgeUSvNp/pCrpxhs3nFX
 35DdnatGQyWVkmkV2WQVrvJpaO8DWa/Dx/vdZpv0u0eRpbv5m/vnMxmG1zBL8ohNY/yPQuxMc
 zaVAmW7FjKry2r5eQpMuoivmzx3w9SPuwmqV4R3XGA3DbrbLWsmYTpidilqRuS1cZK9abnlVY
 mZjCLShVekLlQlT0AOrBE6Mh6ljRRwBAHBPG9jSUF5+9lkfX7bXnvv1cCVcfqZUqN9NmVLD3F
 8o6XEPLGtM2iBHF+qWIKXr0cvRISGRZn7d6bOf7dq+JXByRt0bPdyeJPOdKOGg8eG+0OGsS/7
 n9B2NNXECHm8IoMSj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BYjp4V8dNL0PBJME
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2021 at 07:12:40AM +0000, Joel Stanley wrote:
> On Thu, 13 May 2021 at 16:57, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx=
=2Enet> wrote:
> >
> > The interrupt controller driver is necessary in order to have a
> > functioning Linux system on WPCM450. Select it in mach-npcm/Kconfig.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> Fixes: ece3fe93e8f4 ("ARM: npcm: Introduce Nuvoton WPCM450 SoC")

Ah, right, the fixes tag makes sense.

> Reviewed-by: Joel Stanley <joel@jms.id.au>
>=20
> I will send this to the soc maintainers to apply as a fix.

Thanks!

Jonathan

--BYjp4V8dNL0PBJME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmCjirUACgkQCDBEmo7z
X9uheQ/+J3rREcfk+0H0mbBCp1zvU5TMJRzZ6PCxdyW305R8pjn5hHZGso/9daS3
sXgfoBGwX1YtJAZ8arQbk8O1b+e1E+M95OajLkdLGQA6orRiN1JeWozCGteIqWG6
lHQ2dz9LtTnDXznfUJBzWihu+XMrjhJ6ahTnxAbaQeHz0AL9OVeFPqbr29mpc15X
oS4tB2yZvT7JTwlSgwqjJ66dLCCmmSevyfZrOpErjtYvyVmR/P8YtHDMFJJ5tfpL
afYdwWwEmzz+lyVmciFUxdUdXoK5HBH6beJn9jtpI3Qn022oI7oI0ihBQZRehsuC
QdcIBN+Ce7lbHONpzyuWIIA/kRwM2u86FFIW0rcnum9QlyhPd2cHikyYFWcnMSAE
muphmdLQAAavDlDs+fGwM8mxMMMfVjlG6F4M7umoYp0J2OFdtnW8mQPPzoIy/SDz
UmfbV2jnzn6Wn3nc6qNSl19J3QRR34hF3kzqkd7/UxBVLhI8i724TQxIuG+n92Ue
mC+4KJERdA91NjNUC6CnUqMI+V20mWYfHbvEF9MB4OJBwTG26hCFuNX5FIuhIFp5
9LAQn7ajK7tDXruOtrI0yFVi0DauQQMZqgw7w1xfkEf/rRcyEWOH3cLQW4g7aXMX
D+A+lE91kIJJpuMr3amDSRlSI5fdKe5mNt5bMRyZR7vPgb6Rurk=
=XJwn
-----END PGP SIGNATURE-----

--BYjp4V8dNL0PBJME--

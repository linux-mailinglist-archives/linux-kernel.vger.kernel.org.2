Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12497356BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhDGMHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:07:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:35457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233233AbhDGMHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617797203;
        bh=J/tag75U3iO+Y/OKgSq6pHTQL6viWXxIasOeXm8b2bA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=A57dK1GKvV2ZCuIE/fIlfybFTTDOJoWF4jWuX3Z94Cz7jIAxkdcQrAjShKHwFPRbT
         TdGWqCu9kyY1g07nRWRVQ8TmOVVTzVlflTTOjjv/CZkxbwAeyiNMRlu3p9r5mtSUtj
         FcCzZcX1dBua1mWloHakWIWgPSqo02i3FoKARdM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1lOsQm2oMh-00FAir; Wed, 07
 Apr 2021 14:06:43 +0200
Date:   Wed, 7 Apr 2021 14:06:39 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 06/10] irqchip: Add driver for WPCM450 interrupt
 controller
Message-ID: <YG2gT7C/2P71TYfF@latitude>
References: <20210406120921.2484986-1-j.neuschaefer@gmx.net>
 <20210406120921.2484986-7-j.neuschaefer@gmx.net>
 <87czv6pcx2.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l0kWbujZdkLVT5mD"
Content-Disposition: inline
In-Reply-To: <87czv6pcx2.wl-maz@kernel.org>
X-Provags-ID: V03:K1:Y5gSuqPtFaARAism5B+FeBemHYMx+2GXGlEMhFDECJAPGJzi79i
 oc4YKRb7jSiXoiCHCVfaJmofRLAw8fmH4mVIK4qqeVzia9TBEE1UnIliKMGRfiwNOKh+LY/
 RxkqKP/F+LHrtwgnweKsAgnHeF+4JKfDfJQMKqaxEenSwK5oY41KZS0N8r243Br9iKZcmZf
 Vx+XUFXOHhQ16jyxlqxMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tH/Mj12UbCU=:JH9ZbyRNsrMqdRxGIBDAhM
 bfuEFTnglr86J74GxiaBRI2FzB42Ejjo3PIFExA7OENAZD49pCWldW9T1wcnLTHaXNuodGSQa
 TKpdw3z5lrN1QK3l/pCPaFJoFtNAJix8q2Lr+PMpiVFqL2/WY4vs8Nt/VIZui1K7V2UdtgKfQ
 0UkyIqfrGn1pyJAo2ozVFfU6+Y3fBh32bxYuvC7U+nAZkFyR7o9qXt4qlbh5HtvVHVnzofayN
 wO8tnTTPh+b7l6vEzacGbgyqo8yQc8mdZGOZOOZ4gwqDD79wjVbF6GZps+QMFytzhDPHU1OJZ
 9Skh0i3lrYDwKWehDtFN61HpbRHig0QDm6bYkePA7PgU6K0gwFIDNkP+yK/g+OCoHYy0slMXz
 0fU8SskEf2BNIPZBExgV7hW/MijE9XF5C5QN1H5E+iLFVYqfZlnSGw5G4pC8pMuULMDDegEO8
 6H+nFnrElZ8P1m14032j36B/40z4nWUXaA5D9mvwjO1uqtnPH7Z0uY9j4DqlEmc9rqPFdpVjY
 eAVRNhOvxPq2cRU5bl1rssW9wJkWkgs7piAK9QJ93/ohjTqMS8acBbfy/5chzQsl34f+1UKsd
 YNBwxcjZkVQRAJXaXelOodhBExMr1JCDojaW8qzAQc5DfJlVDU0jeh09JQADwe81ge+1yDq2z
 4WIyZXSUxmO9iLEwX01200z0oxN+1vG/fnEeli7jW+ts9miw4p0ZQZTTfBEdo98gDoERnLRPe
 q13c4zfCCMQV5zZ3yDdb6GSlJxMTXzNDxAldigZEm+N5vdVD2HGBDtX1H66KlYfdAE3Gj6Ooq
 tBeICztf8GJOwvk+GT3HyifolRONZnA1+SPZpbZvnKVgVN9EZkx+wrOVi93p4+hexrISAx22w
 K+ZTMuPw/EThTGyBSdQU9tuAj+eAN+dLmyWAIoUckyh6HszlTX82fZI6bIW2Jg1PuCCjND0fJ
 7A3WpqnYxg85hAhYO4In1hnsrs6yCc65cDVPnPzXvwqeUrg2u901cYQ5wbZumELiy8f72YEYR
 lhiHfMH+B7pu4gQyXanFVjWdC6NHP19C0hCKoiQAmid+Nq0ValLuCQhM62o3zblGnUbCbmp6d
 CsiwmC8mfHP9B5v4xrPggvZSvizd75RouHNnrPB6kvJX5XU3ndKjtiDmtw1fxsEKjDPXXZqY2
 x14IdnWrABIaeIWXwMXcrMNqhWh4z58+Ds3xeFPqaZ/JSu00ejiXAO43dCKYtn0v83q3f//Cb
 In/FzYbj1uk6cPQt4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l0kWbujZdkLVT5mD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 12:11:21PM +0100, Marc Zyngier wrote:
> On Tue, 06 Apr 2021 13:09:17 +0100,
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
=2E..
> > diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
> > index 658c8efb4ca14..a71cf1d189ae5 100644
> > --- a/arch/arm/mach-npcm/Kconfig
> > +++ b/arch/arm/mach-npcm/Kconfig
> > @@ -10,6 +10,7 @@ config ARCH_WPCM450
> >  	bool "Support for WPCM450 BMC (Hermon)"
> >  	depends on ARCH_MULTI_V5
> >  	select CPU_ARM926T
> > +	select WPCM450_AIC
> >  	select NPCM7XX_TIMER
> >  	help
> >  	  General support for WPCM450 BMC (Hermon).
>=20
> I can't take this patch with this particular hunk, as I don't have
> this file in my tree. I can either drop this line, or delay the
> merging of this patch to a later point in time.

Hmm, indeed. Please apply the patch without this hunk. I'll reintroduce
it in another patch.

>=20
> The driver otherwise looks ready.

Good.

Thanks,
Jonathan

--l0kWbujZdkLVT5mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBtoEAACgkQCDBEmo7z
X9vQVhAApP3ye/WFcXXj6ynr3v2cHurZM0f9lYRzT7cNBV0IsR9iGH3ftemJnEyZ
9vtwCg9OneE7cKbEVIdbWBY0M2XAOQWTVMFUHZsQby15N+dSOYgy7rySttqqda5p
U0J2htknDwvOXxoV3RO/lt3W4PAvrRrXrPEUevHNVgdYYV2ptUazFszf5+Y/Obd1
FmemUJanNCU5gduFlFEZX8cx48lQqSHA/bfVrs9o3meL1dLYW6Iw1Nvi71LtrR3q
eEvvAoY1nesqk+d4P72WAZAXNtEWMXoglgsylqyuakcLR0lno8QWGXOiJlR/95+V
gy1VAnL6fNxbRGtQ58yBAiI+wdQVMSK8VaBL95DPRuE2PiaO9di9e2w+JbwIzPHO
59VJvqrHKKvbHNhv6EP/E8mIMFTyxg2CvLHfYp5VoFxCtfQ7pDw1KdX5ESS0lyf9
ir1bT29L1p/uxnDshHvBQIlXfPjXJrADVe3h1AiOhddVnhRUFIGjwX/5XG/w5kkc
kcPfwo7V3JLgXlqWY89l2F6MqeSjwBTecv5FoxVcF7MNVAdNoT6Ac9GnfHZKhbsk
c7JEukC1JCX61g01EimQXh5Mms/LqIkn6pQQP8xNyhU6nQcvpL8/NWqOQf1vgdoZ
N/eB4O+Ne0CfXzykLuF3TtbZKIjAuOG5SYzNK/+F2GJNo9y/D/s=
=qz8s
-----END PGP SIGNATURE-----

--l0kWbujZdkLVT5mD--

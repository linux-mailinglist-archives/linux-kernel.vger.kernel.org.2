Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C63E38C016
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhEUGy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:54:58 -0400
Received: from mx1.emlix.com ([136.243.223.33]:52748 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234422AbhEUGyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:54:49 -0400
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 6BAB06051C;
        Fri, 21 May 2021 08:53:25 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix sysfs leak in alloc_domain()
Date:   Fri, 21 May 2021 08:53:22 +0200
Message-ID: <1889881.5hqWi3GpDC@devpool47>
Organization: emlix GmbH
In-Reply-To: <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>
References: <1716403.SmlLz2RZUD@devpool47> <17411490.HIIP88n32C@mobilepool36.emlix.com> <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3163522.BJEOxDOq7s"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3163522.BJEOxDOq7s
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix sysfs leak in alloc_domain()
Date: Fri, 21 May 2021 08:53:22 +0200
Message-ID: <1889881.5hqWi3GpDC@devpool47>
Organization: emlix GmbH
In-Reply-To: <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>
References: <1716403.SmlLz2RZUD@devpool47> <17411490.HIIP88n32C@mobilepool36.emlix.com> <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>

Am Donnerstag, 22. April 2021, 07:34:17 CEST schrieb Lu Baolu:
> Hi Rolf,
>=20
> On 4/22/21 1:39 PM, Rolf Eike Beer wrote:
> > iommu_device_sysfs_add() is called before, so is has to be cleaned on
> > subsequent errors.
> >=20
> > Fixes: 39ab9555c2411 ("iommu: Add sysfs bindings for struct iommu_devic=
e")
> > Cc: stable@vger.kernel.org # 4.11.x
> > Signed-off-by: Rolf Eike Beer <eb@emlix.com>
>=20
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Ping. Who is going to pick this up, please?

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart3163522.BJEOxDOq7s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYKdY4gAKCRCr5FH7Xu2t
/ACxBADM0v8DMoBMsSIwqGZQTN5UG8+C8zbDs8rpd6pngku/cGNYaHVKaiq9oG41
hXUJEJJVYru+33WKfYb6yLgDogvf7qclfBwqK3Wz180G2nxCqfZ9yAxz4VCexuvY
bYUpOruM3oSwnt+j5WDIBANdct//q1fNc9BDPJgROZ7fws16Dg==
=OzhT
-----END PGP SIGNATURE-----

--nextPart3163522.BJEOxDOq7s--




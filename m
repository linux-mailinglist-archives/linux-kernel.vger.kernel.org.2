Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE363D9FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 10:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhG2Ikw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 04:40:52 -0400
Received: from mx1.emlix.com ([136.243.223.33]:38728 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234880AbhG2Ikv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 04:40:51 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jul 2021 04:40:51 EDT
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 58CCD5F93A;
        Thu, 29 Jul 2021 10:31:50 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     desmondcheongzx@gmail.com
Cc:     anton@tuxera.com, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        skhan@linuxfoundation.org,
        syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com
Subject: Re: [PATCH] ntfs: Fix validity check for file name attribute
Date:   Thu, 29 Jul 2021 10:31:45 +0200
Message-ID: <2424055.QlFIqzKPrH@devpool47>
Organization: emlix GmbH
In-Reply-To: <20210614050540.289494-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2416868.LEy6h3IvCX"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2416868.LEy6h3IvCX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: desmondcheongzx@gmail.com
Cc: anton@tuxera.com, gregkh@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, skhan@linuxfoundation.org, syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com
Subject: Re: [PATCH] ntfs: Fix validity check for file name attribute
Date: Thu, 29 Jul 2021 10:31:45 +0200
Message-ID: <2424055.QlFIqzKPrH@devpool47>
Organization: emlix GmbH
In-Reply-To: <20210614050540.289494-1-desmondcheongzx@gmail.com>

Hi,

I was just scanning through some older vulnerabilities and came across=20
CVE-2018-12929, CVE-2018-12930, and CVE-2018-12931, which are all still ope=
n=20
according to linuxkernelcves.com (originally reported against 4.15 [1]). I=
=20
looked into the commits in fs/ntfs/ from 4.15 onwards to see if they were j=
ust=20
missed, but I can't spot anything there. RedHat claims to have them fixed i=
n=20
one of their kernels [2].

Which makes me wonder if the issue fixed here is a duplicate of the any of =
the=20
above. Is there a reason I can't find any patches for the original issue in=
=20
tree, like the issue only introduced in a custom patchset that Ubuntu/RedHa=
t=20
were using? Is this thing worth it's own CVE if it's no duplicate?

Greetings,

Eike

1) https://marc.info/?t=3D152407734400002&r=3D1&w=3D2
2) https://access.redhat.com/errata/RHSA-2019:0641
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart2416868.LEy6h3IvCX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYQJncQAKCRCr5FH7Xu2t
/EknBACWisFFpJAxn+isaQff639lnnAPEn8ABLf1II4r/EFgnqoBuSrAMvVfJvjC
IxOI3aCtR9XtK6GjB5q4FI4YoE+jd7K+bwR//lInCvwnZdaPZvBGM0DFCzJ62kWl
P6HYTgnZvbNoThgf0S2GB0e/KoU7BH5hVvFSpIHBQoqSkRHRJQ==
=+ScD
-----END PGP SIGNATURE-----

--nextPart2416868.LEy6h3IvCX--




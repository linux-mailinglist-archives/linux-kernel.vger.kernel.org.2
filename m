Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D37343275
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 13:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCUMbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 08:31:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:45189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhCUMbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 08:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616329869;
        bh=50Y/rHSssdb5Pwhs5XahNE/25EWb0MYPd2+DkOjaeSo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=K4MFOgmkGsCESMw93aZbF3tNIhXEMdLh8c1/gCzCjBH47PHtNeSWRNCNZRDxQlsUH
         yRxoc+T5plK26zQtl0Eo4BDqsF4WdAAKSqJpupnrggn93jlEwyvM/Cbix2x7zMkf/i
         iQvMC3sj5QLEfdHlgvkS2UZykwEJSgmnQ3ElbCbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1lrUhF3pG1-00fAWY; Sun, 21
 Mar 2021 13:31:09 +0100
Date:   Sun, 21 Mar 2021 13:31:07 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/14] Initial support for Nuvoton WPCM450 BMC SoC
Message-ID: <YFc8ix6TsQhLIC2v@latitude>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
 <CAP6Zq1jdO_kw-B-SX0VNiVqQ1rz1vbt+DJ1quvm286+cbKec1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ilxIgzm+yXs67A+p"
Content-Disposition: inline
In-Reply-To: <CAP6Zq1jdO_kw-B-SX0VNiVqQ1rz1vbt+DJ1quvm286+cbKec1Q@mail.gmail.com>
X-Provags-ID: V03:K1:FQs9pDrWozbdgB4aDvQJNyPj2qq4NUi4WXWfmpdJ9Ugs4le4doN
 vAUyUjwOFkMcwaivZp+wkpUWkuzY4nri9ZCR7tZhFTEffA/Lh1Xw9rm1HtP9E3Ni7Dz20xh
 y9JZYMocTjRBzWsA7voim/gFXOapLP5ZSrGeer53sOdnZpZIAgGjXNBPwSU/yoQurDCbuA1
 jierxz6Mvs/CkddABmvSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sqz6zrCVGo0=:fb6rpxLt5B0hw5thCb9eeF
 bQIIdxRE9R5+SKzws+F0Y1QssVXt7m1y8Uuc0x0B+3xT4mcR4ov/ubEmpi3/oB67VnR9Z2bI6
 dEaxreH4+J1oKkZ8cqsBiWk7k5Q//Rvo63jodH0Gqo67Dj25EcKUkzG0gWhrZTnZPDlVSKyjh
 wTaQdhWy9H+IrOHyXFJomY+UURogtjyOf0EXtK+8vnYHULbEUFhRJO8CfVDL7LPLTdgCPBaIc
 T0re3EOMeir1Bvy/kByR6M2WblaHNghIMtr5BZc2Qeiq9MPzJlSzYo5tVx/4DvYQFnTpah6ok
 BLl6SbskYQ+jJvKZcYOFm505FpYA8EWt0OkHN2BqTC5smZ79uBuwjsIMUAzHhjctEOAoYv/+1
 4d8WN2msJZuvmWaYHOkEtLB+HSH/6/AYU6deVWnFKlkqYVbiv6Q6YzSUc3cAxQA4gP/zW0XC8
 KH85vAd3L2eILogfWC71pEKRfsx722rBddYulqVlYoN0pYhgsydwSdMJzzF6G9GrFcz2mK7eJ
 UNkKJSsQhZ+zK9R0bKMAjROJp/7YKRht2GIHdsK5KkEhP/p4SnBZGv5yK7Mf/vmHZV8Da0qs5
 MtEeifs9tZHSsdCED+dOcJ7dkB1u7C0cFhmKgLpzubqY4ONuH+vB6y0ZE/mezLKm2WoGhPJBx
 FdIlAMKshvmwrX4f/06vvVfANJYvf3d1XpEJ2Thmgj5YT5UFZEC53Xb1WaWhtFH7XxXOriwQ9
 ekmp57ewVjoW5Fw61i7JgXTPFJMHNdhWD2PHz7WnDB3yknetESFKmvd3W+lp21zPmBDhG+puU
 SYINtf3viibAseRDs/Dmh9Uo2XmvJ8c3CorsiqkxpzWn7j7NfhXa4R5uwC/nU+JzIbrKVCob6
 O2Lvrj9/hyCVNhy4JnGw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ilxIgzm+yXs67A+p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 21, 2021 at 01:07:53PM +0200, Tomer Maimon wrote:
> Hi Jonathan,
>=20
> Thanks a lot for trying to add WPCM450.
>=20
> Hoever WPCM450 is in EOL for several years and we are not supporting this
> product anymore.
> As you said it is only available in the secondary market.
>=20
> Due to it is better not to add the WPCM450 under Nuvoton maintenance.

I understand. I will instead add a new, separate section for WPCM450 to
the MAINTAINERS file.

> Again we highly appreciate your support and time on NPCM750 patches.

I expect there will be some more cooperation, because the SoCs share
some architectural similarity, for example the 100Mbit Ethernet
controller.


Best regards,
Jonathan

--ilxIgzm+yXs67A+p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBXPIMACgkQCDBEmo7z
X9u1mA//SQ1OYXP0aAQV5lmvmwj1JJq9R1Hxu1Bu4plirEkWUGR9IYbUpNEb0Wjt
aslffTV/Y9LjLYryXv2lQRVdbylFF2IsQL2oM+N6H9wl+GqoYswLdSuJ7YtQnWYs
yw2hEtB3Dt9vS+p86JWT8cb2r0v+hpdnuYuhFG9kLx4hl/HI8//NsDmP9LuzLgR8
ebh1k25S7SFGuHYQDw1LFoTCZuh43RTM0EdR8NXyPLIbAcE6DZC2d160E7cSfRcN
+RMt/GDMwlFdsbVoN/jH0yknDm+sLlDtSquixbztH65lcWiDliYtPYbFB1HopJrP
dSikkJQFP6agSKeyHNUlHwChQxulkqV5EmS3HoF+SQcG/1WySakvz/qWKn3p1cBl
v9wKLbPvCw1H3UnWuXG5ZRZ6E8cTnoqvDyBFdCCeYmGchZc7CV0nBk2ldibD8Sd2
1a1nXau6B+GeVDFfgNoIulFSb+xJpar8/soZc3YyZHDnGsj3HuQBVech2X7zHccj
ZXrUeLetzM0HZ8wARcMsKQCcNhCVEot8d+4zdInLafEGZk1htAnvK89TKYdIXbks
5m43CTcDF7mn1Kb/6EJliXoR/6WtXXceEnMhYaGqFzIuCgH3hRpR8msqjHbnbYr7
C3PTO9D22Hb5puORp1jhJD+jNSyvIG23MnSDtJbQTZd4xSikR4k=
=QlNO
-----END PGP SIGNATURE-----

--ilxIgzm+yXs67A+p--

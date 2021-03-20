Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848D5342EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCTS0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:26:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:37963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhCTS0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616264781;
        bh=XnBFPsqYtC0obgPsNDlGc+fS80txhZEBJqasDqPhkyc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QXgew2LqtPwuv0ajqE8cGtQgKNRAl47/QH707LmvdgaA2FNB3kPcq+BZJKLmvSzVb
         vgviME8VWUEzs3k0L7QGJvrUGFulwpfG6iqiIn3ewVZoTpR0bkoNqOWNzP5/9u7bhL
         1Aqco+JhubjoEf1mKA06ocYxejxmP4QqPY54uLi4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNtF-1m794T46qT-00lo96; Sat, 20
 Mar 2021 19:26:21 +0100
Date:   Sat, 20 Mar 2021 19:26:20 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Switch to new kerneldoc syntax for named
 variable macro argument
Message-ID: <YFY+TEVFa/Z9JZBX@latitude>
References: <20210303191639.3108237-1-j.neuschaefer@gmx.net>
 <YFY9ou51WGqA7/Lg@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q2gYtz1AGiLYS3/b"
Content-Disposition: inline
In-Reply-To: <YFY9ou51WGqA7/Lg@slm.duckdns.org>
X-Provags-ID: V03:K1:nIw1tIeB4LqTL4DICS5n2Q0rqOCDbXt4aADHEwI/PQcAj9OMQLT
 MHghOqqEtAk4QqYiEXryEvkRSJ7LQfb8Waxjt5nalYvF+pN5hEUDUR13FMBF3ajG4cUSvQP
 nSqR87j7b978yje8LhV4UiVWN6Uu8a/UKxVlN1Gm17qYl0ZH++zbme6CUe130QZyXosGQ1E
 NrEDwS+7KkRok7/M46SHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gLR1bDpbtO0=:bzblO9FMWhGtayq7KIkUh4
 OkeQE2Nec9zyPUAizDT+GEwFvU4y7gZ2ab1C6FY2t68TDYDtjNWsf5gcuWJJuB5XLmHImLBYU
 Au/BCjr1UX3uHKC2geWBy4zSZgxo15MiuNpdTTNepptAxzV85bvWPjvgFfq94QL2zCLKG0WP/
 S9Y+o14Pb30RZpRev1stisL0ycBA9voleV0cb4wgHTItz9De1r+DFYRGSA84afoPztlIe1LYj
 VUDTg0oFscCCAYhOWIYLLr/4OnkDnMCHzdif39ot7OUvkbDnpmolhqeOMbHwAn5gQwjJs+bhN
 gYjX0C++lxG3wOcSbOMemlkX+4j/C+IDTVCPmE5CMgq7ITy1efCaVBLrGB1qLysE5B1W/HPvy
 pRw4aITB1uFxYwd9431td47iefzsr9GdwagFBcQ9iLzikEtBb/OPb8trLnm6s0PxcX63Pk50w
 bIudLJDR8UldY0obNiBr+jDU9NgXdTNiS/o8QKxzfa1mIYLhvvu1lqLO6wJ8MEEhUhSuNkml0
 se5Eis7aQhi8Z0KT07fNegIlmEnrYULoEqskYixLw82JsQ5Rnmcowxd/Cfcpv+fxwACXQVWPe
 +TKEpdE36Oco2Mw4LBSlTYPz1XO43U1+apoLP15m+8bvBeAuptvJ53rYbI0doZSxVSMrR9ZnA
 tWoySfZbcdCx3My5+366s5JPrzM+osErmiWPYoAfvpzif1CuqaDp0ZD88ftaglwLqVKD0FDi/
 o6e1SVmJR60MEEhwGbunNaxCJHyc7HoO4ZbdPP5IxtOXo6oo4QteRZtdbFRGvm+aNo6I2exeZ
 Rx87OsSXnjwbbkvB/aUMw3CuzfBoaSPujelEwS0I7y3MSdr1+7qrXY3Z6kHGm04xqxvz1icC9
 3YZj8EeUsm5ALzAK+n/Jyc98FlgkvdnteTISlKjCvSTK47Swd8sILU8R6yCbg4cMH2ArdA4bv
 WP7q/YeEv9IH4rNvS/ok1/A/uFNdn/Nlo9iohMAxH5VqOzBBMhb6XhKwv0bRvZvDoui3pFN7J
 HYLSIGnfFBmChfUAWBAKdU3ijzAqzja20HenA8pQq5D3PbY6+tfPHua+75V1gDhA/0253QjFS
 55RzfUDP1a29xZctNYJWge3C4o/u9cSTO5pxuZ72Z7pYxPCNkcqCeibg8MERD89z+9+3LTn9J
 cdAx9OByeNOXids4q2T9ej+G9omy96SuBiuAxafTH93I3yR+JfByXxLVDQ67JfpabAo90Ankr
 JtckaexLeSKy0dfhj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q2gYtz1AGiLYS3/b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 20, 2021 at 02:23:30PM -0400, Tejun Heo wrote:
> On Wed, Mar 03, 2021 at 08:16:38PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > The syntax without dots is available since commit 43756e347f21
> > ("scripts/kernel-doc: Add support for named variable macro arguments").
> >=20
> > The same HTML output is produced with and without this patch.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

> Can you re-send with trivial@kernel.org cc'd?

Will do.


Jonathan Neusch=C3=A4fer

--q2gYtz1AGiLYS3/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBWPkUACgkQCDBEmo7z
X9u5iA/+M53cnrzdz2BUndawmDH7DC2PUoy1VdiAHq7W7zYDh146ZjNtn5UimbqP
7CTvXnSb6aCjpxf2EoE1LAuBgFOb3Isdak9kqKoOB9wFhCNsBzyPHrg2GeZ+eiA9
OyZ9QOZ/4AsepHx3Ksi+eT8g0RMNKZG8J0rMQkmUuET0o86eJvYwufO9QUFtGD6o
xx7r8VOyHx1L8akMTcHO4os+wQEAxwmrGTC5oOg4PjVnaJx2/bRza3x5np+t/+HG
1L2PhQdBxqwpllk2AEw5fLzQMTYfir9uz6f9t25ut82RQ7ddiwTBNHI274CHRV7v
vRA1OFhD/KTjq+ykQyABDbctvoEqjqV2s9v2w8GDufYoxTfH/gWtOZ5b13V52xW1
vhhxtND161S5hEKipaSh8RkwcvHc4rGYG2SG9Lpwd4w0KMrP76kP4/joJu8O/3iu
qAXyYAMJMPlZWsf11rbDksOEQZ2pF7ZugHKWHDBxEMMhyxQV7Ux8HA3Sulorf/iW
/6S1dInraoz7fsYAU0Zs980gy4CY51xLiTXB7oHm50asbsOqVhmjGd4xLpoaew++
PTN5tk87d5cVWoWL1LbmU6i1X6AfvMNOtJcKxKfLgXyoR6g58v8fUNxRnvgfCNxL
gnAowSPlj+34mkEkG09bfYpBGbvv1kNkyBhNNQmW4E7SFhmTC18=
=uVGO
-----END PGP SIGNATURE-----

--q2gYtz1AGiLYS3/b--

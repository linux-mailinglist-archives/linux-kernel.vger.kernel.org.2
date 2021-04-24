Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086F036A167
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 15:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhDXNnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 09:43:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:55445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhDXNnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 09:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619271746;
        bh=x8wM5P4pxtXqykeKqtUFgAdDsAbTPdRi6CFie1F34X0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=D31v/g1yF6BZWGFLqeONSOy2M/a3KxMjRgsc5knS+0SnkM0+LF1uSfyCLEPMUrIe4
         LB9oOr7I4sxsfeQO5bDkmTEf5X+8YPolwKdGJbDml27qZV2YgQOK/URptd6inHtD5i
         GonAp2u0ww8PBGFdJcZvfnlx8XoR2229mPhuRf1I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.179]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ81-1m4KPM3oaD-00WB1N; Sat, 24
 Apr 2021 15:42:26 +0200
Date:   Sat, 24 Apr 2021 15:42:23 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] misc: eeprom_93xx46: Switch based on word size, not
 addrlen
Message-ID: <YIQgPwtzaEJDprHo@latitude>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
 <20210424123034.11755-5-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mF+lD7BQt1FLCE++"
Content-Disposition: inline
In-Reply-To: <20210424123034.11755-5-linkmauve@linkmauve.fr>
X-Provags-ID: V03:K1:GoKrb9UrTWKh4wozJikWV5nuK1jO8DIotg+VbOJZF5DMHSmyiQC
 T2o4SipGqha9LeVr2pEV3RKrB9dGE9kwpe406HacvZW9fu8rInI14Ha8FY2o5JUCkyrgd3z
 IqgmBMNIi2UX2Eo/tq7iMOR4N+11asIic0hRWDY1pNP3OMvhV9cZYV7U0af1xg5aPoFRMZ+
 dlx21BLWyiZ3lwsSaeGmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zi44y7ZFSGU=:Q4UNMvYnUixzhcKPl9Gn3F
 yyOND/mOEifLsVg30S/Q+DpxbELCXzBd5OK0f25LA3i7z/+fLZWEtDUypB95C8i8KrlILOOo9
 44HQx4iWwBTMEFw7z2ApCSjH6uWxBgErCTr3RUBrTMtuKhWS0ddiVN8q3sDxn9U+TVTUAb7Hx
 roA0OdA4qKMTBL9ab9b+HAa/oDYVlO+wlQl96O+WcGnxA6ktESfxeBwwStyP48ADQs5dwQsli
 oD9nH4ud2vKTThIsRkiYAHZv/1v7AB+hYX4TjfxT9xvjRXVlKL0PQ20bzc8EBcDhYuehcw4xu
 yKoJs5X4zLUMomZL6418ZC7IW2PbbOjQhOMPAdJM5WotmiqW4eqeHx/+LGGhRwudX5ONO6Ubt
 4uEeMCDkodj4Ov08AQ5hNmu4RREXrLFG36eMzg4CdkTRrtOGub/dY/gquVHowkfOVsphlI6nI
 1FqxAuR2qec+pf9oOgrXuHaloQzrdS17uUA4ptqVHwGCC7EGDpar0M+d4gDBI3YqA+1UJsXfs
 GMKk3yBHMhVP3mg8FBwl1pRhLaj1qtFEWI4QhytRLRLaEBO+GvS+s/EyCb/MnI7Ow7p+/1v0i
 uZ4+H/eKfLOrE3i6G76vLGNZq0t7NBAbanDW7NJeREPmGTI11UVkRueBmElc+fPLp5S06UKsZ
 higMAk6jPngwajtgxL8y+J+GQm2SCy8Xofu2PEhrlXo7uvirG8waezh3wPxTHBOo9tOfov9Gl
 oRIMdnDCt6D9EgNmHje+NXjA5lQhM/xH6TgIzkriRLbpuNz6gb8cZ5BdaAdsGYtjhv6jJCLua
 HG+JgzqmbkCW4dY3fE6TJ75nn1Qw4r8AU82KwqSVQ4nxxGjOfvv4Z7EBBTOxXEwXxRpon00RX
 SHBZIFv9Krr1KWqX/S1NeCkOOX7e6CMLdkGT7P2ntwrDoy9IcQLFuQCrUmOM7fPZO1o5enkEe
 5UTIMTrzyoLoZbimDGOqmvYX+sqm9lGzsf3Sexbt/XOdwkPfU2bZ711GBFa6oAQZ1INL/z9h+
 MAno2isRA9gn6r8KVHaLZuJ4DtvtwgGh6dFuta4aI39uIoSUSrzK/+LgaaEJ8fT6qm3NMvOvL
 q4QiaJVEETqDOjieyfzR3TDyb6+cQXQxACv5HpjCh52yV2cHeZ2ofCo0tOvQTS0YDwcQDjksW
 /9DAcntHBcTh+U+oPzoG0MtOSS8Z2dxco6+IYys0vQcV2uCC1JT7wgWBNIcWIoHY/NGmZq84X
 imZaMzDXwd8XaILdw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mF+lD7BQt1FLCE++
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 24, 2021 at 02:30:33PM +0200, Emmanuel Gil Peyrot wrote:
> This avoids using magic numbers based on the total size and length of an
> address, where we only want to differentiate between 8-bit and 16-bit,
> and finally makes 93c56 and 93c66 usable!
>=20
> If the two pointer indirections is too much, we could move the flags to
> the main struct instead, but I doubt it=E2=80=99s going to make any sensi=
ble
> difference.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---

Ah, this somewhat addresses my reply to the previous patch.
I think by rearranging and/or squashing the patches, they could tell a
more coherent story, and cause less confusion.

(Basically: avoid creating conditions where the code is wrong =E2=80=94 if a
 later patch is needed in order to make a previous patch correct, but the
 later patch alone wouldn't make the code incorrect, swap them. If there's
 breakage either way and you can't tease them apart, squash them together.)



Thanks,
Jonathan

--mF+lD7BQt1FLCE++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmCEID8ACgkQCDBEmo7z
X9vTaRAAsXPixWA1V+sKf7bVhbGsOdJmZkLSze1UvUIuAFWJRQVK2hMAjvauN0iJ
G6Gc572a5qZ4sLK2MEkukWLh9Z4x/aFaxDlcS3w0VABoLUwuvxdfFPaadiyKwtsY
QLKSRie1J7Q3qEuGtNK1s9Z/+3Qm/1AXd7LdrB8k2FFsaQPAmb6YsgtyxaHcMSux
asi8irRGxVWhdu7Ez3vxOslfHvu5ijvR3+DBqech2eCWmR7tWGlVYobyLs3dNmtV
qOmn+NZf9rajkuWc/2FZHKdP4/DU5yXoOQylc9LlkFG4zPCS9dxFkrtJyQuYl6Bx
IusNHeq+F+XyoIluKkA7gocx3Wr6XgpL0Rq+lTr2abjs0JhDXJPmzTZzo6NgJB9O
ZrCExHjI4cu3hGGWG/niKR3SkQo+YCzk5AsSkZJt5BZAI2Yy9/N3wncF8PoZ1x+L
sfHZ7L+DsFNqpRKUGRqAUGbpMilT0yoq+ZfNQ5orrC5inK1mpzQnEpdYTOkk7uBv
R2IWGXmel9gDjAmXfL7jXsWwGcKV0BF7nlhJVqeNplQpshlHDKtCFYKnFnp25QWI
ngRzxGyGveW41MocDzrFOwYJuffI0GJNslak+sTl0Y9ZmD/drdUVcs9UWDJIh8iR
U3C514IBjQVc5NulMA5oVysJTCpw3TJOX2+BOe1frMAqHR4IaFI=
=UwN5
-----END PGP SIGNATURE-----

--mF+lD7BQt1FLCE++--

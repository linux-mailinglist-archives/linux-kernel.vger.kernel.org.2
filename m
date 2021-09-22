Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05841414158
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhIVFvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:51:35 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:52489 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbhIVFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=yXcPbo8Zymmfv4sqpIjMg8iY0k2cKSJFduh1ALnwUzE=;
        b=CzZlYoYi2y0wJlB9EBXlMdOEnoWGLhQ2uUP5XqNK5VC7HnSsrGzsCmigKxKwbUY5XFahMFu0JLyRJjV7ldHr6pBj3TV1F4WG5Fq9SIygSajbRmJkDyOcqsxCexJNx5+ojVXVNR9rpSri9EGYWSN3f59ZJs3RlpkOaGKbJyQb8zKAhowo/mc6cOxAnhn5Bcwmw5eQ5jYDga2kgBWHNdU6wHBSHuLayG6ssESp/XJmFHxvzUcyPr4TbaPboDcgFYlwsE++6XebLUqPyaFpipRpCXRzoRHe9R855snJFGnBBvVuEJvEGO5RnRG8vL4/33+NF9OcZ0oSdTam+EVfsJhzEw==;
Received: from 101.red-88-4-142.dynamicip.rima-tde.net ([88.4.142.101] helo=[192.168.2.252])
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1mSv8l-0003Ma-JN; Wed, 22 Sep 2021 07:49:55 +0200
Message-ID: <259e8411270f663352829e8df9af627d6fba4d1b.camel@igalia.com>
Subject: Re: [PATCH 0/6] ipack: ipoctal: fix info leak and other bugs
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     Johan Hovold <johan@kernel.org>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 Sep 2021 07:49:45 +0200
In-Reply-To: <20210917114622.5412-1-johan@kernel.org>
References: <20210917114622.5412-1-johan@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zl7qek+jvUMhi9k9cYqT"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zl7qek+jvUMhi9k9cYqT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

Thanks for the patch series!

Patch series is,

Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>

Greg, Would you mind picking this patch series through your char-misc
tree?

Thanks!

Sam

On Fri, 2021-09-17 at 13:46 +0200, Johan Hovold wrote:
> This series fixes a stack info leak and a number of other bugs all
> found
> through inspection. Included is also a related cleanup.
>=20
> Note that the series has only been compile tested.
>=20
> Johan
>=20
>=20
> Johan Hovold (6):
> =C2=A0 ipack: ipoctal: fix stack information leak
> =C2=A0 ipack: ipoctal: fix tty registration race
> =C2=A0 ipack: ipoctal: fix tty-registration error handling
> =C2=A0 ipack: ipoctal: fix missing allocation-failure check
> =C2=A0 ipack: ipoctal: fix module reference leak
> =C2=A0 ipack: ipoctal: rename tty-driver pointer
>=20
> =C2=A0drivers/ipack/devices/ipoctal.c | 101 +++++++++++++++++++++--------=
---
> =C2=A01 file changed, 66 insertions(+), 35 deletions(-)
>=20


--=-zl7qek+jvUMhi9k9cYqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmFKw/kACgkQf/S6MvF9
w0O60RAAg+oSvmEdmbF25U/ZcccJoEuf3JpkRTHkQpTXBEFYn45Ps1J40PkuAr59
1TA8oWTJtBVUvbiToNdRfLOVPhL1JoeeJBzFhaC/Rj3YQ0NtZMrsmstvin66Nh4B
qvuR3nIgmAB+qtvYw7xyNXbCRBddCbUDDJHSnjkBcsA7G11vj9scKiD1akNVO47r
m3KxWwk2b4Zjg8iYFsWbK+PHOnN9At9M8JGMOZw+pancGIeFrdVuutQRlP4d6FJs
x0UGR8A4qMtQfVkYltxGKOchg1VloP0V1W5O6TaTwHSGRLpXoGr5uzAoD5e7R8FA
1R0uMZgN19E7c+oN0TiqK7Jw++loUxe3JBWe6u7KtrtC7uHf/2oPlVei2gbG21lg
P7TgBIjz82nKn/f6EkKvFnHzTQvDUShD5hAfYJArpa+dZJVB8/Pd2ogV+0EhO4e7
+R+ZJNcYUFrZuShg6HXJR/UVzw5ErgtkrpON+DRH7jBI9F8T7wnjuyvYdcsnqqQB
djTr4nanBeTbzQrTwt51Y2qf2LV+bteGi2XGWb3xVXUNV+lrBZR4TJLg0t4RNDgI
jsi+47pSNTXfUN1rSLQtuK7N5EDHB1nz43Qqs/n0mLTgxIohaKcySRD/+7hv8qAz
fwNoFCPRjtl351KlBxGmu7e29mX0ds31g2497WPsjUzw+J2VySE=
=EGCx
-----END PGP SIGNATURE-----

--=-zl7qek+jvUMhi9k9cYqT--


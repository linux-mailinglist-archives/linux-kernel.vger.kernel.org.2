Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19B241B73F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbhI1TOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:14:07 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42412 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhI1TOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:14:06 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 99DFA1C0B87; Tue, 28 Sep 2021 21:12:25 +0200 (CEST)
Date:   Tue, 28 Sep 2021 21:12:25 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.10 000/102] 5.10.70-rc2 review
Message-ID: <20210928191225.GA29510@duo.ucw.cz>
References: <20210928071741.331837387@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20210928071741.331837387@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.70 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYVNpGQAKCRAw5/Bqldv6
8rVOAJ9SBohYfhkJWzo2HINZflnNXsCELQCfZ9mtqGVZzrhksuIlJD17WRIWc98=
=BKrq
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

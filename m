Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FDE31F171
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBRU4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:56:23 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:48940 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhBRU4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:56:16 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 653491C0B8A; Thu, 18 Feb 2021 21:55:34 +0100 (CET)
Date:   Thu, 18 Feb 2021 21:55:34 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jari Ruusu <jariruusu@users.sourceforge.net>,
        Willy Tarreau <w@1wt.eu>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218205534.GA10201@duo.ucw.cz>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <YC4atKmK7ZqlOGER@kroah.com>
 <20210218113107.GA12547@1wt.eu>
 <602E766F.758C74D8@users.sourceforge.net>
 <YC55t1vkRuC9uXcx@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <YC55t1vkRuC9uXcx@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > For me
> > only way to get properly working WiFi on my laptop computer is to
> > compile that Intel out-of-tree version. Sad, but true.
>=20
> Why use 4.19.y on a laptop in the firstplace?  That feels very wrong and
> is not the recommended thing to use the LTS kernels for.

Well, that's actually what distributions are doing, for example Debian
10.8 is on 4.19...

I expect -stable is what most users are running on their notebooks.

Best regards,
									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYC7URgAKCRAw5/Bqldv6
8umPAKCeGuopd/KU36qh3nxlsMwhHlsobwCdEXRHJe4x7nTSJYMsqSg+C5sc8yw=
=azOZ
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

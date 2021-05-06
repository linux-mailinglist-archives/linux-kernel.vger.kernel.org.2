Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D0A375257
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhEFKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:30:59 -0400
Received: from mout01.posteo.de ([185.67.36.65]:52267 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234428AbhEFKay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:30:54 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 44B6F240028
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:29:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1620296995; bh=SMQ6/WYEjZWsTq+4axDbaXC7iYxdjWKO4vYmFp3waCI=;
        h=Date:From:To:Cc:Subject:From;
        b=ciT8FMsLnxxObl1ZaBvJrvqY0xr2Zan8EhqqgStbtUpRm9ddPBKwEIFr8eBh5Xb9P
         6ioCo/GQS4DrEqsdXACPk2BG62rFRdkSrDjK/JLeLnUbTkbtFvgISFSFMrpzIwiT9J
         u+4lt4u7Y8U6MgkhQ1r8uQd7HtDhmuBPCeCtXphcndTrE0aJIuSWfY0sdfKwEo9ar5
         kC/WQsfP82MmF7PjbuGDy2UtzDSP2CEIkA3dIy9AU9D45aME9EwLipIxY26ByNUypx
         GAREaxToFjHuW8Z5wg876oF/IN1Tpg1RMoW2Z3/6JKW13+kqDpMrhW+c2q2YEDzPp8
         pgOLK+3Mi4dfA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FbVFZ3Z5Tz9rxD;
        Thu,  6 May 2021 12:29:54 +0200 (CEST)
Date:   Thu,  6 May 2021 10:29:54 +0000
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>,
        linux-input@vger.kernel.org, Ash Logan <ash@heyquark.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] HID: wiiu-drc: Add a driver for this gamepad
Message-ID: <YJPFIlcUe+P/dg9G@latitude>
References: <20210502232836.26134-1-linkmauve@linkmauve.fr>
 <20210502232836.26134-2-linkmauve@linkmauve.fr>
 <YJMdK8zQR7Al3wWC@latitude>
 <20210506100705.5bcpywy25kfqwgkn@luna>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0hwymdEhwY8Z/zkk"
Content-Disposition: inline
In-Reply-To: <20210506100705.5bcpywy25kfqwgkn@luna>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0hwymdEhwY8Z/zkk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 06, 2021 at 12:07:05PM +0200, Emmanuel Gil Peyrot wrote:
> On Wed, May 05, 2021 at 10:33:15PM +0000, Jonathan Neusch=C3=A4fer wrote:
[...]
> > Is there a reference of the device-specific HID format? I briefly looked
> > at https://libdrc.org/docs/index.html but couldn't find it there.
>=20
> You were very close, the input report is described here:
> https://libdrc.org/docs/re/sc-input.html

Ok, I think this link would be somewhat useful to have in the commit
message or a comment.

> This project wrote a userland driver for using the DRC without the DRH,
> but it requires a very specific wifi chip which makes it quite
> cumbersome to use.

I see.


Thanks,
Jonathan

--0hwymdEhwY8Z/zkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmCTxRoACgkQCDBEmo7z
X9ud+g//aiTvysLIGf8nNtre9zlALljZwn0hUqDCKQbQ0Gqu0S5g9mU+/Fr/YBQ9
DUU1mcfYjh8PMJNDpv3WhYlx2JiXg6u6m6c4dx3FclD/SrciCW2LpxOgcvGPB96+
PuRxvkK30cDDw49Ufuw2S4lcT8xkDbYZbenZdoW+zbOFynBGqh++xUqBRh2H4IFG
vQOmxe7XBMZB5lA9w4lSoL7ehnV89rIGLuiamZRiuvEfSsSALz5/4zUxPTyk7Oe4
82cxBhzfXBfHFKRbSifiP6nJViVL+i/WD4atkO6kab7LjAFj0UqIm+T8uq8ACnFx
Q6EKDG5+RWNN2yrQhCB9ePHm7xdATFWH4UKLvLcrNeWJeYCGIshLF7G0N4APb07u
dCodNjypbx6tTZmH0MzbvTe4QTYTxJ6dR8WC8hM13ncpmNwe2k09VzEG3EYXl6gJ
PpkHuHaTUopThzeNZO8O1W/DrBj/rjAl6jguOzEuNNyQ0G7BcvLKwyevi2m5xkOW
igoIZZaCpVnfX9E47UUmc53BTMBQyI2D+FFHcAuwrDcTTxosoEXM2hdHd7Oz8z6P
vtwtoxVFz1Xkj8DB3ksjukB+0Pm2SeC2g1C/gJO+fB/yyf/RjEhPjuj+3rFPzX/9
cPXeyBcmUne/PHgU+mVm4VNyA9BPwcwx1WjZB659ib0co5aa8mo=
=j7cO
-----END PGP SIGNATURE-----

--0hwymdEhwY8Z/zkk--

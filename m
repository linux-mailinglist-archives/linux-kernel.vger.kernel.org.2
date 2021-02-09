Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB331546A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhBIQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:52:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:42720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233096AbhBIQvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:51:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0A1AAC6E;
        Tue,  9 Feb 2021 16:50:31 +0000 (UTC)
Message-ID: <a4e480f9f605a1f0350db30298d99540c91555b2.camel@suse.de>
Subject: Re: [RFC/PATCH v2 09/16] soc: bcm: bcm2835-power: Add support for
 BCM2711's Argon ASB
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        mripard@kernel.org, eric@anholt.net,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Date:   Tue, 09 Feb 2021 17:50:30 +0100
In-Reply-To: <CAMEGJJ3d-d7-h_=B2XpFAiwSAdfnsPGh1mZjX5=sdeu3PNTPmg@mail.gmail.com>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
         <20210209125912.3398-10-nsaenzjulienne@suse.de>
         <CAMEGJJ3i_hEAnO4rDQ+emqB=OYXetLyKh1kMRwAbUnYZ1e48VA@mail.gmail.com>
         <56e237a8d0646c03d4ff44e439d1b0f81c800a9b.camel@suse.de>
         <CAMEGJJ3d-d7-h_=B2XpFAiwSAdfnsPGh1mZjX5=sdeu3PNTPmg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sXLGIjMr8WhgE4kBWr8S"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sXLGIjMr8WhgE4kBWr8S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phil,

On Tue, 2021-02-09 at 16:38 +0000, Phil Elwell wrote:
> Nicolas,
>
> > > Please don't refer to this block as ARGON - it is the IP of Raspberry
> > > Pi Trading and it's name is RPiVid.
> >=20
> > OK, sorry for that. I, again, mixed both ASB names. I'll rename the Arg=
on ASB
> > to RPiVid. How should I call the one present in older RPis?
>=20
> It can keep its unqualified name of ASB_*.

Fair enough.

Regards,
Nicolas


--=-sXLGIjMr8WhgE4kBWr8S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAivVYACgkQlfZmHno8
x/7zaggAnqh3JclLyABLSm4P9iCwtHfguoGsM6vJqQDDSOAq+ZA3V5y5zD+yph80
TXEZBG6TtLIc5HI2B8ofqGvg5XCStIoJs2/gtxyfBwuUhSM8sN/mrrmLkguFmKD6
j5yiTZyT/5wb8p7JPfgvJP3FvmpkuQcIWkOph8JiFVoO1QtgrFfjJTt7WSwJcnU1
2wHwhoowvHXOYtegtZBqDAp30gGf8eM9GLIshRUudCCSl0QcyqxlWQ5a4pdPerUF
Dx82Jfghybuz/a/tY4ENz+g+AOeGGjKRd8LYxVJjbdZ9mGL5O5vNQwvHpJavwAiF
Ntrf4JNc7BfqKcgy4979r+zk+WZ5Bg==
=nTpY
-----END PGP SIGNATURE-----

--=-sXLGIjMr8WhgE4kBWr8S--


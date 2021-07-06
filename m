Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043A13BD735
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbhGFMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:53:52 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:54688 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbhGFMxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=Ds9da9wtVE2KkfSs70Y6kMbyOH44F4R+xW3YesStoew=;
        b=Pdo6apdfeg8aHxg2rdLUm6FmM02rQK0VBvfB62AmC+r+4BmaV7ftO+VnstwklQqoXGsejRznOFFZIMb/bRz2NMGjkX6H6l7FgTS+i5gmsEMYTuU3X1Eq3gqnZv2uAaNB/4eIyjrdpBLlhaeeP1lcVw4w4jE1IA5pnhfFp1QgSwCWn4Kwi3zdbnTPgK2pDdZ0yGzd0yJzSLzqoKOCFQ71C0B+rCTtTdgAi4ov0zz4xaGFUkw9nA+JQSp2VaBoyiZjZZvSCksVblznxKcoKiJ8IJ7bJ3mzpfKUkhVwLMviVEcNl090UIaSxFRUXcSFrmILOv9xXewm6PPd0Dx/AH3pUg==;
Received: from 152.red-88-9-105.dynamicip.rima-tde.net ([88.9.105.152] helo=[192.168.2.252])
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1m0kXK-00016F-T0; Tue, 06 Jul 2021 14:50:50 +0200
Message-ID: <22817b58fe78a803af3440b7571922289fdb87f8.camel@igalia.com>
Subject: Re: [PATCH] bus: Make remove callback return void
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@ya>
Date:   Tue, 06 Jul 2021 14:50:40 +0200
In-Reply-To: <YORBc384OjIBC/Yj@kuha.fi.intel.com>
References: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
         <YORBc384OjIBC/Yj@kuha.fi.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-uS6BQyKaXrtbvHw9wwhA"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uS6BQyKaXrtbvHw9wwhA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-07-06 at 14:41 +0300, Heikki Krogerus wrote:
> On Tue, Jul 06, 2021 at 11:50:37AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > The driver core ignores the return value of this callback because
> > there
> > is only little it can do when a device disappears.
> >=20
> > This is the final bit of a long lasting cleanup quest where several
> > buses were converted to also return void from their remove callback.
> > Additionally some resource leaks were fixed that were caused by
> > drivers
> > returning an error code in the expectation that the driver won't go
> > away.
> >=20
> > With struct bus_type::remove returning void it's prevented that newly
> > implemented buses return an ignored error code and so don't
> > anticipate
> > wrong expectations for driver authors.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20

For ipack changes:

Acked-by: Samuel Iglesias Gons=C3=A1lvez <siglesias@igalia.com>

Thanks,

Sam

--=-uS6BQyKaXrtbvHw9wwhA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmDkUaAACgkQf/S6MvF9
w0Mk4RAAk9b3Zpvche0TpvgnTBdQ299jNyNXX1pdTj1Kri+KpCE1xlNlFtaePrqT
6dmvkqFptJwtK2/uP+6WtHjdwP1dvXfjVNa9ZRbRUFP1he5wFPXGdVl7AULbB4we
tsEmEvwmFlKM1YD0Pie6KZbw9hZzXIsYizc+nhiG48KYdeMxCM/ccGoScEjlaMU9
RPKFyDhCB3ehkABppIIti9UNhV4w8Ps6d9gSCsjGkLRj+YTrtFuUlxl/CNiNHej1
V4RM3ZlVNNByNPGEW3+mtEP/Pw/n7XLXw17IneOHxL134qYATMJVnNFuJOOAc3Es
3nLKHbvqihZE/rr1byLX2jH2jibj2jOXPOTW0MGENv0WylZvt53AB7dErstEalov
ptVyNwFFnBOor6PnQWFqwnOQLhfxQNlChcVC/8bdqZ0EdF3ZRtecs25gfPR7AllQ
nbcPAU0my+l+7I66j8uTna4C/ztKFs+8Zn5zVLa8zQToZifnDITDmR+jOSKz/vtz
+YSDSQMMvCP3p9ue4GYfJr1z9SORNm6VVrdU2R3b6lp6uos1gmB7Z+YEYVWxTGKX
alGgBCX78MCEHETydFT++LfT4teGlKNc/eYXDag8CWkqyyEi0y2IJe99UYiRimre
3M1NVSivqVMg4SqBh1yMKc/gjI7M1c9VGg6UbKrTzTXJjGRlAF4=
=qOWU
-----END PGP SIGNATURE-----

--=-uS6BQyKaXrtbvHw9wwhA--


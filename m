Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B30325463
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhBYRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:09:27 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:39844 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbhBYRIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:08:30 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0E5941C0B81; Thu, 25 Feb 2021 18:07:27 +0100 (CET)
Date:   Thu, 25 Feb 2021 18:07:26 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     intel-gfx@lists.freedesktop.org,
        kernel list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
        airlied@redhat.com, sean@poorly.run
Subject: Re: udldrm does not recover from powersave? Re: udldrmfb: causes
 WARN in i915 on X60 (x86-32)
Message-ID: <20210225170726.GA31110@duo.ucw.cz>
References: <20210224200912.GA27905@duo.ucw.cz>
 <452585d5-9d18-f5a8-9d6b-6d39aa037480@suse.de>
 <20210225095322.GA5089@amd>
 <4fb31ea5-ef20-4752-4782-8d9f1afdf51d@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <4fb31ea5-ef20-4752-4782-8d9f1afdf51d@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > This is in -next, but I get same behaviour on 5.11; and no, udl does
> > >=20
> > > Thanks for reporting. We are in the process of fixing the issue. The =
latest
> > > patch is at [1].
> > >=20
> >=20
> > Thank you, that fixes the DMA issue, and I can use the udl.
> >=20
> > ...for a while. Then screensaver blanks laptop screen, udl screen
> > blanks too. Upon hitting a key, internal screen shows up, udl does
> > not.
> >=20
> > I try rerunning xrandr ... --auto, but could not recover it.
> >=20
> > Any ideas?
>=20
> Did it work before the regression?
>=20
> For testing, could you please remove the fix and then do
>=20
>   git revert 6eb0233ec2d0
>=20
> This would restore the old version. Please report back on the
> results.

Ok, I went to 7f206cf3ec2b with 6eb0233ec2d0 reverted. That fails to
build:

drivers/usb/core/message.c: In function =E2=80=98usb_set_configuration=E2=
=80=99:
drivers/usb/core/message.c:2100:12: error: =E2=80=98struct device=E2=80=99 =
has no member named =E2=80=98dma_pfn_offset=E2=80=99
 2100 |   intf->dev.dma_pfn_offset =3D dev->dev.dma_pfn_offset;
      |            ^
drivers/usb/core/message.c:2100:38: error: =E2=80=98struct device=E2=80=99 =
has no member named =E2=80=98dma_pfn_offset=E2=80=99
 2100 |   intf->dev.dma_pfn_offset =3D dev->dev.dma_pfn_offset;
      |                                      ^
  CC      drivers/net/ethernet/intel/e1000e/param.o
make[3]: *** [scripts/Makefile.build:271: drivers/usb/core/message.o]
Error 1

So I tried to go to bad commit's parent:

git checkout 6eb0233ec2d0^
git log
commit cf141ae989e2ff119cd320326da5923b480d1641
    ARM/keystone: move the DMA offset handling under ifdef CONFIG_ARM_LPAE

But that resulted in lockup soon after "--setprovidersource" command
was isued.

Best regards,
									Pavel

--=20
http://www.livejournal.com/~pavelmachek

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYDfZTgAKCRAw5/Bqldv6
8puHAKC6y3/9FJshPuwi5TGRXtugLLvqRACgmwbLRxRTo5cLtjr+rw0WaJviAC8=
=6IoU
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

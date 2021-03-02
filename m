Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDD332A655
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346520AbhCBOVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 09:21:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:38564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235778AbhCBMn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:43:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46604ACD4;
        Tue,  2 Mar 2021 12:42:18 +0000 (UTC)
Message-ID: <5ba9bdddbdee87d501b791309115c2eadaf9be84.camel@suse.de>
Subject: Re: [RFC 09/13] iommu/arm-smmu: Make use of
 dev_64bit_mmio_supported()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     DTML <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 02 Mar 2021 13:42:16 +0100
In-Reply-To: <CAK8P3a1t3yCD4vXF803nL=n3Y3hD1MOPOAEZwZA+782N64PXTA@mail.gmail.com>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
         <20210226140305.26356-10-nsaenzjulienne@suse.de>
         <CAK8P3a1t3yCD4vXF803nL=n3Y3hD1MOPOAEZwZA+782N64PXTA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JrdrgEmwCwoQS03/ReLX"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JrdrgEmwCwoQS03/ReLX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd, thanks for the reviews!

On Tue, 2021-03-02 at 10:32 +0100, Arnd Bergmann wrote:
> On Fri, Feb 26, 2021 at 3:03 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (smmu->impl && unlik=
ely(smmu->impl->write_reg))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0smmu->impl->write_reg(smmu, page, offset, val);
> > -       else
> > +       else if (dev_64bit_mmio_supported(smmu->dev))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0writel_relaxed(val, arm_smmu_page(smmu, page) + =
offset);
> > +       else
> > +               hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + o=
ffset);
> > =C2=A0}
>=20
> This is a writel_relaxed(), not a writeq_relaxed(), so I suppose you don'=
t
> have to change it at all.

Yes, that was silly of me. I was worrying about the semantics of the whole
thing, and missed basic stuff like this.

> > +       else if (dev_64bit_mmio_supported(smmu->dev))
> > +               return readq_relaxed(arm_smmu_page(smmu, page) + offset=
);
> > +       else
> > +               return hi_lo_readq_relaxed(arm_smmu_page(smmu, page) + =
offset);
> > }
>=20
>=20
> I see this pattern repeat across multiple drivers. I think Christoph
> had originally
> suggested folding the if/else logic into the writel_relaxed() that is def=
ined in
> include/linux/io-64-nonatomic-hi-lo.h, but of course that doesn't work if=
 you
> need to pass a device pointer.
>=20
> It might still make sense to have another wrapper in that same file thoug=
h,
> something like
>=20
> static inline hi_lo_writeq_relaxed_if_possible(struct device *dev, __u64 =
val,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0volatile void __iomem *addr=
)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dev_64bit_mmio_supported(sm=
mu->dev)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0readq_relaxed(arm_smmu_page(smmu, page) + offset);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0writel_relaxed(val >> 32, addr + 4);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0writel_relaxed(val, addr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> }

I like the idea. I'll try to integrate it into the next revision.

Regards,
Nicolas


--=-JrdrgEmwCwoQS03/ReLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmA+MqgACgkQlfZmHno8
x/7dpwf/aLel0KoDRYbTs0N1MCxUYaw65bxfhjj33y441mkd9HUSVemzI3HBOTln
uEs/4WoEx/tWa+9t93oM2P+RLoQsk79775dXJzUUsKhaEjfFwEjEKlME+XCyedJ1
ST7bgtafNyYLOEVgDqIOm/ies5GMLg7uO8f9za9Qfyu77tclP2AkvKFhlOyKHp5M
dbZY4+YwhzP6mqVRqZCPlQvHZUBh1UH7yQHdZNjZkLcgvz3x1+f6EUW+rScBrpNq
iSqt5gav8YDB0AcWD7tsxDZajP1tTqqjHfREvZoycWs7QLeC8vrODzO7S/G4za7u
a8YAd5JlT6Xja8V8kqq5VSQmcdNYoA==
=Loxv
-----END PGP SIGNATURE-----

--=-JrdrgEmwCwoQS03/ReLX--


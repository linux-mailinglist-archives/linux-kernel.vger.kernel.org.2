Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E732A7B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579169AbhCBQ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:28:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:43008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1572973AbhCBOIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:08:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF120AFF5;
        Tue,  2 Mar 2021 14:06:59 +0000 (UTC)
Message-ID: <6c26302c546afb4d9d35e044b3b5d643704d46a5.camel@suse.de>
Subject: Re: [RFC 10/13] iommu/arm-smmu-impl: Get rid of Marvell's
 implementation details
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, ardb@kernel.org,
        hch@infradead.org, narmstrong@baylibre.com, dwmw2@infradead.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com, arnd@arndb.de,
        will@kernel.org
Date:   Tue, 02 Mar 2021 15:06:58 +0100
In-Reply-To: <96b6c3e4-d9d3-270e-6d8e-7c826ae11827@arm.com>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
         <20210226140305.26356-11-nsaenzjulienne@suse.de>
         <96b6c3e4-d9d3-270e-6d8e-7c826ae11827@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/u4BP8h9tAaw6XMVTBaB"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/u4BP8h9tAaw6XMVTBaB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-03-02 at 11:40 +0000, Robin Murphy wrote:
> On 2021-02-26 14:03, Nicolas Saenz Julienne wrote:
> > arm-smmu can now deal with integrations on buses that don't support
> > 64bit MMIO accesses. No need to create a special case for that on
> > Marvell's integration.
>=20
> This breaks compatibility with existing DTs.

Yes. On top of that, I had a brief word with robh on the topic of DT
properties. I'm going to explore alternatives that don't depend on it.

Regards,
Nicolas



--=-/u4BP8h9tAaw6XMVTBaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmA+RoIACgkQlfZmHno8
x/4MCAf/TpAOjoNHKE4k6N89MnAltLVWF4UlHKUz/tIYugJ2GUImpgURvwxaudOX
nQvFM1vEiW60EjrG6P++8r5z+GGnkazSz4KOCfgMrog9XjRqNPghs1912LeSuBuW
w94CUzLy/cXbAHwb7Ll6c3rF47fIwoYvl+ii7+n858wTmIw9yLjxZrnwA61aEUha
wmqCaMgudz9OtfDOAxhG9wCuG+IAXCRFeWffG9+JrVhO1gOnJlESt0YExV71G/Kw
k+q5VwnH9VuTE+PrngfiNdLmhmW04idgTsVnPIOt1NZLZxJLXbryufQmL+jWOBxq
rSF6APg/ku0+yfHJZorjZlkJm8QTFw==
=iVwW
-----END PGP SIGNATURE-----

--=-/u4BP8h9tAaw6XMVTBaB--


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE55E346B00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhCWVY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:24:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:48442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233454AbhCWVYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:24:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EA89ACBF;
        Tue, 23 Mar 2021 21:24:05 +0000 (UTC)
Message-ID: <c1989e31501ccfb6e1350d467d4f26089bfcfb64.camel@suse.de>
Subject: Re: [PATCH 1/4] dt-bindings: mmc: iproc-sdhci: Convert to
 json-schema
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, f.fainelli@gmail.com,
        phil@raspberrypi.com, tim.gover@raspberrypi.com,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 22:24:03 +0100
In-Reply-To: <20210323210812.GA1318204@robh.at.kernel.org>
References: <20210322185816.27582-1-nsaenz@kernel.org>
         <20210322185816.27582-2-nsaenz@kernel.org>
         <0e98588e-65f1-6839-1fcd-584b480a31bd@broadcom.com>
         <20210323210812.GA1318204@robh.at.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Kqj0rgI1viL6xwIZYs2f"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Kqj0rgI1viL6xwIZYs2f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-03-23 at 15:08 -0600, Rob Herring wrote:
> On Mon, Mar 22, 2021 at 12:11:29PM -0700, Scott Branden wrote:
> > On 2021-03-22 11:58 a.m., Nicolas Saenz Julienne wrote:
> > > Convert the brcm,iproc-sdhci binding to DT schema format using json-s=
chema
> > >=20
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > > ---
> > > =C2=A0.../bindings/mmc/brcm,iproc-sdhci.yaml        | 58 ++++++++++++=
+++++++
> > > =C2=A0.../bindings/mmc/brcm,sdhci-iproc.txt         | 37 ------------
> > > =C2=A02 files changed, 58 insertions(+), 37 deletions(-)
> > > =C2=A0create mode 100644 Documentation/devicetree/bindings/mmc/brcm,i=
proc-sdhci.yaml
> > > =C2=A0delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,s=
dhci-iproc.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.y=
aml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > > new file mode 100644
> > > index 000000000000..19d84f3ef9e6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > > @@ -0,0 +1,58 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mmc/brcm,iproc-sdhci.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Broadcom IPROC SDHCI controller
> > > +
> > > +maintainers:
> > > +  - Nicolas Saenz Julienne <nsaenz@kernel.org>
> > This is already covered in the MAINTAINERS section via "N:	iproc".
> > M:	Ray Jui <ray.jui@broadcom.com>
> >=20
> > M:	Scott Branden <scott.branden@broadcom.com>
> >=20
> > M:	bcm-kernel-feedback-list@broadcom.com
>=20
> Maybe so, but still required here. The problem is there is no=20
> MAINTAINERS file in the DT only tree[1].

Well in that case, if Scott and Ray are OK with it I'll add them.

Regards,
Nicolas


--=-Kqj0rgI1viL6xwIZYs2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBaXHMACgkQlfZmHno8
x/5wwQgAh1Rp8sV61fH6qBqdWWSc8ujt7FJTqUPs0nk9fJPKewgyJrGU6ACpX6Iy
WhlBBN1lywQjMc/MiY1KxiwjepKN63R3Md4EiFepiAFG7YKG5YU76LsOj2hyQa8f
Rb6yv8GWFmXaEBtF2GuVF5touIJTc+Z6RwdsrXavqDVOT/pa0qypsVCG296oW3kL
xn92Gzs/1afX0wCL9+a+Bm9ePHUucb5aXMzkWvv8gV8x2O2yygmEsWKpHq0zd+fz
r71G8cYYDRZ3g7HfNmYfAoOHg+1yYUS3qJSI6cr0j9cx6pEyI8FcpJYGv9GnFb8M
d+eyS0f6Xz7lHbKcxBtRYxdVYF8WVw==
=i5nF
-----END PGP SIGNATURE-----

--=-Kqj0rgI1viL6xwIZYs2f--


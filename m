Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AB542BACA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhJMItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:49:10 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:25755 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234560AbhJMItI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634114825; x=1665650825;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=pAs91x88z+ajqtkXU1xcpob8J9OK5iJT+zTO2gT1iSo=;
  b=IeDsCLCaYBqRNw6a8nWeozpJt8XYOwQ7SBTjXp7oWPfUA/W8iv0vSYnC
   0yTpd7+bdejEDEbQuuo+Lz3/SrMy8UakHGWNb406h/9RhggKBhfmmJToH
   45Gi/qpAdZAarL2ISwgG87c0UIiBFEXGEqNjhvDu8mYn+7UBRm6PHogtK
   Gllcg7THZeg4+2XY9MYchvbdaRVNqg7y3KPgQh2qGJwZAsNpnYyzhxIWW
   yAXMfjyZ7J6/d8PplpxpIu82a+DiS3vntO1YoduWgyB/k7vNCQMi8lDCE
   bB8chlI/VJ6VoRetAUpHcvLNQV1uyJRqHhRTrDVY/Bz6kiP+oYUUHBPlf
   g==;
X-IronPort-AV: E=Sophos;i="5.85,370,1624312800"; 
   d="scan'208";a="20016647"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Oct 2021 10:47:04 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 13 Oct 2021 10:47:04 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 13 Oct 2021 10:47:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634114824; x=1665650824;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=pAs91x88z+ajqtkXU1xcpob8J9OK5iJT+zTO2gT1iSo=;
  b=pS+TCdEXTeT871X7A3AyV7GPgqdefmlmSrHkc64z0Mvm7/QX/5B83d8A
   LWpGD3Lf4VqfeRYqFMNHHd99uMYpP4L1syiu1VnvyTlOaxBrHcX7XkbUX
   srUAtyVyMR3VNUaAkThGn90YjgPFptlP4+ito4aqpxA/uhIfNwefSzfnA
   kyxwh87CpYRuU47/iRR7k8DU59gKjD6nEy3okd8j35Sun/v2+VneGxCXE
   WSuog9hygkQYnVij37xIMipsK0NJ7JWviZcrL5IKTX/Uz0045LcKWujn+
   btfR863ngaZ/tpn7b8yQLIXW13ffhzuTojdJbCOy7g6dO+wK58nxYrDNz
   A==;
X-IronPort-AV: E=Sophos;i="5.85,370,1624312800"; 
   d="scan'208";a="20016646"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2021 10:47:04 +0200
Received: from vtuxmail01.tq-net.de (localhost [127.0.0.1])
        by vtuxmail01.tq-net.de (Postfix) with ESMTP id 550EF280065;
        Wed, 13 Oct 2021 10:47:04 +0200 (CEST)
Received: by vtuxmail01 (kopano-spooler) with MAPI; Wed, 13 Oct 2021 10:47:04
 +0200
Subject: AW: (EXT) Re: [PATCH v2 1/2] dt-bindings: mtd: spi-nor: Add
 output-driver-strength property
From:   "Alexander Stein" <Alexander.Stein@ew.tq-group.com>
To:     "Michael Walle" <michael@walle.cc>
Cc:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Rob Herring" <robh@kernel.org>, "Pratyush Yadav" <p.yadav@ti.com>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        =?us-ascii?Q?linux-mtd=40lists=2Einfrad?= =?us-ascii?Q?ead=2Eorg?= 
        <linux-mtd@lists.infradead.org>,
        =?us-ascii?Q?devicetree=40vger=2Ekernel=2Eorg?= 
        <devicetree@vger.kernel.org>,
        =?us-ascii?Q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>
Date:   Wed, 13 Oct 2021 08:47:04 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.82
Message-Id: <kcEE.9geNR42QRKGTSoedF1sEfQ.ALRP5Q7A1wE@vtuxmail01.tq-net.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,


Am 2021-10-12 09:48, schrieb Michael Walle:
> Am 2021-10-12 08:17, schrieb Alexander Stein:
> > This property is for optimizing output voltage impedance and is
> > specific to each board. It overwrites the default set by the flash
> > device. Various flash devices support different impedances.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > Changes in v2:
> > * Updated the property description and the commit message accordingly
> >=20
> >  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > index ed590d7c6e37..4c3c506a8853 100644
> > --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > @@ -72,6 +72,14 @@ properties:
> >        be used on such systems, to denote the absence of a reliable=20
> > reset
> >        mechanism.
> >=20
> > +  output-driver-strength:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Output driver strength in ohms which optimizes the impedance at=20
> > Vcc/2
> > +      output voltage. This property overwrites the default set by the=20
> > flash
> > +      device. This is board specific and should be determined by the
> > +      manufacturer. Various flash devices support different=20
> > impedances.
>=20
> Mh, this seems to be very tailored to this flash chip. Eg. the "Vcc/2",=20
> is
> this something specific to this flash or is this some kind of common=20
> usage=3F

"Vcc/2" is taken from the datasheet description.

> For example, Winbond flashes specifies the output driver strength in=20
> percent.
> Settings are 25%, 50%, 75%, 100% there.
>=20
> I'd have to ask a hardware guy, if one could convert between these two
> representations of the driver strength.

Well, 100% must map to some actual value. Which then can be used to create
a discrete value table, which are then supported by the flash driver.
E.g. for Micron not every flash supports the same set of settings for
driver strength.
Macronix uses similar settings (values and bitmask), but in a different
register. But if some vendors have pretty much incompatible settings, it
might be feasible to provide vendor specific settings, e.g.
"micron,drive-strength =3D <45>" (for 45 Ohm) or "winbond,drive-strength =3D <100>"
(for 100%).

Best regards,
Alexander


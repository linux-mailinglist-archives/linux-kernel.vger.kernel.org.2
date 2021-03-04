Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E140E32D6F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhCDPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:43:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:34553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbhCDPnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614872529;
        bh=VPzS3XtaV2jscfNrk2ckzZDmYf8qCvklrXC7Xl+tdY8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gywqfanq34JcFUHmUTUM5Ro0P1rnbKzpGNn6vI0LfpnMU6YwBKe69gyqvsE75f8QJ
         G39vU1rekPsuBZ2B14i3mX9Tr8oPKFBVsYZdXVwRoMGJSShqMfb/LQidnZfiIWUMoD
         PniYjMpcOzBs3r6xg1JFTnUJtSQBm1xqfGXYW9es=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1lkSgz3l9N-012I0C; Thu, 04
 Mar 2021 16:42:09 +0100
Date:   Thu, 4 Mar 2021 16:42:07 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND 2/2] ARM: dts: Add board-specific compatible
 string to npcm750-evb devicetree
Message-ID: <YED/zzV5kb35k2vb@latitude>
References: <20210303154622.3018839-1-j.neuschaefer@gmx.net>
 <20210303154622.3018839-2-j.neuschaefer@gmx.net>
 <CAP6Zq1hwp+wJpbN496096q8izRRoU2Jg+OKugcSk+BcXWfME9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jauI0NPFqHr1tpGx"
Content-Disposition: inline
In-Reply-To: <CAP6Zq1hwp+wJpbN496096q8izRRoU2Jg+OKugcSk+BcXWfME9A@mail.gmail.com>
X-Provags-ID: V03:K1:dX47pp6N1kFMXQkOQn8hUd6L0alawbDNcXiMH+vHmgaY+iWFk6b
 e9jGTEDQojWW+hCidvV93nYTNvj530fL/7wFR89fsleK1WFtHenjtYOGBnSd51jStjCACoP
 D0XXKulJ3Nk4cOYuDb+MYWd9VFf98uc1IuWiwbh588VsLWUZLtmQ2epsJGSh1LpFMwA/38b
 vCHD1fhYpAd3+GOSM1pgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kybh/PBLxE8=:F+GhkkKJMtP974fNccgDbB
 8cCA0fw02PHEoRFdTpEluBQVb10wGYeAhSVFEhO7qwiLKa7nI9cFGy8rsMQzAeohmArT6z7qM
 XVWZXrbO1tmBUNgjBECZVooVVBKLG5yqdb8zrASV+haCL6AkGYFH4famf6vIWIZDtUsRnbJT0
 ilouS+WZ0uybclz35xhDXF0rMbQeHkzUvIdDmbRLLu7bDTz4fjDZa8P3ss5aBMUuNnJ9BpmSB
 vRLXm4+Km40nyuhiLieK9OEDgTEcStppTzGkBZdRnNJ184kK39ivHYCK63J2O/G4jM0n94vET
 eW3XFT0w1jMmErpKj+vqgw8dr2a7vWNvURxaxZVsm+g59zk4eKQXdf9YvGHjJNKkRRdKXxLCW
 4K+E4WQRECaTGQ/hHjpxHznRT8oZb2tIVxl0dsj7Wc5MlQbtrPnAvhT5pFPiwyNQdsxMfgVQv
 ztzWmUnnnqTQh5kg/IRbqQOg7uNcSPGTfr2zqfLQHSb4jHsSElba4NG2FH/pTroVXXTACbPIt
 o2dagxF2D6bSj17A91CmbZAS2Pw5FZpJwnz8MPwpSyA7Q6ljnuO1pdKpcQPVUuBqmbMTF5rQ0
 ft0h5WUljZVYotIfCjvP1IrR67YL1ASSCGjIxmJc6wbQIlUrztDWp8tRP9cXy7+55NbVs400Y
 79SRqB6zfqYmQ9D3WvM1HHzfzlS4tyRD8R+2vlTxSJEql6bxOSCuS+bHraGxjz5pEBHR3EQ9j
 BgcmxWxOQr2ulbAVyAd1abOsWPLo7GPle42ll+P5b0aXEPETYsfsAcsA6RF6UpKRzdEMNuZWl
 K1nN+9vVtfhxald5/9DtDoWQILWOFVX2482I5+qtGE+3qLEeIg0t6JgCR9vXNsha7j777thzu
 wGvjfefriR+xvtSrgTlQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jauI0NPFqHr1tpGx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 04, 2021 at 05:21:36PM +0200, Tomer Maimon wrote:
> Hi Jonathan,
>=20
> Thanks a lot for sending the patch,
>=20
> I think that when it related to the SoC EVB it can stay with the
> genral compatible name nuvoton,npcm750
>=20
> you can see it also in,
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/aspeed-as=
t2500-evb.dts#L8

To make the single compatible string match the DT binding, I'll have to
write the binding a little differently. I wrote it like this:

  compatible:
    oneOf:
      - description: NPCM750 based boards
        items:
          - enum:
              - nuvoton,npcm750-evb         # NPCM750 evaluation board
          - const: nuvoton,npcm750


I guess I could do something like this:

  compatible:
    oneOf:
      - description: NPCM750 development board
        const: nuvoton,npcm750


And later add this part, when needed:

      - description: NPCM750 based boards
        items:
          - enum:
              - vendor,foo-bar-bmc
          - const: nuvoton,npcm750


What do you think?


Thanks,
Jonathan Neusch=C3=A4fer


> On Wed, 3 Mar 2021 at 17:47, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.=
net>
> wrote:
[...]
> >  / {
> >         model =3D "Nuvoton npcm750 Development Board (Device Tree)";
> > -       compatible =3D "nuvoton,npcm750";
> > +       compatible =3D "nuvoton,npcm750-evb", "nuvoton,npcm750";

--jauI0NPFqHr1tpGx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBA/8UACgkQCDBEmo7z
X9uThA//c7olZ+Kqwd7U6t2kYlBKyTffPaezxpMzoBRm279l3m6K766RRCLYoeQL
wnAM/m6lvU3OXGiQwGxGyruFjDWxXo5p8UNFW+dI3JLzpkty7Jl7gu/EH7e/nWad
ftV4REogYqABKD8WL6LXk9cEf/8nnyVJX2PAlNjcNIGRcYusQ66Y75gQRm6JtBjN
QTImrmP1FySoS/Gea8CmKfFWYjSpccMYgG7aObHc+7SbtArJ6inBT15kbKba53k5
F047NDjZslQk/h+j0JxDWwef70KwtDT2S63DdJfTHUbW52Z6xuwd0xfSMk1rTun1
Gg1oBiQLXg5554IYB9d773X03uOeGJasT4et33obA0vdaDsYd6AAHcSMX80rZaiZ
fyRbFRjHM08Q6XZ+VayvUkxkN6of5ZpM+wBlGAPHJuAyXGfbCoHnHRLJd1c2XXjT
C5duUdTEF2pWGyBc/C4UrnTy8AUKenPDy4Zm0ZA2m6OvX1LQ2WF9pwynnDb1OZaT
a3HsfNDyMoU1I41MRs1QsXdiUOplX78PDS008incEHgryOdw/3g0JEYeMls442oU
pbleWoWzObbrroZ/fU0qe08zvY/ZG4XJcys+CIkpElyx3uDQhKzlpP6Z8RHprPyh
KXqF0RRUZtbvNeoS1sstiw+LGbDjRrdzdQ8gAHxRxiZNSuil66I=
=l5TV
-----END PGP SIGNATURE-----

--jauI0NPFqHr1tpGx--

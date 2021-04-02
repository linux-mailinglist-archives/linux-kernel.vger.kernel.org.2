Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9D352A08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 13:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhDBLCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 07:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBLCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 07:02:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA22C0613E6;
        Fri,  2 Apr 2021 04:02:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D5A0D1F467EE
Received: by earth.universe (Postfix, from userid 1000)
        id 9C8973C0C96; Fri,  2 Apr 2021 13:02:25 +0200 (CEST)
Date:   Fri, 2 Apr 2021 13:02:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     David Lechner <david@lechnology.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/32] MAINTAINERS: update lego,ev3-battery.yaml reference
Message-ID: <20210402110225.valyqjzsu7j3cbnl@earth.universe>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
 <be4e2f1c7f6b2cfbda4fc98ca2177b048a3ed575.1617279355.git.mchehab+huawei@kernel.org>
 <a727e107-a322-7720-3438-a165b3297a32@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mi6rf72afdrsl3eq"
Content-Disposition: inline
In-Reply-To: <a727e107-a322-7720-3438-a165b3297a32@lechnology.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mi6rf72afdrsl3eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 01, 2021 at 10:40:32AM -0500, David Lechner wrote:
> On 4/1/21 7:17 AM, Mauro Carvalho Chehab wrote:
> > Changeset 3004e581d92a ("dt-bindings: power: supply: lego-ev3-battery: =
Convert to DT schema format")
> > renamed: Documentation/devicetree/bindings/power/supply/lego_ev3_batter=
y.txt
> > to: Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yam=
l.
> >=20
> > Update its cross-reference accordingly.
> >=20
> > Fixes: 3004e581d92a ("dt-bindings: power: supply: lego-ev3-battery: Con=
vert to DT schema format")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
>=20
> Reviewed-by: David Lechner <david@lechnology.com>

Thanks, queued.

-- Sebastian

--mi6rf72afdrsl3eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBm+bYACgkQ2O7X88g7
+poDWw//Xw9KYuw6rNRmZIBIba9FR4HexCMziSwG865vKL0x78jJN+TqYShB2O83
lcLbgsbhs5EZrsRMfMCnP/NSPNO9BQE/XKDmySpUhH3maKcBDDqYIojANDbsTjuT
chjzImvnHtcFkNjpWOxUB9axLtX82n3ePzukbMCLPzgDCe1oB40fMppLntjnF/hb
gByzUIhsci/FNfTy0mF2iNsRGotNp1Suah/YyxqS8+MmEnDCd7cSmxEykyEoORSV
KTdw6cHRZxvDGThQlzi0ktbr4jwxShwzzvv+orqwD9nlFrW7Z+m9V6z4wjcsurTs
HBcxEe4eVHmhM+S02LNeiZfZypjXMOWitt5eQLx2Ymc8+x/ZlpoexS/yo36pyJCY
7TOz5t0UeZj4mxK5h+9skiYsNMd1Et2K1fJwm42SDH67qQQ24mpWPR/w6bcsW8aG
VRYL8DnzpLOOGt27xGCLfNAowwHIfJ0Qjg4vU0Sw5Wq7DD7lQJywETtERz6s/DSF
QLFz1uLpDhRP876OLegq4HQPTzn3HwSU6z7qz2kY0+yT7H7zxV6kJTcP3RmY/VwX
rh3MDkKVnADC1rC5kcMXXxSUYjOJsRurMWbP0A42T2QCBNL+2lnAcy0HTIgKvrMj
y23dBXDFfUjxvbxZg/pu3QzHbiJ+/LV4mrIaUP5Tjg5s0ylOVIk=
=EVmw
-----END PGP SIGNATURE-----

--mi6rf72afdrsl3eq--

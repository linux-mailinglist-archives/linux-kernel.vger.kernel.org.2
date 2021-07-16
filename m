Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DD43CB810
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbhGPNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:51:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34754 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGPNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:51:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5F3BA1F42328
Received: by earth.universe (Postfix, from userid 1000)
        id 1B33C3C0C97; Fri, 16 Jul 2021 15:48:43 +0200 (CEST)
Date:   Fri, 16 Jul 2021 15:48:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>, inux-pm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, ChiYuan Huang <cy_huang@richtek.com>,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v5 3/3] power: supply: mt6360_charger: add MT6360 charger
 support
Message-ID: <20210716134843.w7cl7ekkm3dm6pu5@earth.universe>
References: <20210528081300.64759-1-gene.chen.richtek@gmail.com>
 <20210528081300.64759-4-gene.chen.richtek@gmail.com>
 <62cdd2d18839e16686f35f0cf08080e2cb3b1768.camel@fi.rohmeurope.com>
 <CAE+NS36WuNkQYn8_UvsZaU5Equ9YH+Ya=c_j3cLNhuFnHT_J-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pohkpagvdzmtywuv"
Content-Disposition: inline
In-Reply-To: <CAE+NS36WuNkQYn8_UvsZaU5Equ9YH+Ya=c_j3cLNhuFnHT_J-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pohkpagvdzmtywuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 31, 2021 at 11:39:50AM +0800, Gene Chen wrote:
> > > +static int mt6360_charger_remove(struct platform_device *pdev)
> > > +{
> > > +     struct mt6360_chg_info *mci =3D platform_get_drvdata(pdev);
> > > +
> > > +     cancel_work_sync(&mci->chrdet_work);
> > > +
> > > +     return 0;
> > > +}
> >
> > Just as a note, devm_work_autocancel() should hopefully be included at
> > next cycle. Then you might be able to drop the .remove().
>=20
> ACK, I will replace it, thanks.

> > FWIW:
> > Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Did I miss a newer revision?

-- Sebastian

--pohkpagvdzmtywuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDxjjMACgkQ2O7X88g7
+ppTGQ/+KQXLPxlOLzYDzYM0l9Zir5lSyErWq9qNFYx2jYwWoF9CmsimzVIE79rV
N/PpiJrNBHYkuarViJpXEE6pYB3HQmZG9WptsZjO41/LZKUZzHHhc/rKLOb3qY2B
3KuNMq81o2aPQaxtH6xwEfNN/Y/3HSk7s6XJOckHAsr9Cot501tgyj8PKnQDGsmd
Gd5rfg/q5o6Sgd/f5pUQNt2SwOq9EdVEYNp+C5/v7wboyMK5dFy88Sr9KiU633Jo
x/7gSnDhAhSl4/izOgx9ESRC6sUnuAoBHDuiLm8QZq3nVRLOFhLZgsp2gpDuARBo
l1gGM2wIDa1mKEC6r5YRikaG3eJMqI01ds2i8r9b73X6gH5zhXo7qN/QJWlTeVdg
2LRkmzb/smxpDZczoDPEKZRkk976waecF9b3v1F1fOs7dMXSdP7cOdYUHIJXk7LB
TfbQ6nJL/I9pgOtP/E70N9aQ7vBUyiboy+B3h8GuIHMFkTYvrPeqwxSBvTYoNQI3
DIRmYOtzPELVvbfzNNCLXdpij24aVk2duDWYdhhgNp277gnJKoLLu3Ft07ptpyKT
RatfO50uBCy8+I5VJ624nQ+8WTBAYWquXaTUHu238/hgpXDnDhb5303qtCPtONq4
ZpZ+5hR3ZurhDjee/blJYsxpw1Ts4oMzx9PwodEaa+QAGroHudI=
=RwZv
-----END PGP SIGNATURE-----

--pohkpagvdzmtywuv--

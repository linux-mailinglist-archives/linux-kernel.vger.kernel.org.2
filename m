Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CAB375ECC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 04:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhEGCZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 22:25:24 -0400
Received: from m32-153.88.com ([43.250.32.153]:33958 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229909AbhEGCZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 22:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=QZ7ZfGWSXA+1jwZCyMowJFddDgqNQ4ceGg7hx
        FOFeSI=; b=IyA+/2+oDpNBgdIt+jxXGucieUehZGLs/MwnxlCmznYIbfCizD9nQ
        hrAxldO5JOka/k4WLnbNhhSCZLFC38JCF5yRVVp2k6+6ZXf/xazxaP9hYIc4oaz4
        xYMsVrMq4mYyf8vFuz4hR2ikiZ6HxTc84XOiE7EjC15jMQ8x59rCWE=
Received: from bobwxc.top (unknown [120.238.248.9])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCn9ljRpJRg6hQiAA--.21941S2;
        Fri, 07 May 2021 10:24:19 +0800 (CST)
Date:   Fri, 7 May 2021 10:24:17 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] docs/zh_CN: make reporting-bugs.rst obsolete
Message-ID: <20210507022416.GA20158@bobwxc.top>
References: <20210506083207.15705-1-wanjiabing@vivo.com>
 <CAMU9jJqDDggxSz83XiqrBG_-_B9j6HEVJ0KgGBLuMERZziGOuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <CAMU9jJqDDggxSz83XiqrBG_-_B9j6HEVJ0KgGBLuMERZziGOuw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgCn9ljRpJRg6hQiAA--.21941S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1kXw1UtF4xCw1kWF4xCrg_yoW5XFyfpF
        ykKFW8tFW7tFs8Kw1xGF4Iq3WIyay8uayrGr95Jw1rGr90yF4vqr4qyrZ0gas3ZryfAFyU
        X3yUKF98Cw12krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgvb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02F40EFcxC0VAKzVAqx4xG6I80
        ewAv7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
        Ja73UjIFyTuYvj4RRbyZUUUUU
X-Originating-IP: [120.238.248.9]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 07, 2021 at 09:56:58AM +0800, teng sterling wrote:
> Hi Jiabing
>=20
> CC bobwxc@email.cn
>=20
> Wan Jiabing <wanjiabing@vivo.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:33=E5=86=99=E9=81=93=EF=BC=9A
> >
> > In commit d2ce285378b09 ("docs: make reporting-issues.rst official
> > and delete reporting-bugs.rst"),reporting-bugs.rst was deleted and
> > replaced by reporting-issues.rst.
> >
> > In commit da514157c4f06 ("docs: make reporting-bugs.rst obsolete"),
> > it made reporting-bugs.rst obsolete in docs.
> >
> > Fix it in docs/zh_CN to make reporting-bugs.rst obsolete.
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> > ---
> >  Documentation/translations/zh_CN/SecurityBugs | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)

This is a translation left over from history.
We have a new one as=20
    Documentation/translations/zh_CN/admin-guide/security-bugs.rst

Maybe better to drop it.

Thanks,

    Wu X.C.


> >
> > diff --git a/Documentation/translations/zh_CN/SecurityBugs b/Documentat=
ion/translations/zh_CN/SecurityBugs
> > index 2d0fffd122ce..adf4042ba7f8 100644
> > --- a/Documentation/translations/zh_CN/SecurityBugs
> > +++ b/Documentation/translations/zh_CN/SecurityBugs
> > @@ -31,9 +31,9 @@ linux=E5=86=85=E6=A0=B8=E5=AE=89=E5=85=A8=E5=9B=A2=E9=
=98=9F=E5=8F=AF=E4=BB=A5=E9=80=9A=E8=BF=87email<security@kernel.org>=E6=9D=
=A5=E8=81=94=E7=B3=BB=E3=80=82=E8=BF=99=E6=98=AF
> >  =E4=B8=80=E7=BB=84=E7=8B=AC=E7=AB=8B=E7=9A=84=E5=AE=89=E5=85=A8=E5=B7=
=A5=E4=BD=9C=E4=BA=BA=E5=91=98=EF=BC=8C=E5=8F=AF=E4=BB=A5=E5=B8=AE=E5=8A=A9=
=E6=94=B9=E5=96=84=E6=BC=8F=E6=B4=9E=E6=8A=A5=E5=91=8A=E5=B9=B6=E4=B8=94=E5=
=85=AC=E5=B8=83=E5=92=8C=E5=8F=96=E6=B6=88=E4=B8=80=E4=B8=AA=E4=BF=AE=E5=A4=
=8D=E3=80=82=E5=AE=89
> >  =E5=85=A8=E5=9B=A2=E9=98=9F=E6=9C=89=E5=8F=AF=E8=83=BD=E4=BC=9A=E4=BB=
=8E=E9=83=A8=E5=88=86=E7=9A=84=E7=BB=B4=E6=8A=A4=E8=80=85=E9=82=A3=E9=87=8C=
=E5=BC=95=E8=BF=9B=E9=A2=9D=E5=A4=96=E7=9A=84=E5=B8=AE=E5=8A=A9=E6=9D=A5=E4=
=BA=86=E8=A7=A3=E5=B9=B6=E4=B8=94=E4=BF=AE=E5=A4=8D=E5=AE=89=E5=85=A8=E6=BC=
=8F=E6=B4=9E=E3=80=82
> >  =E5=BD=93=E9=81=87=E5=88=B0=E4=BB=BB=E4=BD=95=E6=BC=8F=E6=B4=9E=EF=BC=
=8C=E6=89=80=E8=83=BD=E6=8F=90=E4=BE=9B=E7=9A=84=E4=BF=A1=E6=81=AF=E8=B6=8A=
=E5=A4=9A=E5=B0=B1=E8=B6=8A=E8=83=BD=E8=AF=8A=E6=96=AD=E5=92=8C=E4=BF=AE=E5=
=A4=8D=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=B8=8D=E6=B8=85=E6=A5=9A=E4=BB=
=80=E4=B9=88
> > -=E6=98=AF=E6=9C=89=E5=B8=AE=E5=8A=A9=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=
=8C=E9=82=A3=E5=B0=B1=E8=AF=B7=E9=87=8D=E6=B8=A9=E4=B8=80=E4=B8=8Badmin-gui=
de/reporting-bugs.rst=E6=96=87=E4=BB=B6=E4=B8=AD=E7=9A=84=E6=A6=82=E8=BF=B0=
=E8=BF=87=E7=A8=8B=E3=80=82=E4=BB=BB
> >
> > -=E4=BD=95=E6=94=BB=E5=87=BB=E6=80=A7=E7=9A=84=E4=BB=A3=E7=A0=81=E9=83=
=BD=E6=98=AF=E9=9D=9E=E5=B8=B8=E6=9C=89=E7=94=A8=E7=9A=84=EF=BC=8C=E6=9C=AA=
=E7=BB=8F=E6=8A=A5=E5=91=8A=E8=80=85=E7=9A=84=E5=90=8C=E6=84=8F=E4=B8=8D=E4=
=BC=9A=E8=A2=AB=E5=8F=96=E6=B6=88=EF=BC=8C=E9=99=A4=E9=9D=9E=E5=AE=83=E5=B7=
=B2=E7=BB=8F
> > -=E8=A2=AB=E5=85=AC=E5=B8=83=E4=BA=8E=E4=BC=97=E3=80=82
> > +=E6=98=AF=E6=9C=89=E5=B8=AE=E5=8A=A9=E7=9A=84=E4=BF=A1=E6=81=AF=EF=BC=
=8C=E9=82=A3=E5=B0=B1=E8=AF=B7=E9=87=8D=E6=B8=A9=E4=B8=80=E4=B8=8Badmin-gui=
de/reporting-issues.rst=E6=96=87=E4=BB=B6=E4=B8=AD=E7=9A=84
>=20
>=20
>  =E9=82=A3=E5=B0=B1=E8=AF=B7=E9=87=8D=E6=B8=A9=E4=B8=80=E4=B8=8Badmin-gui=
de/reporting-issues.rst=EF=BC=88=E4=B8=AD=E6=96=87=EF=BC=9Atranslations/zh_=
CN/admin-guide/reporting-issues.rst=EF=BC=89
> =E6=96=87=E4=BB=B6=E4=B8=AD=E7=9A=84=E6=A6=82=E8=BF=B0=E8=BF=87=E7=A8=8B
> The "reporting-issues.rst" has been translated into Chinese. For the
> convenience of developers who prefer Chinese, I suggest including a
> link to the Chinese documentation:-)
> >
> > +=E6=A6=82=E8=BF=B0=E8=BF=87=E7=A8=8B=E3=80=82=E4=BB=BB=E4=BD=95=E6=94=
=BB=E5=87=BB=E6=80=A7=E7=9A=84=E4=BB=A3=E7=A0=81=E9=83=BD=E6=98=AF=E9=9D=9E=
=E5=B8=B8=E6=9C=89=E7=94=A8=E7=9A=84=EF=BC=8C=E6=9C=AA=E7=BB=8F=E6=8A=A5=E5=
=91=8A=E8=80=85=E7=9A=84=E5=90=8C=E6=84=8F=E4=B8=8D=E4=BC=9A=E8=A2=AB=E5=8F=
=96=E6=B6=88=EF=BC=8C
> > +=E9=99=A4=E9=9D=9E=E5=AE=83=E5=B7=B2=E7=BB=8F=E8=A2=AB=E5=85=AC=E5=B8=
=83=E4=BA=8E=E4=BC=97=E3=80=82
> >
> >  2) =E5=85=AC=E5=BC=80
>=20
>=20
> Thanks=EF=BC=8C
>=20
> Yanteng Si
> >
> >
> > --
> > 2.25.1
> >

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmCUpM0ACgkQtlsoEiKC
sIUxoAv/bAWgTeeAII0BIcDlPjLEGnplKdABiR1WjEkzMDchEUrpBila5kwRV7GX
lQrgeMs1YAFhBlQcsm/opcABa00P6R4GoCygnyjYDOz3o4rxFOzvNOf2VgMFO676
uCv0IKceZDaCVgZdavyhzA+fujvAK+QvWkgzgW0ZfTR3O9pJbOlBylVjWnLb7jZB
LpHx+kFFagLiMDmNS2n+3KtDf41xllFjtIkg3fraLjnw24zMesAkQ9tbpx8qk+yf
wb3YQzWd9MRaosR+Y6L6FJAPDz+VS+LViuQezsz4MC0YY/rQaWojHZyHMqzXR2TZ
broASgocwimeZ6b/Rlyj8GcMdWEc+bzjVQwQ/9YYJULjLvicTIVAYFklZj2ZfvQU
zo1FeuuxINU48qtb2innROKezrqkiX1I91RAkGF0xfDI613KTnlQkCyN9+/mWpVa
39JyuFWalPcmaVp+xf8DmvW/WufpxaIB1M2yzNdXVwIKZhNBPlrZqf8Nb/op3X3P
exhzKA4n
=Ne/R
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


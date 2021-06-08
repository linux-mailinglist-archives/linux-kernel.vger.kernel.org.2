Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92CC39ECC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFHDLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:11:08 -0400
Received: from [43.250.32.171] ([43.250.32.171]:62879 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230351AbhFHDLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=T3s/8Iy3mLupaJcx7wXM/C2mxKpeuVOFkYxMq
        ppqg1Y=; b=W06ZzkqaMS5aPyqDP806xSjFpeXwCOjeQQQ9cwgHF1P2joifExYu0
        d4zMDk9w7tzgZcGJeqhEAxZeX2Ne5xbosZfPYVLI7VOHMsrymvYFzbciIEZwrAAa
        PbEVdvAMApefNBWZemFbT9fH7G7xzbuOLlk5efIULi+HRbMa2TpvhQ=
Received: from bobwxc.top (unknown [120.238.248.220])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgAnwjVP375gzvMDAA--.9902S2;
        Tue, 08 Jun 2021 11:09:05 +0800 (CST)
Date:   Tue, 8 Jun 2021 11:09:03 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Hu Haowen <src.res@email.cn>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH] docs/zh_CN: add a translation for index
Message-ID: <20210608030903.GB3207@bobwxc.top>
References: <20210607093433.39160-1-src.res@email.cn>
 <CAMU9jJrkxTUgS0P3tpr-Udw9WqUgqCJ2D0G+ja5UX=B+4DRw7g@mail.gmail.com>
 <CAMU9jJq5ykLjZK2NFo98FxuKDmJnSCcUGn2-N53ioX9nspBSLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <CAMU9jJq5ykLjZK2NFo98FxuKDmJnSCcUGn2-N53ioX9nspBSLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgAnwjVP375gzvMDAA--.9902S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xuFWrZr4ktr4UXFWrXwb_yoW8uFykpF
        4DKFWfK3WDAF17Crs2gw1xGF45t3WxGw4Yqr1Ut3sagrs0yr9xtr43tr909ryxXryxAFyD
        trWayFZ5C34ayFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        ASzI0EjI02j7AqF2xKxwAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I64
        8v4I1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1U
        Jr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUxIJPDUUUU
X-Originating-IP: [120.238.248.220]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 07, 2021 at 09:43:37PM +0800, teng sterling wrote:
> CC Xiangcheng
>=20
> teng sterling <sterlingteng@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=887=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:40=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > CC siyanteng@loongson.cn
> > Hu Haowen <src.res@email.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=887=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:37=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > The original file has added a former intro in commit b51208d41c6a4e7f=
c2f0
> > > ("docs: Tweak the top-level Sphinx page") and hence update the Chinese
> > > version for it.
> > >
> > > Signed-off-by: Hu Haowen <src.res@email.cn>
> > > ---
> > >  Documentation/translations/zh_CN/index.rst | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/translations/zh_CN/index.rst b/Documentati=
on/translations/zh_CN/index.rst
> > > index 1f953d3439a5..003126abc0d6 100644
> > > --- a/Documentation/translations/zh_CN/index.rst
> > > +++ b/Documentation/translations/zh_CN/index.rst
> > > @@ -17,6 +17,11 @@
> > >     **=E7=BF=BB=E8=AF=91=E8=AE=A1=E5=88=92:**
> > >     =E5=86=85=E6=A0=B8=E4=B8=AD=E6=96=87=E6=96=87=E6=A1=A3=E6=AC=A2=
=E8=BF=8E=E4=BB=BB=E4=BD=95=E7=BF=BB=E8=AF=91=E6=8A=95=E7=A8=BF=EF=BC=8C=E7=
=89=B9=E5=88=AB=E6=98=AF=E5=85=B3=E4=BA=8E=E5=86=85=E6=A0=B8=E7=94=A8=E6=88=
=B7=E5=92=8C=E7=AE=A1=E7=90=86=E5=91=98=E6=8C=87=E5=8D=97=E9=83=A8=E5=88=86=
=E3=80=82
> > >
> > > +=E8=BF=99=E6=98=AF=E5=86=85=E6=A0=B8=E6=96=87=E6=A1=A3=E6=A0=91=E7=
=9A=84=E9=A1=B6=E7=BA=A7=E7=9B=AE=E5=BD=95=E3=80=82=E5=86=85=E6=A0=B8=E6=96=
=87=E6=A1=A3=EF=BC=8C=E5=B0=B1=E5=83=8F=E5=86=85=E6=A0=B8=E6=9C=AC=E8=BA=AB=
=E4=B8=80=E6=A0=B7=EF=BC=8C=E5=9C=A8=E5=BE=88=E5=A4=A7=E7=A8=8B=E5=BA=A6=E4=
=B8=8A=E6=98=AF=E4=B8=80=E9=A1=B9=E6=AD=A3
> > how about:
> >
> > =E8=BF=99=E6=98=AF=E4=B8=AD=E6=96=87=E5=86=85=E6=A0=B8=E6=96=87=E6=A1=
=A3=E6=A0=91=E7=9A=84=E9=A1=B6=E7=BA=A7=E7=9B=AE=E5=BD=95=E3=80=82
> > > +=E5=9C=A8=E8=BF=9B=E8=A1=8C=E7=9A=84=E5=B7=A5=E4=BD=9C=EF=BC=9B=E5=
=BD=93=E6=88=91=E4=BB=AC=E5=8A=AA=E5=8A=9B=E5=B0=86=E8=AE=B8=E5=A4=9A=E5=88=
=86=E6=95=A3=E7=9A=84=E6=96=87=E4=BB=B6=E6=95=B4=E5=90=88=E6=88=90=E4=B8=80=
=E4=B8=AA=E8=BF=9E=E8=B4=AF=E7=9A=84=E6=95=B4=E4=BD=93=E6=97=B6=E5=B0=A4=E5=
=85=B6=E5=A6=82=E6=AD=A4=E3=80=82=E5=8F=A6
> > > +=E5=A4=96=EF=BC=8C=E9=9A=8F=E6=97=B6=E6=AC=A2=E8=BF=8E=E6=82=A8=E5=
=AF=B9=E5=86=85=E6=A0=B8=E6=96=87=E6=A1=A3=E8=BF=9B=E8=A1=8C=E6=94=B9=E8=BF=
=9B=EF=BC=9B=E5=A6=82=E6=9E=9C=E6=82=A8=E6=83=B3=E6=8F=90=E4=BE=9B=E5=B8=AE=
=E5=8A=A9=EF=BC=8C=E8=AF=B7=E5=8A=A0=E5=85=A5vger.kernel.org
> > =E4=B8=AD=E6=96=87=E5=86=85=E6=A0=B8=E6=96=87=E6=A1=A3=E8=BF=9B=E8=A1=
=8C=E6=94=B9=E8=BF=9B=EF=BC=9B
> > > +=E4=B8=8A=E7=9A=84linux-doc=E9=82=AE=E4=BB=B6=E5=88=97=E8=A1=A8=E3=
=80=82
> > =E4=B8=8A=E7=9A=84linux-doc=E9=82=AE=E4=BB=B6=E5=88=97=E8=A1=A8=EF=BC=
=8C=E5=85=88=E6=94=B9=E8=BF=9B=E5=8E=9F=E5=A7=8B=E8=8B=B1=E6=96=87=E6=96=87=
=E6=A1=A3=EF=BC=8C=E5=86=8D=E5=B0=86=E5=85=B6=E7=BF=BB=E8=AF=91=E4=B8=BA=E4=
=B8=AD=E6=96=87=E5=90=8E=EF=BC=8C=E6=9B=B4=E6=96=B0=E7=9B=B8=E5=BA=94=E7=9A=
=84=E4=B8=AD=E6=96=87=E6=96=87=E6=A1=A3=E3=80=82
> > > +
> > >  =E8=AE=B8=E5=8F=AF=E8=AF=81=E6=96=87=E6=A1=A3
> > >  ----------
> > >
> > > --
> > > 2.25.1
> > >
> > BTW, I think these are similar to "disclaimer-zh_CN", but not as good
> > as the latter.
> >
> > Alex and Xiangcheng, what do you think?
> >
> > Thanks,
> > Yanteng

I think,

Use =E4=B8=AD=E6=96=87=E5=86=85=E6=A0=B8=E6=96=87=E6=A1=A3=E6=A0=91

And then

=2E. include:: ./disclaimer-zh_CN.rst

Thanks,
	Wu X.C.

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmC+304ACgkQtlsoEiKC
sIVe+Qv/fav8gef/+hQ/wwQsuPr1GJmF8QhX30/3BWlEWm2AI5uabn4AQfUKKujs
Aue4pXn6nGMYFEdHptdYtYCJC4uRdQW8VRI4TC0gX3dxXrVIw0H/hfFteXx9gdWi
CnfcmYxel7P6kIwkNgHeTomuYNGtaLJsmk51mG6l7x8dwZs7prTabcLDlR/VRnbG
j4buouXGMJMbZPLT+t/LpQXopkanQos07Cf3g7NZutPJIRQ81zhrJsfE6qxMjUkY
Fjv1l69ygEZ84ZduR+Bfg2eLwszDz+YIXVs9YDNFtOH6hDz90bu+yobdz39dXOfK
gegZPQjdWCf/YfyDuB5KW4dALTfFWNUogeNHSLdL+f38oBMkmLtEZBIQTekwG1PT
n+DSBibesa9WmaIL36q3+gEF1IOi2cO1rd2+XRN3Ki8EVkdVrxtYKCzf94c8BE67
vm3ZJDQPgv9VCnxQMJbt5d2nWuMTZlO2bo3AzXgkJi2xZO+BGMsN+KUAUZ9vU7mG
zufA0KOz
=nTpY
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--


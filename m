Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B166039ECD1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFHDQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:16:10 -0400
Received: from m32-153.88.com ([43.250.32.153]:5824 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230237AbhFHDQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=fxzUMVV0EPeh/zmL3o0HanjEphz9QxxNjXiEy
        gfeBMs=; b=VDKO3rIroIXL3Kqm+MFkHgygLTmAX0I1QReg8ga8296npuF6mW8WO
        taXO26HhOVrp6hyAqHEL/eMsApFkzOTgQYn6A06yeXPv6fklrbye1QBbkkUTgYsD
        QzWZr/do+XbLLTABl0C7FN4O6eKN60CiUUoBfhyOkh1MORO3Ky2y9Q=
Received: from bobwxc.top (unknown [120.238.248.220])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgB3Tv1+4L5gENUEAA--.12609S2;
        Tue, 08 Jun 2021 11:14:07 +0800 (CST)
Date:   Tue, 8 Jun 2021 11:14:05 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Hu Haowen <src.res@email.cn>
Cc:     alexs@kernel.org, corbet@lwn.net, bernard@vivo.com,
        maskray@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs/zh_CN: create new translations for
 zh_CN/dev-tools/testing-overview
Message-ID: <20210608031405.GC3207@bobwxc.top>
References: <20210605120504.40246-1-src.res@email.cn>
 <20210608024439.GA3207@bobwxc.top>
 <01cd7a95-8b91-ad2f-ad94-80b06c1fe5c0@email.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <01cd7a95-8b91-ad2f-ad94-80b06c1fe5c0@email.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgB3Tv1+4L5gENUEAA--.12609S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1xGr17uw4rJFy8JFWkJFb_yoW8Wr1xp3
        yv93ZxJF4jgry2yrZak3W0qrnYkwnYqry8X3W3tFyUWrWvyFnIkry7trZFgwn09392yFyF
        vF42gr9rC34rAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        ASzI0EjI02j7AqF2xKxwAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I64
        8v4I1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1U
        Jr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUxIJPDUUUU
X-Originating-IP: [120.238.248.220]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2021 at 10:53:20AM +0800, Hu Haowen wrote:
>=20
> =E5=9C=A8 2021/6/8 =E4=B8=8A=E5=8D=8810:44, Wu X.C. =E5=86=99=E9=81=93:
> > On Sat, Jun 05, 2021 at 08:05:04PM +0800, Hu Haowen wrote:
> > > Create new translations for dev-tools/testing-overview.rst and link it
> > > to dev-tools/index.rst with TODOList modifications.
> > >=20
> > > Signed-off-by: Hu Haowen <src.res@email.cn>
> > > ---
> > >   .../translations/zh_CN/dev-tools/index.rst    |   5 +
> > >   .../zh_CN/dev-tools/testing-overview.rst      | 110 +++++++++++++++=
+++
> > [...]
> > > +
> > > +=E4=BB=A3=E7=A0=81=E8=A6=86=E7=9B=96=E7=8E=87=E5=B7=A5=E5=85=B7
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +=E6=94=AF=E6=8C=81=E4=B8=A4=E7=A7=8D=E4=B8=8D=E5=90=8C=E4=BB=A3=E7=
=A0=81=E4=B9=8B=E9=97=B4=E7=9A=84=E8=A6=86=E7=9B=96=E7=8E=87=E6=B5=8B=E9=87=
=8F=E5=B7=A5=E5=85=B7=E3=80=82=E5=AE=83=E4=BB=AC=E5=8F=AF=E4=BB=A5=E7=94=A8=
=E6=9D=A5=E9=AA=8C=E8=AF=81=E4=B8=80=E9=A1=B9=E6=B5=8B=E8=AF=95=E6=89=A7=E8=
=A1=8C=E7=9A=84
> > Linux=E5=86=85=E6=A0=B8=E6=94=AF=E6=8C=81=E4=B8=A4=E7=A7=8D=E4=B8=8D=E5=
=90=8C=E7=9A=84=E4=BB=A3=E7=A0=81=E8=A6=86=E7=9B=96=E7=8E=87=E6=B5=8B=E8=AF=
=95=E5=B7=A5=E5=85=B7=E3=80=82
>=20
>=20
> But you mentioned that this sentence should be
> "=E6=94=AF=E6=8C=81=E4=B8=A4=E7=A7=8D=E4=B8=8D=E5=90=8C=E4=BB=A3=E7=A0=81=
=E4=B9=8B=E9=97=B4=E7=9A=84=E8=A6=86=E7=9B=96=E7=8E=87=E6=B5=8B=E9=87=8F=E5=
=B7=A5=E5=85=B7" in
> the previous email. Should I take this version or the previous version?
>=20

Actually was "=E6=94=AF=E6=8C=81=E4=B8=A4=E7=A7=8D=E4=B8=8D=E5=90=8C=E7=9A=
=84=E4=BB=A3=E7=A0=81=E8=A6=86=E7=9B=96=E7=8E=87=E6=B5=8B=E8=AF=95=E5=B7=A5=
=E5=85=B7=E3=80=82"
<https://lore.kernel.org/linux-doc/20210523140332.GA1097@bobwxc.top/>

I forgot the head and you added something in the middle :)

Please use the new version.

Thanks,
	Wu

>=20
> Thx,
>=20
> Hu Haowen
>=20
>=20
> >=20
> > > +=E7=A1=AE=E5=88=87=E5=87=BD=E6=95=B0=E6=88=96=E4=BB=A3=E7=A0=81=E8=
=A1=8C=E3=80=82=E8=BF=99=E6=9C=89=E5=8A=A9=E4=BA=8E=E5=86=B3=E5=AE=9A=E5=86=
=85=E6=A0=B8=E8=A2=AB=E6=B5=8B=E8=AF=95=E4=BA=86=E5=A4=9A=E5=B0=91=EF=BC=8C=
=E6=88=96=E7=94=A8=E6=9D=A5=E6=9F=A5=E6=89=BE=E5=90=88=E9=80=82=E7=9A=84=E6=
=B5=8B=E8=AF=95
> > > +=E4=B8=AD=E6=B2=A1=E6=9C=89=E8=A6=86=E7=9B=96=E5=88=B0=E7=9A=84=E6=
=9E=81=E7=AB=AF=E6=83=85=E5=86=B5=E3=80=82
> > > +
> > OK, good job!
> >=20
> > Just need to fix a small problem, after that
> >=20
> > Reviewed-by: Wu XiangCheng <bobwxc@email.cn>
> > Thanks,
> > 	Wu X.C.

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmC+4H0ACgkQtlsoEiKC
sIV2Tgv9EnbkMJpnj4dK4miRataUqjBTt7FVUGlsCvpTcgxnAu/Oqe7wivNGBYnU
aAm0lzzPN+gLNhRVUQCfcBPODwq7uyhKzbJpD4S4mJf/LE0KfUwiHYl6+fV4+V7R
erjDxKeTW8dxy1ajFMzR57qrE7zYdc165UdQ7BmqyE49aLnUK0qnbGKFsbtxeCTQ
g0eWt3Bma4ftXO62PkdDKyE/wcCVeVyL90V7cl+MjF9Wu6gwhg/2Td1djsTBZWYg
xk9wctglnB94SKTMBwY1NEHsOY1Pup25X5g2LPoTHz6u0DMSQp9qiyw7rUEv1siy
oFRhNjT7W+2BbDN3gSvyLYn2O03fWogWnca5ENYPXl6cNNFwfqDOY300Q3Aoe9WW
0gbiPTWJMx3XxFUhjUg8Atdg2ZgjBI0KakZSo0/Iga9vilB8ne76Q+eEAK4lN9li
2Ke/kcVdo3MfpwZ2Ynkjgx0QLagNXrVSL6K7IpSu5LAKN+KrUWz/f/6h3cSquRfx
wuKxG8rA
=fX3L
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--


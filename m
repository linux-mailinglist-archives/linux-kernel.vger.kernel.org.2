Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04413601A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhDOFjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:39:05 -0400
Received: from [43.250.32.171] ([43.250.32.171]:13616 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229560AbhDOFjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=e+5AxPE7Oi4vd2SZdO2Iljr7Knf4PsxLD9AgT
        ERDiCw=; b=fF7pniN7Gn4b8I03X2lhuT8y9qpz+0FCA7iFix2gp5U5s1ofExTMG
        bqLNIpqnB0n+CwOYgRA6s2L6c6sIq4iSF3tpS6UZvRGCg7KQjnjTsG05SgPAB13y
        blYG2mWiNZLB5eQ9t/JQFzL7P+KeL9tDuKsjHRpzoG8CECFuEzQ6Gw=
Received: from bobwxc.top (unknown [120.238.248.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgB36tBM0XdgHZddAA--.16109S2;
        Thu, 15 Apr 2021 13:38:23 +0800 (CST)
Date:   Thu, 15 Apr 2021 13:38:20 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Fangrui Song <maskray@google.com>
Cc:     Alex Shi <seakeel@gmail.com>, Alex Shi <alexs@kernel.org>,
        Bernard Zhao <bernard@vivo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        YanTeng Si <sterlingteng@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v5] docs/zh_CN: add translations in zh_CN/dev-tools/gcov
Message-ID: <20210415053820.GA26262@bobwxc.top>
References: <20210414082316.15160-1-bernard@vivo.com>
 <20210414132127.GA13306@bobwxc.top>
 <69e5d111-a439-7000-ad5e-4e0f4dabe29f@gmail.com>
 <20210415050755.onbtp7ftzawftrud@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20210415050755.onbtp7ftzawftrud@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgB36tBM0XdgHZddAA--.16109S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1xKw15uryxJr4DXFyxZrb_yoW5tFy3pF
        srGayxKF48KrWUCryI9w10q39Fyay5K3W2qFy8Jryjqrs09F4Skr12gr18Wasxu34DAryq
        y3W7AFnakw15AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02F40EFcxC0VAKzVAqx4xG6I80
        ewAv7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
        IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_
        Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj4RRbyZUUUUU
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2021 at 10:07:55PM -0700, Fangrui Song wrote:
> Reviewed-by: Fangrui Song <maskray@google.com>
>=20
> Inlined some suggestions.

Thanks for your review!

>=20
> On 2021-04-14, Alex Shi wrote:
> > Reviewed-by: Alex Shi <alexs@kernel.org>
> >=20
> > On 2021/4/14 =E4=B8=8B=E5=8D=889:21, Wu XiangCheng wrote:
> > > From: Bernard Zhao <bernard@vivo.com>
> > >=20
> > > Add new zh translations
> > > * zh_CN/dev-tools/gcov.rst
> > > * zh_CN/dev-tools/index.rst
> > > and link them to zh_CN/index.rst
> > >=20
> > > Signed-off-by: Bernard Zhao <bernard@vivo.com>
> > > Reviewed-by: Wu XiangCheng <bobwxc@email.cn>
> > > Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
> > > ---
> > > +
[...]
> > > +=E5=9C=A8Linux=E5=86=85=E6=A0=B8=E9=87=8C=E4=BD=BF=E7=94=A8gcov=E5=
=81=9A=E4=BB=A3=E7=A0=81=E8=A6=86=E7=9B=96=E7=8E=87=E6=A3=80=E6=9F=A5
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +gcov=E6=98=AFlinux=E4=B8=AD=E5=B7=B2=E7=BB=8F=E9=9B=86=E6=88=90=E7=
=9A=84=E4=B8=80=E4=B8=AA=E5=88=86=E6=9E=90=E6=A8=A1=E5=9D=97=EF=BC=8C=E8=AF=
=A5=E6=A8=A1=E5=9D=97=E5=9C=A8=E5=86=85=E6=A0=B8=E4=B8=AD=E5=AF=B9GCC=E7=9A=
=84=E4=BB=A3=E7=A0=81=E8=A6=86=E7=9B=96=E7=8E=87=E7=BB=9F
>=20
> instrumentation =E4=B8=80=E8=88=AC=E8=AF=91=E4=BD=9C =E6=8F=92=E6=A1=A9=
=EF=BC=8C=E8=80=8C=E9=9D=9E =E5=88=86=E6=9E=90=E3=80=82

Have rewrited this paragraph.
Here is "gcov profiling kernel"=EF=BC=8Cgcov=E5=88=86=E6=9E=90=E6=A0=B8=E5=
=BF=83

>=20
> > > +=E8=AE=A1=E6=8F=90=E4=BE=9B=E4=BA=86=E6=94=AF=E6=8C=81=E3=80=82
> > > +linux=E5=86=85=E6=A0=B8=E8=BF=90=E8=A1=8C=E6=97=B6=E7=9A=84=E4=BB=A3=
=E7=A0=81=E8=A6=86=E7=9B=96=E7=8E=87=E6=95=B0=E6=8D=AE=E4=BC=9A=E4=BB=A5gco=
v=E5=85=BC=E5=AE=B9=E7=9A=84=E6=A0=BC=E5=BC=8F=E5=AD=98=E5=82=A8=E5=9C=A8de=
bug-fs=E4=B8=AD=EF=BC=8C=E5=8F=AF
>=20
> =E4=B8=93=E6=9C=89=E5=90=8D=E8=AF=8D Linux =E5=BA=94=E5=A4=A7=E5=86=99=E3=
=80=82

Done.

>=20
> > > +=E4=BB=A5=E9=80=9A=E8=BF=87gcov=E7=9A=84 ``-o`` =E9=80=89=E9=A1=B9=
=EF=BC=88=E5=A6=82=E4=B8=8B=E7=A4=BA=E4=BE=8B=EF=BC=89=E8=8E=B7=E5=BE=97=E6=
=8C=87=E5=AE=9A=E6=96=87=E4=BB=B6=E7=9A=84=E4=BB=A3=E7=A0=81=E8=BF=90=E8=A1=
=8C=E8=A6=86=E7=9B=96=E7=8E=87=E7=BB=9F=E8=AE=A1=E6=95=B0=E6=8D=AE
> > > +=EF=BC=88=E9=9C=80=E8=A6=81=E8=B7=B3=E8=BD=AC=E5=88=B0=E5=86=85=E6=
=A0=B8=E7=BC=96=E8=AF=91=E8=B7=AF=E5=BE=84=E4=B8=8B=E5=B9=B6=E4=B8=94=E8=A6=
=81=E6=9C=89root=E6=9D=83=E9=99=90=EF=BC=89::
> > > +
> > > +    # cd /tmp/linux-out
> > > +    # gcov -o /sys/kernel/debug/gcov/tmp/linux-out/kernel spinlock.c
> > > +
> > > +=E8=BF=99=E5=B0=86=E5=9C=A8=E5=BD=93=E5=89=8D=E7=9B=AE=E5=BD=95=E4=
=B8=AD=E5=88=9B=E5=BB=BA=E5=B8=A6=E6=9C=89=E6=89=A7=E8=A1=8C=E8=AE=A1=E6=95=
=B0=E6=B3=A8=E9=87=8A=E7=9A=84=E6=BA=90=E4=BB=A3=E7=A0=81=E6=96=87=E4=BB=B6=
=E3=80=82
> > > +=E5=9C=A8=E8=8E=B7=E5=BE=97=E8=BF=99=E4=BA=9B=E7=BB=9F=E8=AE=A1=E6=
=96=87=E4=BB=B6=E5=90=8E=EF=BC=8C=E5=8F=AF=E4=BB=A5=E4=BD=BF=E7=94=A8=E5=9B=
=BE=E5=BD=A2=E5=8C=96=E7=9A=84 gcov_ =E5=89=8D=E7=AB=AF=E5=B7=A5=E5=85=B7=
=EF=BC=88=E6=AF=94=E5=A6=82 lcov_ =EF=BC=89=EF=BC=8C=E6=9D=A5=E5=AE=9E=E7=
=8E=B0
> > > +=E8=87=AA=E5=8A=A8=E5=8C=96=E5=A4=84=E7=90=86linux=E5=86=85=E6=A0=B8=
=E7=9A=84=E8=A6=86=E7=9B=96=E7=8E=87=E8=BF=90=E8=A1=8C=E6=95=B0=E6=8D=AE=EF=
=BC=8C=E5=90=8C=E6=97=B6=E7=94=9F=E6=88=90=E6=98=93=E4=BA=8E=E9=98=85=E8=AF=
=BB=E7=9A=84HTML=E6=A0=BC=E5=BC=8F=E6=96=87=E4=BB=B6=E3=80=82
> > > +
> > > +=E5=8F=AF=E8=83=BD=E7=9A=84=E7=94=A8=E9=80=94:
> > > +
> > > +* =E8=B0=83=E8=AF=95=EF=BC=88=E7=94=A8=E6=9D=A5=E5=88=A4=E6=96=AD=E6=
=AF=8F=E4=B8=80=E8=A1=8C=E7=9A=84=E4=BB=A3=E7=A0=81=E6=98=AF=E5=90=A6=E5=B7=
=B2=E7=BB=8F=E8=BF=90=E8=A1=8C=E8=BF=87=EF=BC=89
> > > +* =E6=B5=8B=E8=AF=95=E6=94=B9=E8=BF=9B=EF=BC=88=E5=A6=82=E4=BD=95=E4=
=BF=AE=E6=94=B9=E6=B5=8B=E8=AF=95=E4=BB=A3=E7=A0=81=EF=BC=8C=E5=B0=BD=E5=8F=
=AF=E8=83=BD=E5=9C=B0=E8=A6=86=E7=9B=96=E5=88=B0=E6=B2=A1=E6=9C=89=E8=BF=90=
=E8=A1=8C=E8=BF=87=E7=9A=84=E4=BB=A3=E7=A0=81=EF=BC=89
> > > +* =E5=86=85=E6=A0=B8=E9=85=8D=E7=BD=AE=E4=BC=98=E5=8C=96=EF=BC=88=E5=
=AF=B9=E4=BA=8E=E6=9F=90=E4=B8=80=E4=B8=AA=E9=80=89=E9=A1=B9=E9=85=8D=E7=BD=
=AE=EF=BC=8C=E5=A6=82=E6=9E=9C=E5=85=B3=E8=81=94=E7=9A=84=E4=BB=A3=E7=A0=81=
=E4=BB=8E=E6=9D=A5=E6=B2=A1=E6=9C=89=E8=BF=90=E8=A1=8C=E8=BF=87=EF=BC=8C=E6=
=98=AF
> > > +  =E5=90=A6=E8=BF=98=E9=9C=80=E8=A6=81=E8=BF=99=E4=B8=AA=E9=85=8D=E7=
=BD=AE=EF=BC=89
>=20
> minimizing: =E4=BC=98=E5=8C=96 -> =E6=9C=80=E5=B0=8F=E5=8C=96/=E7=AE=80=
=E5=8C=96

Done.

>=20
> > > +.. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
> > > +.. _lcov: http://ltp.sourceforge.net/coverage/lcov.php
> > > +
> > > +
> > > +=E5=87=86=E5=A4=87
> > > +----
> > > +
> > > +=E5=86=85=E6=A0=B8=E6=89=93=E5=BC=80=E5=A6=82=E4=B8=8B=E9=85=8D=E7=
=BD=AE::
> > > +
> > > +        CONFIG_DEBUG_FS=3Dy
> > > +        CONFIG_GCOV_KERNEL=3Dy
> > > +
> > > +=E8=8E=B7=E5=8F=96=E6=95=B4=E4=B8=AA=E5=86=85=E6=A0=B8=E7=9A=84=E8=
=A6=86=E7=9B=96=E7=8E=87=E6=95=B0=E6=8D=AE=EF=BC=8C=E8=BF=98=E9=9C=80=E8=A6=
=81=E6=89=93=E5=BC=80::
> > > +
> > > +        CONFIG_GCOV_PROFILE_ALL=3Dy
> > > +
> > > +=E9=9C=80=E8=A6=81=E6=B3=A8=E6=84=8F=E7=9A=84=E6=98=AF=EF=BC=8C=E6=
=95=B4=E4=B8=AA=E5=86=85=E6=A0=B8=E5=BC=80=E5=90=AF=E8=A6=86=E7=9B=96=E7=8E=
=87=E7=BB=9F=E8=AE=A1=E4=BC=9A=E9=80=A0=E6=88=90=E5=86=85=E6=A0=B8=E9=95=9C=
=E5=83=8F=E6=96=87=E4=BB=B6=E5=B0=BA=E5=AF=B8=E7=9A=84=E5=A2=9E=E5=A4=A7=EF=
=BC=8C
> > > +=E5=90=8C=E6=97=B6=E5=86=85=E6=A0=B8=E8=BF=90=E8=A1=8C=E7=9A=84=E4=
=B9=9F=E4=BC=9A=E5=8F=98=E6=85=A2=E4=B8=80=E4=BA=9B=E3=80=82
>=20
> s/=E7=9A=84//

Done.

>=20
> > > +=E5=8F=A6=E5=A4=96=EF=BC=8C=E5=B9=B6=E4=B8=8D=E6=98=AF=E6=89=80=E6=
=9C=89=E7=9A=84=E6=9E=B6=E6=9E=84=E9=83=BD=E6=94=AF=E6=8C=81=E6=95=B4=E4=B8=
=AA=E5=86=85=E6=A0=B8=E5=BC=80=E5=90=AF=E8=A6=86=E7=9B=96=E7=8E=87=E7=BB=9F=
=E8=AE=A1=E3=80=82
> > > +
> > > +=E4=BB=A3=E7=A0=81=E8=BF=90=E8=A1=8C=E8=A6=86=E7=9B=96=E7=8E=87=E6=
=95=B0=E6=8D=AE=E5=8F=AA=E5=9C=A8debugfs=E6=8C=82=E8=BD=BD=E5=AE=8C=E6=88=
=90=E5=90=8E=E6=89=8D=E5=8F=AF=E4=BB=A5=E8=AE=BF=E9=97=AE::
> > > +
[...]
> > > +
> > > +=E7=BC=96=E8=AF=91=E6=9C=BA=E5=92=8C=E6=B5=8B=E8=AF=95=E6=9C=BA=E5=
=88=86=E7=A6=BB
> > > +------------------
> > > +
> > > +gcov=E7=9A=84=E5=86=85=E6=A0=B8=E5=88=86=E6=9E=90=E6=9E=B6=E6=9E=84=
=E6=94=AF=E6=8C=81=E5=86=85=E6=A0=B8=E7=9A=84=E7=BC=96=E8=AF=91=E5=92=8C=E8=
=BF=90=E8=A1=8C=E6=98=AF=E5=9C=A8=E5=90=8C=E4=B8=80=E5=8F=B0=E6=9C=BA=E5=99=
=A8=E4=B8=8A=EF=BC=8C=E4=B9=9F=E5=8F=AF=E4=BB=A5=E7=BC=96=E8=AF=91=E5=92=8C=
=E8=BF=90
>=20
> =E5=88=86=E6=9E=90 -> =E6=8F=92=E6=A1=A9

Done.

>=20
> > > +=E8=A1=8C=E6=98=AF=E5=9C=A8=E4=B8=8D=E5=90=8C=E7=9A=84=E6=9C=BA=E5=
=99=A8=E4=B8=8A=E3=80=82
[...]

Thanks!

Wu

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmB30UgACgkQtlsoEiKC
sIUQuAv/WQclSGZzklGXZclzUOK0rZT4FLVV9ds2zT2mpWoOvvBihx5QUBBXSvPT
xaAkW3mJGNXqIYjr3jGxOWthdRrFD1HWFUaMoyW8mkg5qORscCZxU+lihMmlVp6B
GKWmW6q3QF9eujSntudA8fpjrUVb0/jJOie0w+nV2fEcH1xjrNn3+vfZ1PnFSHyl
7JE7bhy1Fsb4mBo1IIJ3G6eJvh7aHAKVLhDMW8vFW7IKiLmVtHkJ5v9osATwAMvo
bLyFA3+u0CHqV3jaMv4GoSwcvfQMDLXlSaj9z4hfA7+3B04BPrj4yCc8sCi0rElX
7OAs45RYMpArTXqxQhC2MnPmVqeHLIlOelveq6iyFx62otjdAMwckcQ+OoLJF8fF
f4Y6Pccly1Y/PcqvJs8cKRFyHJ3R6+AqHvdwxKBOEd7/Tjuny82yEwOvd/aP1/0r
kqpmZ/KCodPYYQtnnyDvrOTd5sXcpXReymmxXAoU7bbanUI3/UWIos/nutSJFXbt
jvTOqams
=FIbD
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--


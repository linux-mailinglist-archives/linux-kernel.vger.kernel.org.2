Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E422939A084
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFCMHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:07:49 -0400
Received: from m32-153.88.com ([43.250.32.153]:15198 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229747AbhFCMHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=hTo4ZZAKzb8rq0WKz65ovYlqxLCuQVuSBE+Q9
        OhIE38=; b=WZkFqXEVwRAX7s4XuZJbg2/UYqbUutZ6D3YLhknRNwX0lDMrLq/l2
        Zmpz42I/YoitjMKiB9KAxBeVt1BUYASf4wAQqiMpbQ4pt5bD1PiRdRzDtJyEjVQ7
        DpVTo19JL61IfYiUR38UzBhbUQ1TVcEmS1HBmY36ung+9tUnuuiS7s=
Received: from bobwxc.top (unknown [120.238.248.220])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgBX+laPxbhgT5ZiAA--.35207S2;
        Thu, 03 Jun 2021 20:05:38 +0800 (CST)
Date:   Thu, 3 Jun 2021 20:05:33 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bernard Zhao <bernard@vivo.com>,
        Fangrui Song <maskray@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v3] docs/zh_CN: add translations in
 zh_CN/dev-tools/kasan
Message-ID: <20210603120308.GB5502@bobwxc.top>
References: <1622713654-16093-1-git-send-email-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <1622713654-16093-1-git-send-email-wanjiabing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgBX+laPxbhgT5ZiAA--.35207S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFW3Cw1UWr4xXrW7Cr43Awb_yoWrtr17pr
        ZYkrWSka1Ivr1SkFyUuF1DGF18Cr1xCay5KFn7X3ZYqr1kJrWayr12kF9FgrWxu348ZFW8
        Aa1SkF90vF9YkwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzx
        vE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI
        8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCF04k20xvE
        74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
        WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUUBWlPUUUUU==
X-Originating-IP: [120.238.248.220]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 03, 2021 at 05:47:25PM +0800, Wan Jiabing wrote:
> Add new zh translations
> * zh_CN/dev-tools/kasan.rst
> and link it to zh_CN/dev-tools/index.rst
>=20
> Reviewed-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
> Changelog:
> v3:
> - Fix aligns and inaccurate translation
> v2:
> - Delete spaces surround with English words.
> ---
>  .../translations/zh_CN/dev-tools/index.rst         |   2 +-
>  .../translations/zh_CN/dev-tools/kasan.rst         | 417 +++++++++++++++=
++++++
>  2 files changed, 418 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/kasan.rst
>=20
> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Docum=
entation/translations/zh_CN/dev-tools/index.rst
> index fd73c47..e6c99f2 100644
> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
> @@ -19,13 +19,13 @@
>     :maxdepth: 2
> =20
>     gcov
> +   kasan
> =20
>  Todolist:
> =20
>   - coccinelle
>   - sparse
>   - kcov
> - - kasan
>   - ubsan
>   - kmemleak
>   - kcsan
> diff --git a/Documentation/translations/zh_CN/dev-tools/kasan.rst b/Docum=
entation/translations/zh_CN/dev-tools/kasan.rst
> new file mode 100644
> index 0000000..a12b3b0
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/dev-tools/kasan.rst
> @@ -0,0 +1,417 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/dev-tools/kasan.rst
> +:Translator: =E4=B8=87=E5=AE=B6=E5=85=B5 Wan Jiabing <wanjiabing@vivo.co=
m>
> +
> +=E5=86=85=E6=A0=B8=E5=9C=B0=E5=9D=80=E6=B6=88=E6=AF=92=E5=89=82(KASAN)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E6=A6=82=E8=BF=B0
> +----
> +
> +KernelAddressSANitizer(KASAN)=E6=98=AF=E4=B8=80=E7=A7=8D=E5=8A=A8=E6=80=
=81=E5=86=85=E5=AD=98=E5=AE=89=E5=85=A8=E9=94=99=E8=AF=AF=E6=A3=80=E6=B5=8B=
=E5=B7=A5=E5=85=B7=EF=BC=8C=E4=B8=BB=E8=A6=81=E5=8A=9F=E8=83=BD=E6=98=AF
> +=E6=A3=80=E6=9F=A5=E5=86=85=E5=AD=98=E8=B6=8A=E7=95=8C=E8=AE=BF=E9=97=AE=
=E5=92=8C=E4=BD=BF=E7=94=A8=E5=B7=B2=E9=87=8A=E6=94=BE=E5=86=85=E5=AD=98=E7=
=9A=84=E9=97=AE=E9=A2=98=E3=80=82KASAN=E6=9C=89=E4=B8=89=E7=A7=8D=E6=A8=A1=
=E5=BC=8F:
> +
> +1. =E9=80=9A=E7=94=A8KASAN=EF=BC=88=E4=B8=8E=E7=94=A8=E6=88=B7=E7=A9=BA=
=E9=97=B4=E7=9A=84ASan=E7=B1=BB=E4=BC=BC=EF=BC=89
> +2. =E5=9F=BA=E4=BA=8E=E8=BD=AF=E4=BB=B6=E6=A0=87=E7=AD=BE=E7=9A=84KASAN=
=EF=BC=88=E4=B8=8E=E7=94=A8=E6=88=B7=E7=A9=BA=E9=97=B4=E7=9A=84HWASan=E7=B1=
=BB=E4=BC=BC=EF=BC=89
> +3. =E5=9F=BA=E4=BA=8E=E7=A1=AC=E4=BB=B6=E6=A0=87=E7=AD=BE=E7=9A=84KASAN=
=EF=BC=88=E5=9F=BA=E4=BA=8E=E7=A1=AC=E4=BB=B6=E5=86=85=E5=AD=98=E6=A0=87=E7=
=AD=BE=EF=BC=89
> +
> +=E7=94=B1=E4=BA=8E=E9=80=9A=E7=94=A8KASAN=E7=9A=84=E5=86=85=E5=AD=98=E5=
=BC=80=E9=94=80=E8=BE=83=E5=A4=A7=EF=BC=8C=E9=80=9A=E7=94=A8KASAN=E4=B8=BB=
=E8=A6=81=E7=94=A8=E4=BA=8E=E8=B0=83=E8=AF=95=E3=80=82=E5=9F=BA=E4=BA=8E=E8=
=BD=AF=E4=BB=B6=E6=A0=87=E7=AD=BE=E7=9A=84KASAN
> +=E5=8F=AF=E7=94=A8=E4=BA=8Edogfood=E6=B5=8B=E8=AF=95=EF=BC=8C=E5=9B=A0=
=E4=B8=BA=E5=AE=83=E5=85=B7=E6=9C=89=E8=BE=83=E4=BD=8E=E7=9A=84=E5=86=85=E5=
=AD=98=E5=BC=80=E9=94=80=EF=BC=8C=E5=B9=B6=E5=85=81=E8=AE=B8=E5=B0=86=E5=85=
=B6=E7=94=A8=E4=BA=8E=E5=AE=9E=E9=99=85=E5=B7=A5=E4=BD=9C=E9=87=8F=E3=80=82
> +=E5=9F=BA=E4=BA=8E=E7=A1=AC=E4=BB=B6=E6=A0=87=E7=AD=BE=E7=9A=84KASAN=E5=
=85=B7=E6=9C=89=E8=BE=83=E4=BD=8E=E7=9A=84=E5=86=85=E5=AD=98=E5=92=8C=E6=80=
=A7=E8=83=BD=E5=BC=80=E9=94=80=EF=BC=8C=E5=9B=A0=E6=AD=A4=E5=8F=AF=E7=94=A8=
=E4=BA=8E=E7=94=9F=E4=BA=A7=E3=80=82=E5=90=8C=E6=97=B6=E5=8F=AF=E7=94=A8=E4=
=BA=8E
> +=E6=A3=80=E6=B5=8B=E7=8E=B0=E5=9C=BA=E5=86=85=E5=AD=98=E9=97=AE=E9=A2=98=
=E6=88=96=E4=BD=9C=E4=B8=BA=E5=AE=89=E5=85=A8=E7=BC=93=E8=A7=A3=E6=8E=AA=E6=
=96=BD=E3=80=82
> +
> +=E8=BD=AF=E4=BB=B6KASAN=E6=A8=A1=E5=BC=8F=EF=BC=88#1=E5=92=8C#2=EF=BC=89=
=E4=BD=BF=E7=94=A8=E7=BC=96=E8=AF=91=E6=97=B6=E5=B7=A5=E5=85=B7=E5=9C=A8=E6=
=AF=8F=E6=AC=A1=E5=86=85=E5=AD=98=E8=AE=BF=E9=97=AE=E4=B9=8B=E5=89=8D=E6=8F=
=92=E5=85=A5=E6=9C=89=E6=95=88=E6=80=A7=E6=A3=80=E6=9F=A5=EF=BC=8C
> +=E5=9B=A0=E6=AD=A4=E9=9C=80=E8=A6=81=E4=B8=80=E4=B8=AA=E6=94=AF=E6=8C=81=
=E5=AE=83=E7=9A=84=E7=BC=96=E8=AF=91=E5=99=A8=E7=89=88=E6=9C=AC=E3=80=82
> +
> +=E9=80=9A=E7=94=A8KASAN=E5=9C=A8GCC=E5=92=8CClang=E5=8F=97=E6=94=AF=E6=
=8C=81=E3=80=82GCC=E9=9C=80=E8=A6=818.3.0=E6=88=96=E6=9B=B4=E9=AB=98=E7=89=
=88=E6=9C=AC=E3=80=82=E4=BB=BB=E4=BD=95=E5=8F=97=E6=94=AF=E6=8C=81=E7=9A=84=
Clang
> +=E7=89=88=E6=9C=AC=E9=83=BD=E6=98=AF=E5=85=BC=E5=AE=B9=E7=9A=84=EF=BC=8C=
=E4=BD=86=E4=BB=8EClang 11=E6=89=8D=E5=BC=80=E5=A7=8B=E6=94=AF=E6=8C=81=E6=
=A3=80=E6=B5=8B=E5=85=A8=E5=B1=80=E5=8F=98=E9=87=8F=E7=9A=84=E8=B6=8A=E7=95=
=8C=E8=AE=BF=E9=97=AE=E3=80=82
> +
> +=E5=9F=BA=E4=BA=8E=E8=BD=AF=E4=BB=B6=E6=A0=87=E7=AD=BE=E7=9A=84KASAN=E6=
=A8=A1=E5=BC=8F=E4=BB=85=E5=9C=A8Clang=E4=B8=AD=E5=8F=97=E6=94=AF=E6=8C=81=
=E3=80=82
> +
> +=E7=A1=AC=E4=BB=B6KASAN=E6=A8=A1=E5=BC=8F=EF=BC=88#3=EF=BC=89=E4=BE=9D=
=E8=B5=96=E7=A1=AC=E4=BB=B6=E6=9D=A5=E6=89=A7=E8=A1=8C=E6=A3=80=E6=9F=A5=EF=
=BC=8C=E4=BD=86=E4=BB=8D=E9=9C=80=E8=A6=81=E6=94=AF=E6=8C=81=E5=86=85=E5=AD=
=98=E6=A0=87=E7=AD=BE=E6=8C=87=E4=BB=A4=E7=9A=84=E7=BC=96=E8=AF=91=E5=99=A8
> +=E7=89=88=E6=9C=AC=E3=80=82GCC 10+=E5=92=8CClang 11+=E6=94=AF=E6=8C=81=
=E6=AD=A4=E6=A8=A1=E5=BC=8F=E3=80=82
> +
> +=E4=B8=A4=E7=A7=8D=E8=BD=AF=E4=BB=B6KASAN=E6=A8=A1=E5=BC=8F=E9=83=BD=E9=
=80=82=E7=94=A8=E4=BA=8ESLUB=E5=92=8CSLAB=E5=86=85=E5=AD=98=E5=88=86=E9=85=
=8D=E5=99=A8=EF=BC=8C=E8=80=8C=E5=9F=BA=E4=BA=8E=E7=A1=AC=E4=BB=B6=E6=A0=87=
=E7=AD=BE=E7=9A=84KASAN=E7=9B=AE=E5=89=8D
> +=E4=BB=85=E6=94=AF=E6=8C=81SLUB=E3=80=82
> +
> +=E7=9B=AE=E5=89=8Dx86_64=E3=80=81arm=E3=80=81arm64=E3=80=81xtensa=E3=80=
=81s390=E3=80=81riscv=E6=9E=B6=E6=9E=84=E6=94=AF=E6=8C=81=E9=80=9A=E7=94=A8=
KASAN=E6=A8=A1=E5=BC=8F=EF=BC=8C=E4=BB=85
> +arm64=E6=9E=B6=E6=9E=84=E6=94=AF=E6=8C=81=E5=9F=BA=E4=BA=8E=E6=A0=87=E7=
=AD=BE=E7=9A=84KASAN=E6=A8=A1=E5=BC=8F=E3=80=82
> +
> +=E7=94=A8=E6=B3=95
> +----
> +
> +=E8=A6=81=E5=90=AF=E7=94=A8KASAN=EF=BC=8C=E8=AF=B7=E4=BD=BF=E7=94=A8=E4=
=BB=A5=E4=B8=8B=E5=91=BD=E4=BB=A4=E9=85=8D=E7=BD=AE=E5=86=85=E6=A0=B8::
> +
> +	  CONFIG_KASAN=3Dy
> +
> +=E5=90=8C=E6=97=B6=E5=9C=A8 ``CONFIG_KASAN_GENERIC`` (=E5=90=AF=E7=94=A8=
=E9=80=9A=E7=94=A8KASAN=E6=A8=A1=E5=BC=8F)=EF=BC=8C ``CONFIG_KASAN_SW_TAGS``
> +(=E5=90=AF=E7=94=A8=E5=9F=BA=E4=BA=8E=E7=A1=AC=E4=BB=B6=E6=A0=87=E7=AD=
=BE=E7=9A=84KASAN=E6=A8=A1=E5=BC=8F)=EF=BC=8C=E5=92=8C ``CONFIG_KASAN_HW_TA=
GS`` (=E5=90=AF=E7=94=A8=E5=9F=BA=E4=BA=8E=E7=A1=AC=E4=BB=B6=E6=A0=87=E7=AD=
=BE
> +=E7=9A=84KASAN=E6=A8=A1=E5=BC=8F)=E4=B9=8B=E9=97=B4=E8=BF=9B=E8=A1=8C=E9=
=80=89=E6=8B=A9=E3=80=82
> +
> +=E5=AF=B9=E4=BA=8E=E8=BD=AF=E4=BB=B6=E6=A8=A1=E5=BC=8F=EF=BC=8C=E8=BF=98=
=E5=8F=AF=E4=BB=A5=E5=9C=A8 ``CONFIG_KASAN_OUTLINE`` =E5=92=8C ``CONFIG_KAS=
AN_INLINE``
> +=E4=B9=8B=E9=97=B4=E8=BF=9B=E8=A1=8C=E9=80=89=E6=8B=A9=E3=80=82outline=
=E5=92=8Cinline=E6=98=AF=E7=BC=96=E8=AF=91=E5=99=A8=E6=8F=92=E6=A1=A9=E7=B1=
=BB=E5=9E=8B=E3=80=82=E5=89=8D=E8=80=85=E4=BA=A7=E7=94=9F=E8=BE=83=E5=B0=8F=
=E7=9A=84=E4=BA=8C=E8=BF=9B=E5=88=B6=E6=96=87=E4=BB=B6=EF=BC=8C
> +=E8=80=8C=E5=90=8E=E8=80=85=E5=BF=AB1.1-2=E5=80=8D=E3=80=82
> +
> +=E8=A6=81=E5=B0=86=E5=8F=97=E5=BD=B1=E5=93=8D=E7=9A=84slab=E5=AF=B9=E8=
=B1=A1=E7=9A=84alloc=E5=92=8Cfree=E5=A0=86=E6=A0=88=E8=B7=9F=E8=B8=AA=E5=8C=
=85=E5=90=AB=E5=88=B0=E6=8A=A5=E5=91=8A=E4=B8=AD=EF=BC=8C=E8=AF=B7=E5=90=AF=
=E7=94=A8
> +``CONFIG_STACKTRACE`` =E3=80=82=E8=A6=81=E5=8C=85=E6=8B=AC=E5=8F=97=E5=
=BD=B1=E5=93=8D=E7=89=A9=E7=90=86=E9=A1=B5=E9=9D=A2=E7=9A=84=E5=88=86=E9=85=
=8D=E5=92=8C=E9=87=8A=E6=94=BE=E5=A0=86=E6=A0=88=E8=B7=9F=E8=B8=AA=E7=9A=84=
=E8=AF=9D=EF=BC=8C
> +=E8=AF=B7=E5=90=AF=E7=94=A8``CONFIG_PAGE_OWNER`` =E5=B9=B6=E4=BD=BF=E7=
=94=A8 ``page_owner=3Don`` =E8=BF=9B=E8=A1=8C=E5=BC=95=E5=AF=BC=E3=80=82
--------^

missed a space here

Build it, just here.

Thanks,
	Wu X.C.


--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmC4xPsACgkQtlsoEiKC
sIU7BgwAvxMe58tMbNHB+ajapeQV1W/FfIM0M7TIlGXOlqmdwgmuZnbZSLk1NwUj
PjIg8uYQH++TfVudS+4OA9loLxIDaS913XurAsjA3U/dWIlyYU3Y4McE/vZrMBnO
b8tvwn9eD579sd5tsA0wtK4NJ7VBIFtg8R5cMeers/dm+b7eKSb5Lf1MN9YqvX0F
CmGsXsGfkWkEdRMsZkbj96N0Uo1UTXqEZgxEumr25xwN5+dnpcAtUqzvNfxlunnu
PaJL7UGIi37Dbov5EUHXIdqOhjYQzHdEpTNsgZLKb6ofL1sVDPY3pF5zCxArgMWP
S9sZAmt5DHaC1uqyLK9ZovWYDO/pqWvVuU+jf6ZVgqAg+phm/EwQd7RSEYjyT2UB
BTah2vLrUKcgcS5z1yThT0Qtmm6MiSGgbxwcw3ZhjbzBn/GPF/h2ANZ6zOhTzMRW
OZmrL4ZJjBXY8n0DexaTMCF2EBlEgV5xO13xLbI0Qf6YYf6IxGMsKMSOYRzYnP82
k4gNAOOv
=k+i9
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--


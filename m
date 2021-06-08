Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911B539EC67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFHC5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:57:46 -0400
Received: from m34-101.88.com ([104.250.34.101]:60057 "EHLO 88.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230233AbhFHC5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=xeVn0pq+FA2Ofzo8XmxTNibXjPD8cpbni56ED
        xo9rIw=; b=TWC5mB2Ds3mYhsRxVGvIYnQypzcF0RCpzdhUv0cLuT6HkFvd4PS9V
        LK9ixjDYW/Qh25bmVXsh5gXCIYYAe0F1g9qVOALyL2h6MkZyZox6YrXCH4ZQyWd3
        OkhC/a2fAgicpiIf1PNW4EQWrJppP+gqx5cMFooiVoGn4aZI3yMbuA=
Received: from bobwxc.top (unknown [120.238.248.220])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgAHozaY2b5gTe0DAA--.10018S2;
        Tue, 08 Jun 2021 10:44:42 +0800 (CST)
Date:   Tue, 8 Jun 2021 10:44:40 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Hu Haowen <src.res@email.cn>
Cc:     alexs@kernel.org, corbet@lwn.net, bernard@vivo.com,
        maskray@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs/zh_CN: create new translations for
 zh_CN/dev-tools/testing-overview
Message-ID: <20210608024439.GA3207@bobwxc.top>
References: <20210605120504.40246-1-src.res@email.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20210605120504.40246-1-src.res@email.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgAHozaY2b5gTe0DAA--.10018S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1fGr4rXryUtFW5Zw4ruFg_yoWfuFb_Ww
        s3tayUCrn3XF17WayIyrs8JrZagws8Xr1qkF4DZr98Xw13Ca97X3WDW3Z8KFyIgFsxZ39r
        Cr40gF1Iqr4IyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487M2
        AExVA0xI801c8C04v7Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1U
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
        4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
        WIevJa73UjIFyTuYvjfUsvtCUUUUU
X-Originating-IP: [120.238.248.220]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 05, 2021 at 08:05:04PM +0800, Hu Haowen wrote:
> Create new translations for dev-tools/testing-overview.rst and link it
> to dev-tools/index.rst with TODOList modifications.
>=20
> Signed-off-by: Hu Haowen <src.res@email.cn>
> ---
>  .../translations/zh_CN/dev-tools/index.rst    |   5 +
>  .../zh_CN/dev-tools/testing-overview.rst      | 110 ++++++++++++++++++
[...]
> +
> +=E4=BB=A3=E7=A0=81=E8=A6=86=E7=9B=96=E7=8E=87=E5=B7=A5=E5=85=B7
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E6=94=AF=E6=8C=81=E4=B8=A4=E7=A7=8D=E4=B8=8D=E5=90=8C=E4=BB=A3=E7=A0=81=
=E4=B9=8B=E9=97=B4=E7=9A=84=E8=A6=86=E7=9B=96=E7=8E=87=E6=B5=8B=E9=87=8F=E5=
=B7=A5=E5=85=B7=E3=80=82=E5=AE=83=E4=BB=AC=E5=8F=AF=E4=BB=A5=E7=94=A8=E6=9D=
=A5=E9=AA=8C=E8=AF=81=E4=B8=80=E9=A1=B9=E6=B5=8B=E8=AF=95=E6=89=A7=E8=A1=8C=
=E7=9A=84

Linux=E5=86=85=E6=A0=B8=E6=94=AF=E6=8C=81=E4=B8=A4=E7=A7=8D=E4=B8=8D=E5=90=
=8C=E7=9A=84=E4=BB=A3=E7=A0=81=E8=A6=86=E7=9B=96=E7=8E=87=E6=B5=8B=E8=AF=95=
=E5=B7=A5=E5=85=B7=E3=80=82

> +=E7=A1=AE=E5=88=87=E5=87=BD=E6=95=B0=E6=88=96=E4=BB=A3=E7=A0=81=E8=A1=8C=
=E3=80=82=E8=BF=99=E6=9C=89=E5=8A=A9=E4=BA=8E=E5=86=B3=E5=AE=9A=E5=86=85=E6=
=A0=B8=E8=A2=AB=E6=B5=8B=E8=AF=95=E4=BA=86=E5=A4=9A=E5=B0=91=EF=BC=8C=E6=88=
=96=E7=94=A8=E6=9D=A5=E6=9F=A5=E6=89=BE=E5=90=88=E9=80=82=E7=9A=84=E6=B5=8B=
=E8=AF=95
> +=E4=B8=AD=E6=B2=A1=E6=9C=89=E8=A6=86=E7=9B=96=E5=88=B0=E7=9A=84=E6=9E=81=
=E7=AB=AF=E6=83=85=E5=86=B5=E3=80=82
> +

OK, good job!

Just need to fix a small problem, after that

Reviewed-by: Wu XiangCheng <bobwxc@email.cn>

Thanks,
	Wu X.C.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmC+2Y4ACgkQtlsoEiKC
sIUf6Qv/YNJKKNFFRa6M7Z1NGnPhMUCd5s/R/9aWTRFXwt63nayVkAZ8F4mmcX+H
ujmPyxAQtEaZ3MI43fcmSXNmwGS36z54dDaHSv31OXP33v+hxgj6sccN/lAAiUYb
wFK9xvnH7BZ3hfmaAPMogMK1gdTldkODmY/34O8BjOX82NMWyYDE/v5CBqmRq8Yl
qdlpKpmo6c+YRL19ysPOep1Q5OGAzQ8nn2vEBWYv6BlCYrTbxN6iteKyZbBlBUjT
zuz1T0jrx7RCS0oR0m303PWjjkVO+8csF5hgR5Qt6Dva6Cwvp4NU7N/sIya/ijb/
NE7kdHYZYhB6u2PW4hR5We6BxJ9QQ2FcIw5aO5ksALcxx8Tf4WhrBupeofLRBsJX
Rs3e2NVRvA6QnnD26PWI1zCv94o+K4QeNNPlnLCkHcvYhMlYrFDFSN6Yvu4FZk49
eN6p9myKynwYY1u+/jnryY+Wo0IzOxXnRvsx/UN7c7mSr7mv/n6PS91wRwqt2mLm
fGbt+3zW
=dUSj
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


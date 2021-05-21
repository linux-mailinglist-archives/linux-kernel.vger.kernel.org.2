Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4556238CB54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbhEUQyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:54:53 -0400
Received: from m32-153.88.com ([43.250.32.153]:14500 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237780AbhEUQyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=CfzEGnSaMANS+q038pdfLfw6YqCcAOmc/lwy0
        RmS2CQ=; b=C51hqHV3uDpgnyNbU3E6rNDeSze0yCRSJYP8jmY48Bk0/JPDcsII+
        sEfmCbPaKZDqxF3W+4MNWa570lPgAhsmnruRP5SZgaVK1itL24i5Sa/CQqfcJIz0
        RdFnIWclVdRiEKywJZwHa7yUAumouQUS6wCButJOP0yyCykBM9E9hA=
Received: from bobwxc.top (unknown [120.238.248.9])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgAHV1l_5adggQ9AAA--.29093S2;
        Sat, 22 May 2021 00:53:21 +0800 (CST)
Date:   Sat, 22 May 2021 00:53:19 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Hu Haowen <src.res@email.cn>
Cc:     alexs@kernel.org, corbet@lwn.net, bernard@vivo.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: update a translation in zh_CN/dev-tools/gcov
Message-ID: <20210521165319.GA18245@bobwxc.top>
References: <20210521155551.29176-1-src.res@email.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20210521155551.29176-1-src.res@email.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgAHV1l_5adggQ9AAA--.29093S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZr1xGFWDuF1DCFW7WFWkCrg_yoW8JryDpr
        WkKryxG3WIvry5C3y8GF17tr18uFyxWw4UK3W0q3ZYqrnxXrsYkr47tr90gFyfXrWrZFWr
        AF4F9Fyruw1jk3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28E
        F7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wASzI
        0EjI02j7AqF2xKxwAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
        1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7VU0mhF7UUUUU==
X-Originating-IP: [120.238.248.9]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 21, 2021 at 11:55:51PM +0800, Hu Haowen wrote:
> The original file has added some words in commit c797997a244cd2c58908
> ("Documentation: dev-tools: Add Testing Overview"), hence update the
> Chinese translation of them.
>=20
> Signed-off-by: Hu Haowen <src.res@email.cn>
> ---
>  Documentation/translations/zh_CN/dev-tools/index.rst | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Docum=
entation/translations/zh_CN/dev-tools/index.rst
> index fd73c479917b..7ba02fc392a6 100644
> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
> @@ -11,6 +11,9 @@
>  =E7=9B=AE=E5=89=8D=E8=BF=99=E4=BA=9B=E6=96=87=E6=A1=A3=E5=B7=B2=E7=BB=8F=
=E6=95=B4=E7=90=86=E5=9C=A8=E4=B8=80=E8=B5=B7=EF=BC=8C=E4=B8=8D=E9=9C=80=E8=
=A6=81=E5=86=8D=E8=8A=B1=E8=B4=B9=E9=A2=9D=E5=A4=96=E7=9A=84=E7=B2=BE=E5=8A=
=9B=E3=80=82
>  =E6=AC=A2=E8=BF=8E=E4=BB=BB=E4=BD=95=E8=A1=A5=E4=B8=81=E3=80=82
> =20
> +=E6=9C=89=E5=85=B3=E6=B5=8B=E8=AF=95=E4=B8=93=E7=94=A8=E5=B7=A5=E5=85=B7=
=E7=9A=84=E7=AE=80=E8=A6=81=E6=A6=82=E8=BF=B0=EF=BC=8C=E5=8F=82=E8=A7=81
> +Documentation/dev-tools/testing-overview.rst
> +
>  .. class:: toc-title
> =20
>  	   =E7=9B=AE=E5=BD=95
> --=20
> 2.25.1

Looks not bad.
Are you already working on translating testing-overview.rst?
If not, please also add todo entry of testing-overview.rst with v2.

Acked-by: Wu XiangCheng <bobwxc@email.cn>

Thanks,
Wu X.C.


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmCn5XMACgkQtlsoEiKC
sIUU7QwAlUwBZNaB2V5Fy7LRjfAK44OeexjGKjsZAEOBfTtDFMiZ558R/ZvQohWk
37oOQSReyoe4d/Rb3itaFSMfIUAZQWDCaclxUojZGq03EO6yKNMlaCWF/tYHbFZG
ZXpXDiy20E1TJLcJas4YjIovjnOJ6ztca6rZkcn10YTKItWjjCEPDwHvKnDmsosx
OjmFoAxpXI+0HDrbkPWuGR4bZVh9hGh/P8TR+lhPdxicBLSjAJ1lv2zcppyys9h/
Uw9YCqiacvmrSKcD6KdPfQoknHt/vGB8FHQjLEvqkZT1KbLLMbWQRJhJCz1uXIgx
f7WnG6cjXCws26lY3uWOfXqKQrvBrYeMEZRHE3+bM0BczOE5Ywc1qGeZNDfNOYHS
kUP1eRzHIDA61PGt4lKU5ffjCd8OxdexrXz0Zwgj38QB3NRfvqjUrawzcKaRgiXR
wdfjfU99OQOnkbnAaiHJ7u3QoXVbK10tMzogLyafrfwxJ+fCL58x0+PX2bXrQGNX
OUcQJnVg
=ftgU
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


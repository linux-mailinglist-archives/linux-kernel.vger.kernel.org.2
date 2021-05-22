Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E202938D68C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 18:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhEVQ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 12:57:38 -0400
Received: from m32-153.88.com ([43.250.32.153]:52936 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231274AbhEVQ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 12:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=tNJiZ6hCcVUW/Tbb+hubaKAFFdy6kfjlvBb5j
        oKGuB4=; b=dL9l1E/ECCHilCsBqq8SEHXrf86b2GTaGqbkajFT1c8WoGP7W1v+g
        lqSbM5M4LVHkTzEJvY9+c2xcjWTtnVRWzBKXQWRrDVjp5hpI+8RKcZBOWYbcUdLC
        eOGQ/1+sfnu+FQSXOBOXCUB7etcwJX16KMMiRPaHG/RufFX0mRqfFs=
Received: from bobwxc.top (unknown [120.238.248.9])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCn9limN6lgXERCAA--.33551S2;
        Sun, 23 May 2021 00:56:08 +0800 (CST)
Date:   Sun, 23 May 2021 00:56:06 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Activate xeCJK only in CJK chapters
Message-ID: <20210522165606.GA25494@bobwxc.top>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgCn9limN6lgXERCAA--.33551S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GF4kWw4kCw45Jr1xWF15urg_yoW8Jr47pF
        WxG3ZrAFWDt34UJrs7Cw4xur1Sya1fJw4Fkry2y3sYvF909a4xtr1Iya90ga4Du3WrG3ZI
        vw4jvw4UWFZ8Cr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUg2b7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2
        z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r4UM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21le4C267I2x7xF54xIwI1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6x8ErcxFaVAv8VWxJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82
        IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI
        43ZEXa7IUU3rc3UUUUU==
X-Originating-IP: [120.238.248.9]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 22, 2021 at 04:28:55PM +0900, Akira Yokosawa wrote:
> Activating xeCJK in English or Italian-translation documents
> results in sub-optimal typesetting with wide-looking apostrophes
> and quotation marks.
>=20
> The xeCJK package provides macros for enabling and disabling its
> effect in the middle of a document, namely \makexeCJKactive and
> \makexeCJKinactive.
>=20
> So the goal of this change is to activate xeCJK in the relevant
> chapters in translations.
>=20
> To do this:
>=20
>     o Define custom macros in the preamble depending on the
>       availability of the "Noto Sans CJK" font so that those
>       macros can be embedded in translations.tex after the fact.
>       By default, xeCJK is inactive.
>=20
>     o Add a script retouch-translations.sh to embed the on/off
>       macros in translations.tex where necessary.
>       The patterns in the script are ad-hoc by nature, and will
>       need updates when the chapter organization changes.
>=20
>     o Invoke the script at the final step of target "latexdocs".
>=20
>=20
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---

Hi Akira,

Test this patch with Noto Sans SC font, worked well.
=E2=80=9C=E2=80=9D use right font in western language docs now.

Tested-by: Wu XiangCheng <bobwxc@email.cn>

Thanks,
Wu X.C.


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmCpN6IACgkQtlsoEiKC
sIX51wv+LhidirgRV7Z1DY6PhPpg119USK/wghNNiU7FSW1qctrr9VQAJpwEsKbX
RxWlTwRLVXUb5lpfi1t+CshRncAC54HBVrGj9OUTsMfpKlUvnrsvWUyAqHdUh+8x
XhEJ9PRHr6IIg7E5yYjZBdhjrTYR/XbQctIfxfysxrBtj75bfmzJblodPySFeF3Z
BqTFkxLccy9WjBPOM03eQpNOckxa3WMAmMQVNnPJBrPhG+CirPCID2rYs/EqppKU
BokEmCl+D36Q1KqPK+uN8cXYflgouwkxpbC1GBdoubml4QzNoTt6rPI4qKnJYy2Q
K+oNBV9Po5y4u3ak+tOEP1HyDTvcQCqqghF/gufcUZvrTKz575IcMJPVV0eGIWKc
TSTOZ+D17/6PsOI+Yq2M0IMFq2qiXAovyuP1IbCYwMxiYlF5RWogBDs3No11dL8A
k5ehCn8jhDP5cw14bRkBeDzqQt+ibNWMTO4K32aeGe/NkhuFAxQ8UtgJtA9b2Vuy
rsU9uyb3
=AlNl
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--


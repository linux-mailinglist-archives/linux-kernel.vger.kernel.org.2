Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F15390106
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhEYMbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:31:50 -0400
Received: from [43.250.32.171] ([43.250.32.171]:64261 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232322AbhEYMbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:31:48 -0400
X-Greylist: delayed 167193 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 08:31:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=R1zbQ9T2RJnV7Sbd/KX83UV4qObCUItyh1O7x
        38m6Mg=; b=XILSSNAsahxSPDvCRwGZkf4FPiRuZJf1AUz/QKjQM2OaRiX20weXa
        oFCvLkd0OCeVNA6Bbg78AK1Eb79tgqWPgBDJ+iJ9sbMXlA3YzJyaOIBc+MJcM+15
        rAIG5GJFH9Z+DysnTatqiq8vQ0+B7xDvMBEk2Q0SpUtBrnB8oeJ4Rg=
Received: from bobwxc.top (unknown [120.238.248.9])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgCXXkHV7axgn8U9AA--.13701S2;
        Tue, 25 May 2021 20:30:15 +0800 (CST)
Date:   Tue, 25 May 2021 20:30:12 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Activate exCJK only in CJK chapters
Message-ID: <20210525123012.GA16810@bobwxc.top>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
 <0229bc4d-b391-41b9-e900-b88089c493df@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <0229bc4d-b391-41b9-e900-b88089c493df@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgCXXkHV7axgn8U9AA--.13701S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFykCr1UXr15Cry3tw48Crg_yoW5Gw43pa
        ykGFyfK3W7tryUJ3s7Cw17Gr12ka1fGa15Gr1UG393tr90k34Igr17trWq9as7Ww1fCa97
        Za1Fq3yUCrWUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgIb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzx
        vE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw2
        8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
        0xZFpf9x07UbyCJUUUUU=
X-Originating-IP: [120.238.248.9]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 08:17:26PM +0900, Akira Yokosawa wrote:
> Activating xeCJK in English and Italian-translation documents
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
>       macros can be used regardless of the use of xeCJK package.
>=20
>     o Patch \sphinxtableofcontents so that xeCJK is inactivated
>       after table of contents.
>=20
>     o Embed those custom macros in each language's index.rst file
>       as a ".. raw:: latex" construct.
>=20
> Note: A CJK chapter needs \kerneldocCJKon in front of its chapter
> heading, while a non-CJK chapter should have \kerneldocCJKoff
> below its chapter heading.
>=20
> This is to make sure the CJK font is available to CJK chapter's
> heading and ending page's footer.
>=20
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Test it, worked well.

Tested-by: Wu XiangCheng <bobwxc@email.cn>

And one warning when am patch:

    .git/rebase-apply/patch:62: trailing whitespace.
	    \kerneldocCJKoff


> I think per-directory conf.py can be tried as a follow-up
> change after this patch is applied.

Agree, I think it's enough for this problem.
If we need more complex customization, per-directory conf.py then worth.=20

> --- a/Documentation/translations/index.rst
> +++ b/Documentation/translations/index.rst
> @@ -18,6 +18,10 @@ Translations
>  Disclaimer
>  ----------
> =20
> +.. raw:: latex
> +
> +	\kerneldocCJKoff=09
> +
>  Translation's purpose is to ease reading and understanding in languages =
other
>  than English. Its aim is to help people who do not understand English or=
 have
>  doubts about its interpretation. Additionally, some people prefer to read
> diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/t=
ranslations/it_IT/index.rst
> index bb8fa7346939..e80a3097aa57 100644
> --- a/Documentation/translations/it_IT/index.rst
> +++ b/Documentation/translations/it_IT/index.rst
> @@ -4,6 +4,10 @@
>  Traduzione italiana
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +.. raw:: latex
> +
> +	\kerneldocCJKoff
> +
>  :manutentore: Federico Vaga <federico.vaga@vaga.pv.it>
> =20
>  .. _it_disclaimer:

And for above two, maybe better to put "raw:: latex" block above the
title, more beautiful, and CJKoff will be done before enter "Italiana"
chapter.

Thanks,
	Wu X.C.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmCs7dEACgkQtlsoEiKC
sIWTswwAv5nmEGuedqGPdaTEnqXz8pYIVEwQOOfg18hxDoggEHBoKkDPVpdlB26r
vnSK8hD2mV+q/+ldclGlOwrS/s/DtamtqDN5D1ZhrjfPiyIrhazcR/gxUyyWLqy9
yz+QrVBp2UD2XXf9kuZvrLOkZ45RuzDGNxR45lZ61O2e7hoQnewPctFJ1OrsH/fI
gQsV3qoB5fKM81F+i2WAlQ/Er3KL7P4CLFFxGRMMZWRGO9PDMYoUoZbAfwLQ6V4y
cEIrOUvzKPbOfNTJ80D9Gp4tYbuWTEqkSrPPbOnb7CvFdboBMGabNuGbtOIKFMae
4ssXS5OFYMRSugSH4fv/st5wduGV91n3aHhDZWp7PkdHqFXYUPJD+JOoMvWIwnes
UBAxl5+nteIAvlUZOVEELemX1+g6YdQONTZ4iP8pvs4WhBaybnKM/xKoLFJ4K+ok
dPSOsDxeUglX+DFFiuCiCMTz7IrGjd2dMIOqThsCQQWUf4lVahO85fO4gbmeXw+n
TmwmW8GU
=CO7a
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--


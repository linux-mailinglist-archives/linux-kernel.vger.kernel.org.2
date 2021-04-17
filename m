Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60775362CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 04:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhDQCry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 22:47:54 -0400
Received: from [43.250.32.171] ([43.250.32.171]:13286 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S231997AbhDQCrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 22:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=9svKhiJCSGJEfqRKWrQE5iQRWDKGyHTzP15kP
        /2Be0Y=; b=TXVhYu0oWPlNPAIjyJvELIusrU5widLy8DG2XcFpWFzEwJUVn25Kd
        6bSmDgdOA3I4aNJ97NEY9Y+oqPDiMh0vhx7yoHI0hgwxPX0n4rIEpdWbTIkiIwYi
        pNb01BkH8sYTZKoQv8izk9lOCLt28+GyOQmc2IOkiKBfC2983IUC3g=
Received: from bobwxc.top (unknown [120.238.248.129])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgB36c8mTHpgJV5hAA--.23207S2;
        Sat, 17 Apr 2021 10:47:04 +0800 (CST)
Date:   Sat, 17 Apr 2021 10:47:02 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        SeongJae Park <sjpark@amazon.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] Add a new translation tool scripts/trslt.py
Message-ID: <20210417024702.GA21292@bobwxc.top>
References: <cover.1618208899.git.bobwxc@email.cn>
 <871rbbi7pn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <871rbbi7pn.fsf@meer.lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: LCKnCgB36c8mTHpgJV5hAA--.23207S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1kWFW8Kr43Jr4DXw1rCrg_yoW8tFWUpF
        yrG3ZrKF4qqw42yr4Ikw4UXF1rAFn7Kw45Gry5trn3A398Jr92qF4rKryY9FWqqr9Yq3Wj
        vw4jvrWDWF1DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgIb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2
        z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzx
        vE52x082IY62kv0487M2AExVA0xI801c8C04v7Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw2
        8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
        0xZFpf9x07jHBTOUUUUU=
X-Originating-IP: [120.238.248.129]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2021 at 03:00:36PM -0600, Jonathan Corbet wrote:
> Wu XiangCheng <bobwxc@email.cn> writes:
>=20
> > Hi all,
> >
> > This set of patches aim to add a new translation tool - trslt.py, which
> > can control the transltions version corresponding to source files.
> >
> > For a long time, kernel documentation translations lacks a way to contr=
ol the
> > version corresponding to the source files. If you translate a file and =
then
> > someone updates the source file, there will be a problem. It's hard to =
know
> > which version the existing translation corresponds to, and even harder =
to sync
> > them.=20
> >
> > The common way now is to check the date, but this is not exactly accura=
te,
> > especially for documents that are often updated. And some translators w=
rite=20
> > corresponding commit ID in the commit log for reference, it is a good w=
ay,=20
> > but still a little troublesome.
> >
> > Thus, the purpose of ``trslt.py`` is to add a new annotating tag to the=
 file
> > to indicate corresponding version of the source file::
> >
> > .. translation_origin_commit: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
> >
> > The script will automatically copy file and generate tag when creating =
new
> > translation, and give update suggestions based on those tags when updat=
ing
> > translations.
> >
> > More details please read doc in [Patch 2/2].
>=20
> So, like Federico, I'm unconvinced about putting this into the
> translated text itself.  This is metadata, and I'd put it with the rest
> of the metadata.  My own suggestion would be a tag like:
>=20
>   Translates: 6161a4b18a66 ("docs: reporting-issues: make people CC the r=
egressions list")
>=20
> It would be an analogue to the Fixes tag in this regard; you could have
> more than one of them if need be.

Yes, that's also a good idea rather than add a tag to text itself.

>=20
> I'm not sure we really need a script in the kernel tree for this; it
> seems like what you really want is some sort of git commit hook.  That
> said, if you come up with something useful, we can certainly find a
> place for it.

Emmm, thought again.

Maybe we just need a doc to tell people recommended practice, just put a
script or hook in the doc.

Use it or not, depend on themselves. That's may easier, but I'm worried
about whether this loose approach will work better.

Thanks!

Wu X.C.

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmB6TCIACgkQtlsoEiKC
sIV0DQwAs6kC2TRcIs+42F2bspvSpcjeU3W05y/wwZPppem7GMUw5tyqs9kG/Qhm
mnSbfiPzI6OqhZcYmuXKkZ6kZdRFc92QOlm17kiuhJd6dIanj3+6AfqSGHVmYyNJ
H2VKs+nBvDDkYGtt/sF2iyee0jTnBRZ4d9bkP9nmfVqg7EMv1v/q17crfSaiEZ0A
S8XndocCCRt2QaIMLJNWc+Zz3V0TYxo3xexJfQfnLIRlIiqkf0+tVBGEixTh4TJ2
RXY2upHv+Em01alhDBpQw70hwKjMMRdboDlo9dK6GGNTeF/2Dn3HSXC2nvkBl3U6
e2RFR9496z5cs7ilBSxGHjw0lTeNjmI7JFcIrVEFn/zagDK8seyOsjkX65XRO80W
xtNqIHmVQTKzTwkYFMmqGhp5qPx6i8oyeQwMNunSwEY4v6xEOo/ykinbE7TiQQNp
3GyizNMD1QImMLG/P4AbwKlafqsuLJh2+hIWAySOgVKon6nUfMkac/zYRnLbVf+Y
rFTxKRaa
=4rpE
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--


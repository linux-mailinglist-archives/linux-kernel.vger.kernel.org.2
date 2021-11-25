Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725B645DE7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbhKYQTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:19:36 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58561 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349907AbhKYQRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:17:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211125161421euoutp01e6352d217ba995f3682cb1faa85ccaa9~61iNPrir81219312193euoutp01j;
        Thu, 25 Nov 2021 16:14:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211125161421euoutp01e6352d217ba995f3682cb1faa85ccaa9~61iNPrir81219312193euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637856861;
        bh=Hrtu5q65ZaumZjQCEWTawZuhYnYw1Z8httMuWW69YnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAalbNHWs02UX/W8cPe0Vefj5/i2MqzgtXE7/xtdclZ6ieTJpuENHSGpssbQmh0/H
         q2vGJwWOnV/Fg8AVlSORFUIg2QggRmvzryfE7i/VjedUyXfryxpdRQIu4x/RPCooAk
         W0DRko/Zh1zzIpEOU+AZVmFkjl1vlAsnjZ40i1nE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211125161421eucas1p2118f4b5c51200da8c1a185e4d761a58c~61iM_yWO23193031930eucas1p2b;
        Thu, 25 Nov 2021 16:14:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 99.FE.10260.D56BF916; Thu, 25
        Nov 2021 16:14:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211125161420eucas1p2b3dbac252dab05d0a5406d0fca8ab945~61iMmWXY63193031930eucas1p2a;
        Thu, 25 Nov 2021 16:14:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211125161420eusmtrp2487e09dff25a61d466100b01dd8493f3~61iMlu49D2998329983eusmtrp2g;
        Thu, 25 Nov 2021 16:14:20 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-89-619fb65d5994
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.8B.09404.C56BF916; Thu, 25
        Nov 2021 16:14:20 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211125161420eusmtip123a02ca9c508d1068b8dece158d433b7~61iMZPZjQ0791907919eusmtip1X;
        Thu, 25 Nov 2021 16:14:20 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Joe Perches <joe@perches.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] get_maintainer: ignore "my" e-mail address
Date:   Thu, 25 Nov 2021 17:14:07 +0100
In-Reply-To: <a0bd71ce82c7c7b9cb72972b091f9f1054b6595c.camel@perches.com>
        (Joe Perches's message of "Tue, 16 Nov 2021 15:14:37 -0800")
Message-ID: <dleftjpmqob4c0.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRieb89p97TsdnZb02tVWGuMlXJpWCMkhjVjpF+KMZzRkait2S23
        GWrGLautphtlqVyzTUXWjgpDpVpbajAVQiphq6l0b4jWVzP9e97neZ/3fd5vPooQpztIqVB1
        FKtRM2EyLp80V47WLd1rzmKW3Xs2Q3n1SxupfFti4CrzKz7xfAnVgLGBUCWYjEjVX+S+k9jN
        9wlmw0KPshqv9fv5h7ruBka2iY73ZMQTsahcqEOOFNDecNWSzNEhPiWmcxFcz36JcDGAIEf3
        g8RFP4JvbeeIKYshr4fAwl0E+rgEHi6+I/jwsHHCQlFc2hPy8wPtUELPh08mJ7uXoP3h9uf7
        XDvtTG+CZr2bnSbphfCnMuF/Ckc6DsGAsQbZBQG9Gqy9aQ52PIteA787+niYF4Elo53EM8Mh
        o67rf2qgqykYbz7Lw0E3w4uc6w4YO4OtyjTJu8Lf4iyOPQTQMZCSvAp74xGYDSMk7lkLza/H
        uBhvhIYzFQTuF0JTtwjvFUKy+fIkLYC482LcLYeCxCeTU6Sgt+UijFVwc/zz5OMaEIz01BNJ
        aF7mtHMyp52TOTGWoBdDYYkXppfAnZxOAuN1UFDQQ2YjByNyYaO14SGsdqWaPeapZcK10eoQ
        zwMR4UVo4rtYx6sGH6NcW59nGeJQqAzJJ8yt9/PqkZRUR6hZmUSwKSCLEQuCmRMnWU3EPk10
        GKstQ3MoUuYikPyOZcR0CBPFHmHZSFYzpXIoR2ksJ16x702Qk/XXA1XXHfD68E6xXfExSJk7
        xt97USqukFvcllioTg8PGE6tNHGundSpL916ecDX4+0QckkadNw1a9foe+sOhV/e6gvJp+uq
        U0pvGrK59YKAhTueO+lWGPNnb211azxzsNY77exPW8eXftdCkf7r4eoHwzGh8iH9lsEYlhL6
        S0b9FqV619Z3p7yS/K1zsqTxgmShzlUbeKk1wUMjP8bIDuHl4hvCPTOXmlvHGp9Sj4pWtQx4
        Jf3hVcW6mSIb07fNTVImcpyvcMtP69y9BdXS7gXNXEKeajrlbxIdv5HXW5EZ2N4+3FlQav3e
        pNWVB7QUvvZxkVLpa8wlMlJ7iFmuIDRa5h84BYfYqQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Xd2YbfMTDSZO1LOYff8xi8XlXXPY
        LNYeucvuwOzxZdU1Zo++LasYPT5vkgtgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DLeLM8ouCxYMX7mT3MDYyH+boYOTkkBEwk5qx+z9zFyMUh
        JLCUUeLj1z6mLkYOoISUxMq56RA1whJ/rnWxQdQ8ZZSY/GU1I0gNm4CexNq1ESCmiICixN0t
        /CDlzAJ+Enc2TWIFCQsLOEvc6ZUFCQsJeEh8n/6YEcRmEVCV+HsMZBEXB6dAB9DEf39YQBK8
        AuYSpz9MZQWxRQUsJf48+8gOEReUODnzCQvE/GyJr6ufM09gFJiFJDULSWoW0GpmAU2J9bv0
        IcLaEssWvmaGsG0l1q17z7KAkXUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYFxsO/Zzyw7G
        la8+6h1iZOJgPMSoAtT5aMPqC4xSLHn5ealKIrzOgfMThXhTEiurUovy44tKc1KLDzGaAv02
        kVlKNDkfGLF5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MWQe/
        XwttrGCpCNRoTg7e228yTUFt9a+FFuwKbklm02caRCz2b17KKyF0xvjT6rhU9qIGu522MTy/
        ZVTOKcpOCjjy4CXzmeePC3ZtXnp2m7TrJ4cHk1OPutlmvm3kC3v+Ym+Ln3zsPjs/p9McVy5O
        brXmyi+VS929yGpKwK9g31nvp7wxmJmUPbXv22Fmu/sfWlyjA4KnGD0Nv9GSeHSD1+6JEsvf
        KVuLFaSzTLDXbHhye66XlcjDh6rW6RONt3E68Dz5frekuoTt//H7hxSuCC9UC5+wQVdK/ezD
        5B3PLtySN9+fGX3qk//6thi30JtTTqV/sz+zxSyppnr5l+gPbu96S3uTO0QM9m/KtOZSYinO
        SDTUYi4qTgQAcZjX7yADAAA=
X-CMS-MailID: 20211125161420eucas1p2b3dbac252dab05d0a5406d0fca8ab945
X-Msg-Generator: CA
X-RootMTR: 20211125161420eucas1p2b3dbac252dab05d0a5406d0fca8ab945
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211125161420eucas1p2b3dbac252dab05d0a5406d0fca8ab945
References: <a0bd71ce82c7c7b9cb72972b091f9f1054b6595c.camel@perches.com>
        <CGME20211125161420eucas1p2b3dbac252dab05d0a5406d0fca8ab945@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2021-11-16 wto 15:14>, when Joe Perches wrote:
> On Tue, 2021-11-16 at 22:34 +0100, =C5=81ukasz Stelmach wrote:
>> Ignore one's own e-mail address given as a parameter to --ignore-me
>> or in the EMAIL environment variable.
>
> Why is this useful?
>
> git send-email already supports this.
>
>        --suppress-cc=3D<category>
>            Specify an additional category of recipients to suppress
>            the auto-cc of:
>
>            =E2=80=A2   author will avoid including the patch author
>
>            =E2=80=A2   self will avoid including the sender
>
>       --[no-]suppress-from
>            If this is set, do not add the From: address to the cc:
>            list. Default is the value of sendemail.suppressFrom
>            configuration value; if that is unspecified, default to
>            --no-suppress-from.
>

Not really, git send-email does not support --suppress-to, and with
get_maintainers.pl coupled with git send-email as follows

=2D-8<---------------cut here---------------start------------->8---
[sendemail]
        tocmd =3D "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback=
 --norolestats --nol --"
        cccmd =3D "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback=
 --norolestats --nom --nor --nofixes --"
=2D-8<---------------cut here---------------end--------------->8---

my address is added to To: if I am a maintainer of the patched files.
To avoid this the --ignore-me options can be added to tocmd.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmGftk8ACgkQsK4enJil
gBDkUgf+LW8d2acmiBi/v91/+/krlu03RtxGI6ml736KC/JkfOF29VF74/voUEAd
7Z3/G3Y8bW8mWWnfCL31/4tj1HcHNBXAKhwnb5Pf1p8h4qXKzcrQMOaIzS3jQN1h
/b584NeuZTDBW0wxV3z3YjrS5r8t95zPzjToTWns9xo5nnoZTDTTDxwF98ZA4Ydv
KmoDa2brv+BGMsgO9NbSNB/UxdXi4A7AusV05dhl+vfY/kq55XYZkGBiATaifQKP
su1hhOZgxI0R/7ALbKofKgcGr2l/lxnB9+hxMYR+QoeYfRkBZrYFkqKiGty24Thv
6ryESHoMgFjq85Qn8iEVET0uw8pPPw==
=LCQb
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE12C3FF2E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346827AbhIBR7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:59:39 -0400
Received: from home.keithp.com ([63.227.221.253]:54500 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346809AbhIBR7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:59:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id A49CB3F30805;
        Thu,  2 Sep 2021 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630605495; bh=TYiDI4/h43REKTZqe6SThSKOMp9tdXU7h56KuM3s8uU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HXr3afV3CIQ4pvhYRHMGCmFA9GlxeL+hMHgwJGdkhOpcXJ02iSnkFHz4JBxYeNoxb
         G+y543USj5pysieM+es1LpnCem7yr9rV0P932yyQs8pSt86gfdC6lQqMCh5l9YlCci
         YyJToSMdCQeh2pSQhinAGX6PJwcXBaWz4ud6+nLAJhy2kY/A0JkQ2IA2t29ud9z7x3
         lQZ7+Jp3loWfJKVypsHTp9do3pPEG7jIyjBYRKm/Q3pDd3DsRRPN6xs768YvLYv/qS
         f1d7a/0E2RovDnXTB0+xzrfCDvuwpt00po+7STDfw80xmlMel239FeAVTMIiWLVmBZ
         liU9JM11/schA==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id W0TBSWDwJTET; Thu,  2 Sep 2021 10:58:10 -0700 (PDT)
Received: from keithp.com (168-103-156-98.tukw.qwest.net [168.103.156.98])
        by elaine.keithp.com (Postfix) with ESMTPSA id C815A3F30803;
        Thu,  2 Sep 2021 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1630605490; bh=TYiDI4/h43REKTZqe6SThSKOMp9tdXU7h56KuM3s8uU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hqPDiRun0rYLMssA2cdH5hnWaVPr3uROXZrwRL9eb/glrR+NIi7nYEMl6F+vebH57
         QI8FUlLqvKQ3IkGAfwrQGpuMM64DfqCNrrku0ay8efhpP+WifI8NZLE803Kzo54mbp
         Jvdnk9KaRz/EJo/sTDa0XCHXj1E2BfjZdCVEBaGbMGafHcJGKw3vn3wGlOrjt2J2PM
         ku1g1ZuPmRcg5kS8NWo144W7v0FziGIDaJUw8BUhsrzBDd7r9K96OokIqhtMi+R+uN
         m9JCvHgqUtZw6ScytXmMsxP+4pqU3+CgpErBqpSxxNhradiRXvcugpjSDe4mCq4eNu
         CbjSm/ytGA85w==
Received: by keithp.com (Postfix, from userid 1000)
        id 9D65B1E60119; Thu,  2 Sep 2021 10:58:32 -0700 (PDT)
From:   Keith Packard <keithp@keithp.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: RE: [PATCH 0/2]: ARM: Enable THREAD_INFO_IN_TASK
In-Reply-To: <20210902165353.GI22278@shell.armlinux.org.uk>
References: <20210902155429.3987201-1-keithp@keithp.com>
 <20210902165353.GI22278@shell.armlinux.org.uk>
Date:   Thu, 02 Sep 2021 10:58:32 -0700
Message-ID: <87a6kuhnav.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

> I think you're introducing a circular dependency with this for
> certain kernel configurations:
>
> E.g. Have you tried running this with CONFIG_CPU_V6 enabled?

That's very useful feedback -- no, I hadn't ever tried this
configuration (presumably the compiler would have complained).

> #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())

I've read through the v6 architecture reference manual (again) and
cannot find any place to store either a per_cpu_offset or even a small
processor id, which I didn't find surprising as I would have expected it
to already be used for this purpose.

I'll re-spin the changes making them conditional on !CONFIG_CPU_V6,
unless someone has an idea of how to identify the current core in a
multi-core ARMv6 system.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmExEMgACgkQ2yIaaQAA
ABH/ug/9ELJJBXQv/84eOLswDo8KROwQ23CzASf0Nz0YaullHqpG6xKO/DYiFFvp
3EceURpqdgbIyLI/o9K8l9k//A2cTx62u3kB6JgYcJVouADBFZmcmUrgf1Aqb55i
uK16O3iMOUbTcCp8Ye1A3IEKuqfUx/f6199pRh775JUwSbZdWXum3poOSwouxVcz
G2C9bRYtbcO7u92O+CHCqXnnUDib39SnWyRs1eu31pYaHsqwNCBC+ECKn+zKi66f
K1WKjth/X/+sUQLYQasf6HfvT+503dAl0NyxpjS0TknDPgXDtUU/+sOitxS9AY2/
fSzTHd3cXxIUWgr6gShvPVH1/hdtXk2oajADHBwXmRqdjCaZYXWGX1YzpWL0/sTv
mEiiK05x0ORbgWBhjAiwzcqPGNdJkNsFOVr+zgABlwjRxfmn3Mr/7BgDWuEamgUe
x/UMqlYJDYLAkOO6xedgiJ6MKvkVxS8r/yBx8kNHCKbqf1/5JewOFIExpYAnE9G1
VAbaEnV0DY6usJFg05zktEoIfMikBO388YjqOrWSKYN5R1GqCc63so71pfLI0lXx
gbiPRuvWNW6+p/rvGP38r9ckS/e/BAQBOMV2bcIay153qEZvBpIq3N0sAmk1gKei
K4k0jWVWtMT63NnYqUCYMly9CPntUy3+OPmY4dRvx9wrFoyD0QQ=
=S1aA
-----END PGP SIGNATURE-----
--=-=-=--

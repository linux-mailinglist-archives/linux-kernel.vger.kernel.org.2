Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F0639287E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhE0H1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:27:34 -0400
Received: from ozlabs.org ([203.11.71.1]:41785 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhE0H1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:27:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FrK9g0ggkz9sTD;
        Thu, 27 May 2021 17:25:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1622100359;
        bh=YQLamtKVY98aqdADqaCNSOAc4QEP5KeiQ0HcfFqfhzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YVl/21u/M3kDvYmBlgqmwh7ToSlY8Ep9ndJmrZ7D3LFQQ2h/XOP8FYU9X7NZmoTcL
         QxGsXnWvfwk6mWJ8XHGTRJOZBDZHdcxIf5Eam2lIWbgoGFerXxxJoYyBBCzoLZzhns
         YwIRE3qEO5SYaKtetdA4Oj6Ilwgrri2Iiy7pqeS3Szz+fxJDAPTz/T/Et9Ww1xWZiW
         4iGOxqGfBxV+tLRCcwsGSnl7XqkfJF2bj4FMSpb0TeG5GJlfcyWROWfeQ922UrDlHf
         Kc6htnu30A/TtpqgzEAycHk8DH9Qurn5DhGKBkJG/vXvBYVUsMLcfFVx64PZTHySlq
         8c1cP7AZjJlfA==
Date:   Thu, 27 May 2021 17:25:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-ID: <20210527172556.31e63155@canb.auug.org.au>
In-Reply-To: <20210526173141.f1b511816fb33eab881e0c8f@linux-foundation.org>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
        <YK3tQ0a0S/CLxyyb@linux.ibm.com>
        <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
        <YK6EXNZHY1xt7Kjs@linux.ibm.com>
        <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
        <20210526173141.f1b511816fb33eab881e0c8f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CoLTGC06BAEA8Pb41FEqUbs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CoLTGC06BAEA8Pb41FEqUbs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 26 May 2021 17:31:41 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Wed, 26 May 2021 20:16:14 -0400 Qian Cai <quic_qiancai@quicinc.com> wr=
ote:
>=20
> >=20
> >=20
> > On 5/26/2021 1:24 PM, Mike Rapoport wrote: =20
> > > On Wed, May 26, 2021 at 12:09:14PM +0000, Qian Cai (QUIC) wrote: =20
> > >>>
> > >>> On Tue, May 25, 2021 at 03:25:59PM +0000, Qian Cai (QUIC) wrote: =20
> > >>>> Reverting the patchset "arm64: drop pfn_valid_within() and simplif=
y pfn_valid()" [1] from today's linux-next fixed a crash while =20
> > >>> reading files under /sys/devices/system/memory. =20
> > >=20
> > > Does the issue persist of you only revert the latest patch in the ser=
ies?
> > > In next-20210525 it would be commit=20
> > > 89fb47db72f2 ("arm64-drop-pfn_valid_within-and-simplify-pfn_valid-fix=
")
> > > and commit
> > > dfe215e9bac2 ("arm64: drop pfn_valid_within() and simplify pfn_valid(=
)"). =20
> >=20
> > Reverting those two commits alone is enough to fix the issue. =20
>=20
> (cc Stephen)
>=20
> Thanks, I'll drop
>=20
> arm64-drop-pfn_valid_within-and-simplify-pfn_valid.patch
> arm64-drop-pfn_valid_within-and-simplify-pfn_valid-fix.patch

Reverted from linux-next for today as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/CoLTGC06BAEA8Pb41FEqUbs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmCvSYQACgkQAVBC80lX
0GzcRAf+IcVmcfKdbF7o0IBQyg9HEg/Rcb8kBI0CBkTTje9mMZ7V0C8LZldlFNdu
WnY34wef4b0APpBIT+AP4bQErjms9oTddLo9NRHoMGGzLoDXQu+VUW2em1LVQs+y
9wEjgoCDE4jonLosojerFgBADLdwQEViBF5+Z9f3TPzkPuI8Z+A2ySBVP0mDkz7C
yGn7aX5DNmsFBv5PwxadLSYgb/qOHDqBEMSkKnpmEO474UgY+cl+xXmtIJ5jB9cN
Iy8A1gQTKQK862+JcdY08IlG6W12m88o9647HfUlTZCnza2eEpU/Iokk4aqEmc+I
hnXdiEWzC2q0JgqYCanI9hwOpmfdYA==
=eDK7
-----END PGP SIGNATURE-----

--Sig_/CoLTGC06BAEA8Pb41FEqUbs--

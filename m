Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D0F326645
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBZRY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:24:47 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6140C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:24:06 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u12so6251958pjr.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=GFCixV8jMVFh23XUzlOOrP/f+e7zoLH+LJdWzCiIF/4=;
        b=IDz2uvRhZ9Qkb622qGfXIXKZPeLO0GaCmx+aoQhKPIWpfMe05mdlqc+rray20ICDaN
         U76aT+K/SWg6kbZNwg5S5fbQlAnrnXc0oMA7dipJV8a3jXjjGRallZ7aOUrjxsU3gOFS
         7SpGAJVmiuIiCXMQNNWVssTdtwTGPfBTYtMmN+a0UdvrLgMdmZBwm9mHtXGUfgQpf6WJ
         R+5Uf86io+wGqw7fTwtCG30FjqyGTGnyXiqu3RDtZO7JwfFNYywcRlPr6ZrQup9K/Dr2
         cyNSuaW42PRwWQ5zyfZQkfTRy3qJ82o1MuazpDf68dCOuX2VpoqiGjY0yfMlsyI7RBml
         +t6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=GFCixV8jMVFh23XUzlOOrP/f+e7zoLH+LJdWzCiIF/4=;
        b=dbp2+ZMNPIb+DuvjwLXh0H2Kul8TaaqixY9ddDwwOds7I8qTDc7PXn0znXGdqV8L2S
         UHyTQtgD9R+SuMgXBpEkmCSWJUCHCqhSYoSoejNOAfpZTLVx349SHmL0TeCNc9DT4F3Y
         P8eBpn4b8lt8utuuAmH6/9avkuPFWNGyONidNtYPHAfcV3+W7elW1qjZt0/Sg8VLXbcG
         ppfNM53BAtp4cdfeVL/q5jVTZ7jJYt4Mu/KAe0j9k+PRX7CRiIgjKAlCnUiTugPCytNE
         4RGO+gf+dZ4yR6dro6zdwzvYakZkpNavVPqYravjhZ0uoI+ZO6AdYJRaBYtPcHbCUJfz
         NxNg==
X-Gm-Message-State: AOAM530in9lv329cftY4yGtxzcfm5l694VtLqzERKag3jXrucJjsegQV
        iLcf7Lz+LnvrADWLn4nxax0=
X-Google-Smtp-Source: ABdhPJyMLOOZPpRPAU7LoIcfVmR1DNC9Jzp3UlL4U/sdRPMDuBiIIgXZUGDhD3ykqusC9nogvphOWg==
X-Received: by 2002:a17:90a:ba02:: with SMTP id s2mr4527275pjr.53.1614360246071;
        Fri, 26 Feb 2021 09:24:06 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id js2sm9316883pjb.54.2021.02.26.09.24.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2021 09:24:05 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <2CDFE432-90D3-43EE-BA9F-2CFEB8BB343C@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C5765D4B-3D28-475A-832A-032E02F03391";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [RFC 1/6] vdso/extable: fix calculation of base
Date:   Fri, 26 Feb 2021 09:24:03 -0800
In-Reply-To: <YDgTrqNDk+vPF9LA@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
To:     Sean Christopherson <seanjc@google.com>
References: <20210225072910.2811795-1-namit@vmware.com>
 <20210225072910.2811795-2-namit@vmware.com> <YDgTrqNDk+vPF9LA@google.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_C5765D4B-3D28-475A-832A-032E02F03391
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Feb 25, 2021, at 1:16 PM, Sean Christopherson <seanjc@google.com> =
wrote:
>=20
> On Wed, Feb 24, 2021, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Apparently, the assembly considers __ex_table as the location when =
the
>> pushsection directive was issued. Therefore when there is more than a
>> single entry in the vDSO exception table, the calculations of the =
base
>> and fixup are wrong.
>>=20
>> Fix the calculations of the expected fault IP and new IP by adjusting
>> the base after each entry.
>>=20
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Sean Christopherson <seanjc@google.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: x86@kernel.org
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> arch/x86/entry/vdso/extable.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/entry/vdso/extable.c =
b/arch/x86/entry/vdso/extable.c
>> index afcf5b65beef..c81e78636220 100644
>> --- a/arch/x86/entry/vdso/extable.c
>> +++ b/arch/x86/entry/vdso/extable.c
>> @@ -32,7 +32,7 @@ bool fixup_vdso_exception(struct pt_regs *regs, int =
trapnr,
>> 	nr_entries =3D image->extable_len / (sizeof(*extable));
>> 	extable =3D image->extable;
>>=20
>> -	for (i =3D 0; i < nr_entries; i++) {
>> +	for (i =3D 0; i < nr_entries; i++, base +=3D sizeof(*extable)) {
>=20
> It's been literally years since I wrote this code, but I distinctly =
remember the
> addresses being relative to the base.  I also remember testing =
multiple entries,
> but again, that was a long time ago.
>=20
> Assuming things have changed, or I was flat out wrong, the comment =
above the
> macro magic should also be updated.
>=20
> /*
> * Inject exception fixup for vDSO code.  Unlike normal exception =
fixup,
> * vDSO uses a dedicated handler the addresses are relative to the =
overall
> * exception table, not each individual entry.
> */

I will update the comment. I am not very familiar with pushsection =
stuff,
but the offsets were wrong.

Since you say you checked it, I wonder whether it can somehow be caused
by having exception table entries defined from multiple object files.

Anyhow, this change follows the kernel=E2=80=99s (not vDSO) exception =
table
scheme.


--Apple-Mail=_C5765D4B-3D28-475A-832A-032E02F03391
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmA5LrMACgkQHaAqSaba
D1rlug//SzVkoxU8j7Sj1Gg9YU/aGpsBFSx5cIZ1+ZOVNTBYzCZ0e1fjEyVGAjig
dhmOha7jKdfUntgw/ObJ0QkKqUDTu71GMlr+AfibT6emd3LkrUa7D0O04flkt2qM
pswSNzJnEBCbGRNdH9R8YMcJKrCEJodpP28BOOtwFb+OndTAYLmUe9PSKixnGbry
Xlb1dJE/crT+5Vp2o5yqfrpZaLD4Mkz84KEO12ALTLKS81FGy0WtyF3cUCaorCLm
WMpgpVKwRMZEowSiYTSFBW3TQGQtMce3L3FRYlviPI/fo47M4QJJ+d6zTEV6KWrC
4/64HUXzCO1HziIJkjEvrabB4ZtkEdwCMPl7I4seeUzPWtgae8n1ZUtVwcMnJzKL
kxy5sMbxWxoOFOiywWoSa5DIOn99CfT55WLBjFMjaaPQ84SuFXiShBY/o04feAGM
+zAM06HHg0r20MASs5qEQvVoJXS5ytVE+h1vdVIrTODCz3S8PR/pcbm7GVx2DEWy
hoRRTNYZVQFjOwKpGCvBMVK8V4st9lcRlUhkaeyFGtJ5mcxbQpcB+sn2Qt6YRhBb
trUq3H9uLLKTdXWoXCOElLtapejCvHDfvwjuR6Idk7YUB8uqQ4+0S8FhVPQPczcy
h8e4TUeRlFsHVRDHa8bvJ6E7CcPNq5ypCPfhaeT/fA0MIkZGYdA=
=JShR
-----END PGP SIGNATURE-----

--Apple-Mail=_C5765D4B-3D28-475A-832A-032E02F03391--

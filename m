Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6279B3271B4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 10:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhB1JVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 04:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhB1JVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 04:21:32 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7BC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 01:20:51 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q20so9188857pfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 01:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5U8n3GiSpCk4oUUJob/tRw55WrYcqNjPdfcSiRR+jLk=;
        b=uPvwsFoFKDK8g2T84gIaPpi3E/fOAEueiY7gQ7Xe1D5qwdhiM4N7raHR3o1IddqgIm
         lZhHJpRfdquaZY0XWrnR6fOeZgBtrg73OWH4jioMwijAfXp2UIA5Htwzj5aAEpfg0Dql
         ASKAoc8Ms9py/QYHm2J3slvciLU+F+3GmtDMMD/+mTfjnfk0nrn8/4es8O0r01pScZWc
         USSnWDw+o0vXcOrVPtFnIS73DRhxvXRYWuCazNWgM4jIHxGR9XXriQRGluyuZifFIhZ8
         vhXv58jURI2cdKcmEN0NeiB/TurIBq70NHeoAQgLszZvVW1VjjnbRKMb8xnFfeJpz+oe
         /ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5U8n3GiSpCk4oUUJob/tRw55WrYcqNjPdfcSiRR+jLk=;
        b=Bp5zBuNg2dRRxLBYU7ZIjbFPDflxkOBsfZcQsgcdV5SigiF4rg0ujL4PMPb8wBwfja
         +oa0JxC7wnvpgSvYNR24iRoxlmS+LNV6TBCGDXqNAjdpqYCX3cFzMkOBvyDME2u6sAyj
         P1rP8itSDr6EBj/A23N4N3WeKiaf1avxf7HkyweeLpGLDs+4BroXKnV3cU1kQA/UsNt5
         VD55wVobHrsyNfdFxY3IW6huFcbDNwJs/KCsvKiosXa2fZrVRgZRTLPgITgWoPfaUyR6
         4E11BudOFoMywbMRDO8qrQJdqphWLUboBUpuRmHdVRrzerziClOeO2JB5Mh2KWHONd7o
         3wHA==
X-Gm-Message-State: AOAM531xhOO6hYV9Q2++AZxEZi3ZszAljfusRlIwpHRbwh9jastHCgrv
        d67Z7mcGUfW+EcPPDt4S4sU=
X-Google-Smtp-Source: ABdhPJzghzaw8I4A27oiC5/wqt/NmTbTNPOLJ3zDtLBVlDQdI46KTq9yEk17hAhTWQZqfTZCdLWCXA==
X-Received: by 2002:a62:1ad4:0:b029:1ed:b92c:6801 with SMTP id a203-20020a621ad40000b02901edb92c6801mr10305462pfa.7.1614504050812;
        Sun, 28 Feb 2021 01:20:50 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id y23sm13984165pfo.50.2021.02.28.01.20.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Feb 2021 01:20:50 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <194EFB5E-46DE-4FEB-BCD5-3281B4C2A097@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_AD31CEAA-7F3A-40B6-BCEF-0FCEE3FAC892";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [RFC 1/6] vdso/extable: fix calculation of base
Date:   Sun, 28 Feb 2021 01:20:48 -0800
In-Reply-To: <YDk0Ld5TIEnhA0Cb@google.com>
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
 <2CDFE432-90D3-43EE-BA9F-2CFEB8BB343C@gmail.com>
 <YDk0Ld5TIEnhA0Cb@google.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_AD31CEAA-7F3A-40B6-BCEF-0FCEE3FAC892
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On Feb 26, 2021, at 9:47 AM, Sean Christopherson <seanjc@google.com> =
wrote:
>=20
> On Fri, Feb 26, 2021, Nadav Amit wrote:
>>=20
>>> On Feb 25, 2021, at 1:16 PM, Sean Christopherson <seanjc@google.com> =
wrote:
>>> It's been literally years since I wrote this code, but I distinctly =
remember the
>>> addresses being relative to the base.  I also remember testing =
multiple entries,
>>> but again, that was a long time ago.
>>>=20
>>> Assuming things have changed, or I was flat out wrong, the comment =
above the
>>> macro magic should also be updated.
>>>=20
>>> /*
>>> * Inject exception fixup for vDSO code.  Unlike normal exception =
fixup,
>>> * vDSO uses a dedicated handler the addresses are relative to the =
overall
>>> * exception table, not each individual entry.
>>> */
>>=20
>> I will update the comment. I am not very familiar with pushsection =
stuff,
>> but the offsets were wrong.
>>=20
>> Since you say you checked it, I wonder whether it can somehow be =
caused
>> by having exception table entries defined from multiple object files.
>=20
> Oooh, I think that would do it.  Have you checked what happens if =
there are
> multiple object files and multiple fixups within an object file?

Good thing that you insisted...

I certainly do not know well enough the assembly section directives,
but indeed it seems (after some experiments) that referring to the
section provides different values from different objects.

So both the current (yours) and this patch (mine) are broken. I think
the easiest thing is to fall back to the kernel exception table scheme.
I checked the following with both entries in the same and different
objects and it seems to work correctly:

-- >8 --

diff --git a/arch/x86/entry/vdso/extable.c =
b/arch/x86/entry/vdso/extable.c
index afcf5b65beef..3f395b782553 100644
--- a/arch/x86/entry/vdso/extable.c
+++ b/arch/x86/entry/vdso/extable.c
@@ -32,9 +32,11 @@ bool fixup_vdso_exception(struct pt_regs *regs, int =
trapnr,
 	nr_entries =3D image->extable_len / (sizeof(*extable));
 	extable =3D image->extable;

-	for (i =3D 0; i < nr_entries; i++) {
-		if (regs->ip =3D=3D base + extable[i].insn) {
-			regs->ip =3D base + extable[i].fixup;
+	for (i =3D 0; i < nr_entries; i++, base +=3D sizeof(*extable)) {
+		if (regs->ip =3D=3D base + extable[i].insn +
+			offsetof(struct vdso_exception_table_entry, =
insn)) {
+			regs->ip =3D base + extable[i].fixup +
+				offsetof(struct =
vdso_exception_table_entry, fixup);
 			regs->di =3D trapnr;
 			regs->si =3D error_code;
 			regs->dx =3D fault_addr;
diff --git a/arch/x86/entry/vdso/extable.h =
b/arch/x86/entry/vdso/extable.h
index b56f6b012941..4ffe3d533148 100644
--- a/arch/x86/entry/vdso/extable.h
+++ b/arch/x86/entry/vdso/extable.h
@@ -13,8 +13,8 @@

 .macro ASM_VDSO_EXTABLE_HANDLE from:req to:req
 	.pushsection __ex_table, "a"
-	.long (\from) - __ex_table
-	.long (\to) - __ex_table
+	.long (\from) - .
+	.long (\to) - .
 	.popsection
 .endm
 #else
--
2.25.1



--Apple-Mail=_AD31CEAA-7F3A-40B6-BCEF-0FCEE3FAC892
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmA7YHAACgkQHaAqSaba
D1q7mw//RVy8FkgUNYcgRRtELtMq8RlPe6Nv7vJPg/O3K+H1H9AHPMiIhUXF+I3I
7UX77t9TmQ4s6ezq4tsjcb9IAcv3Q30sPfvIjU71Uig7RWGUbyGOxQ7T+itVyv94
1zadspaFnfm70kPh6/uuIJOyTJd8pxWO3U1naiJwzhwSqcJUin1EvQwoG2X9eVXk
+vHDra6ORUmMKxj0CPYpGhOjwn3oQjLWUwRCsL6VOqYKmnFHfDbdop+CWY7vFilg
4rdSDgAwtCze9luOUqcBKxapqvAaYGnfQaymTIIs/vc3YyVpdikzbh50/pk7NOVo
+i2P+fPKAPgTZsF+dNFQDBqRvC6F68q2CmPK2XzWRugkDuTNwtKVwPsKijU/+bM3
HDIQ1dGcrMcds9Upl/fLygOCWa5n3nKey9B0yNhkYaVLkzjOl0P7l9bzdL4Bf+x1
S93IEsNbD4efJFg/jyV2+DyieyhyQoNNIvcvOdhBHZ4xE5Ky9KSSGEIm2F/YXA1z
RFe1atpNk90rOGqJR1B2BekcXSUHY2gKjLYzyJZLG4QYTpgwSQEd1MIdRfTd0QPN
CYNGGxxfB/rIg0nBzezlhmiFYpo4IUDku5DY8Y50thQFmnUkfOPa+pVugnlNoUh4
1h2tLoEOGpcu7dZgpvdVJb6q1zn/fOA9CF7EyyHac6GdInA7Fgw=
=EXpb
-----END PGP SIGNATURE-----

--Apple-Mail=_AD31CEAA-7F3A-40B6-BCEF-0FCEE3FAC892--

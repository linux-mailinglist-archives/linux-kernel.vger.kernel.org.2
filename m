Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546BF3B4753
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFYQWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 12:22:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37927 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFYQWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 12:22:15 -0400
Received: from [IPv6:2601:646:8602:8be1:493a:1894:bb79:383b] ([IPv6:2601:646:8602:8be1:493a:1894:bb79:383b])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 15PGJkkS2433945
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 25 Jun 2021 09:19:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 15PGJkkS2433945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021052901; t=1624637986;
        bh=GXwzMqahWVrY5lhUBS+Ylk89C/7XJ7PWpUAttwGCH8E=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=K+ku9mTCiqHwOcY97VZvMVkuSiTtKg1CfvYWLA35kU8IwV1b6fZZzdlVpV/j2dxKn
         Ae6XrSiPR9AwIstna17qrlcQUmlqhLEeRe7x3mjUebr04DkXq7XsYGMRBrLWsnKbS7
         tJgJOfybN0OIykf71Jlt3c6p1m11bzHN/03vXyQp0zo2NtQ5FtGHlOap4OiLSGMqLk
         pL7E5+3y+B/aoMr/buAKSgTCv0MNYY1/h1EaXajLEAlfWp/AiI3V7blqTtbx71hQ+m
         S4TOcEA8Q9ceECBKaR7yN+hITgBV/fwUx+n8+mfMBR64Vh5Mwdw40MZuedLLszYqNk
         WIGc+aUmp5RMA==
Date:   Fri, 25 Jun 2021 09:19:38 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <YNXkVBcmBvZL7khv@zn.tnic>
References: <YNRzSy3NuwBDYWwr@kroah.com> <YNR7aw+C+7AJnBIG@zn.tnic> <YNXG472lXPHlbuCF@kroah.com> <YNXkVBcmBvZL7khv@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
To:     Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <F8B4FDC6-851F-4EC5-A308-BBAB52A75EF3@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a user space build time tool=2E

You can use PRIu32/64 or cast to unsigned long long; it's not like the per=
formance for this case is going to matter one iota=2E

On June 25, 2021 7:12:36 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Fri, Jun 25, 2021 at 02:06:59PM +0200, Greg Kroah-Hartman wrote:
>> Casting seems to be the only way to make this "quiet" that I can
>tell=2E
>>=20
>> Unless someone else has a good idea?
>
>Hmm, so in Documentation/core-api/printk-formats=2Erst we say that for
>printk() with different size types, we should "use a format specifier
>of
>its largest possible type and explicitly cast to it=2E"
>
>And that kinda sounds ok to me because we don't potentially lose
>through
>the casting=2E
>
>IOW, I guess something like this below=2E
>
>---
>diff --git a/arch/x86/tools/relocs=2Ec b/arch/x86/tools/relocs=2Ec
>index 04c5a44b9682=2E=2E42b0f425a2c7 100644
>--- a/arch/x86/tools/relocs=2Ec
>+++ b/arch/x86/tools/relocs=2Ec
>@@ -389,7 +389,7 @@ static void read_ehdr(FILE *fp)
> 		Elf_Shdr shdr;
>=20
> 		if (fseek(fp, ehdr=2Ee_shoff, SEEK_SET) < 0)
>-			die("Seek to %d failed: %s\n", ehdr=2Ee_shoff, strerror(errno));
>+			die("Seek to %lu failed: %s\n", (unsigned long)ehdr=2Ee_shoff,
>strerror(errno));
>=20
> 		if (fread(&shdr, sizeof(shdr), 1, fp) !=3D 1)
>			die("Cannot read initial ELF section header: %s\n",
>strerror(errno));
>@@ -412,17 +412,17 @@ static void read_shdrs(FILE *fp)
>=20
> 	secs =3D calloc(shnum, sizeof(struct section));
> 	if (!secs) {
>-		die("Unable to allocate %d section headers\n",
>+		die("Unable to allocate %ld section headers\n",
> 		    shnum);
> 	}
> 	if (fseek(fp, ehdr=2Ee_shoff, SEEK_SET) < 0) {
>-		die("Seek to %d failed: %s\n",
>-			ehdr=2Ee_shoff, strerror(errno));
>+		die("Seek to %lu failed: %s\n",
>+		    (unsigned long)ehdr=2Ee_shoff, strerror(errno));
> 	}
> 	for (i =3D 0; i < shnum; i++) {
> 		struct section *sec =3D &secs[i];
> 		if (fread(&shdr, sizeof(shdr), 1, fp) !=3D 1)
>-			die("Cannot read ELF section headers %d/%d: %s\n",
>+			die("Cannot read ELF section headers %d/%ld: %s\n",
> 			    i, shnum, strerror(errno));
> 		sec->shdr=2Esh_name      =3D elf_word_to_cpu(shdr=2Esh_name);
> 		sec->shdr=2Esh_type      =3D elf_word_to_cpu(shdr=2Esh_type);
>@@ -450,12 +450,12 @@ static void read_strtabs(FILE *fp)
> 		}
> 		sec->strtab =3D malloc(sec->shdr=2Esh_size);
> 		if (!sec->strtab) {
>-			die("malloc of %d bytes for strtab failed\n",
>-				sec->shdr=2Esh_size);
>+			die("malloc of %lu bytes for strtab failed\n",
>+			    (unsigned long)sec->shdr=2Esh_size);
> 		}
> 		if (fseek(fp, sec->shdr=2Esh_offset, SEEK_SET) < 0) {
>-			die("Seek to %d failed: %s\n",
>-				sec->shdr=2Esh_offset, strerror(errno));
>+			die("Seek to %lu failed: %s\n",
>+			    (unsigned long)sec->shdr=2Esh_offset, strerror(errno));
> 		}
> 		if (fread(sec->strtab, 1, sec->shdr=2Esh_size, fp)
> 		    !=3D sec->shdr=2Esh_size) {
>@@ -475,12 +475,12 @@ static void read_symtabs(FILE *fp)
> 		}
> 		sec->symtab =3D malloc(sec->shdr=2Esh_size);
> 		if (!sec->symtab) {
>-			die("malloc of %d bytes for symtab failed\n",
>-				sec->shdr=2Esh_size);
>+			die("malloc of %lu bytes for symtab failed\n",
>+			    (unsigned long)sec->shdr=2Esh_size);
> 		}
> 		if (fseek(fp, sec->shdr=2Esh_offset, SEEK_SET) < 0) {
>-			die("Seek to %d failed: %s\n",
>-				sec->shdr=2Esh_offset, strerror(errno));
>+			die("Seek to %lu failed: %s\n",
>+			    (unsigned long)sec->shdr=2Esh_offset, strerror(errno));
> 		}
> 		if (fread(sec->symtab, 1, sec->shdr=2Esh_size, fp)
> 		    !=3D sec->shdr=2Esh_size) {
>@@ -508,12 +508,12 @@ static void read_relocs(FILE *fp)
> 		}
> 		sec->reltab =3D malloc(sec->shdr=2Esh_size);
> 		if (!sec->reltab) {
>-			die("malloc of %d bytes for relocs failed\n",
>-				sec->shdr=2Esh_size);
>+			die("malloc of %lu bytes for relocs failed\n",
>+			    (unsigned long)sec->shdr=2Esh_size);
> 		}
> 		if (fseek(fp, sec->shdr=2Esh_offset, SEEK_SET) < 0) {
>-			die("Seek to %d failed: %s\n",
>-				sec->shdr=2Esh_offset, strerror(errno));
>+			die("Seek to %lu failed: %s\n",
>+			    (unsigned long)sec->shdr=2Esh_offset, strerror(errno));
> 		}
> 		if (fread(sec->reltab, 1, sec->shdr=2Esh_size, fp)
> 		    !=3D sec->shdr=2Esh_size) {
>diff --git a/arch/x86/tools/relocs=2Eh b/arch/x86/tools/relocs=2Eh
>index 43c83c0fd22c=2E=2E4c49c82446eb 100644
>--- a/arch/x86/tools/relocs=2Eh
>+++ b/arch/x86/tools/relocs=2Eh
>@@ -17,6 +17,7 @@
> #include <regex=2Eh>
> #include <tools/le_byteshift=2Eh>
>=20
>+__attribute__((__format__(printf, 1, 2)))
> void die(char *fmt, =2E=2E=2E) __attribute__((noreturn));
>=20
> #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

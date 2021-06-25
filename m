Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF293B4751
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFYQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 12:20:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54731 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhFYQUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 12:20:33 -0400
Received: from [IPv6:2601:646:8602:8be1:493a:1894:bb79:383b] ([IPv6:2601:646:8602:8be1:493a:1894:bb79:383b])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 15PGHlpw2433485
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 25 Jun 2021 09:17:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 15PGHlpw2433485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021052901; t=1624637869;
        bh=o04MLK9yGLA91PjsTYSeSl4Z+P8FWRubaxv247wpYzE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=KmSsBcjFUJ5KzU2FQD23Pns9dlirB1BA1whGPg1iw/nG7pSf22ephHLVaCOQva+0/
         8/BZertootOCsOUgu3Cxqn4dR60KnSQcHew4sNguJb27++gN/Sqvdh3OcOAVUDixmM
         nAiJIpATP6M6+L11iGqMyG66XqgOYiVeY3o1F44Wia/aENgaIwsPn3fhDfc53uOBBk
         V08ZFMzWxC053uul6r7+6CbQb+pQJ4ApLTu3O2a28Jua4GFkfbXUx9+TEuco6RYrFq
         C+kGrRLmC71KE6A7idetzt7d9ioZwsqYTtwnyt5vOKp39Sv6q17JW+b7HDLeH0tsJK
         TO1FGM/APUZ9Q==
Date:   Fri, 25 Jun 2021 09:17:40 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <YNSaMnRDwan+aYT4@kroah.com>
References: <YNRzSy3NuwBDYWwr@kroah.com> <YNR7aw+C+7AJnBIG@zn.tnic> <YNSaMnRDwan+aYT4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
CC:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <58B9D76E-306C-4CE5-BAAA-E5D38832BE23@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%zu wouldn't DTRT for cross build=2E

On June 24, 2021 7:44:02 AM PDT, Greg Kroah-Hartman <gregkh@linuxfoundatio=
n=2Eorg> wrote:
>On Thu, Jun 24, 2021 at 02:32:43PM +0200, Borislav Petkov wrote:
>> On Thu, Jun 24, 2021 at 01:58:03PM +0200, Greg Kroah-Hartman wrote:
>> > There are a number of printf "mismatches" in the use of die() in
>> > x86/tools/relocs=2Ec=2E  Fix them up and add the printf attribute to
>the
>> > reloc=2Eh header file to prevent them from ever coming back=2E
>> >=20
>> > Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>> > Cc: Ingo Molnar <mingo@redhat=2Ecom>
>> > Cc: Borislav Petkov <bp@alien8=2Ede>
>> > Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>> > Cc: linux-kernel@vger=2Ekernel=2Eorg
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation=2Eorg>
>> > ---
>> >  arch/x86/tools/relocs=2Ec | 21 +++++++++++----------
>> >  arch/x86/tools/relocs=2Eh |  1 +
>> >  2 files changed, 12 insertions(+), 10 deletions(-)
>> >=20
>> > Originally sent back in Feb, but it seems to have been missed:
>> >
>	https://lore=2Ekernel=2Eorg/r/20210227095356=2E603513-1-gregkh@linuxfoun=
dation=2Eorg
>> >=20
>> >=20
>> > diff --git a/arch/x86/tools/relocs=2Ec b/arch/x86/tools/relocs=2Ec
>> > index ce7188cbdae5=2E=2Ec3105a8c6cde 100644
>> > --- a/arch/x86/tools/relocs=2Ec
>> > +++ b/arch/x86/tools/relocs=2Ec
>> > @@ -389,7 +389,8 @@ static void read_ehdr(FILE *fp)
>> >  		Elf_Shdr shdr;
>> > =20
>> >  		if (fseek(fp, ehdr=2Ee_shoff, SEEK_SET) < 0)
>> > -			die("Seek to %d failed: %s\n", ehdr=2Ee_shoff, strerror(errno));
>> > +			die("Seek to %d failed: %s\n",
>> > +			    (int)ehdr=2Ee_shoff, strerror(errno));
>>=20
>> Instead of casting all those, I think you should use %zu as,
>apparently,
>> we're using unsigned types for Elf{32,64}_Off and Elf{32,64}_Xword,
>etc=2E
>
>Odd, I thought I tried that and something did not work=2E  Let me try it
>again=2E=2E=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

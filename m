Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9A9381B25
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 23:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhEOVIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 17:08:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33025 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhEOVIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 17:08:41 -0400
Received: from [IPv6:2601:646:8602:8be1:e512:4e99:5d16:dcc6] ([IPv6:2601:646:8602:8be1:e512:4e99:5d16:dcc6])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14FL7ANU3374296
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 15 May 2021 14:07:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14FL7ANU3374296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621112832;
        bh=ECT3h7vQpngfn25c/QoKWtsYhzETuPXg6kMhVwqDoE0=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=crxNoHPwLXC/E/Tx9ql6mZSrnh+eZC8qeB1jM/DoPxaFfZSlQNtydPnIdVCgOEOqM
         h9q+p+pLFJgFssFmIeSbgIyl5DckJ2ZeMIZre+pnC9wH7krpTTd0aVlqvQpbOSCCA7
         Ech/YmYujBzf0iWn6wSXZE92KxIbb4mhCrtAg76EYXebQHoUdKBVG6IwgvAf2N3Ec4
         FuAlI1iFpRC0UyqXp9vPCcp+mSmQPsjUmsmdxQJrQybJNF4t7hIih+IcAnz99eH4Sq
         M3zBTVByBoy/Tq+/Orfx1W/KeWYCq+E6Ylp6KSEQD9/zkQZ7UAg0FhRHDKHhhoujvZ
         GmmOHWoksdgpg==
Date:   Sat, 15 May 2021 14:07:01 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <2ebf1bac-93c1-4b7f-add4-4ede3c149b52@www.fastmail.com>
References: <20210515011015.2707542-1-hpa@zytor.com> <20210515011015.2707542-5-hpa@zytor.com> <f2e4c3c3-08c3-eae1-803a-aa85d7e75ca0@kernel.org> <C1CB9B19-185F-469E-A59C-ECAA95AAC279@zytor.com> <2ebf1bac-93c1-4b7f-add4-4ede3c149b52@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 4/4] x86/syscall: use int everywhere for system call numbers
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <BC75A7E8-8870-4E71-9F81-0309CF4853FB@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty soon you'll have the whole entry code rewritten back into assembly =
=F0=9F=98=86

On May 15, 2021 11:48:22 AM PDT, Andy Lutomirski <luto@kernel=2Eorg> wrote=
:
>
>
>On Sat, May 15, 2021, at 10:42 AM, H=2E Peter Anvin wrote:
>> Answer: I don't think it is a good idea to have the system can table
>offset =2E=2E=2E it seems like an unnecessary debugging headache=2E
>
>Emit it in asm:
>
>table_minus_one:
> =2Equad not_a_syscall
>table:
> (real table here)
>
>/me runs=2E
>
>
>
>>=20
>> On May 15, 2021 8:37:12 AM PDT, Andy Lutomirski <luto@kernel=2Eorg
><mailto:luto%40kernel=2Eorg>> wrote:
>> >On 5/14/21 6:10 PM, H=2E Peter Anvin wrote:
>> >> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom
><mailto:hpa%40zytor=2Ecom>>
>> >>=20
>> >> System call numbers are defined as int, so use int everywhere for
>> >> system call numbers=2E This patch is strictly a cleanup; it should
>not
>> >> change anything user visible; all ABI changes have been done in
>the
>> >> preceeding patches=2E
>> >>=20
>> >> Signed-off-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom
><mailto:hpa%40zytor=2Ecom>>
>> >> ---
>> >>  arch/x86/entry/common=2Ec        | 93
>> >++++++++++++++++++++++++----------
>> >>  arch/x86/include/asm/syscall=2Eh |  2 +-
>> >>  2 files changed, 66 insertions(+), 29 deletions(-)
>> >>=20
>> >> diff --git a/arch/x86/entry/common=2Ec b/arch/x86/entry/common=2Ec
>> >> index f51bc17262db=2E=2E714804f0970c 100644
>> >> --- a/arch/x86/entry/common=2Ec
>> >> +++ b/arch/x86/entry/common=2Ec
>> >> @@ -36,49 +36,87 @@
>> >>  #include <asm/irq_stack=2Eh>
>> >> =20
>> >>  #ifdef CONFIG_X86_64
>> >> -__visible noinstr void do_syscall_64(struct pt_regs *regs,
>unsigned
>> >long nr)
>> >> +
>> >> +static __always_inline bool do_syscall_x64(struct pt_regs *regs,
>int
>> >nr)
>> >> +{
>> >> + /*
>> >> + * Convert negative numbers to very high and thus out of range
>> >> + * numbers for comparisons=2E Use unsigned long to slightly
>> >> + * improve the array_index_nospec() generated code=2E
>> >> + */
>> >> + unsigned long unr =3D nr;
>> >> +
>> >> + if (likely(unr < NR_syscalls)) {
>> >> + unr =3D array_index_nospec(unr, NR_syscalls);
>> >> + regs->ax =3D sys_call_table[unr](regs);
>> >> + return true;
>> >> + }
>> >> + return false;
>> >> +}
>> >
>> >How much do you like micro-optimization?  You could be silly^Wclever
>> >and
>> >add a new syscall handler:
>> >
>> >long skip_syscall(struct pt_regs *regs)
>> >{
>> > return regs->ax;
>> >}
>> >
>> >and prepend this to the syscall tables -- it would be a sort-of-real
>> >syscall -1=2E  Then the call sequence becomes:
>> >
>> >int adjusted_nr =3D nr + 1 (or nr - x32bit + 1);
>> >
>> >if (likely(nr < NR_adjusted_syscalls)) {
>> >   unr =3D array_index_nospec=2E=2E=2E;
>> >   regs->ax =3D sys_call_table[unr](regs);  /* might be a no-op! */
>> >} else {
>> >    regs->ax =3D -ENOSYS;
>> >}
>> >
>> >which removes a branch from the fast path=2E
>>=20
>> --=20
>> Sent from my Android device with K-9 Mail=2E Please excuse my brevity=
=2E
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

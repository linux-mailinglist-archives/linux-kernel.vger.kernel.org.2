Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C836C387BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbhERPGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:06:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56801 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344161AbhERPGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:06:12 -0400
Received: from [IPv6:2601:646:8602:8be1:c569:1cd0:3c83:3a98] ([IPv6:2601:646:8602:8be1:c569:1cd0:3c83:3a98])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14IF4dJI3967288
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 18 May 2021 08:04:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14IF4dJI3967288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621350280;
        bh=wimyxhuEh6IiLThCe1ubHmUesa58ublLSsS8OXmapko=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=VnUdbCRrGwg38mCBJ9+R9zkHunTLxOMeF/LfVnyzVzGMGRbNS+TQXoYULjqe2X8JH
         /PBGRJzlmaO5wlbh1Tt9O3HD02qHhAj4CiZPmP+6R2WqZ35gUt0ybK+gaN5Fp4XrSf
         UlzYRMcXffXnh0ncisnxfVqLk/NJC/FBAFvqhMj6UvNae0XdSdbTbKOW51wrjQQ5OJ
         2fD/11igDYyY9GLvNC9ls4ZZZrDaJd9AKiFtnhs7rutJaXSXXaaeTc55G0R1QdxjMk
         ObR2zJbAZ2qOtvW0PfUBHA+0Oi7f09RmtsUkOCXATc3L6Afb0QTo0M6ye+rTLFKEY9
         yqh1N5m3/Fb7g==
Date:   Tue, 18 May 2021 08:04:28 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <YKDPJum3pB/Ma9Gs@gmail.com>
References: <20210515011015.2707542-1-hpa@zytor.com> <20210515011015.2707542-3-hpa@zytor.com> <YKDPJum3pB/Ma9Gs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/4] x86/syscall: update and extend selftest syscall_numbering_64
To:     Ingo Molnar <mingo@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <F236981F-F8B5-4994-9550-730676DDE074@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I finished the ptracer addition to the test=2E It was *interesting*: =
it turns out that ptracing system calls, *even without modifying the state =
in any way*, just being a passive observer, a sign-extends the system call =
numbers *on current kernels*=2E

This means that on current kernels passively tracing a process changes the=
 syscall behavior=2E I think we can all agree that that is not acceptable=
=2E

I will do a couple of cleanups and add this to a v4 patchset=2E

On May 16, 2021 12:52:06 AM PDT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>
>> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>>=20
>> Update the syscall_numbering_64 selftest to reflect that a system
>call
>> is to be extended from 32 bits=2E Add a mix of tests for valid and
>> invalid system calls in 64-bit and x32 space=2E
>>=20
>> Use an explicit system call instruction, because we cannot know if
>the
>> glibc syscall() wrapper intercepts instructions, extends the system
>> call number independently, or anything similar=2E
>>=20
>> Use long long instead of long to make it possible to compile this
>test
>> on x32 as well as 64 bits=2E
>>=20
>> Signed-off-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> ---
>>  =2E=2E=2E/testing/selftests/x86/syscall_numbering=2Ec | 274
>++++++++++++++----
>>  1 file changed, 222 insertions(+), 52 deletions(-)
>
>Small request: I'd suggest moving this to the first place - so that we
>can=20
>easily test before/after effects of (current) patch #1/4=2E
>
>Thanks,
>
>	Ingo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE9386E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbhERA2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:28:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58457 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235315AbhERA2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:28:10 -0400
Received: from [IPv6:2601:646:8602:8be1:c569:1cd0:3c83:3a98] ([IPv6:2601:646:8602:8be1:c569:1cd0:3c83:3a98])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14I0QXWv3839931
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 17 May 2021 17:26:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14I0QXWv3839931
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621297598;
        bh=+KmKCH9+X1GrMfr1BN1l176CssFSpSIwHtCwdbJbrPQ=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=KrJFNZRXuhD/qvYmWRw/WrJsNy/X8RApGB406O4HPveoW1zKtlsuXQ6ZKyhr0jxEi
         R6nfVL36wX/zFCRmuvdbx4ARXEYIrqFuyy+gvU/JZ5Ld5RbaXu9rS9UneuVRji2DUp
         CBsAmX/lR/Gv3b6zTPP/pUpBWrHWoeD8l3e3tZVnell8oWPDcFXyyU9n2w9eh7j6Bt
         3HIFUv/NcVs4xinKG/R8pwbJWTkth3WkP29ymWfbfZ3KwtMPY8oqoTWBi17VjGfQ9+
         mCe2MKuI+cXPQlzJUgy8OKkd1Db8NmiDf4/EN0Qs95355KdVwqQaAqdbjq4tqMNNfy
         OUlWZdgoSHo3Q==
Date:   Mon, 17 May 2021 17:26:22 -0700
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
Message-ID: <516A893A-3436-4693-8960-FCE70C3C0B5E@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure=2E I am also working on implementing Andy's request of adding a ptrace=
r; it will probably take me a few days to clear off the time to do so=2E

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5F630E348
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBCTab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhBCTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:30:22 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DB2C06178B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:29:42 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c132so446076pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 11:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=UyMU5rTSwCIYnYU1RdEtFYBd359sp7Lm0A85U/CwY8I=;
        b=CvgRQZJFwZxjbB5/Tz85UglZwZSI+/KeqceL+it1YnkyiWG7LKXLx6/PPrCeywPSgV
         dOkQcAwNTPWHkwDt4oQPnubIodhsB9FEutLgAWXd74nAsOJUpp4LICwGJ6G5oyqVibQY
         FdXBT78ovtPkWPpuBdqlyVJt7Z159rAsVQhq7d5ZcLMluLlpwArYMoBC5VAvTtlwekIS
         beJ+B2EwH4rYaBFSCZIslSaPBNs7kfeSpvEoMqIh7LmqOhyqT96IKynweHNwiAAQTL0M
         KrEeZxVNDc/RFldPbNUgTw9iUX3/q2BMhNc1yravdeRiUROS9fQtQLJrO/eTBulx+X7y
         OEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=UyMU5rTSwCIYnYU1RdEtFYBd359sp7Lm0A85U/CwY8I=;
        b=hJgDksTJMZLeEQGQyNB0y/wtb/2/PEgozrMfvrXqWZCp7o4SuGHSqxDON54Rss34oE
         nYBShKpU7Mw1ndKAskg/HCdbcUzUYzGYiuQQTZacgqjYRRHSmxnc3/AjuDEyTYcK+m+D
         2uEE8YL47b2q8tnM1zJVhSyJ2PuqwlQZ2RwMJiPoLBPXV9mZRhlWOrUkp1pKsNnx5ior
         YKplsmZh6B1z5QZaRBjweXT3XC9cQpSmKqU50FJl9zMCxZoj2kOF5iwb3bUeQww6xKiG
         gTbRXCRivbapDuSDcbuFnpUBryfemxr9kE5eap4NO83rCsah62qB2CJqrb/Os+PiDOpQ
         velA==
X-Gm-Message-State: AOAM530jcmLCIPf+4/DpD85PIPLBLfbnCrqomu6D7ASxH/gjnNgplZ/3
        wz/BYrDM0BRGqVxV3EnnQVloW6wKcXGs5iww
X-Google-Smtp-Source: ABdhPJxK436aGRz4+Oq43ueT3jgU7mMqozv6DdeYAUNPtidPe32NibnLeGVgdzwd3bwHZZL3/HSG1w==
X-Received: by 2002:a65:4785:: with SMTP id e5mr5413906pgs.0.1612380581631;
        Wed, 03 Feb 2021 11:29:41 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:d574:d341:616c:1b33? ([2601:646:c200:1ef2:d574:d341:616c:1b33])
        by smtp.gmail.com with ESMTPSA id m11sm2675028pjz.44.2021.02.03.11.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 11:29:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 07/11] x86/fault: Split the OOPS code out from no_context()
Date:   Wed, 3 Feb 2021 11:29:39 -0800
Message-Id: <78B808CF-16E2-4C41-B680-0AFD1428ED4A@amacapital.net>
References: <20210203185517.GH13819@zn.tnic>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20210203185517.GH13819@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 3, 2021, at 10:56 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Sun, Jan 31, 2021 at 09:24:38AM -0800, Andy Lutomirski wrote:
>> Not all callers of no_context() want to run exception fixups.
>> Separate the OOPS code out from the fixup code in no_context().
>>=20
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>> arch/x86/mm/fault.c | 116 +++++++++++++++++++++++---------------------
>> 1 file changed, 62 insertions(+), 54 deletions(-)
>>=20
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 1939e546beae..6f43d080e1e8 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -618,53 +618,20 @@ static void set_signal_archinfo(unsigned long addre=
ss,
>> }
>>=20
>> static noinline void
>> -no_context(struct pt_regs *regs, unsigned long error_code,
>> -       unsigned long address, int signal, int si_code)
>> +page_fault_oops(struct pt_regs *regs, unsigned long error_code,
>=20
> Not sure about this name - it still tries to recover:
> efi_recover_from_page_fault().
>=20

That function is a lie. It tries to keep the system alive but it doesn=E2=80=
=99t return if it =E2=80=9Crecovers=E2=80=9D.   Maybe I should add a comment=
?

> Judging by where it is called, maybe no_context_tail() or
> no_context_oops() or no_context_finish_me_already()...
>=20
> Yah, I haz no better idea. :-\
>=20
> ...
>=20
>> @@ -739,6 +692,61 @@ no_context(struct pt_regs *regs, unsigned long error=
_code,
>>    oops_end(flags, regs, sig);
>> }
>>=20
>> +static noinline void
>> +no_context(struct pt_regs *regs, unsigned long error_code,
>> +       unsigned long address, int signal, int si_code)
>> +{
>> +    if (user_mode(regs)) {
>> +        /*
>> +         * This is an implicit supervisor-mode access from user
>> +         * mode.  Bypass all the kernel-mode recovery code and just
>> +         * OOPS.
>> +         */
>> +        goto oops;
>=20
> Just do
>=20
>        return page_fault_oops(...);
>=20
> here and get rid of the label.
>=20
> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette

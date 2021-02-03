Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2530E39B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhBCTxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhBCTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:53:46 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0C1C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 11:53:06 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q131so497728pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 11:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7n6CrltV3b/ke2j1vdkK4p7GUAbDRn0FTiKigrboJIU=;
        b=mT4iHEvhHGj4Let9W9IhYmoBMRer1nQVrGdQDffIAeA1chc9eUtR7VPhesIhgOLw3T
         txxRaJbQXduPa7GEpp59MblGiHAZfZB3MDtEGBS2sb/R3ptxDYzCAJosnWcPlvrSYO+d
         nl6e+1VrMM1Z1dWno8ZY5DPL4WQmXa9R1sV1ilFs8O81hBOOpAfWz8wCF5FXWZ0RLKWa
         n6uU/7DiEcnHHr/DouhATv9h3a4DWxo8hZDzOP++g5grwHYs1N5seAndtBYQ0+IAGcbj
         opnEqYdM8m8nAKtSOPnGaaoULgGjNepf07debDBA6p8cHDEwsMwrVvapJhFq8HQbmucP
         jerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7n6CrltV3b/ke2j1vdkK4p7GUAbDRn0FTiKigrboJIU=;
        b=Fiht/7dKdRKUpMwKF81WJFizywAikhRcduXU6UDDZ1LltTqTKfHngwjtpwRrJgogDc
         wAuEZsoJrQqNVxLDjgjXmwSons2VOiAKaBS6Y20pwrNUpJ9tuw1Zrfw6qQyCbtWvSR0+
         W2hu38tdRSYW1ZMGnpsywWWUvyCoDukHAw5nK7tIWPcUc5pfF+ZnjTIRW++h0NxKCrCQ
         WaBsGfZe8+yNuJrShj/SDtiVk7B3CAaUshm+u5CK5lYMK+SRECMCXWe3cj/usYBYGedk
         Kc4AA9uK4DwYs0fGM0nF/kOud+d9SPCQqiXdJEjvGYv4itgRSUPY9UWFroBVOKqj1/tL
         Y5Wg==
X-Gm-Message-State: AOAM532sN8ehtSmFKYs8Zune5t2CTCIDqswue3EL7vIfT4UP4toTu0XL
        XpJFK8wOD2fbj4gnE9N82vmR0nqlS9wUhJcU
X-Google-Smtp-Source: ABdhPJxNocpweP8MKMooD3H5YQdiok78oh6no9Sj9XW0G13PDjT5+4q5P8QTYwIYdJvy3MxsDokILw==
X-Received: by 2002:a05:6a00:a8d:b029:1ba:71d1:fe3c with SMTP id b13-20020a056a000a8db02901ba71d1fe3cmr4484680pfl.51.1612381985722;
        Wed, 03 Feb 2021 11:53:05 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:d574:d341:616c:1b33? ([2601:646:c200:1ef2:d574:d341:616c:1b33])
        by smtp.gmail.com with ESMTPSA id g8sm2943928pfv.140.2021.02.03.11.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 11:53:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 09/11] x86/fault: Rename no_context() to kernelmode_fixup_or_oops()
Date:   Wed, 3 Feb 2021 11:53:03 -0800
Message-Id: <88AA1DD6-615B-4049-B335-F2F40F85EF08@amacapital.net>
References: <20210203193949.GI13819@zn.tnic>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20210203193949.GI13819@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 3, 2021, at 11:39 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Sun, Jan 31, 2021 at 09:24:40AM -0800, Andy Lutomirski wrote:
>> The name no_context() has never been very clear.  It's only called for
>> faults from kernel mode, so rename it and change the no-longer-useful
>> user_mode(regs) check to a WARN_ON_ONCE.
>>=20
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>> arch/x86/mm/fault.c | 28 ++++++++++------------------
>> 1 file changed, 10 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 177b612c7f33..04cc98ec2423 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -693,17 +693,10 @@ page_fault_oops(struct pt_regs *regs, unsigned long=
 error_code,
>> }
>>=20
>> static noinline void
>> -no_context(struct pt_regs *regs, unsigned long error_code,
>> -       unsigned long address, int signal, int si_code)
>> +kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,=

>> +             unsigned long address, int signal, int si_code)
>=20
> Ew, I don't like functions with "or" in the name - they're probably not
> doing one thing only as they should.
>=20
> Why not simply "handle_kernel_fault" ?

Hmm, I could maybe get behind handle_kernelmode_fault.  I=E2=80=99ll contemp=
late it.  I like the name of the function indicating that either it returns a=
fter fixing it or it doesn=E2=80=99t return.

I refuse to say =E2=80=9Ckernel=E2=80=9D without qualification. In this $@!$=
 file, we have kernel _mode_, kernel _address_, and kernel _privilege_, and t=
hey are all different.

>=20
> Also, all the callsites now do:
>=20
>    if (!user_mode(regs)) {
>        kernelmode_fixup_or_oops
>        ...
>=20
> I guess you can push the "user_mode" check inside that function for less
> hairy code at the callsites.

I feel like that would be more obfuscated =E2=80=94 then the function would r=
eturn without fixing anything for usermode faults, return after fixing it fo=
r kernel mode faults, or oops.

>=20
>> {
>> -    if (user_mode(regs)) {
>> -        /*
>> -         * This is an implicit supervisor-mode access from user
>> -         * mode.  Bypass all the kernel-mode recovery code and just
>> -         * OOPS.
>> -         */
>> -        goto oops;
>> -    }
>> +    WARN_ON_ONCE(user_mode(regs));
>=20
> I guess...
>=20
> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette

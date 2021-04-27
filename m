Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B292336CFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 01:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbhD0Xvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 19:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbhD0Xvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 19:51:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E82C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:51:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so8010707pjj.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=LWGe6SWA/bYZp/RAafLEiICJuTiPklY+BiBhvpohOys=;
        b=ysBTlZpKznZhTsHY4k3PrOcMe54kYcGklldgqwyfe6h7T6SDC8DqnRXaBG7jYNhWxS
         qLAKh+Ru8KQFmekqNOGzrifeQAsejkI0A+kegRMACOKX71xqe5S8KBXD9e83nxRk9iPL
         8+2CSvXfXj6s/ChK+lKbPjKsMIAhNFmHSHiCneOrTRjocAPw2QrgdkGoO1F3zqOUpU22
         5BI9jsz2zUXv2WnMnMtMEqV9/Yqc5MJGbnGHKgoECUDpNc+BetB5MW8+Zm1JpILklv7H
         cfL5qPiftKJMvN4q2amY3y4g6iBoa04flBytYxI2Labh2klH/+xWIR1mH346IccknLxe
         w7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=LWGe6SWA/bYZp/RAafLEiICJuTiPklY+BiBhvpohOys=;
        b=kIL2qQASoNg7Yw2SaMmcJyL3E12qu2w0UmraRviMmhUl3LgSGvO5/eal7tqPBfJSi7
         IovQUc/ZQpPnxqEQvFfFPoZzArwfroQ4M3uZkquGictjk7pGcS9dWi7/Zoqh0OdZqwwe
         L+TawerX1PYMQX8d5Pfc+BDn4WPOalhYHvibl/FYZ/eyFf4RPPOL8BzacPmNj/SC28XF
         6HKpYRUIcKcfBzF5Qyws+c21byVuF0sX0jjkJya67Q3zdxR8sZjHwaSQDzaG7BOix0T/
         NGT1zQLhu2iRxgbWXjvvJY7qt8lOVhn+YOLzQiKF77R1HMgzOS6n3Zb0WrR2qf85NgeA
         kEIw==
X-Gm-Message-State: AOAM531QYLwCsPQRP2CFMAGiZF0L2bHAOYNjk6t4EAorbJFRZ8EtQqN7
        WTftKdjkjJpIHJELoc9M7bdSbg==
X-Google-Smtp-Source: ABdhPJxlJ2yLmgcZ5mwzf+rgUzGjMvXiRKpcKfYZYR3xCD4mtGcacrB/MAM3TLHB3g3tBr7oTxCQ6g==
X-Received: by 2002:a17:90b:1e10:: with SMTP id pg16mr893738pjb.30.1619567468235;
        Tue, 27 Apr 2021 16:51:08 -0700 (PDT)
Received: from smtpclient.apple (2603-8001-6500-2faf-d537-2818-24ab-4c1c.res6.spectrum.com. [2603:8001:6500:2faf:d537:2818:24ab:4c1c])
        by smtp.gmail.com with ESMTPSA id x90sm3176223pjj.55.2021.04.27.16.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 16:51:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: pt_regs->ax == -ENOSYS
Date:   Tue, 27 Apr 2021 16:51:06 -0700
Message-Id: <78327AF2-575F-415E-98D4-6ECDFE311D0F@amacapital.net>
References: <202104271619.0DBE456@keescook>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Will Drewry <wad@chromium.org>
In-Reply-To: <202104271619.0DBE456@keescook>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: iPhone Mail (18E199)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 27, 2021, at 4:29 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
> =EF=BB=BFOn Tue, Apr 27, 2021 at 03:58:03PM -0700, H. Peter Anvin wrote:
>>> On 4/27/21 2:28 PM, Andy Lutomirski wrote:
>>>=20
>>>> On Apr 27, 2021, at 2:15 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>>>=20
>>>> =EF=BB=BFTrying to stomp out some possible cargo cult programming?
>>>>=20
>>>> In the process of going through the various entry code paths, I have to=
 admit to being a bit confused why pt_regs->ax is set to -ENOSYS very early i=
n the system call path.
>>>>=20
>>>=20
>>> It has to get set to _something_, and copying orig_ax seems perhaps sill=
y.  There could also be code that relies on ptrace poking -1 into the nr res=
ulting in -ENOSYS.
>>>=20
>>=20
>> Yeah. I obviously ran into this working on the common entry-exit code for=

>> FRED; the frame has annoyingly different formats because of this, and I
>> wanted to avoid slowing down the system call path.
>>=20
>>>> What is perhaps even more confusing is:
>>>>=20
>>>> __visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned lon=
g nr)
>>>> {
>>>>        nr =3D syscall_enter_from_user_mode(regs, nr);
>>>>=20
>>>>        instrumentation_begin();
>>>>        if (likely(nr < NR_syscalls)) {
>>>>                nr =3D array_index_nospec(nr, NR_syscalls);
>>>>                regs->ax =3D sys_call_table[nr](regs);
>>>> #ifdef CONFIG_X86_X32_ABI
>>>>        } else if (likely((nr & __X32_SYSCALL_BIT) &&
>>>>                          (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)) {=

>>>>                nr =3D array_index_nospec(nr & ~__X32_SYSCALL_BIT,
>>>>                                        X32_NR_syscalls);
>>>>                regs->ax =3D x32_sys_call_table[nr](regs);
>>>> #endif
>>>>        }
>>>>        instrumentation_end();
>>>>        syscall_exit_to_user_mode(regs);
>>>> }
>>>> #endif
>>>>=20
>>>> Now, unless I'm completely out to sea, it seems to me that if syscall_e=
nter_from_user_mode() changes the system call number to an invalid number an=
d pt_regs->ax to !-ENOSYS then the system call will return a different value=
(!) depending on if it is out of range for the table (whatever was poked int=
o pt_regs->ax) or if it corresponds to a hole in the table. This seems to me=
 at least to be The Wrong Thing.
>>>=20
>>> I think you=E2=80=99re right.
>>>=20
>>>>=20
>>>> Calling regs->ax =3D sys_ni_syscall() in an else clause would arguably b=
e the right thing here, except possibly in the case where nr (or (int)nr, se=
e below) =3D=3D -1 or < 0.
>>>=20
>>> I think the check should be -1 for 64 bit but (u32)nr =3D=3D (u32)-1 for=
 the 32-bit path. Does that seem reasonable?
>=20
> FWIW, there is some confusion with how syscall_trac_enter() signals the
> "skip syscall" condition (-1L), vs actually calling "syscall -1".

Fortunately there is not, and never will be, a syscall -1.  But I agree that=
 calling max syscall + 1 should behave identically to calling a nonexistent s=
yscall in the middle of the table.=

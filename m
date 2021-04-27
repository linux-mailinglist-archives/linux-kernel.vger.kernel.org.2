Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CA036CDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhD0V3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhD0V3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:29:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05872C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:28:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s20so15775045plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9PSp2PSXQIcRqg9fX25LBpn6iZGmTPQHxkfgD+jcFR0=;
        b=hStEy6KasMCXpT5gm1CTnwE/5YQtK7hyk7TCgK28eSrEMs5ygdB07wIn0er4I+ygVI
         gTLqZnSTZZt/PNRo6h+vFjx8vbD6Kv84iMc6QkSVWIGK6RS6nudOG6FaMega8bUB+0IA
         i9/sRR9e+1aC27nE1Qje0ZKlYoIW8ZbsKmb3a2qN0jZid094lhR0RzoMRJXD49c75iCv
         FSiRCApp3c6z7FFsu5DDbWUsGESU4HNQ1aPXpbfvDktXvqHGYSPA5vSSepEecO0fTdeb
         tlSHM473hPw5BlfjKrlV6RhF5ZpQY2b6XtJPE0U5EvY8ev0osJyv0rxneAwUCS4mFZFY
         dj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9PSp2PSXQIcRqg9fX25LBpn6iZGmTPQHxkfgD+jcFR0=;
        b=b2CZWwS2ZlqkHrt50GJC1SIDe0R3I8VSipRMHJ6zNnIHjrmHXNCg1kvKUQ/nha+gA6
         RztL2BQSuRFjWOMYqITGSRIhdBq0HvzI8y8muLoR0cetqaKsVnX0qUWvHHJi7IsfP4aZ
         eJqD9SdRcVRNDDeywiEugZgsXusJzJteUDl9hhN5KwB52CSBAfmFu9RUl2muNRViWWWb
         IWcHp5/JKfcw2ggsaekRcv3yi9vZzYWtDVouWkqWxaxU+6zQVlhSDamqhvL8Sbk8dHyL
         dklKHtL2ICydpzKp0CBH96gAE66K7zU4a22/eBV/gX9MgBTZ94rY/okcj0yc7myAs+4d
         BWdQ==
X-Gm-Message-State: AOAM532ft3rKhpSY7vwa41YXBWHP8AjcdL66QbBhFTCcyAkFVdTCqDiC
        qMl5m8hAHbfFwGhcbnJBMth4uQ==
X-Google-Smtp-Source: ABdhPJxHbf8moCJr91r6MD2891LGyW0z5cVpk9kYgRhh+AWiLx/XdWOlvEeIEMjw5JPDvqCK9RcThg==
X-Received: by 2002:a17:902:8a8a:b029:ec:857a:4d51 with SMTP id p10-20020a1709028a8ab02900ec857a4d51mr26042778plo.68.1619558911548;
        Tue, 27 Apr 2021 14:28:31 -0700 (PDT)
Received: from smtpclient.apple (2603-8001-6500-2faf-38d4-ff31-0f64-ab02.res6.spectrum.com. [2603:8001:6500:2faf:38d4:ff31:f64:ab02])
        by smtp.gmail.com with ESMTPSA id bf3sm2582177pjb.16.2021.04.27.14.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 14:28:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: pt_regs->ax == -ENOSYS
Date:   Tue, 27 Apr 2021 14:28:29 -0700
Message-Id: <F9F5E9D4-C1EE-455A-A6B1-4DF9D349BBAA@amacapital.net>
References: <f0240e15-223a-7600-4494-7a0a75155bdb@zytor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
In-Reply-To: <f0240e15-223a-7600-4494-7a0a75155bdb@zytor.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: iPhone Mail (18E199)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 27, 2021, at 2:15 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>=20
> =EF=BB=BFTrying to stomp out some possible cargo cult programming?
>=20
> In the process of going through the various entry code paths, I have to ad=
mit to being a bit confused why pt_regs->ax is set to -ENOSYS very early in t=
he system call path.
>=20

It has to get set to _something_, and copying orig_ax seems perhaps silly.  T=
here could also be code that relies on ptrace poking -1 into the nr resultin=
g in -ENOSYS.

> What is perhaps even more confusing is:
>=20
> __visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long n=
r)
> {
>        nr =3D syscall_enter_from_user_mode(regs, nr);
>=20
>        instrumentation_begin();
>        if (likely(nr < NR_syscalls)) {
>                nr =3D array_index_nospec(nr, NR_syscalls);
>                regs->ax =3D sys_call_table[nr](regs);
> #ifdef CONFIG_X86_X32_ABI
>        } else if (likely((nr & __X32_SYSCALL_BIT) &&
>                          (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)) {
>                nr =3D array_index_nospec(nr & ~__X32_SYSCALL_BIT,
>                                        X32_NR_syscalls);
>                regs->ax =3D x32_sys_call_table[nr](regs);
> #endif
>        }
>        instrumentation_end();
>        syscall_exit_to_user_mode(regs);
> }
> #endif
>=20
> Now, unless I'm completely out to sea, it seems to me that if syscall_ente=
r_from_user_mode() changes the system call number to an invalid number and p=
t_regs->ax to !-ENOSYS then the system call will return a different value(!)=
 depending on if it is out of range for the table (whatever was poked into p=
t_regs->ax) or if it corresponds to a hole in the table. This seems to me at=
 least to be The Wrong Thing.

I think you=E2=80=99re right.

>=20
> Calling regs->ax =3D sys_ni_syscall() in an else clause would arguably be t=
he right thing here, except possibly in the case where nr (or (int)nr, see b=
elow) =3D=3D -1 or < 0.

I think the check should be -1 for 64 bit but (u32)nr =3D=3D (u32)-1 for the=
 32-bit path. Does that seem reasonable?

>=20
> Now, syscall_get_nr() returns the low 32 bits of the system call number un=
conditionally. There are places where we look at the sign of this number, wh=
ich means that 0xffffffff7fffffff is "positive" and 0x7fffffffffffffff is "n=
egative". We have gone back and forth more than once on if we should look at=
 %rax or just %eax on a system call... I have to admit that the current desi=
gn makes me a bit nervous.
>=20
> Finally, can anything bad happen in some weird corner case inside one of t=
he syscall_*_mode() calls or after an interrupt if someone tries to call sys=
call(-1) or another negative number?
>=20
> Food for thought or just my not being up to date?
>=20
> Thanks,
>=20
>    -hpa
>=20

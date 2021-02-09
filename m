Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EA53149CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBIH5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhBIH50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:57:26 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFC6C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 23:56:45 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u11so9273146plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 23:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=IKtDbkpTW92/CPv0ahP5JLmJlZUSWpczGDc7m2oxTH8=;
        b=SkBJdGJEHT4IkA/vrqy4/eKEYfeLuq/49hO/9zSk+FVJ6OD/YMaAB4WQN4PQ6peKc0
         3bDvkqZUBcAFFyX8yOUA2LMWqC/TW8xf7aXYms8/f06DUCsXNQPu0GUK4O1SXMg5ADJj
         JTE5WPvK75VljUjWJ6asLKqFsIHvTWCC79oZMznWD+9DWQTOnvTp2CAny4RKqiyXruCI
         a0ZT4QJ+Juyj6EVXvL1V0AwUMfUBOObCwjaxVp8PXmJ69hHKSFU3oLwLa8jc6F5QGQ12
         70Lj7so1IBFWLE4zNLdG8rH+M3E6DtsaLXj8vc/hJIsJfMT2INqEZdOTVFeVE4noosF/
         ZDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=IKtDbkpTW92/CPv0ahP5JLmJlZUSWpczGDc7m2oxTH8=;
        b=OUyXMmojDmpQ1sV9damjeh0ZKXJL9j9pc6F2V2pDEbMPgsbWy+NVFpN72M4h6WURhf
         xhDotATkAs4wLSdMXA3BFjVmrDj96DjOoI32NxUGpdEk0CHsy3MUePzkrNZhViq4T6Nz
         I+uQPo4KSvVNKtoMTU3bf9e+UhPIhYuiCZerea9+IYTYi9utbUSjPFVFM7/Xw96LG6KE
         UFV9D3+5sogZpBHp10g25qIZQ8zkpwEysuzuGgRGrf5Zqy+PP33ZyF0SrMiohA7CoYYy
         wVg1VXsMSw6KJ0bizmrv3FL1UQR33MRG1OFqzCAmY0bEq6E2iwnMjPhXe2APJHNFFyc/
         gbSQ==
X-Gm-Message-State: AOAM5315lQZ4Wd5qMHRUVfq4gSETlz8/oEMtFliBhWWmzzagbI49chRa
        XYxEAYo5vkfppGf/TJ394bM=
X-Google-Smtp-Source: ABdhPJy6bPsgDzpDCTtda60Dzrws2lQ5LtiRaH1BA44OInHnVZ7+E+K3x9BMnzOXI2tDN049ftktNw==
X-Received: by 2002:a17:90a:6588:: with SMTP id k8mr2792812pjj.43.1612857405439;
        Mon, 08 Feb 2021 23:56:45 -0800 (PST)
Received: from localhost ([1.132.144.180])
        by smtp.gmail.com with ESMTPSA id n1sm6641098pgn.94.2021.02.08.23.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:56:44 -0800 (PST)
Date:   Tue, 09 Feb 2021 17:56:38 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 17/22] powerpc/syscall: Do not check unsupported scv
 vector on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <fc3afe1870f943b2010805fcb045b718a638b3c6.1612796617.git.christophe.leroy@csgroup.eu>
        <1612835741.qmlhg8iwmj.astroid@bobo.none>
        <82c4abb1-cb52-e856-b2dd-d7c7d48bd292@csgroup.eu>
In-Reply-To: <82c4abb1-cb52-e856-b2dd-d7c7d48bd292@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612857042.f9qpgkdvz6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 4:13 pm:
>=20
>=20
> Le 09/02/2021 =C3=A0 03:00, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
>>> Only PPC64 has scv. No need to check the 0x7ff0 trap on PPC32.
>>> For that, add a helper trap_is_unsupported_scv() similar to
>>> trap_is_scv().
>>>
>>> And ignore the scv parameter in syscall_exit_prepare (Save 14 cycles
>>> 346 =3D> 332 cycles)
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>> v5: Added a helper trap_is_unsupported_scv()
>>> ---
>>>   arch/powerpc/include/asm/ptrace.h | 5 +++++
>>>   arch/powerpc/kernel/entry_32.S    | 1 -
>>>   arch/powerpc/kernel/interrupt.c   | 7 +++++--
>>>   3 files changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/a=
sm/ptrace.h
>>> index 58f9dc060a7b..2c842b11a924 100644
>>> --- a/arch/powerpc/include/asm/ptrace.h
>>> +++ b/arch/powerpc/include/asm/ptrace.h
>>> @@ -229,6 +229,11 @@ static inline bool trap_is_scv(struct pt_regs *reg=
s)
>>>   	return (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && TRAP(regs) =3D=3D 0x3000=
);
>>>   }
>>>  =20
>>> +static inline bool trap_is_unsupported_scv(struct pt_regs *regs)
>>> +{
>>> +	return (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && TRAP(regs) =3D=3D 0x7ff0)=
;
>>> +}
>>=20
>> This change is good.
>>=20
>>> +
>>>   static inline bool trap_is_syscall(struct pt_regs *regs)
>>>   {
>>>   	return (trap_is_scv(regs) || TRAP(regs) =3D=3D 0xc00);
>>> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry=
_32.S
>>> index cffe58e63356..7c824e8928d0 100644
>>> --- a/arch/powerpc/kernel/entry_32.S
>>> +++ b/arch/powerpc/kernel/entry_32.S
>>> @@ -344,7 +344,6 @@ transfer_to_syscall:
>>>  =20
>>>   ret_from_syscall:
>>>   	addi    r4,r1,STACK_FRAME_OVERHEAD
>>> -	li	r5,0
>>>   	bl	syscall_exit_prepare
>>=20
>> For this one, I think it would be nice to do the "right" thing and make
>> the function prototypes different on !64S. They could then declare a
>> local const bool scv =3D 0.
>>=20
>> We could have syscall_exit_prepare and syscall_exit_prepare_maybe_scv
>> or something like that, 64s can use the latter one and the former can be
>> a wrapper that passes constant 0 for scv. Then we don't have different
>> prototypes for the same function, but you just have to make the 32-bit
>> version static inline and the 64-bit version exported to asm.
>=20
> You can't call a static inline function from ASM, I don't understand you.

I mean

#ifdef CONFIG_PPC_BOOK3S_64
notrace unsigned long syscall_exit_prepare_scv(unsigned long r3,
                                           struct pt_regs *regs,
                                           long scv)
#else
static inline long syscall_exit_prepare_scv(unsigned long r3,
                                           struct pt_regs *regs,
                                           long scv)
#endif

#ifndef CONFIG_PPC_BOOK3S_64
notrace unsigned long syscall_exit_prepare(unsigned long r3,
                                           struct pt_regs *regs)
{
	return syscall_exit_prepare_scv(r3, regs, 0);
}
#endif


>=20
> What is wrong for you really here ? Is that the fact we leave scv random,=
 or is that the below=20
> IS_ENABLED() ?

That scv arg is random. I know generated code essentially would be no=20
different and no possibility of tracing, but would just prefer to call=20
the C "correctly" if possible.

> I don't mind keeping the 'li r5,0' before calling the function if you fin=
d it cleaner, the real=20
> performance gain is with setting scv to 0 below for PPC32 (and maybe it s=
hould be set to zero for=20
> book3e/64 too ?).

Yes 64e would like this optimisation.

Thanks,
Nick

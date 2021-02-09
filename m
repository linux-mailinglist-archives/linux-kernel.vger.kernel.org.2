Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC323149BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBIHvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBIHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:51:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55925C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 23:50:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id t2so1162068pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 23:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=5g1rjOnIQG1RbAsbT1GRZgI1Y3bpjqwUB4yp5UT05gs=;
        b=uJgsPO6ncqWCxGesdI9Gh7Mm8vaFGnCgV5v1iank0VORDrOcwfEe7sJQ/LGP8vl+R5
         H8zeX1Z6TQkDjYT1t1k0EIIlki9ux4y5tqtMUaR7oenJCtXPqlyTANNENTcWBCz18rXm
         s+YySsM9MgSd98THt7aZ1g86EGGsz581WsCFeU35UnVJ4tDQBXxTnL4aZwKn+7S6SVLf
         n/YDqOKOtG6IYbicJo0owC/0RpU8kmnjqTwWMEzsu+bF3tEv08te2fMIR5e2xmfPPobQ
         hocenFn9vgW30Qs3of99gjAxK+ERKGbwAeN3ktba1dPwrQAnM5QNr6C024mXIFybwfCQ
         DCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=5g1rjOnIQG1RbAsbT1GRZgI1Y3bpjqwUB4yp5UT05gs=;
        b=HzJov8aTljjuHK8EKm9KZzx6FKmJYwn88YZ+cTUSNvhy+Vgd2C9aWYJGyESV/fLFdM
         zKHj307ucu+zSw/01gGMBe4Rf3PP/1vE+EAqO846wvszx67HOxIOyL5bLcd/dFofCAER
         pqYca2OSWHNLQelS+DsdjZccnUY4iK43MPkb7u2S2+PCoFhieNH6KurtbXtzDL8hi9pw
         Wk5sKv09aiHCmqukxvrcVhxSbij3/bdcD7vFCJBtyxlB9SQlsdExNHisMjw8EG/+fLbw
         1PTsLCnTL9MqFHr3Rfg1+N2QJ1zPNwRyT9z1uMjmCVABuk3wqFGd6dILJbCbBIvwyvhh
         MQFw==
X-Gm-Message-State: AOAM530c2yHpHYEf6nXDXbhxItgVhKBGBwOqkPIXS8KN9klppuqi8mo7
        skLC/nJdd66LmhLsDgZVERg=
X-Google-Smtp-Source: ABdhPJxqQLCI9BcmTM1hBEE93Jf49B3kTAlJG20Om8W/xcDsrZFbNyuJpTjpAnMqVXjqo3oxQueobg==
X-Received: by 2002:a17:90a:1042:: with SMTP id y2mr2943918pjd.204.1612857042967;
        Mon, 08 Feb 2021 23:50:42 -0800 (PST)
Received: from localhost ([1.132.146.111])
        by smtp.gmail.com with ESMTPSA id y4sm1511935pji.34.2021.02.08.23.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:50:42 -0800 (PST)
Date:   Tue, 09 Feb 2021 17:50:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 09/22] powerpc/syscall: Make interrupt.c buildable on
 PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <ba073ad67bd971a88ce331b65d6655523b54c794.1612796617.git.christophe.leroy@csgroup.eu>
        <1612833796.dl9doe6njg.astroid@bobo.none>
        <73fd6e9b-fe99-e804-d681-c0a22b9bef38@csgroup.eu>
In-Reply-To: <73fd6e9b-fe99-e804-d681-c0a22b9bef38@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612857002.ckz8h2ixz5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 4:02 pm:
>=20
>=20
> Le 09/02/2021 =C3=A0 02:27, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
>>> To allow building interrupt.c on PPC32, ifdef out specific PPC64
>>> code or use helpers which are available on both PP32 and PPC64
>>>
>>> Modify Makefile to always build interrupt.o
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>> v5:
>>> - Also for interrupt exit preparation
>>> - Opted out kuap related code, ppc32 keeps it in ASM for the time being
>>> ---
>>>   arch/powerpc/kernel/Makefile    |  4 ++--
>>>   arch/powerpc/kernel/interrupt.c | 31 ++++++++++++++++++++++++-------
>>>   2 files changed, 26 insertions(+), 9 deletions(-)
>>>
>=20
>>> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/inte=
rrupt.c
>>> index d6be4f9a67e5..2dac4d2bb1cf 100644
>>> --- a/arch/powerpc/kernel/interrupt.c
>>> +++ b/arch/powerpc/kernel/interrupt.c
>>> @@ -39,7 +39,7 @@ notrace long system_call_exception(long r3, long r4, =
long r5,
>>>   		BUG_ON(!(regs->msr & MSR_RI));
>>>   	BUG_ON(!(regs->msr & MSR_PR));
>>>   	BUG_ON(!FULL_REGS(regs));
>>> -	BUG_ON(regs->softe !=3D IRQS_ENABLED);
>>> +	BUG_ON(arch_irq_disabled_regs(regs));
>>>  =20
>>>   #ifdef CONFIG_PPC_PKEY
>>>   	if (mmu_has_feature(MMU_FTR_PKEY)) {
>>> @@ -65,7 +65,9 @@ notrace long system_call_exception(long r3, long r4, =
long r5,
>>>   			isync();
>>>   	} else
>>>   #endif
>>> +#ifdef CONFIG_PPC64
>>>   		kuap_check_amr();
>>> +#endif
>>=20
>> Wouldn't mind trying to get rid of these ifdefs at some point, but
>> there's some kuap / keys changes going on recently so I'm happy enough
>> to let this settle then look at whether we can refactor.
>=20
> I have a follow up series that implements interrupts entries/exits in C a=
nd that removes all kuap=20
> assembly, I will likely release it as RFC later today.
>=20
>>=20
>>>  =20
>>>   	account_cpu_user_entry();
>>>  =20
>>> @@ -318,7 +323,7 @@ notrace unsigned long syscall_exit_prepare(unsigned=
 long r3,
>>>   	return ret;
>>>   }
>>>  =20
>>> -#ifdef CONFIG_PPC_BOOK3S /* BOOK3E not yet using this */
>>> +#ifndef CONFIG_PPC_BOOK3E_64 /* BOOK3E not yet using this */
>>>   notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *reg=
s, unsigned long msr)
>>>   {
>>>   #ifdef CONFIG_PPC_BOOK3E
>>=20
>> Why are you building this for 32? I don't mind if it's just to keep
>> things similar and make it build for now, but you're not using it yet,
>> right?
>=20
> The series using that will follow, I thought it would be worth doing this=
 at once.

Yeah that's fine by me then.

Thanks,
Nick

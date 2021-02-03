Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1E30DA54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhBCM4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhBCMyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:54:02 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA7BC0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:53:21 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o7so17345791pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LOtl+4N3n7HC1FTJVHyIZDNqxeDX06oURAfIAKcKhm0=;
        b=b6TzmQGyTZeGrsFIAcz7KusQs/jmT0+vFcqvfxr55jjPJxAol7u0OU0gfk1kgTJ8hI
         VlpH16VqRzmxaOo7ppn/zN/ZGfe5NUZ0KQjKUmmTLGYqbu4mgxp/Xer2ptBT35Za0wzg
         67jt37ic3jN53srVEPGNwlD1ls6cPnMTzbH4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LOtl+4N3n7HC1FTJVHyIZDNqxeDX06oURAfIAKcKhm0=;
        b=nJSvBjnYmIds6J3eAL7CHKsYIUA5S5JaFD3ZA98r5/6fY16ZVdlcS3BCLNSJxDiL2b
         421lU2QOoyJRAAmCY+T6+MJpjvt7kNvfSD1VE2jRE5QHR268c1lpKlzePT6suWEqqWhP
         e4/xGaNb3AROcCk+lUqTP5498Unjy371B3Jasgc3+0qOpTY+V5Qb0x3hSEYP5PV0g/WB
         ic8Nzk+KmL/4sGsufYgopnUnKLFQxkHoND6ODjMeAVqDXQaDDSbve6atg023yzRZgYOM
         b5YZAFAlALSPyqk5Ol2DGuswXyqjSSWyy2bvg+bXwpzy/6dUFfk3Ap10Nojmasj/YNM8
         GLVA==
X-Gm-Message-State: AOAM531U/7NG/rQLNJxwHG2kJPX2s3nBB0HIY+RVz7/nshUJcwUYHIrY
        ygI4damJKSZ0LwXmxQNjT3/7Ug==
X-Google-Smtp-Source: ABdhPJxoxaYMqJUUweFxjd8UeCMfbqbN1x4UPxdu1S7fFkwQ6XsD5JnWtAJve9gYCSqzPSGZrPc2TQ==
X-Received: by 2002:a63:ff4f:: with SMTP id s15mr3522513pgk.62.1612356801346;
        Wed, 03 Feb 2021 04:53:21 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-1c59-4eca-f876-fd51.static.ipv6.internode.on.net. [2001:44b8:1113:6700:1c59:4eca:f876:fd51])
        by smtp.gmail.com with ESMTPSA id 9sm2288251pfy.110.2021.02.03.04.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:53:20 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Subject: Re: [PATCH v10 6/6] powerpc: Book3S 64-bit outline-only KASAN support
In-Reply-To: <4b790789-052f-76de-a289-726517026efd@csgroup.eu>
References: <20210203115946.663273-1-dja@axtens.net> <20210203115946.663273-7-dja@axtens.net> <4b790789-052f-76de-a289-726517026efd@csgroup.eu>
Date:   Wed, 03 Feb 2021 23:53:17 +1100
Message-ID: <875z39wbwi.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 03/02/2021 =C3=A0 12:59, Daniel Axtens a =C3=A9crit=C2=A0:
>> Implement a limited form of KASAN for Book3S 64-bit machines running und=
er
>> the Radix MMU, supporting only outline mode.
>>=20
>
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process=
.c
>> index a66f435dabbf..9a6fd603f0e7 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -2157,8 +2157,8 @@ void show_stack(struct task_struct *tsk, unsigned =
long *stack,
>>   			break;
>>=20=20=20
>>   		stack =3D (unsigned long *) sp;
>> -		newsp =3D stack[0];
>> -		ip =3D stack[STACK_FRAME_LR_SAVE];
>> +		newsp =3D READ_ONCE_NOCHECK(stack[0]);
>> +		ip =3D READ_ONCE_NOCHECK(stack[STACK_FRAME_LR_SAVE]);
>>   		if (!firstframe || ip !=3D lr) {
>>   			printk("%s["REG"] ["REG"] %pS",
>>   				loglvl, sp, ip, (void *)ip);
>> @@ -2176,17 +2176,19 @@ void show_stack(struct task_struct *tsk, unsigne=
d long *stack,
>>   		 * See if this is an exception frame.
>>   		 * We look for the "regshere" marker in the current frame.
>>   		 */
>> -		if (validate_sp(sp, tsk, STACK_INT_FRAME_SIZE)
>> -		    && stack[STACK_FRAME_MARKER] =3D=3D STACK_FRAME_REGS_MARKER) {
>> +		if (validate_sp(sp, tsk, STACK_INT_FRAME_SIZE) &&
>> +		    (READ_ONCE_NOCHECK(stack[STACK_FRAME_MARKER]) =3D=3D
>> +		     STACK_FRAME_REGS_MARKER)) {
>>   			struct pt_regs *regs =3D (struct pt_regs *)
>>   				(sp + STACK_FRAME_OVERHEAD);
>>=20=20=20
>> -			lr =3D regs->link;
>> +			lr =3D READ_ONCE_NOCHECK(regs->link);
>>   			printk("%s--- interrupt: %lx at %pS\n",
>> -			       loglvl, regs->trap, (void *)regs->nip);
>> +			       loglvl, READ_ONCE_NOCHECK(regs->trap),
>> +			       (void *)READ_ONCE_NOCHECK(regs->nip));
>>   			__show_regs(regs);
>>   			printk("%s--- interrupt: %lx\n",
>> -			       loglvl, regs->trap);
>> +			       loglvl, READ_ONCE_NOCHECK(regs->trap));
>>=20=20=20
>>   			firstframe =3D 1;
>>   		}
>
>
> The above changes look like a bug fix not directly related to KASAN. Shou=
ld be split out in another=20
> patch I think.

That code corresponds to the following part of the patch description:

| - Make our stack-walking code KASAN-safe by using READ_ONCE_NOCHECK -
|   generic code, arm64, s390 and x86 all do this for similar sorts of
|   reasons: when unwinding a stack, we might touch memory that KASAN has
|   marked as being out-of-bounds. In our case we often get this when
|   checking for an exception frame because we're checking an arbitrary
|   offset into the stack frame.
|
|   See commit 20955746320e ("s390/kasan: avoid false positives during stack
|   unwind"), commit bcaf669b4bdb ("arm64: disable kasan when accessing
|   frame->fp in unwind_frame"), commit 91e08ab0c851 ("x86/dumpstack:
|   Prevent KASAN false positive warnings") and commit 6e22c8366416
|   ("tracing, kasan: Silence Kasan warning in check_stack of stack_tracer")

include/linux/compiler.h describes it as follows:

/*
 * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
 * to hide memory access from KASAN.
 */

So I think it is sufficently connected with KASAN to be in this patch.

Kind regards,
Daniel

>
> Christophe

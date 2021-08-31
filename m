Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2B3FC778
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhHaMoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhHaMoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:44:03 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781CC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:43:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u1so6751214plq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1T9uonz6ZV23kuXHurfGRVVB5lj7jIMJH16i3NUSCRI=;
        b=nfZ6GVy6XIZpVYmM2uOlyVC1X/U0qS3IIyNg9Nzojxlxxo1q4qjqwJkv99OFwFFelU
         /TI02CsSbxj5tiUl8aw/d+B2sy7z/krc9mKngFTEwZ6nuyaf9z3dT9Dt4efJcgshuF27
         /tFGNWA7GjwDT+fPl83WNTH1BxiKsufoewBTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1T9uonz6ZV23kuXHurfGRVVB5lj7jIMJH16i3NUSCRI=;
        b=jVP0IaWSlSjg1c8ft3UFvZqMipydDPlsxkhRwwvNMHA8vdd7ey0L7izkI3HXfT455n
         nnZHMEpQYYz4UvJEmEP/4bibm8t86mj9tidofQHiEhevdHrOxx/hGaSBuXTMN3rrGV9H
         1iitVbAu5fOsAMyFt5BSkitvllQG7vES0muAgjNyfW989A3mQBQ+lzZt6BHkM/pC+zi9
         hc4uVkSnzGFoyAddWP6V7OtEJAA9YJZvRt/FGXJ2GCrFsBDVNPfXe1LraUfG4UmK0+d5
         XA6KlBJp2kh642b2V5Gv72+2iDPpV6z6KKpLbiKoX67sZV6085Qu9ZweWgS7nypqA0vw
         g4fg==
X-Gm-Message-State: AOAM530eYQorF189eXwZXouBtXApTw38Lo0kHUTqn7wNOU+/MiGp62po
        N0BANtHaun1V55o8zN+bDkECBzBZGGa1gw==
X-Google-Smtp-Source: ABdhPJy8ox3UGj+wMMB7zStDq/2+tdrLtd+0Un35XhLM9MdTTTqfb0lFaJjKx8bldixJYj9H8JfvFw==
X-Received: by 2002:a17:902:7c93:b029:12c:b603:150d with SMTP id y19-20020a1709027c93b029012cb603150dmr4544469pll.5.1630413787686;
        Tue, 31 Aug 2021 05:43:07 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:a664:ffe7:ee94:4600])
        by smtp.gmail.com with ESMTPSA id t38sm17484590pfg.207.2021.08.31.05.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 05:43:07 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64: Avoid link stack corruption in kexec_wait()
In-Reply-To: <9f43118b-ef81-9a80-0e0b-5e74433e0b8c@csgroup.eu>
References: <3ffe7775f3fcda8e5fca6a7bc7db0b8251153c67.1629705147.git.christophe.leroy@csgroup.eu>
 <87ilzm6str.fsf@dja-thinkpad.axtens.net>
 <9f43118b-ef81-9a80-0e0b-5e74433e0b8c@csgroup.eu>
Date:   Tue, 31 Aug 2021 22:43:04 +1000
Message-ID: <87fsup7pk7.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 31/08/2021 =C3=A0 08:17, Daniel Axtens a =C3=A9crit=C2=A0:
>> Hi Christophe,
>>=20
>>> Use bcl 20,31,+4 instead of bl in order to preserve link stack.
>>>
>>> See commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
>>> in __get_datapage()") for details.
>>=20
>>  From my understanding of that commit message, the change helps to keep
>> the link stack correctly balanced which is helpful for performance,
>> rather than for correctness. If I understand correctly, kexec_wait is
>> not in a hot path - rather it is where CPUs spin while waiting for
>> kexec. Is there any benefit in using the more complicated opcode in this
>> situation?
>
> AFAICS the main benefit is to keep things consistent over the kernel and =
not have to wonder "is it a=20
> hot path or not ? If it is I use bcl 20,31, if it is not I use bl". The b=
est way to keep things in=20
> order is to always use the right instruction.

Yeah, Nick Piggin convinced me of this offline as well.

>
>>=20
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/powerpc/kernel/misc_64.S | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_6=
4.S
>>> index 4b761a18a74d..613509907166 100644
>>> --- a/arch/powerpc/kernel/misc_64.S
>>> +++ b/arch/powerpc/kernel/misc_64.S
>>> @@ -255,7 +255,7 @@ _GLOBAL(scom970_write)
>>>    * Physical (hardware) cpu id should be in r3.
>>>    */
>>>   _GLOBAL(kexec_wait)
>>> -	bl	1f
>>> +	bcl	20,31,1f
>>>   1:	mflr	r5
>>=20
>> Would it be better to create a macro of some sort to wrap this unusual
>> special form so that the meaning is more clear?
>
> Not sure, I think people working with assembly will easily recognise that=
 form whereas an obscure=20
> macro is always puzzling.
>
> I like macros when they allow you to not repeat again and again the same =
sequence of several=20
> instructions, but here it is a single quite simple instruction which is n=
ot worth a macro in my mind.
>


Sure - I was mostly thinking specifically of the bcl; mflr situation but
I agree that for the single instruction it's not needed.

In short, I am convinced, and so:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

> Christophe

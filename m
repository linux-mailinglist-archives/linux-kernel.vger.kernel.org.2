Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36EC30B7ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 07:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhBBGjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 01:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhBBGjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 01:39:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BCCC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 22:38:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y10so7646762plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 22:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=vD1g1+uwOQCPPPbfxm4dRfRFhp8B4sJeqT21+NMMZj0=;
        b=lioIuEDZEfEtPfnANMGtZBsMHPclUfU18q1WLAjxe8PVPtc8cfYs8G3JnwaJOoEp/9
         6Xxzrja4O9ltDVFw9yaa3hZIKyr8FSGTUdfa0ShN0rh4tFXaRWFLJrBO18xD2vMqLPHb
         6MpAAGchKqxd+0FB5wix1XKkK7v/sLPVbH370VcmY6flKnlp9SGzD42lO/D44weaNSXA
         3y49TGlJlCWk8YT2doXfFRwietzJeonLNblJiwZWDuuUf5OmTdO685R+02Q8hAP906mC
         LaCrE+DH9oQ+DhAagQHBQx4fQBUOTC5k27aLPe8YaGH7vah2Xda4+AyI90DL0SejBo8p
         GBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=vD1g1+uwOQCPPPbfxm4dRfRFhp8B4sJeqT21+NMMZj0=;
        b=YS2kfxCjsBRZ/Ua44I/OYtWtvYsbED6Nfl/+Izdz1RYRznEOnnPxj72Be06gAexwjl
         +S0dXY032Pxfg/tgybXu5iDvS1bcwtfqFXRRm0gyItVGMdfhbUpIZiGNFRCpERHbUGw5
         rjeRFPdYD5fbVRnojF5cqkYDciEgeystHLYV1Lk6mxmyHtaIS/4tD9bUj9PDsKCE7afK
         X8RRaAVIP0FeFJQLDn/Oqa6DR560WN3ZIw+bLDz+2+vwtrZtjI4dGF3IKXH7y5xLpg3L
         aNg4rWT4fxvWCV2P50Aw1/p80WDbbg7efNuaJu1sQPEszMY5hLbmHF2FVdEVINY9BDBM
         mT5w==
X-Gm-Message-State: AOAM532NSvPJpyx4jDX9q2+iqljun6JN7XVAAMsWZ28S3rqAaR0ZYZBI
        2guU3ORlfT2C3bRBglhK4HQ=
X-Google-Smtp-Source: ABdhPJwCiQVbVMJIuCyFwf8iv/Nr9wAGKz0HGRgq8WpMG2KH+TF0oxWr5AEMvOcI9r5OdNQDQrNomQ==
X-Received: by 2002:a17:90a:1082:: with SMTP id c2mr2739120pja.183.1612247917959;
        Mon, 01 Feb 2021 22:38:37 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id p2sm1687782pjj.0.2021.02.01.22.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 22:38:37 -0800 (PST)
Date:   Tue, 02 Feb 2021 16:38:31 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 11/23] powerpc/syscall: Rename syscall_64.c into
 syscall.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Laight <David.Laight@ACULAB.COM>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        Paul Mackerras <paulus@samba.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
        <ff9dd4accdc897013594768833d54444e4823bf9.1611585031.git.christophe.leroy@csgroup.eu>
        <1611656343.yaxha7r2q4.astroid@bobo.none>
        <d9993f034db848d1afeffa322373b811@AcuMS.aculab.com>
        <1611791083.sqnnh21vv0.astroid@bobo.none>
        <0cf90825-da89-6464-98d4-dc7490bff557@csgroup.eu>
In-Reply-To: <0cf90825-da89-6464-98d4-dc7490bff557@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612247170.ea0f766ml4.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 2, 2021 4:15 pm:
>=20
>=20
> Le 28/01/2021 =C3=A0 00:50, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from David Laight's message of January 26, 2021 8:28 pm:
>>> From: Nicholas Piggin
>>>> Sent: 26 January 2021 10:21
>>>>
>>>> Excerpts from Christophe Leroy's message of January 26, 2021 12:48 am:
>>>>> syscall_64.c will be reused almost as is for PPC32.
>>>>>
>>>>> Rename it syscall.c
>>>>
>>>> Could you rename it to interrupt.c instead? A system call is an
>>>> interrupt, and the file now also has code to return from other
>>>> interrupts as well, and it matches the new asm/interrupt.h from
>>>> the interrupts series.
>>>
>>> Hmmm....
>>>
>>> That might make it harder for someone looking for the system call
>>> entry code to find it.
>>=20
>> It's very grep'able.
>>=20
>>> In some sense interrupts are the simpler case.
>>>
>>> Especially when comparing with other architectures which have
>>> special instructions for syscall entry.
>>=20
>> powerpc does have a special instruction for syscall, and it causes a
>> system call interrupt.
>>=20
>> I'm not sure about other architectures, but for powerpc its more
>> sensible to call it interrupt.c than syscall.c.
>=20
> Many other architectures have a syscall.c but for a different purpose: it=
 contains arch specific=20
> system calls. We have that in powerpc as well, it is called syscalls.c
>=20
> So to avoid confusion, I'll rename it. But I think "interrupt" is maybe n=
ot the right name. An=20
> interrupt most of the time refers to IRQ.

That depends what you mean by interrupt and IRQ.

Linux kind of considers any asynchronous maskable interrupt an irq=20
(local_irq_disable()). But if you say irq it's more likely to mean
a device interrupt, and "interrupt" usually refres to the asynch
ones.

But Linux doesn't really assign names to synchronous interrupts in
core code. It doesn't say they aren't interrupts, it just doesn't
really have a convention for them at all.

Other architectures e.g., x86 also have things like interrupt
descriptor table for synchronous interrupts as well. That's where
I got the interrupt wrappers code from actually.

So it's really fine to use the proper arch-specific names for things
in arch code. I'm trying to slowly change names from exception to
interrupt.

> For me system call is not an interrupt in the way it=20
> doesn't unexpectedly interrupt a program flow. In powerpc manuals it is g=
enerally called exceptions,=20
> no I'm more inclined to call it exception.c

Actually that's backwards. Powerpc manuals (at least the one I look at)=20
calls them all interrupts including system calls, and also the system
call interrupt is actually the only one that doesn't appear to be
associated with an exception.

Also there is no distinction about expecte/unexpected -- a data storage=20
interrupt is expected if you access a location without the right access=20
permissions for example, but it is still an interrupt.

These handlers very specifically deal with the change to execution flow
(i.e., the interrupt), they do *not* deal with the exception which may=20
be associated with it (that is the job of the handler).

And on the other hand you can deal with exceptions in some cases without
taking an interrupt at all. For example if you had MSR[EE]=3D0 you could
change the decrementer or execute msgclr or change HMER SPR etc to clear
various exceptions without ever taking the interrupt.

Thanks,
Nick

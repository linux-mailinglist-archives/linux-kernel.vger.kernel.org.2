Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F963E03A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhHDOqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhHDOqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:46:09 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89135C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 07:45:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u16so3265616ple.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=P8L654BT1qD/OuJQ67qVjzfF7qTMazs5HMM0i+7RRcU=;
        b=fwuZTS2ikg4ACOiCjTD3LaULWWQfkT6c5+djcaSAxEdN887vXddrjiEPZJTGjhao4W
         4XXCqUZFuOW7vRaVDQuYzrx2RxgSJ6XDKIKdfOrUdf8mXVJMuMAaEvJ2VOiDMtSQWsI8
         uvF+0bAm30zV+6/a9+/RJsvA0trmPceQgiFakE8lJj+vNxQxeTfCE6DJI7j4MOcdVwZ9
         ArgXHlyYuAYaT/KJwoMVDARa+rLS5gwK1EQ2eC/3QZK3yJ3TLtg6gAskMF8mE5lQ05M5
         UOlmoo6diMCotD5tufmYGe57o96OtQ9HH+C9IUO33C+OdhA3EoK1KK3jI4paAXw5hB73
         h4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=P8L654BT1qD/OuJQ67qVjzfF7qTMazs5HMM0i+7RRcU=;
        b=hA7uf6myTdevbmKLfwu5dnqn6u+Omy9r/mv/IO9vh/HUbDtu2DOqNuJ0EvWolHSEsS
         5l9JI9k1MOPpcjH4mlO4WkfvtLnanqlXADOaq91os5MNGV7Md1hkuIEJPKNSusX2VpZw
         qheJJfuHvf6r61zjnUMvU1mOSJ5n3wO9bLcJ5ulfEeHDLYOJNZpNpt5K86RkG3Ah4f5Y
         qEjE2rLM6TMq7NnHyrB2y2QGKeIi2dhT0do4tzLYV8xPJl8NnTPmSTtA9zFeRlchHpva
         x4AbO/+wCcfk92RcL6dXSD8F3cmQCJ/Lrb0+dsEZJh8lX+eaZZiONlbI2SLbTzUy7G4Z
         zvng==
X-Gm-Message-State: AOAM533XUv6EpyKuieENL1ZBzOvU388BF1i6b3o8p/baYupVUZrg5pey
        4H3nxJs0fRZiqzWD9UHbko94Zbs9H2w=
X-Google-Smtp-Source: ABdhPJxLmkmmgouPLnRDtGmrVMfLMsXI77C3t2tw1c5wn0y6G7joHKaNpwWijYksY1TkSpEX0KgijA==
X-Received: by 2002:a05:6a00:b83:b029:352:9507:f3b9 with SMTP id g3-20020a056a000b83b02903529507f3b9mr27559882pfj.13.1628088356088;
        Wed, 04 Aug 2021 07:45:56 -0700 (PDT)
Received: from localhost (60-242-181-102.static.tpgi.com.au. [60.242.181.102])
        by smtp.gmail.com with ESMTPSA id g1sm3246958pfo.0.2021.08.04.07.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:45:55 -0700 (PDT)
Date:   Thu, 05 Aug 2021 00:45:50 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/32s: Fix napping restore in data storage
 interrupt (DSI)
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Finn Thain <fthain@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, userm57@yahoo.com
References: <731694e0885271f6ee9ffc179eb4bcee78313682.1628003562.git.christophe.leroy@csgroup.eu>
        <ce20d16c-b0b2-94c-3e22-794d95c376b@linux-m68k.org>
        <b04a90a9-9d62-2192-f896-ea99be911604@csgroup.eu>
        <8fb08f68-ed01-65f9-fb9e-66abf2b18a00@csgroup.eu>
        <1628068469.gv4bl1fw7w.astroid@bobo.none>
        <d8e1f924-ca60-4dcc-ac5f-3801ea226edf@csgroup.eu>
In-Reply-To: <d8e1f924-ca60-4dcc-ac5f-3801ea226edf@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1628085762.7z2g9ulayj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of August 4, 2021 11:28 pm:
>=20
>=20
> Le 04/08/2021 =C3=A0 13:36, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of August 4, 2021 4:21 pm:
>>> Hi Nic,
>>>
>>> I think I'll need your help on that one.
>>>
>>> Le 04/08/2021 =C3=A0 08:07, Christophe Leroy a =C3=A9crit=C2=A0:
>>>>
>>>>
>>>> Le 04/08/2021 =C3=A0 06:04, Finn Thain a =C3=A9crit=C2=A0:
>>=20
>> Hi Finn!
>>=20
>>>>> On Tue, 3 Aug 2021, Christophe Leroy wrote:
>>>>>
>>> ...
>>>>>
>>>>> ------------[ cut here ]------------
>>>>> kernel BUG at arch/powerpc/kernel/interrupt.c:49!
>>>>> Oops: Exception in kernel mode, sig: 5 [#1]
>>>>> BE PAGE_SIZE=3D4K MMU=3DHash SMP NR_CPUS=3D2 PowerMac
>>>>> Modules linked in:
>>>>> CPU: 0 PID: 1859 Comm: xfce4-session Not tainted 5.13.0-pmac-VMAP #10
>>>>> NIP:=C2=A0 c0011474 LR: c0011464 CTR: 00000000
>>>>> REGS: e2f75e40 TRAP: 0700=C2=A0=C2=A0 Not tainted=C2=A0 (5.13.0-pmac-=
VMAP)
>>>>> MSR:=C2=A0 00021032 <ME,IR,DR,RI>=C2=A0 CR: 2400446c=C2=A0 XER: 20000=
000
>>>>>
>>>>> GPR00: c001604c e2f75f00 ca284a60 00000000 00000000 a5205eb0 00000008=
 00000020
>>>>> GPR08: ffffffc0 00000001 501200d9 ce030005 ca285010 00c1f778 00000000=
 00000000
>>>>> GPR16: 00945b20 009402f8 00000001 a6b87550 a51fd000 afb73220 a6b22c78=
 a6a6aecc
>>>>> GPR24: 00000000 ffffffc0 00000020 00000008 a5205eb0 00000000 e2f75f40=
 000000ae
>>>>> NIP [c0011474] system_call_exception+0x60/0x164
>>>>> LR [c0011464] system_call_exception+0x50/0x164
>>>>> Call Trace:
>>>>> [e2f75f00] [00009000] 0x9000 (unreliable)
>>>>> [e2f75f30] [c001604c] ret_from_syscall+0x0/0x28
>>>>> --- interrupt: c00 at 0xa69d6cb0
>>>>> NIP:=C2=A0 a69d6cb0 LR: a69d6c3c CTR: 00000000
>>>>> REGS: e2f75f40 TRAP: 0c00=C2=A0=C2=A0 Not tainted=C2=A0 (5.13.0-pmac-=
VMAP)
>>>>> MSR:=C2=A0 0000d032 <EE,PR,ME,IR,DR,RI>=C2=A0 CR: 2400446c=C2=A0 XER:=
 20000000
>>>>>
>>>>> GPR00: 000000ae a5205de0 a5687ca0 00000000 00000000 a5205eb0 00000008=
 00000020
>>>>> GPR08: ffffffc0 401201ea 401200d9 ffffffff c158f230 00c1f778 00000000=
 00000000
>>>>> GPR16: 00945b20 009402f8 00000001 a6b87550 a51fd000 afb73220 a6b22c78=
 a6a6aecc
>>>>> GPR24: afb72fc8 00000000 00000001 a5205f30 afb733dc 00000000 a6b85ff4=
 a5205eb0
>>>>> NIP [a69d6cb0] 0xa69d6cb0
>>>>> LR [a69d6c3c] 0xa69d6c3c
>>>>> --- interrupt: c00
>>>>> Instruction dump:
>>>>> 7cdb3378 93810020 7cbc2b78 93a10024 7c9d2378 93e1002c 7d3f4b78 4800d6=
29
>>>>> 817e0084 931e0088 69690002 5529fffe <0f090000> 69694000 552997fe 0f09=
0000
>>>>> ---[ end trace c66c6c3c44806276 ]---
>>>>>
>>>
>>> Getting a BUG at arch/powerpc/kernel/interrupt.c:49 meaning MSR_RI is n=
ot set, but the c00 interrupt
>>> frame shows MSR_RI properly set, so what ?
>>=20
>> Could the stack be correct but regs pointer incorrect?
>>=20
>> Instruction dump is
>>=20
>>     0:   78 33 db 7c     mr      r27,r6
>>     4:   20 00 81 93     stw     r28,32(r1)
>>     8:   78 2b bc 7c     mr      r28,r5
>>     c:   24 00 a1 93     stw     r29,36(r1)
>>    10:   78 23 9d 7c     mr      r29,r4
>>    14:   2c 00 e1 93     stw     r31,44(r1)
>>    18:   78 4b 3f 7d     mr      r31,r9
>>    1c:   29 d6 00 48     bl      0xd644
>>    20:   84 00 7e 81     lwz     r11,132(r30)
>>    24:   88 00 1e 93     stw     r24,136(r30)
>>    28:   02 00 69 69     xori    r9,r11,2
>>    2c:   fe ff 29 55     rlwinm  r9,r9,31,31,31
>>    30:   00 00 09 0f     twnei   r9,0
>>    34:   00 40 69 69     xori    r9,r11,16384
>>    38:   fe 97 29 55     rlwinm  r9,r9,18,31,31
>>    3c:   00 00 09 0f     twnei   r9,0
>>=20
>> regs->msr is in r11 =3D=3D 0xce030005 so some kernel address?
>>=20
>> r1  =3D=3D 0xe2f75f00
>> r30 =3D=3D 0xe2f75f40
>>=20
>> I think that matches if the function allocates 48 bytes of stack.
>> STACK_FRAME_OVERHEAD is 16, so the difference would be 0x40 in that
>> case. Seems okay.
>>=20
>> I'm not sure then. Can you get a hash fault interrupt come in here
>> because of the vmap stack access and clobber r11? Hmm...
>>=20
>> fast_hash_page_return:
>>          andis.  r10, r9, SRR1_ISI_NOPT@h        /* Set on ISI, cleared =
on DSI */
>>=20
>> Is that really right? DSI can set this bit for NOHPTE as well no?
>=20
> On DSI, the error bits are in DSISR while they are in SRR1 on ISI.
>=20
> r9 is supposed to contain SRR1 in both cases. Powerpc 32 bits programming=
 manual explicitely says=20
> that bits 1-4 and 10-15 of SRR1 are cleared on DSI.

Ah right, I had in mind it was DSISR on DSI and SRR1 on ISI because
we put them together early on 64s. Can't think of anything else at the=20
moment.

Thanks,
Nick


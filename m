Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FA23DFD53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhHDIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhHDIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:54:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490D7C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 01:53:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e21so2288329pla.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=jAaZlMkl00zT0OtQniQ7FZrvBURnMn0WpyG8CxlOJn4=;
        b=fk37KOcrmxMPrw7cXIiBvrn80IgC1iRB7IkdNmQkax/PkAu2NsEsTirizGutmU0QG3
         VOTUOnlbIbIdLU0C4uyIcoRR6n4b/fVNrmKQNEezNIobfi1RL5uwvOj39pFxVgRTEy7H
         AvGcHpBt8z3iaVpcL+yI3PzBkSXCtI3XLjQQkvm8URA0+/IcP1KxVDb7Xyk2csBABKZ+
         OTv00GJ1mmF+6sI5vx+ExobgY5rfNtwZNlDkIr38Dd5SRIl39N6BIHjCT7AfiPFL/gqH
         Y5n/jMA4zpg1cXov+VHFc1ZKEG6zqaiOIa2bttWvHaATHK+M8V1EEGMEaPbbEaP1hTA0
         oNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=jAaZlMkl00zT0OtQniQ7FZrvBURnMn0WpyG8CxlOJn4=;
        b=jLd0HKm2kTFr3954UMmi5128b+NHo28VHN3oJ66bFl03i0V6ZkZIDF+ul869y/Mfwx
         zHJH6S+kMlo55nl4OxDkDp8nJZxxXzP/j3VXoqQ6gKCg+AdTw2Wa+6b3N+AXIrljHhM/
         hAnB52p5wi1jr4T5ptApoCg/97kr5r0tv14u/EiyTdQr2yJ6P0zftbNZFEYw94O6BWbm
         B9LCIryjO6SdFZmz0M9nciaSIeiGpPv9nodL3iQc8EDNLFYYUzzweKgbUFcDLv/7T+64
         mNcbdHcvF1ScIEoMX4ZfpQ27KR7Tbw3o4QVVrQuno0PLGGHCdJ4Ef92AF1okMa24tMXj
         G4yw==
X-Gm-Message-State: AOAM532xjBo7X9DhYcMrDRXMfeonjThMTZswUXAStQfaepErofGcS9za
        nsT3HEvWVjLkvLAjntwiGOs=
X-Google-Smtp-Source: ABdhPJwcXvw0oSoxqi2MuD7Y5yzBqeL8SRppbr8D0zPLRVYAgmrTaQA5Pd9K8CuLIjyynNaYi0XY+Q==
X-Received: by 2002:a17:902:b78b:b029:12c:6f89:51aa with SMTP id e11-20020a170902b78bb029012c6f8951aamr21910891pls.3.1628067232884;
        Wed, 04 Aug 2021 01:53:52 -0700 (PDT)
Received: from localhost (60-242-181-102.static.tpgi.com.au. [60.242.181.102])
        by smtp.gmail.com with ESMTPSA id u13sm1893006pfh.123.2021.08.04.01.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 01:53:52 -0700 (PDT)
Date:   Wed, 04 Aug 2021 18:53:47 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: Remove MSR_PR check in
 interrupt_exit_{user/kernel}_prepare()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <b36623df00ef3d2296f928487b6e23f93a217afa.1628054802.git.christophe.leroy@csgroup.eu>
        <1628064412.48kzr1eula.astroid@bobo.none>
        <cd5f54fd-fbf4-e471-9971-1e8c86755754@csgroup.eu>
In-Reply-To: <cd5f54fd-fbf4-e471-9971-1e8c86755754@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1628067212.yli25q0lwj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of August 4, 2021 6:37 pm:
>=20
>=20
> Le 04/08/2021 =C3=A0 10:08, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of August 4, 2021 3:27 pm:
>>> In those hot functions that are called at every interrupt, any saved
>>> cycle is worth it.
>>>
>>> interrupt_exit_user_prepare() and interrupt_exit_kernel_prepare() are
>>> called from three places:
>>> - From entry_32.S
>>> - From interrupt_64.S
>>> - From interrupt_exit_user_restart() and interrupt_exit_kernel_restart(=
)
>>>
>>> In entry_32.S, there are inambiguously called based on MSR_PR:
>>>
>>> 	interrupt_return:
>>> 		lwz	r4,_MSR(r1)
>>> 		addi	r3,r1,STACK_FRAME_OVERHEAD
>>> 		andi.	r0,r4,MSR_PR
>>> 		beq	.Lkernel_interrupt_return
>>> 		bl	interrupt_exit_user_prepare
>>> 	...
>>> 	.Lkernel_interrupt_return:
>>> 		bl	interrupt_exit_kernel_prepare
>>>
>>> In interrupt_64.S, that's similar:
>>>
>>> 	interrupt_return_\srr\():
>>> 		ld	r4,_MSR(r1)
>>> 		andi.	r0,r4,MSR_PR
>>> 		beq	interrupt_return_\srr\()_kernel
>>> 	interrupt_return_\srr\()_user: /* make backtraces match the _kernel va=
riant */
>>> 		addi	r3,r1,STACK_FRAME_OVERHEAD
>>> 		bl	interrupt_exit_user_prepare
>>> 	...
>>> 	interrupt_return_\srr\()_kernel:
>>> 		addi	r3,r1,STACK_FRAME_OVERHEAD
>>> 		bl	interrupt_exit_kernel_prepare
>>>
>>> In interrupt_exit_user_restart() and interrupt_exit_kernel_restart(),
>>> MSR_PR is verified respectively by BUG_ON(!user_mode(regs)) and
>>> BUG_ON(user_mode(regs)) prior to calling interrupt_exit_user_prepare()
>>> and interrupt_exit_kernel_prepare().
>>>
>>> The verification in interrupt_exit_user_prepare() and
>>> interrupt_exit_kernel_prepare() are therefore useless and can be remove=
d.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>=20
>> Probably okay to do now things are ironing out.
>>=20
>> Unless we want to make a new define for interrupt handler debug and put
>> a bunch of these asserts under it. There's quite a lot more here, and
>> in asm/interrupt.h, etc.
>=20
> But that one is so trivial that I'm not sure there is any point in keepin=
g it even as a kind of=20
> additional DEBUG level, unless you want those BUG_ONs because you don't t=
rust the compiler.

Fair point.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

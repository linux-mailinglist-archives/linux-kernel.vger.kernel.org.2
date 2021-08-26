Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9183F8AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbhHZPFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhHZPFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:05:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5982C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:04:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k24so3300465pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Cob2RUhWAcEaeA//3zLd/8IlPPHsYtXjUY5LhWVYGsE=;
        b=M4z1byWrMqrdBM022DQOMxPzkwXcBBHvojZqiZlR+RCfvVgFLm5Cwx2BHv1zab8o6q
         5NompJCPFB4A+4oIKIhKUkE2S9jjWIGSikDtn0HdHQ5wDsVMt/h4X/3u8MNvU+E091y4
         IQUcJQaTE9XXt7PiadWe+DL9MshYDRRfXNkdQjGPCtUszpyYk7+Ly4iTVHDwL5SOsSHa
         s1F4y7Hm+YMnrvPFcZZ9IY6vcjMVY6doBluPDj96+eZcg4Ni3lxpGF8bYhB9kvPBhaHY
         QBxEeq13O9KKR9O0S/Mhq8m0LvudQtC9Rc13DAWz1ZVwCyg6K34Hs3bMIp2bIYHSjMvf
         gxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Cob2RUhWAcEaeA//3zLd/8IlPPHsYtXjUY5LhWVYGsE=;
        b=Ij7PHjSQpRLFGYS8EbqgQ9uRF2wMltp9rEhFXly+Qb7vuBR1w6X9N2z64/Jp/8rGKJ
         a1tRagKAnCMv6DBQ/uvEjBsyAqhkyX9bA7C7fIT83cuGrLT9OSbQ1TbhyYBZw6HwPlTn
         28ignAyOpDxGZn0jbckfb+WlMKBudgJYJXXSDtVqQTKFHTH5Mr8Z3B7bELpFL+jiTrbw
         ewTEI8wqAV37pNpGJSLbFDzscW4zn32PRaQEhK+E+LVr63N52GCm0SRw5LWhaBqlNCG0
         JG2VyLMEqHO97pSWCLjAWkVhOssGJ6ZU/zLA915zMjoGMBtFhgyzn2ChkniqlAdyygof
         +exQ==
X-Gm-Message-State: AOAM532YRZS0mXLD38qhTMeGCFMTPiyQQUQZqdsPbVPCQSGoKgnPQddR
        drVmyorfydKedNYPv22ypPM=
X-Google-Smtp-Source: ABdhPJyZ9lTKc1LpWB4eAQOFClkGPQgBNEmilLXLk4Fzje/XARSHOyYMnBh2W8c4PALLBvOth18n7w==
X-Received: by 2002:a05:6a00:2171:b029:3ab:eca3:af59 with SMTP id r17-20020a056a002171b02903abeca3af59mr4263197pff.46.1629990282261;
        Thu, 26 Aug 2021 08:04:42 -0700 (PDT)
Received: from localhost (220-244-72-10.tpgi.com.au. [220.244.72.10])
        by smtp.gmail.com with ESMTPSA id x4sm3608641pff.126.2021.08.26.08.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 08:04:42 -0700 (PDT)
Date:   Fri, 27 Aug 2021 01:04:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/bug: Remove specific powerpc BUG_ON() and
 WARN_ON() on PPC32
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
        <1628834356.pr4zgn1xf1.astroid@bobo.none>
        <20210818150653.GJ1583@gate.crashing.org>
        <1629946707.f6ptz0tgle.astroid@bobo.none>
        <20210826124901.GY1583@gate.crashing.org>
        <1629983260.5jkx2jf0y8.astroid@bobo.none>
        <20210826143708.GC1583@gate.crashing.org>
In-Reply-To: <20210826143708.GC1583@gate.crashing.org>
MIME-Version: 1.0
Message-Id: <1629989540.drlhb24t2w.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Segher Boessenkool's message of August 27, 2021 12:37 am:
> On Thu, Aug 26, 2021 at 11:57:52PM +1000, Nicholas Piggin wrote:
>> Excerpts from Segher Boessenkool's message of August 26, 2021 10:49 pm:
>> > On Thu, Aug 26, 2021 at 01:26:14PM +1000, Nicholas Piggin wrote:
>> >> Excerpts from Segher Boessenkool's message of August 19, 2021 1:06 am=
:
>> >> > On Fri, Aug 13, 2021 at 04:08:13PM +1000, Nicholas Piggin wrote:
>> >> >> This one possibly the branches end up in predictors, whereas condi=
tional=20
>> >> >> trap is always just speculated not to hit. Branches may also have =
a
>> >> >> throughput limit on execution whereas trap could be more (1 per cy=
cle
>> >> >> vs 4 per cycle on POWER9).
>> >> >=20
>> >> > I thought only *taken* branches are just one per cycle?
>> >>=20
>> >> Taken branches are fetched by the front end at one per cycle (assumin=
g=20
>> >> they hit the BTAC), but all branches have to be executed by BR at one=
=20
>> >> per cycle
>> >=20
>> > This is not true.  (Simple) predicted not-taken conditional branches a=
re
>> > just folded out, never hit the issue queues.  And they are fetched as
>> > many together as fit in a fetch group, can complete without limits as
>> > well.
>>=20
>> No, they are all dispatched and issue to the BRU for execution. It's=20
>> trivial to construct a test of a lot of not taken branches in a row
>> and time a loop of it to see it executes at 1 cycle per branch.
>=20
> (s/dispatched/issued/)

?

>=20
> Huh, this was true on p8 already.  Sorry for my confusion.  In my
> defence, this doesn't matter for performance on "real code".
>=20
>> > Correctly predicted simple conditional branches just get their predict=
ion
>> > validated (and that is not done in the execution units).  Incorrectly
>> > predicted branches the same, but those cause a redirect and refetch.
>>=20
>> How could it validate prediction without issuing? It wouldn't know when
>> sources are ready.
>=20
> In the backend.  But that is just how it worked on older cores :-/

Okay. I don't know about older cores than POWER9. Backend would normally=20
include execution though. Only other place you could do it if you don't
issue/exec would be after it goes back in order, like completion. But
that would be horrible for mispredict penalty.

>> >> The first problem seems like the show stopper though. AFAIKS it would=
=20
>> >> need a special builtin support that does something to create the tabl=
e
>> >> entry, or a guarantee that we could put an inline asm right after the
>> >> builtin as a recognized pattern and that would give us the instructio=
n
>> >> following the trap.
>> >=20
>> > I'm not quite sure what this means.  Can't you always just put a
>> >=20
>> > bla:	asm("");
>> >=20
>> > in there, and use the address of "bla"?
>>=20
>> Not AFAIKS. Put it where?
>=20
> After wherever you want to know the address after.  You will have to
> make sure they stay together somehow.

I still don't follow.

> It is much easier to get the address of something, not the address after
> it.  If you know it is just one insn anyway, that isn't hard to handle
> either (even if prefixed insns exist).
>=20
>> > If not, you need to say a lot
>> > more about what you actually want to do :-/
>>=20
>> We need to put the address (or relative offset) of the trap instruction
>> into an entry in a different section. Basically this:
>>=20
>>    __builtin_trap();
>>    asm ("1:                               \n\t"
>>         "    .section __bug_table,\"aw\"  \n\t"
>>         "2:  .4byte 1b - 2b - 4           \n\t"
>>         "    .previous");
>>=20
>> Where the 1: label must follow immediately after the trap instruction,=20
>> and where the asm must be emitted even for the case of no-return traps=20
>> (but anything following the asm could be omitted).
>=20
> The address *after* the trap insn?  That is much much harder than the
> address *of* the trap insn.

No the address of the trap instruction, hence the -4. I have the label
after because that is the semantics I have from inline asm.

If you could give a built in that put a label at the address of the trap=20
instruction that could be used later by inline asm then that could work
too:

    __builtin_labeled_trap("1:");
    asm ("    .section __bug_table,\"aw\"  \n\t"
         "2:  .4byte 1b - 2b               \n\t"
         "    .previous");

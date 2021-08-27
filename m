Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2383F91EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 03:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbhH0B3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 21:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhH0B3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 21:29:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A61C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 18:28:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so7835380pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 18:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=sW8AGYIk/UaGtGqdRe+NjeOpRZWC7qxLFst7xNdC0P0=;
        b=NA9GElv4yx2yFAsW8GYz0PWrtd793+HB9JwiDJjGJeG9ze2sjL8rd5kEvMeSagaIhu
         plKh710FVM8K7UIHpjWJ5vixYMm7MV5nROhYAYEw9zCGNAhaXlEj/kYY3KgR7/WLP6nL
         oeNsuz0Cv7nqhqDF1UjRH0BC6H4jQ+lhdo5F6BLdXCd7xIyjesNPbCCRGAdFXiv2Z6h8
         A8tDhe4R4JnWx36RHXRgoqQqxfMy35tvryWao1PpGKvw2H49s3aevoHsSKMpQH6r49am
         BWIxAmhpgaqxJZqh1uBC4R5APVJktAY0PrPkF6NL8bskHktZJc+SJKInoNXYgY9w8rJd
         wT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=sW8AGYIk/UaGtGqdRe+NjeOpRZWC7qxLFst7xNdC0P0=;
        b=MkvR0cvKd3zk7MZvUJY/j4YzSP0WVDSWeARVku6Dn/GetUIEsoQOZXR8/eHS9HCirJ
         w77mXR26o46FgVicBNjdQ7/zBn6DmzuLmBkyQynC+boZ5I/qwWhJ8da7BntPuBcAtNph
         deVp7oGVSw+5FASPku68QEHtQoo6e8XqtLMU6j1ut8+y2SIMnTo7CmOo0EszH6jWJzZN
         mtbJOjdLKmIBBmVRtqb5aCASVqKmcTCnex6RrXQ5wByheuxylSeGTN//flIhEF/ofAgU
         5Un29ECZrDABV+WqOb/IaPLD9xqNkEzBFQpv4ioenWORPc9WZnuJnRklA5oYM3xwapDP
         XsZQ==
X-Gm-Message-State: AOAM531hvwAShMmoN6VFY/Ah5x53zp9rZQIUmbgwK73LVUtHXfTzlcdQ
        KKhZU9gLWquBfrbYZE7Ch5ZjY6W6Pw0=
X-Google-Smtp-Source: ABdhPJwlZNJmjEB36AnHjCJJwKiJSOBKwTPeBc0R+VveBiO4pUkDqmT6pw2Bq6rUOWaeLIECUwCZRg==
X-Received: by 2002:a17:90b:360c:: with SMTP id ml12mr19108240pjb.158.1630027713636;
        Thu, 26 Aug 2021 18:28:33 -0700 (PDT)
Received: from localhost (220-244-72-10.tpgi.com.au. [220.244.72.10])
        by smtp.gmail.com with ESMTPSA id d22sm4635766pgi.73.2021.08.26.18.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 18:28:33 -0700 (PDT)
Date:   Fri, 27 Aug 2021 11:28:27 +1000
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
        <1629989540.drlhb24t2w.astroid@bobo.none>
        <20210826153048.GD1583@gate.crashing.org>
In-Reply-To: <20210826153048.GD1583@gate.crashing.org>
MIME-Version: 1.0
Message-Id: <1630026648.b7bpnt3hrh.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Segher Boessenkool's message of August 27, 2021 1:30 am:
> On Fri, Aug 27, 2021 at 01:04:36AM +1000, Nicholas Piggin wrote:
>> Excerpts from Segher Boessenkool's message of August 27, 2021 12:37 am:
>> >> No, they are all dispatched and issue to the BRU for execution. It's=20
>> >> trivial to construct a test of a lot of not taken branches in a row
>> >> and time a loop of it to see it executes at 1 cycle per branch.
>> >=20
>> > (s/dispatched/issued/)
>>=20
>> ?
>=20
> Dispatch is from decode to the issue queues.  Issue is from there to
> execution units.  Dispatch is in-order, issue is not.

I know what those mean, I wonder what your s/dispatched/issued means.
I was saying they are dispatched in response to you saying they never
hit the issue queue.

>=20
>> >> How could it validate prediction without issuing? It wouldn't know wh=
en
>> >> sources are ready.
>> >=20
>> > In the backend.  But that is just how it worked on older cores :-/
>>=20
>> Okay. I don't know about older cores than POWER9. Backend would normally=
=20
>> include execution though.
>> Only other place you could do it if you don't
>> issue/exec would be after it goes back in order, like completion.
>=20
> You do not have to do the verification in-order: the insn cannot finish
> until it is no longer speculative, that takes care of all ordering
> needed.

Branches *can* finish out of order and speculative as they do in P9 and=20
P10. Are you talking about these CPUs or something else which can=20
verify branches without issuing them?

>=20
>> But that would be horrible for mispredict penalty.
>=20
> See the previous point.  Also, any insn known to be mispredicted can be
> flushed immediately anyway.

The point is it has to know sources (CR) to verify (aka execute) the=20
branch prediction was right, and if it needs sources then it needs to=20
either issue and execute in the out of order part, or it needs to wait
until completion which would seem to be prohibitively expensive. I am
interested to know how it works.

>=20
>> >> >> The first problem seems like the show stopper though. AFAIKS it wo=
uld=20
>> >> >> need a special builtin support that does something to create the t=
able
>> >> >> entry, or a guarantee that we could put an inline asm right after =
the
>> >> >> builtin as a recognized pattern and that would give us the instruc=
tion
>> >> >> following the trap.
>> >> >=20
>> >> > I'm not quite sure what this means.  Can't you always just put a
>> >> >=20
>> >> > bla:	asm("");
>> >> >=20
>> >> > in there, and use the address of "bla"?
>> >>=20
>> >> Not AFAIKS. Put it where?
>> >=20
>> > After wherever you want to know the address after.  You will have to
>> > make sure they stay together somehow.
>>=20
>> I still don't follow.
>=20
> some_thing_you_want_to_know_the_address_after_let_us_call_it_A;
> empty_asm_that_we_can_take_the_address_of_known_as_B;
>=20
> You have to make sure the compiler keeps A and B together, does not
> insert anything between them, does put them in the assembler output in
> the same fragment, etc.

How does all this help our problem of putting the address of the trap=20
into the table?

>=20
>> If you could give a built in that put a label at the address of the trap=
=20
>> instruction that could be used later by inline asm then that could work
>> too:
>>=20
>>     __builtin_labeled_trap("1:");
>>     asm ("    .section __bug_table,\"aw\"  \n\t"
>>          "2:  .4byte 1b - 2b               \n\t"
>>          "    .previous");
>=20
> How could a compiler do anything like that?!

How could it add a label at the trap instruction it generates? It didn't=20
seem like an outlandish thing to do, but I'm not a compiler writer. It was=20
just a handwaving idea to show what we want to be able to do.

Thanks,
Nick

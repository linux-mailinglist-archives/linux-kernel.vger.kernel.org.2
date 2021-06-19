Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9593AD7D5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 06:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhFSE3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 00:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhFSE3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 00:29:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04323C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 21:27:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e1so5695439plh.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 21:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=OwhWjl0UY0+FNBxouWMwlE3WFKcnUaBF/uAMsbRoR+E=;
        b=remDXVROwVbNWAZ4K94lJUWS+79cijw76JVLGC2MpS4SqU2OcvHu0KiQMz99rVHjRI
         B9v6dyvY7sFFALw+yOIuw0+MpVw9UW4i+zXMqj/0yFzbqLO7SN8Ok4XkKtwVeIwJEsGN
         OUSix6BvK5sYmNsHED3YqfqlUbeabWWzn9lK6zAzOWAnW/pOvLB63Ni8gNCQQ4ycZ1Jv
         PGLU6Jmf0pEjxOeh1nNLh4hFiGOZ3B0eG/exwUwKJUIxvNufJZN7yiNoQ5UruH4BcpwM
         70v2LUbI8NwxpF7JL9xFbYjqsxzcUJfIbvpxHEV/rLD5p4dDXirfyDr6ZEI40n9fzmEk
         V9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=OwhWjl0UY0+FNBxouWMwlE3WFKcnUaBF/uAMsbRoR+E=;
        b=OcYoNgNt1BfHcsvtb9sIGHWyrN9Zo6M1m0S521/kMtsDhD5zz2yMCS4wd6qnWrnnEX
         GN3lsNoArUrZSaS+u+Q50tj2kp+LiNJMHiYGl9xhoDiHkBYaVjqycHx/2y0nkWJkp/Fr
         H2UTC0nrwKGK+BCrPJuU02eSQZYE5jCN0bguUuhOA0jtYs2mF1mo/J8TuNha5T21AatX
         pyaBSOfwDkcG80ObF0UIUZ7+fNGGDDqPpaSYeAmMt+FnkPIgHbRa0TL0Rz2Sj7Of6KUX
         ZCdVC1Yle7GOnRik6qiaQqiEgq07XqwgFAfHxybNYS0R78LwoC8Owxig+3Y0xFCMofDa
         2p2g==
X-Gm-Message-State: AOAM5312R/uA5oYmjzTpKJ1pmIxUsfS8uBer4qj8ri7mMH24QUDvyJG2
        JpTiNR0hi1n2u4Lr42TQHjE=
X-Google-Smtp-Source: ABdhPJxb5wzmZSMLEWiJc96cGODha1T6X/lL+ejla/x9jHujMiLpaSDEIps/cldQ6uaUurwcLj81HQ==
X-Received: by 2002:a17:90a:6b01:: with SMTP id v1mr14742171pjj.10.1624076858443;
        Fri, 18 Jun 2021 21:27:38 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id d92sm9497486pjk.38.2021.06.18.21.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 21:27:38 -0700 (PDT)
Date:   Sat, 19 Jun 2021 14:27:33 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
To:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
        <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
        <1623816595.myt8wbkcar.astroid@bobo.none>
        <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
        <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
        <1623893358.bbty474jyy.astroid@bobo.none>
        <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
        <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
        <1623911501.q97zemobmw.astroid@bobo.none>
        <5efaca70-35a0-1ce5-98ff-651a5f153a0a@kernel.org>
        <1624070824.uyhrzf8zc7.astroid@bobo.none>
        <a3dbe807-4ee0-44ea-a832-b21e04f25ee1@www.fastmail.com>
In-Reply-To: <a3dbe807-4ee0-44ea-a832-b21e04f25ee1@www.fastmail.com>
MIME-Version: 1.0
Message-Id: <1624076552.h05ftritk3.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 19, 2021 1:20 pm:
>=20
>=20
> On Fri, Jun 18, 2021, at 7:53 PM, Nicholas Piggin wrote:
>> Excerpts from Andy Lutomirski's message of June 18, 2021 9:49 am:
>> > On 6/16/21 11:51 PM, Nicholas Piggin wrote:
>> >> Excerpts from Andy Lutomirski's message of June 17, 2021 3:32 pm:
>> >>> On Wed, Jun 16, 2021, at 7:57 PM, Andy Lutomirski wrote:
>> >>>>
>> >>>>
>> >>>> On Wed, Jun 16, 2021, at 6:37 PM, Nicholas Piggin wrote:
>> >>>>> Excerpts from Andy Lutomirski's message of June 17, 2021 4:41 am:
>> >>>>>> On 6/16/21 12:35 AM, Peter Zijlstra wrote:
>> >>>>>>> On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrote:
>> >>>>>>>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 p=
m:
>> >>>>>>>>> membarrier() needs a barrier after any CPU changes mm.  There =
is currently
>> >>>>>>>>> a comment explaining why this barrier probably exists in all c=
ases.  This
>> >>>>>>>>> is very fragile -- any change to the relevant parts of the sch=
eduler
>> >>>>>>>>> might get rid of these barriers, and it's not really clear to =
me that
>> >>>>>>>>> the barrier actually exists in all necessary cases.
>> >>>>>>>>
>> >>>>>>>> The comments and barriers in the mmdrop() hunks? I don't see wh=
at is=20
>> >>>>>>>> fragile or maybe-buggy about this. The barrier definitely exist=
s.
>> >>>>>>>>
>> >>>>>>>> And any change can change anything, that doesn't make it fragil=
e. My
>> >>>>>>>> lazy tlb refcounting change avoids the mmdrop in some cases, bu=
t it
>> >>>>>>>> replaces it with smp_mb for example.
>> >>>>>>>
>> >>>>>>> I'm with Nick again, on this. You're adding extra barriers for n=
o
>> >>>>>>> discernible reason, that's not generally encouraged, seeing how =
extra
>> >>>>>>> barriers is extra slow.
>> >>>>>>>
>> >>>>>>> Both mmdrop() itself, as well as the callsite have comments sayi=
ng how
>> >>>>>>> membarrier relies on the implied barrier, what's fragile about t=
hat?
>> >>>>>>>
>> >>>>>>
>> >>>>>> My real motivation is that mmgrab() and mmdrop() don't actually n=
eed to
>> >>>>>> be full barriers.  The current implementation has them being full
>> >>>>>> barriers, and the current implementation is quite slow.  So let's=
 try
>> >>>>>> that commit message again:
>> >>>>>>
>> >>>>>> membarrier() needs a barrier after any CPU changes mm.  There is =
currently
>> >>>>>> a comment explaining why this barrier probably exists in all case=
s. The
>> >>>>>> logic is based on ensuring that the barrier exists on every contr=
ol flow
>> >>>>>> path through the scheduler.  It also relies on mmgrab() and mmdro=
p() being
>> >>>>>> full barriers.
>> >>>>>>
>> >>>>>> mmgrab() and mmdrop() would be better if they were not full barri=
ers.  As a
>> >>>>>> trivial optimization, mmgrab() could use a relaxed atomic and mmd=
rop()
>> >>>>>> could use a release on architectures that have these operations.
>> >>>>>
>> >>>>> I'm not against the idea, I've looked at something similar before =
(not
>> >>>>> for mmdrop but a different primitive). Also my lazy tlb shootdown =
series=20
>> >>>>> could possibly take advantage of this, I might cherry pick it and =
test=20
>> >>>>> performance :)
>> >>>>>
>> >>>>> I don't think it belongs in this series though. Should go together=
 with
>> >>>>> something that takes advantage of it.
>> >>>>
>> >>>> I=E2=80=99m going to see if I can get hazard pointers into shape qu=
ickly.
>> >>>
>> >>> Here it is.  Not even boot tested!
>> >>>
>> >>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commi=
t/?h=3Dsched/lazymm&id=3Decc3992c36cb88087df9c537e2326efb51c95e31
>> >>>
>> >>> Nick, I think you can accomplish much the same thing as your patch b=
y:
>> >>>
>> >>> #define for_each_possible_lazymm_cpu while (false)
>> >>=20
>> >> I'm not sure what you mean? For powerpc, other CPUs can be using the =
mm=20
>> >> as lazy at this point. I must be missing something.
>> >=20
>> > What I mean is: if you want to shoot down lazies instead of doing the
>> > hazard pointer trick to track them, you could do:
>> >=20
>> > #define for_each_possible_lazymm_cpu while (false)
>> >=20
>> > which would promise to the core code that you don't have any lazies le=
ft
>> > by the time exit_mmap() is done.  You might need a new hook in
>> > exit_mmap() depending on exactly how you implement the lazy shootdown.
>>=20
>> Oh for configuring it away entirely. I'll have to see how it falls out,=20
>> I suspect we'd want to just no-op that entire function and avoid the 2=20
>> atomics if we are taking care of our lazy mms with shootdowns.
>=20
> Do you mean the smp_store_release()?  On x86 and similar architectures, t=
hat=E2=80=99s almost free.  I=E2=80=99m also not convinced it needs to be a=
 real release.

Probably the shoot lazies code would complile that stuff out entirely so
not that as such, but the entire thing including the change to the=20
membarrier barrier (which as I said, shoot lazies could possibly take=20
advantage of anyway).

My point is I haven't seen how everything goes together or looked at=20
generated code so I can't exactly say yes to your question, but that
there's no reason it couldn't be made to nicely fold away based on
config option so I'm not too concerned about that issue.

Thanks,
Nick

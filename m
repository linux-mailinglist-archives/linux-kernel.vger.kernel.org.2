Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54373AD6DB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 04:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhFSCzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 22:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhFSCzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 22:55:52 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E35C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 19:53:41 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w31so9382786pga.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 19:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=q8YruychI6H4V7aCbfFnQKh9MOjH+cOue3THeZ1aEH0=;
        b=gBhB8ucFljqYNP/0N4TOpMY0ye7hXaHUEA+OIZMO77xyc78fVq99DSOr3wJuKfEGLD
         i2wPOh1I/Lp3DgoBO+fYIDdyM3sFlmEwKlGGf7UqZ9PLjUPzQTkpeJf8HNiFCt6YyYbf
         6ETL8MTijfXuw5SEs9D3jXITzFKmwV7YcSVWeaPQJ7Jj7p7HyKbcOevZ7FzAVxzFQhPr
         U6W3NhVkC8yh6KMVcBEBoEHkBOnQ4YAFKyErs6JkX+D15/nkLOiJysO2XYhexYxMWrJ7
         cFhJn8jbMtDrOHVkuGNUXuWeEpoeg/Uek1Dr/mXV+Vlhm2AirlhnpuzU1p5vDXbsvseP
         gJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=q8YruychI6H4V7aCbfFnQKh9MOjH+cOue3THeZ1aEH0=;
        b=p70VwC6AZlMIUmnFDeDU2SwG33ywlTXP3aYD6FgYC6G9hKoTBOEtPX5W857jGJU5D1
         sw5fvtGHCuLDYkm86pWYyIMrjKzR/irDCx4g3C6RXRv5pIVAGrFESOySxllkXm1BYkTQ
         ztB7RVoBHEzT7iX5QpXxdVLRVgECe35AHA6lSo0+M1d5YG3j8viTZzFieqm2ZS3WYvu6
         qz/uz5kpleI8NFQtFt2E6A0GECG7bxke5OHWWroH1Z8lV5LW1SWBdJGh5x5dj+HBhCTq
         Wk+pxUTLhM7pJxuBi9wwt9cN6L+K85UZsVhckCOU0Xpl6F0ofKje6DDRzBJT88qbnnkm
         TByA==
X-Gm-Message-State: AOAM530Y1Pwa+zOzEs4QSoPLcb5TVWCW815Zk6FLgVd49UEsd38lqEZd
        rFWCHcHELLt7v54f0JAewME=
X-Google-Smtp-Source: ABdhPJzWR7UvDZ+3PhdfjFOd+1ut5+rf7YW3sPc1+XA4N6s5E9b/C62R2XTVSp7XuiBe9GqR4dpvwg==
X-Received: by 2002:a63:5b51:: with SMTP id l17mr12919707pgm.408.1624071220923;
        Fri, 18 Jun 2021 19:53:40 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id u1sm8922481pfu.160.2021.06.18.19.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 19:53:40 -0700 (PDT)
Date:   Sat, 19 Jun 2021 12:53:34 +1000
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
In-Reply-To: <5efaca70-35a0-1ce5-98ff-651a5f153a0a@kernel.org>
MIME-Version: 1.0
Message-Id: <1624070824.uyhrzf8zc7.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 18, 2021 9:49 am:
> On 6/16/21 11:51 PM, Nicholas Piggin wrote:
>> Excerpts from Andy Lutomirski's message of June 17, 2021 3:32 pm:
>>> On Wed, Jun 16, 2021, at 7:57 PM, Andy Lutomirski wrote:
>>>>
>>>>
>>>> On Wed, Jun 16, 2021, at 6:37 PM, Nicholas Piggin wrote:
>>>>> Excerpts from Andy Lutomirski's message of June 17, 2021 4:41 am:
>>>>>> On 6/16/21 12:35 AM, Peter Zijlstra wrote:
>>>>>>> On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrote:
>>>>>>>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
>>>>>>>>> membarrier() needs a barrier after any CPU changes mm.  There is =
currently
>>>>>>>>> a comment explaining why this barrier probably exists in all case=
s.  This
>>>>>>>>> is very fragile -- any change to the relevant parts of the schedu=
ler
>>>>>>>>> might get rid of these barriers, and it's not really clear to me =
that
>>>>>>>>> the barrier actually exists in all necessary cases.
>>>>>>>>
>>>>>>>> The comments and barriers in the mmdrop() hunks? I don't see what =
is=20
>>>>>>>> fragile or maybe-buggy about this. The barrier definitely exists.
>>>>>>>>
>>>>>>>> And any change can change anything, that doesn't make it fragile. =
My
>>>>>>>> lazy tlb refcounting change avoids the mmdrop in some cases, but i=
t
>>>>>>>> replaces it with smp_mb for example.
>>>>>>>
>>>>>>> I'm with Nick again, on this. You're adding extra barriers for no
>>>>>>> discernible reason, that's not generally encouraged, seeing how ext=
ra
>>>>>>> barriers is extra slow.
>>>>>>>
>>>>>>> Both mmdrop() itself, as well as the callsite have comments saying =
how
>>>>>>> membarrier relies on the implied barrier, what's fragile about that=
?
>>>>>>>
>>>>>>
>>>>>> My real motivation is that mmgrab() and mmdrop() don't actually need=
 to
>>>>>> be full barriers.  The current implementation has them being full
>>>>>> barriers, and the current implementation is quite slow.  So let's tr=
y
>>>>>> that commit message again:
>>>>>>
>>>>>> membarrier() needs a barrier after any CPU changes mm.  There is cur=
rently
>>>>>> a comment explaining why this barrier probably exists in all cases. =
The
>>>>>> logic is based on ensuring that the barrier exists on every control =
flow
>>>>>> path through the scheduler.  It also relies on mmgrab() and mmdrop()=
 being
>>>>>> full barriers.
>>>>>>
>>>>>> mmgrab() and mmdrop() would be better if they were not full barriers=
.  As a
>>>>>> trivial optimization, mmgrab() could use a relaxed atomic and mmdrop=
()
>>>>>> could use a release on architectures that have these operations.
>>>>>
>>>>> I'm not against the idea, I've looked at something similar before (no=
t
>>>>> for mmdrop but a different primitive). Also my lazy tlb shootdown ser=
ies=20
>>>>> could possibly take advantage of this, I might cherry pick it and tes=
t=20
>>>>> performance :)
>>>>>
>>>>> I don't think it belongs in this series though. Should go together wi=
th
>>>>> something that takes advantage of it.
>>>>
>>>> I=E2=80=99m going to see if I can get hazard pointers into shape quick=
ly.
>>>
>>> Here it is.  Not even boot tested!
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?=
h=3Dsched/lazymm&id=3Decc3992c36cb88087df9c537e2326efb51c95e31
>>>
>>> Nick, I think you can accomplish much the same thing as your patch by:
>>>
>>> #define for_each_possible_lazymm_cpu while (false)
>>=20
>> I'm not sure what you mean? For powerpc, other CPUs can be using the mm=20
>> as lazy at this point. I must be missing something.
>=20
> What I mean is: if you want to shoot down lazies instead of doing the
> hazard pointer trick to track them, you could do:
>=20
> #define for_each_possible_lazymm_cpu while (false)
>=20
> which would promise to the core code that you don't have any lazies left
> by the time exit_mmap() is done.  You might need a new hook in
> exit_mmap() depending on exactly how you implement the lazy shootdown.

Oh for configuring it away entirely. I'll have to see how it falls out,=20
I suspect we'd want to just no-op that entire function and avoid the 2=20
atomics if we are taking care of our lazy mms with shootdowns.

The more important thing would be the context switch fast path, but even=20
there, there's really no reason why the two approaches couldn't be made=20
to both work with some careful helper functions or structuring of the=20
code.

Thanks,
Nick

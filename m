Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649903AACC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFQGyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:54:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55064C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:52:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso4943523pjx.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=28kUQfGygV49IF31XNAuBhBzoibrbYMJaDYm3b4QmS0=;
        b=HmycbB2P6Pqy9aesrWyPbd/h2iBv/ykl6YMZ+ZG/677lfq7IW1vxRZlU//yKXG+T29
         dWb8iquVluzOVcHD/0NS76AZ44HJm+Rr3jxcYrbNwHEOI5KHCy+5PRXmkgQl4VQ3ghAj
         f1iR0ix45yGRfnSZstlyFCf6U5kg9v8LsHWoHsk5n1uprBj1kHhDjSLZfA0MXC0HZpzF
         9Zf+VG8+vPPyAIojCskKeLCj/YMBL8bzQXt4NSafaNcv+ytzqVc1e14adamtutngTf21
         O+MhTZu1oOladIm1fSJorScbtD3KtIvtJDQUj4CRBHWVaVNnE/x0iAfOIoaGJNU18wPW
         eojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=28kUQfGygV49IF31XNAuBhBzoibrbYMJaDYm3b4QmS0=;
        b=M6QsikyzoW2Ht4pSVhCyu9SjIgsNB4Y/a6wY8fm0fnWGGSHThIg43tKtBia0Iu+qq/
         iFw5bp1W+OoCcSSZxh9z72jGkcuXo81/HSJJsqP/zF7I4MRF6GzSblkD/DzwnWEVNP/c
         cehpuRO9HiKDtOQ7S1Nb6UUu2OQ5FlZ2booGETNwhLddF4IJVjPbugJ7Toyp83264JGV
         h2blNgSAvsH1H47+tMzbK5a1K0zOPzADMqeeJC/ZKOY5Dv7DAT/nFDInGYZBiaeEDQT9
         6jc0WohQ51CJtvXVOYilj5Efgv9L5cQzDWqDnJTERzWagSQ3GbgTX653wgE/EWXf5MKu
         a58w==
X-Gm-Message-State: AOAM531S1/fyZFPG+2e3Sb7SdXR335daTwm+2lFZNoL+ejwsDOAiHPkV
        VwMkDbEztV+nNq+NiZQzwB8=
X-Google-Smtp-Source: ABdhPJw8LPzJCxKDAIzcVYoSW1B87WaU9dpjrOUcjVwdk9HTgMZVRF1Alr6+o1tlW706DhvOOKcgkw==
X-Received: by 2002:a17:902:c78a:b029:109:edbb:44de with SMTP id w10-20020a170902c78ab0290109edbb44demr3252959pla.6.1623912715929;
        Wed, 16 Jun 2021 23:51:55 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id g63sm3989091pfb.55.2021.06.16.23.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 23:51:55 -0700 (PDT)
Date:   Thu, 17 Jun 2021 16:51:49 +1000
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
In-Reply-To: <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
MIME-Version: 1.0
Message-Id: <1623911501.q97zemobmw.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 17, 2021 3:32 pm:
> On Wed, Jun 16, 2021, at 7:57 PM, Andy Lutomirski wrote:
>>=20
>>=20
>> On Wed, Jun 16, 2021, at 6:37 PM, Nicholas Piggin wrote:
>> > Excerpts from Andy Lutomirski's message of June 17, 2021 4:41 am:
>> > > On 6/16/21 12:35 AM, Peter Zijlstra wrote:
>> > >> On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrote:
>> > >>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
>> > >>>> membarrier() needs a barrier after any CPU changes mm.  There is =
currently
>> > >>>> a comment explaining why this barrier probably exists in all case=
s.  This
>> > >>>> is very fragile -- any change to the relevant parts of the schedu=
ler
>> > >>>> might get rid of these barriers, and it's not really clear to me =
that
>> > >>>> the barrier actually exists in all necessary cases.
>> > >>>
>> > >>> The comments and barriers in the mmdrop() hunks? I don't see what =
is=20
>> > >>> fragile or maybe-buggy about this. The barrier definitely exists.
>> > >>>
>> > >>> And any change can change anything, that doesn't make it fragile. =
My
>> > >>> lazy tlb refcounting change avoids the mmdrop in some cases, but i=
t
>> > >>> replaces it with smp_mb for example.
>> > >>=20
>> > >> I'm with Nick again, on this. You're adding extra barriers for no
>> > >> discernible reason, that's not generally encouraged, seeing how ext=
ra
>> > >> barriers is extra slow.
>> > >>=20
>> > >> Both mmdrop() itself, as well as the callsite have comments saying =
how
>> > >> membarrier relies on the implied barrier, what's fragile about that=
?
>> > >>=20
>> > >=20
>> > > My real motivation is that mmgrab() and mmdrop() don't actually need=
 to
>> > > be full barriers.  The current implementation has them being full
>> > > barriers, and the current implementation is quite slow.  So let's tr=
y
>> > > that commit message again:
>> > >=20
>> > > membarrier() needs a barrier after any CPU changes mm.  There is cur=
rently
>> > > a comment explaining why this barrier probably exists in all cases. =
The
>> > > logic is based on ensuring that the barrier exists on every control =
flow
>> > > path through the scheduler.  It also relies on mmgrab() and mmdrop()=
 being
>> > > full barriers.
>> > >=20
>> > > mmgrab() and mmdrop() would be better if they were not full barriers=
.  As a
>> > > trivial optimization, mmgrab() could use a relaxed atomic and mmdrop=
()
>> > > could use a release on architectures that have these operations.
>> >=20
>> > I'm not against the idea, I've looked at something similar before (not
>> > for mmdrop but a different primitive). Also my lazy tlb shootdown seri=
es=20
>> > could possibly take advantage of this, I might cherry pick it and test=
=20
>> > performance :)
>> >=20
>> > I don't think it belongs in this series though. Should go together wit=
h
>> > something that takes advantage of it.
>>=20
>> I=E2=80=99m going to see if I can get hazard pointers into shape quickly=
.
>=20
> Here it is.  Not even boot tested!
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=
=3Dsched/lazymm&id=3Decc3992c36cb88087df9c537e2326efb51c95e31
>=20
> Nick, I think you can accomplish much the same thing as your patch by:
>=20
> #define for_each_possible_lazymm_cpu while (false)

I'm not sure what you mean? For powerpc, other CPUs can be using the mm=20
as lazy at this point. I must be missing something.

>=20
> although a more clever definition might be even more performant.
>=20
> I would appreciate everyone's thoughts as to whether this scheme is sane.

powerpc has no use for it, after the series in akpm's tree there's just
a small change required for radix TLB flushing to make the final flush=20
IPI also purge lazies, and then the shootdown scheme runs with zero
additional IPIs so essentially no benefit to the hazard pointer games.
I have found the additional IPIs aren't bad anyway, so not something=20
we'd bother trying to optmise away on hash, which is slowly being
de-prioritized.

I must say, I still see active_mm featuring prominently in our patch
which comes as a surprise. I would have thought some preparation and=20
cleanup work first to fix the x86 deficienies you were talking about=20
should go in first, I'm eager to see those. But either way I don't see
a fundamental reason this couldn't be done to support archs for which=20
the standard or shootdown refcounting options aren't sufficient.

IIRC I didn't see a fundamental hole in it last time you posted the
idea but I admittedly didn't go through it super carefully.

Thanks,
Nick

>=20
> Paul, I'm adding you for two reasons.  First, you seem to enjoy bizarre l=
ocking schemes.  Secondly, because maybe RCU could actually work here.  The=
 basic idea is that we want to keep an mm_struct from being freed at an ino=
pportune time.  The problem with naively using RCU is that each CPU can use=
 one single mm_struct while in an idle extended quiescent state (but not a =
user extended quiescent state).  So rcu_read_lock() is right out.  If RCU c=
ould understand this concept, then maybe it could help us, but this seems a=
 bit out of scope for RCU.
>=20
> --Andy
>=20

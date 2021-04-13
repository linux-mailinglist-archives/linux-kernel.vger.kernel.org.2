Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBA735E5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347394AbhDMSAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:00:35 -0400
Received: from mail.efficios.com ([167.114.26.124]:60258 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344809AbhDMSAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:00:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 67DC933A705;
        Tue, 13 Apr 2021 14:00:13 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wBu2Bu9ckltM; Tue, 13 Apr 2021 14:00:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E02BA33A65B;
        Tue, 13 Apr 2021 14:00:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E02BA33A65B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618336812;
        bh=ppQsVv5paFBbIn8S2Rd9slDAXUoSOc74hiquz433ogY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=KVoTrLpl6aWOEZgfuyp+meqwSksqJIefK1sz8N7lacYWWNmDV4L5/WWxsnMwN0D0/
         rGnpryRb3PxQT24k2yTYiYSRD4ENRsdmXRW08lRYINy80OXFSuoGnk4kFSFTh86iFT
         ceWL92+G1sPgvRWV1RDhQwCh3A/yuaiTX6I+1sF+LLQ7Aw+0s2YATKBoEOa6eZ0Kfs
         ea8OKyXqRfSxyHc7gfHynLZvMjvfEnZh7dEYcOcF+BFgvEU4aEaiDgJXayyDjCi4Uq
         DAR5/sfMmPXI/hvswPmnrI+wauAUaNC4GXslZ9Nb6SzU0Shx02UCS6DkC7H7Za8VcF
         xwY99bHy8iMsQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MU-KprJaiEoH; Tue, 13 Apr 2021 14:00:12 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id CF87933A658;
        Tue, 13 Apr 2021 14:00:12 -0400 (EDT)
Date:   Tue, 13 Apr 2021 14:00:12 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1347243835.72576.1618336812739.JavaMail.zimbra@efficios.com>
In-Reply-To: <CANn89iLXE6V2gpbJeE6KVU+YiNkmYZKjpRxKv8b69k1ECsyE9g@mail.gmail.com>
References: <20210413162240.3131033-1-eric.dumazet@gmail.com> <20210413162240.3131033-4-eric.dumazet@gmail.com> <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com> <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com> <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com> <CANn89iKnQ7KeCo0os0c67GMgEkmrRqhmGhug-xL-Mx5BhR+BkQ@mail.gmail.com> <989543379.72506.1618334454075.JavaMail.zimbra@efficios.com> <CANn89iLXE6V2gpbJeE6KVU+YiNkmYZKjpRxKv8b69k1ECsyE9g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and
 clear_rseq_cs()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
Thread-Index: MRaVC0QM54TNLJ/HT7ucQNe7vY+fgA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 13, 2021, at 1:33 PM, Eric Dumazet edumazet@google.com wrote:

> On Tue, Apr 13, 2021 at 7:20 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Apr 13, 2021, at 1:07 PM, Eric Dumazet edumazet@google.com wrote:
>>
>> > On Tue, Apr 13, 2021 at 7:01 PM Eric Dumazet <edumazet@google.com> wrote:
>> >>
>> >> On Tue, Apr 13, 2021 at 6:57 PM Eric Dumazet <edumazet@google.com> wrote:
>> >> >
>> >> > On Tue, Apr 13, 2021 at 6:54 PM Mathieu Desnoyers
>> >> > <mathieu.desnoyers@efficios.com> wrote:
>> >> > >
>> >> > > ----- On Apr 13, 2021, at 12:22 PM, Eric Dumazet eric.dumazet@gmail.com wrote:
>> >> > >
>> >> > > > From: Eric Dumazet <edumazet@google.com>
>> >> > > >
>> >> > > > Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
>> >> > > > update includes") added regressions for our servers.
>> >> > > >
>> >> > > > Using copy_from_user() and clear_user() for 64bit values
>> >> > > > is suboptimal.
>> >> > > >
>> >> > > > We can use faster put_user() and get_user().
>> >> > > >
>> >> > > > 32bit arches can be changed to use the ptr32 field,
>> >> > > > since the padding field must always be zero.
>> >> > > >
>> >> > > > v2: added ideas from Peter and Mathieu about making this
>> >> > > >    generic, since my initial patch was only dealing with
>> >> > > >    64bit arches.
>> >> > >
>> >> > > Ah, now I remember the reason why reading and clearing the entire 64-bit
>> >> > > is important: it's because we don't want to allow user-space processes to
>> >> > > use this change in behavior to figure out whether they are running on a
>> >> > > 32-bit or in a 32-bit compat mode on a 64-bit kernel.
>> >> > >
>> >> > > So although I'm fine with making 64-bit kernels faster, we'll want to keep
>> >> > > updating the entire 64-bit ptr field on 32-bit kernels as well.
>> >> > >
>> >> > > Thanks,
>> >> > >
>> >> >
>> >> > So... back to V1 then ?
>> >>
>> >> Or add more stuff as in :
>> >
>> > diff against v2, WDYT ?
>>
>> I like this approach slightly better, because it moves the preprocessor ifdefs
>> into
>> rseq_get_rseq_cs and clear_rseq_cs, while keeping the same behavior for a 32-bit
>> process running on native 32-bit kernel and as compat task on a 64-bit kernel.
>>
>> That being said, I don't expect anyone to care much about performance of 32-bit
>> kernels, so we could use copy_from_user() on 32-bit kernels to remove
>> special-cases
>> in 32-bit specific code. This would eliminate the 32-bit specific "padding"
>> read, and
>> let the TASK_SIZE comparison handle the check for both 32-bit and 64-bit
>> kernels.
>>
>> As for clear_user(), I wonder whether we could simply keep using it, but change
>> the
>> clear_user() macro to figure out that it can use a faster 8-byte put_user ? I
>> find it
>> odd that performance optimizations which would be relevant elsewhere creep into
>> the
>> rseq code.
> 
> 
> clear_user() is a maze of arch-dependent macros/functions/assembly
> 
> I guess the same could be said from  copy_in_user(), but apparently we removed
> special-casing, like in commit a41e0d754240fe8ca9c4f2070bf67e3b0228aa22
> 
> Definitely it seems odd having to carefully choose between multiple methods.

As long as the ifdefs are localized within clearly identified wrappers in the
rseq code I don't mind doing the special-casing there.

The point which remains is that I don't think we want to optimize for speed
on 32-bit architectures when it adds special-casing and complexity to the 32-bit
build. I suspect there is less and less testing performed on 32-bit architectures
nowadays, and it's good that as much code as possible is shared between 32-bit and
64-bit builds to share the test coverage.

Thanks,

Mathieu

> 
> 
>>
>> Thanks,
>>
>> Mathieu
>>
>> >
>> > diff --git a/kernel/rseq.c b/kernel/rseq.c
>> > index
>> > f2eee3f7f5d330688c81cb2e57d47ca6b843873e..537b1f684efa11069990018ffa3642c209993011
>> > 100644
>> > --- a/kernel/rseq.c
>> > +++ b/kernel/rseq.c
>> > @@ -136,6 +136,10 @@ static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp,
>> > {
>> >        u32 ptr;
>> >
>> > +       if (get_user(ptr, &rseq->rseq_cs.ptr.padding))
>> > +               return -EFAULT;
>> > +       if (ptr)
>> > +               return -EINVAL;
>> >        if (get_user(ptr, &rseq->rseq_cs.ptr.ptr32))
>> >                return -EFAULT;
>> >        *uptrp = (struct rseq_cs __user *)ptr;
>> > @@ -150,8 +154,9 @@ static int rseq_get_rseq_cs(struct task_struct *t,
>> > struct rseq_cs *rseq_cs)
>> >        u32 sig;
>> >        int ret;
>> >
>> > -       if (rseq_get_cs_ptr(&urseq_cs, t->rseq))
>> > -               return -EFAULT;
>> > +       ret = rseq_get_cs_ptr(&urseq_cs, t->rseq);
>> > +       if (ret)
>> > +               return ret;
>> >        if (!urseq_cs) {
>> >                memset(rseq_cs, 0, sizeof(*rseq_cs));
>> >                return 0;
>> > @@ -237,7 +242,8 @@ static int clear_rseq_cs(struct task_struct *t)
>> > #ifdef CONFIG_64BIT
>> >        return put_user(0UL, &t->rseq->rseq_cs.ptr64);
>> > #else
>> > -       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32);
>> > +       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32) |
>> > +              put_user(0UL, &t->rseq->rseq_cs.ptr.padding);
>> > #endif
>> >  }
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

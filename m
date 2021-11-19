Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AAB456851
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 03:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhKSC4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 21:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhKSC4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 21:56:37 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5E8C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 18:53:36 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g17so24143323ybe.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 18:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6A2E3X5quPNY7AkhY3QAvahE+TeTxfx7q4kDVwM1ioM=;
        b=Z84F2PArc7rIm9/mAp5IP3wNY0IDh0q00Ts4J+cW+ywU6raVWXAVXHdXjTQ/mIsOF9
         ZmPdiQ/9xYIshEv2qQgD/kkSjZprtV2PsnNLoPTfyAkNECizvbO8GShKmsaaNRHd+ein
         8jam9cdfs3c+PCZwXeVzX+NTgV58Kt04CxtqdJ6Tiz7bB4BdC0LLDGvwzFtKMLVhGYJ2
         hdGyyjQ8yNbU5RN8lFQ3/BPwBCoA1oaV4sWkKHqPtaM/6SQa5j+knmj/94/w7oIBC0ps
         TfdymA4YN3M7/TL92a+pXL05VX4+Daxl1cNwJIV+FkdgxzdSxPjl8qca+yg/Ose1vLUp
         oJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6A2E3X5quPNY7AkhY3QAvahE+TeTxfx7q4kDVwM1ioM=;
        b=KyHmIA2VvnbTEpnHB5EYem/3pVzOV9T9DIG31tVwb+f8Qvqd9EsFPmwM+8m6BhpQ6U
         FXIc9oVUjMY74SbIHfmBdvtKoCa1Blnp0Ps4c0QOV2P0yKQQFV5OjMtHVzBSTKtdck/5
         HZj9fGHAd98In2KYYTtLnqHtHKYxafywE+bjr/9BKJKogpGgO2rYJgjNztA9QxKfV+ev
         skj4XV19jUIEFBcJqW4a0NzGeGVt6bjH64NEjYmrdfAbWs6ea3ZCCe5lL0sY1Je/D3+8
         Zlgq2zJNonXaWiPOx7Y9AtDe3aqsFShJyFzUir9z1ams3n6/15zmr97G8+gdP8OLhUe4
         QGRQ==
X-Gm-Message-State: AOAM532v9RPLjGSOol8FEvC4rzejqz036LnzZopRnwdGa6R8G52ANDyT
        Dr7ktRT3gIdQ1sYRo6Q1OACTKBmd7wp3PDMrccexVg==
X-Google-Smtp-Source: ABdhPJz8vPYy/uapIjqlOin5ZgvjBZmNckWz9vlR/E8h/hxQstuIAvoYmDXA57e4u7f5Igm59/cGt7XWPS4BKHZ+jLs=
X-Received: by 2002:a25:d15:: with SMTP id 21mr32484245ybn.141.1637290415664;
 Thu, 18 Nov 2021 18:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20211118094455.9068-1-songmuchun@bytedance.com> <YZZNv3JflBYwRjdd@hirez.programming.kicks-ass.net>
In-Reply-To: <YZZNv3JflBYwRjdd@hirez.programming.kicks-ass.net>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 19 Nov 2021 10:52:56 +0800
Message-ID: <CAMZfGtUnUjF5wW8ZNdm3KNs54jUBxRfm12q-KbXWtDDBd2HhTQ@mail.gmail.com>
Subject: Re: [PATCH] locking/rwsem: Optimize down_read_trylock() under highly
 contended case
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, boqun.feng@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 8:57 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 18, 2021 at 05:44:55PM +0800, Muchun Song wrote:
>
> > By using the above benchmark, the real executing time on a x86-64 system
> > before and after the patch were:
>
> What kind of x86_64 ?

Intel(R) Xeon(R) CPU E5-2650

>
> >
> >                   Before Patch  After Patch
> >    # of Threads      real          real     reduced by
> >    ------------     ------        ------    ----------
> >          1          65,373        65,206       ~0.0%
> >          4          15,467        15,378       ~0.5%
> >         40           6,214         5,528      ~11.0%
> >
> > For the uncontended case, the new down_read_trylock() is the same as
> > before. For the contended cases, the new down_read_trylock() is faster
> > than before. The more contended, the more fast.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  kernel/locking/rwsem.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> > index c51387a43265..ef2b2a3f508c 100644
> > --- a/kernel/locking/rwsem.c
> > +++ b/kernel/locking/rwsem.c
> > @@ -1249,17 +1249,14 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
> >
> >       DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
> >
> > -     /*
> > -      * Optimize for the case when the rwsem is not locked at all.
> > -      */
> > -     tmp = RWSEM_UNLOCKED_VALUE;
> > -     do {
> > +     tmp = atomic_long_read(&sem->count);
> > +     while (!(tmp & RWSEM_READ_FAILED_MASK)) {
> >               if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> > -                                     tmp + RWSEM_READER_BIAS)) {
> > +                                                 tmp + RWSEM_READER_BIAS)) {
> >                       rwsem_set_reader_owned(sem);
> >                       return 1;
> >               }
> > -     } while (!(tmp & RWSEM_READ_FAILED_MASK));
> > +     }
> >       return 0;
> >  }
>
> This is weird... so the only difference is that leading load, but given
> contention you'd expect that load to stall, also, given it's a
> non-exclusive load, to get stolen by a competing CPU. Whereas the old
> code would start with a cmpxchg, which obviously will also stall, but
> does an exclusive load.

The old code always assumes that rwsem is unlocked at all, so the
initialization of local variable @tmp is 0 (RWSEM_UNLOCKED_VALUE).
Ideally, the first cmpxchg will be successful. However, if rwsem is
contended (e.g. mmap read lock is almost hold by other threads
), sem->count is not always RWSEM_UNLOCKED_VALUE, so the
first cmpxchg has to fail and the second cmpxchg usually succeeds.
This patch will load sem->count first to @tmp and then the cmpxchg
will usually succeed. So this patch reduces the number of executions
of cmpxchg if running the above benchmark.

I have added a patch as follows to verify this. I got the following
statistics by using bpftrace (bpftrace -e
'tracepoint:rwsem:rwsem_read_loop /comm == "a.out"/ {
@cnt[args->count] = count(); }').

Before patch:
@cnt[17]: 1
@cnt[11]: 6
@cnt[10]: 14
@cnt[9]: 62
@cnt[8]: 339
@cnt[1]: 1211
@cnt[7]: 1585
@cnt[6]: 7796
@cnt[5]: 34742
@cnt[4]: 158245
@cnt[3]: 921631
@cnt[2]: 25089070

After patch:
@cnt[9]: 1
@cnt[8]: 3
@cnt[7]: 28
@cnt[6]: 151
@cnt[0]: 197
@cnt[5]: 823
@cnt[4]: 5521
@cnt[3]: 39126
@cnt[2]: 328012
@cnt[1]: 25840840

As you can see the total number of executions of cmpxchg is
reduced by about ~1x.

Thanks.

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index ef2b2a3f508c..cdeb1ad1921f 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1246,14 +1246,18 @@ static inline int __down_read_killable(struct
rw_semaphore *sem)
 static inline int __down_read_trylock(struct rw_semaphore *sem)
 {
        long tmp;
+       int count = 0;

        DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);

        tmp = atomic_long_read(&sem->count);
        while (!(tmp & RWSEM_READ_FAILED_MASK)) {
+               count++;
                if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
                                                    tmp + RWSEM_READER_BIAS)) {
                        rwsem_set_reader_owned(sem);
+                       if (&current->mm->mmap_lock == sem)
+                               trace_rwsem_read_loop(count);
                        return 1;
                }
        }

>
> And the thinking is that the exclusive load and the presence of the
> cmpxchg loop would keep the line on that CPU for a little while and
> progress is made.
>
> Clearly this isn't working as expected. Also I suppose it would need
> wider testing...
>

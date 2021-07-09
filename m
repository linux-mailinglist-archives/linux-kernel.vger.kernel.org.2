Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750833C27D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 18:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhGIRAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:00:30 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C8C0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 09:57:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 8so12826254lfp.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5s53IKTCNOg5VaJYriuf6Xnn23JEdxzFSgN69kF3qNQ=;
        b=jK58VrUbKUb89rEpuhKNIMgt9olAgnSWMrEeD1Gs+CnRDRrkSlsl7NbKKbyKkLkjiD
         6i75++60y+tNup1HRt+nGjF07bYIa5MXoBbsVRurb3AB9MRlNQAz43psWxAThKOuKI0y
         3aYQkMFH3Wogot1wUCmbcG0QRqvt5VNB/5bjNI0wmp5tjZSPiUxe0R/OQ78Go+FFDKGf
         C/J8FZJb71VdNATN0FG/p9Ns8gBwQvdAGbVIGZ5pwIwXN8YpUW0dxQLZ8yWRxdulG8l9
         Fkz/Yf3XDXtmj4P3cujF8moaz/dp08+QFCTKWCi7gRG8CFjLfq4lqYDVhbCvJHnt5FCh
         2jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5s53IKTCNOg5VaJYriuf6Xnn23JEdxzFSgN69kF3qNQ=;
        b=Tn29yA/t6nBCwAP7ioBECWVTPI/rhqAPEmPli0EXGxW23Rlk54Phy5MwZpbE83+bup
         y1eZhqKZeVCb4/IkPyN/YEBYsmEIa636FLwfmi0RblzgptKAZOerCeH88VKEAMABE5cN
         XHsMSyhBWMfT7MkK23Q6uGXvMTtp0X3SoQ6CMEIi70m+8LJ83gmgPNvbp3RSoauXOqBE
         3XnYQui+4y44rlzl+O8+nl9FL6gr+ZSiswg4j8gvDfPTaw9LsgIRYCRXu7Pcw8FRC1Yh
         WKkxYB9w6HcnbxhP54z22is6EAnDK8c3HZisD1090L/dZUd7x+3lt126CuPsfOhXFBI8
         XPjg==
X-Gm-Message-State: AOAM530Q+8Op25M81hL1HpfQEFEPBLoVh+28i6opva6OmvMtK6a35Q+0
        IWk8kwxVwNiY3MdQQ5Ts+SJZn1uf/x3kDAaszTwRtQ==
X-Google-Smtp-Source: ABdhPJzwdge45OBlTwu4SCrybnH71uncXiezBNKB+TcZfkn9SEUthZ7qEAPjtWjoUnKzGtsaX8kxT3km+rCdnFHlzbA=
X-Received: by 2002:a05:6512:2618:: with SMTP id bt24mr19571340lfb.180.1625849864200;
 Fri, 09 Jul 2021 09:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210708194638.128950-1-posk@google.com> <20210708194638.128950-3-posk@google.com>
 <YOgCdMWE9OXvqczk@hirez.programming.kicks-ass.net>
In-Reply-To: <YOgCdMWE9OXvqczk@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 9 Jul 2021 09:57:32 -0700
Message-ID: <CAPNVh5fbDTNPCnSoQFia_VSuDcLsReGey+7iouK6V=p1S7v=sg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3 v0.2] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 1:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jul 08, 2021 at 12:46:37PM -0700, Peter Oskolkov wrote:
>
> > +static inline int umcg_atomic_cmpxchg_64(u64 *uval, u64 __user *uaddr,
> > +                                             u64 oldval, u64 newval)
> > +{
> > +     int ret = 0;
> > +
> > +     if (!user_access_begin(uaddr, sizeof(u64)))
> > +             return -EFAULT;
> > +     asm volatile("\n"
> > +             "1:\t" LOCK_PREFIX "cmpxchgq %4, %2\n"
> > +             "2:\n"
> > +             "\t.section .fixup, \"ax\"\n"
> > +             "3:\tmov     %3, %0\n"
> > +             "\tjmp     2b\n"
> > +             "\t.previous\n"
> > +             _ASM_EXTABLE_UA(1b, 3b)
> > +             : "+r" (ret), "=a" (oldval), "+m" (*uaddr)
> > +             : "i" (-EFAULT), "r" (newval), "1" (oldval)
> > +             : "memory"
> > +     );
> > +     user_access_end();
> > +     *uval = oldval;
> > +     return ret;
> > +}
>
> > +static inline int fix_pagefault(unsigned long uaddr, bool write_fault)
> > +{
> > +     struct mm_struct *mm = current->mm;
> > +     int ret;
> > +
> > +     mmap_read_lock(mm);
> > +     ret = fixup_user_fault(mm, uaddr, write_fault ? FAULT_FLAG_WRITE : 0,
> > +                     NULL);
> > +     mmap_read_unlock(mm);
> > +
> > +     return ret < 0 ? ret : 0;
> > +}
>
> > +static inline int umcg_cmpxchg_64_user(u64 __user *uaddr, u64 *prev, u64 val)
> > +{
> > +     while (true) {
> > +             int ret;
> > +             u64 expected = *prev;
> > +
> > +             pagefault_disable();
> > +             ret = umcg_atomic_cmpxchg_64(prev, uaddr, expected, val);
> > +             pagefault_enable();
> > +
> > +             if (!ret)
> > +                     return *prev == expected ? 0 : -EAGAIN;
> > +
> > +             if (WARN_ONCE(ret != -EFAULT, "Unexpected error"))
> > +                     return -EFAULT;
> > +
> > +             ret = fix_pagefault((unsigned long)uaddr, true);
> > +             if (ret)
> > +                     return -EFAULT;
> > +     }
> > +}
> > +
> > +/**
> > + * atomic_stack_push_user - push a node onto the stack
> > + * @head - a pointer to the head of the stack;
> > + * @node - a pointer to the node to push.
> > + *
> > + * Push a node onto a single-linked list (stack). Atomicity/correctness
> > + * is guaranteed by locking the head via settings its first bit (assuming
> > + * the pointer is aligned).
> > + *
> > + * Return: 0 on success, -EFAULT on error.
> > + */
> > +static inline int atomic_stack_push_user(u64 __user *head, u64 __user *node)
> > +{
> > +     while (true) {
> > +             int ret;
> > +             u64 first;
> > +
> > +             smp_mb();  /* Make the read below clean. */
> > +             if (get_user(first, head))
> > +                     return -EFAULT;
> > +
> > +             if (first & 1UL) {
> > +                     cpu_relax();
> > +                     continue;  /* first is being deleted. */
> > +             }
> > +
> > +             if (put_user(first, node))
> > +                     return -EFAULT;
> > +             smp_mb();  /* Make the write above visible. */
> > +
> > +             ret = umcg_cmpxchg_64_user(head, &first, (u64)node);
> > +             if (!ret)
> > +                     return 0;
> > +
> > +             if (ret == -EAGAIN) {
> > +                     cpu_relax();
> > +                     continue;
> > +             }
> > +
> > +             if (WARN_ONCE(ret != -EFAULT, "unexpected umcg_cmpxchg result"))
> > +                     return -EFAULT;
> > +
> > +             return -EFAULT;
> > +     }
> > +}
>
>
> This is horrible... Jann is absolutely right, you do not, *ever* do
> userspace spinlocks. What's wrong with the trivial lockless single
> linked list approach?.

I'm not sure how to get around the ABA problem with a lockless single
linked list: https://en.wikipedia.org/wiki/ABA_problem

Our semantics can probably be relied on to prevent ABA from happening
with idle workers (popped/removed by the userspace), but idle servers
can trivially have it:

(initial state): head => Server A => Server B => NULL

task1 :
- read head (get A), read A (get B), {/* delayed */}

tasks 2-3-4:
- pop A, pop B, push A

task 1:
- cmp_xchg(head, A /* old */, B /* new */) - succeeds, now B is in the
list erroneously

>
> On top of that, you really want to avoid all that endless stac/clac
> nonsense and only have that once, at the outer edges of things.
>
> Something like the *completely* untested below (except it needs lots of
> extra gunk to support compilers without asm-goto-output, and more widths
> and ...

I'll try the approach you suggest below once it is clear how to deal
with the ABA issue (and the wake server issue raised in patch 3).

>
>
> #define __try_cmpxchg_user_size(ptr, oldp, new, size, label)            \
> ({                                                                      \
>         _Bool __success;                                                \
>         __chk_user_ptr(ptr);                                            \
>         __typeof__(ptr) _old = (__typeof__(ptr))(oldp);                 \
>         __typeof__(*(ptr)) __old = *_old;                               \
>         __typeof__(*(ptr)) __new = (new);                               \
>         switch (size) {                                                 \
>         case 8:                                                         \
>                 volatile u64 *__ptr = (volatile u64 *)(ptr);            \
>                 asm_volatile_goto("1: " LOCK_PREFIX "cmpxchgq %[new], %[ptr]" \
>                                   CC_SET(z)                             \
>                                   _ASM_EXTABLE_UA(1b, %l[label])        \
>                                   : CC_OUT(x) (__success),              \
>                                     [ptr] "+m" (*__ptr),                \
>                                     [old] "+a" (__old),                 \
>                                   : [new] "r" (__new)                   \
>                                   : "memory"                            \
>                                   : label);                             \
>                 break;                                                  \
>         }                                                               \
>         if (unlikely(!success))                                         \
>                 *_old = __old;                                          \
>         __success;                                                      \
> })
>
> #define unsafe_try_cmpxchg_user(ptr, oldp, new, label)                  \
>         __try_cmpxchg_user_size((ptr), (oldp), (new), sizeof(*(ptr)), label);
>
> int user_llist_add(u64 __user *new, u64 __user *head)
> {
>         u64 first;
>         int ret;
>
>         if (unlikely(!access_ok(new, sizeof(*new)) ||
>                      !access_ok(head, sizeof(*head))))
>                 return -EFAULT;
>
> again:
>         __uaccess_begin_nospec();
>
>         unsafe_get_user(first, head, Efault_head);
>         do {
>                 unsafe_put_user(first, new, Efault_new);
>         } while (!unsafe_try_cmpxchg_user(head, &first, new, Efault_head));
>
>         user_access_end();
>
>         return 0;
>
> Efault_new:
>         user_access_end();
>
>         ret = fixup_fault(new);
>         if (ret < 0)
>                 return ret;
>
>         goto again;
>
> Efault_head:
>         user_access_end();
>
>         ret = fixup_fault(head);
>         if (ret < 0)
>                 return ret;
>
>         goto again;
> }

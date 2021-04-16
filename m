Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F317361C00
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhDPInM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbhDPInJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:43:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E40EC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:42:45 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id s5so19315517qkj.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNspso6eu8FyK0S12pp5SaJi4n/DElqZlTW5QhLtIS8=;
        b=VAqp67dfhwx8s/WSkwWTf9LvjkcrrlqkmI3hV2LbByh9zEEJfriAcOu1Prfsg/KaO6
         UiMKEodXxBWoCt279cCoyChMbZ+keT1a+bxpL6COqcs7dYA8OyezXk0c1QCaPjQTXzBI
         aQuZqjm2cx6s7j65Em3Qw734HqutSW0OpViAGnS75rqMezulhaphF+B9HO6iF7tOPohT
         OfzZzsR78EFYFcMd0FgQ/DkjeqouPnP/rCva0szIVKNm/w7wa8OvOeWPYjNRuaV+CkzQ
         HQZ0SXkb+4oQuIssZ1WdCmbRKobqQBz3m+FC2Sm84I9HpKH70ZObPToDo8mtYeSMBigg
         qpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNspso6eu8FyK0S12pp5SaJi4n/DElqZlTW5QhLtIS8=;
        b=divS16w02l465Cwh9AxAhCxsYD4s9sqo9Ae2HcVn7wOGLVNFGSOE2pIUWQBKx9cgU9
         m0wi9NSVfzbXBQqUhijxPxSGFLiicodTH+RFk6QRiEpkWRgAWCiE4PJZ5D7W50ECFygh
         yPjn92g0MzlV7ENsjs7NXFCpQ2pFKj4CMWiiAlB1xmCLmFXFeih1MtXRiH5i33DU2HfC
         i5bVXN3oXtCgmE2jgbDp1r563HhnBXzGLkhJoU6UWMstc7W2SHTfTdRxaRAZ+INW/8WY
         IECjhYMKQ8Nw1NDWXxxCvj392yHxVgOgoFDPvmATUGzwnvf5sJop96enhlO3heYGlOSs
         Pa6w==
X-Gm-Message-State: AOAM530gnJqRRLXPMCvTmzinstKTk6T2IbJ8LsCvYfZG89jPUbAr5qMW
        UEZ8X2MCwhU9ysP+2sXCwTF/MxpOOTqmYztxsphH3A==
X-Google-Smtp-Source: ABdhPJzWKUSYQsBa458mK9ecB0lIGGQOq468BWuE66zGj/IFPSWxEb4Q/2QVAnKhRLAI4JmMh0QSz+UuwnxahszI85g=
X-Received: by 2002:a37:a9c1:: with SMTP id s184mr537104qke.231.1618562564151;
 Fri, 16 Apr 2021 01:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210326205135.6098-1-info@alexander-lochmann.de> <CA+fCnZcTi=QLGC_LCdhs+fMrxkqX66kXEuM5ewOmjVjifKzUrw@mail.gmail.com>
In-Reply-To: <CA+fCnZcTi=QLGC_LCdhs+fMrxkqX66kXEuM5ewOmjVjifKzUrw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Apr 2021 10:42:32 +0200
Message-ID: <CACT4Y+Y_PfAhjV26xYf8wcEv0MYygC14c_92hBN8gqOACK7Oow@mail.gmail.com>
Subject: Re: [PATCHv3] Introduced new tracing mode KCOV_MODE_UNIQUE.
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Alexander Lochmann <info@alexander-lochmann.de>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 3:56 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Fri, Mar 26, 2021 at 9:52 PM Alexander Lochmann
> <info@alexander-lochmann.de> wrote:
> >
>
> Hi Alexander,
>
> > It simply stores the executed PCs.
> > The execution order is discarded.
> > Each bit in the shared buffer represents every fourth
> > byte of the text segment.
> > Since a call instruction on every supported
> > architecture is at least four bytes, it is safe
> > to just store every fourth byte of the text segment.
>
> What about jumps?

KCOV adds call __sanitizer_cov_trace_pc per coverage point. So besides
the instructions in the original code, we also always have this call.


> [...]
>
> > -#define KCOV_IN_CTXSW  (1 << 30)
> > +#define KCOV_IN_CTXSW  (1 << 31)
>
> This change needs to be mentioned and explained in the changelog.
>
> > -static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
> > +static __always_inline notrace bool check_kcov_mode(enum kcov_mode needed_mode,
> > +                                                   struct task_struct *t,
> > +                                                   unsigned int *mode)
> >  {
> > -       unsigned int mode;
> > -
> >         /*
> >          * We are interested in code coverage as a function of a syscall inputs,
> >          * so we ignore code executed in interrupts, unless we are in a remote
> > @@ -162,7 +163,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
> >          */
> >         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
> >                 return false;
> > -       mode = READ_ONCE(t->kcov_mode);
> > +       *mode = READ_ONCE(t->kcov_mode);
> >         /*
> >          * There is some code that runs in interrupts but for which
> >          * in_interrupt() returns false (e.g. preempt_schedule_irq()).
> > @@ -171,7 +172,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
> >          * kcov_start().
> >          */
> >         barrier();
> > -       return mode == needed_mode;
> > +       return ((int)(*mode & (KCOV_IN_CTXSW | needed_mode))) > 0;
>
> This change needs to be mentioned and explained in the changelog.
>
> [...]
>
> >  static notrace unsigned long canonicalize_ip(unsigned long ip)
> > @@ -191,18 +192,27 @@ void notrace __sanitizer_cov_trace_pc(void)
> >         struct task_struct *t;
> >         unsigned long *area;
> >         unsigned long ip = canonicalize_ip(_RET_IP_);
> > -       unsigned long pos;
> > +       unsigned long pos, idx;
> > +       unsigned int mode;
> >
> >         t = current;
> > -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
> > +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC | KCOV_MODE_UNIQUE_PC, t, &mode))
> >                 return;
> >
> >         area = t->kcov_area;
> > -       /* The first 64-bit word is the number of subsequent PCs. */
> > -       pos = READ_ONCE(area[0]) + 1;
> > -       if (likely(pos < t->kcov_size)) {
> > -               area[pos] = ip;
> > -               WRITE_ONCE(area[0], pos);
> > +       if (likely(mode == KCOV_MODE_TRACE_PC)) {
> > +               /* The first 64-bit word is the number of subsequent PCs. */
> > +               pos = READ_ONCE(area[0]) + 1;
> > +               if (likely(pos < t->kcov_size)) {
> > +                       area[pos] = ip;
> > +                       WRITE_ONCE(area[0], pos);
> > +               }
> > +       } else {
> > +               idx = (ip - canonicalize_ip((unsigned long)&_stext)) / 4;
> > +               pos = idx % BITS_PER_LONG;
> > +               idx /= BITS_PER_LONG;
> > +               if (likely(idx < t->kcov_size))
> > +                       WRITE_ONCE(area[idx], READ_ONCE(area[idx]) | 1L << pos);
>
> This is confusing: for KCOV_MODE_TRACE_PC, pos is used to index area,
> and for else, idx is used to index area. You should swap idx and pos.
>
> [...]
>
> > @@ -213,9 +223,10 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> >         struct task_struct *t;
> >         u64 *area;
> >         u64 count, start_index, end_pos, max_pos;
> > +       unsigned int mode;
> >
> >         t = current;
> > -       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
> > +       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t, &mode))
> >                 return;
>
> mode isn't used here, right? No need for it then.
>
> > @@ -562,12 +576,14 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
> >  {
> >         struct task_struct *t;
> >         unsigned long size, unused;
> > -       int mode, i;
> > +       int mode, i, text_size, ret = 0;
> >         struct kcov_remote_arg *remote_arg;
> >         struct kcov_remote *remote;
> >         unsigned long flags;
> >
> >         switch (cmd) {
> > +       case KCOV_INIT_UNIQUE:
> > +               fallthrough;
> >         case KCOV_INIT_TRACE:
> >                 /*
> >                  * Enable kcov in trace mode and setup buffer size.
> > @@ -581,11 +597,42 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
> >                  * that must not overflow.
> >                  */
> >                 size = arg;
> > -               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> > -                       return -EINVAL;
> > -               kcov->size = size;
> > -               kcov->mode = KCOV_MODE_INIT;
> > -               return 0;
> > +               if (cmd == KCOV_INIT_UNIQUE) {
>
> Let's put this code under KCOV_INIT_UNIQUE in the switch. This
> internal if only saves duplicating two lines of code, which isn't
> worth it.
>
> > +                       if (size != 0)
> > +                               return -EINVAL;
> > +                       text_size = (canonicalize_ip((unsigned long)&_etext)
> > +                                    - canonicalize_ip((unsigned long)&_stext));
> > +                       /**
> > +                        * A call instr is at least four bytes on every supported architecture.
> > +                        * Hence, just every fourth instruction can potentially be a call.
> > +                        */
> > +                       text_size = roundup(text_size, 4);
> > +                       text_size /= 4;
> > +                       /*
> > +                        * Round up size of text segment to multiple of BITS_PER_LONG.
> > +                        * Otherwise, we cannot track
> > +                        * the last (text_size % BITS_PER_LONG) addresses.
> > +                        */
> > +                       text_size = roundup(text_size, BITS_PER_LONG);
> > +                       /* Get the amount of bytes needed */
> > +                       text_size = text_size / 8;
> > +                       /* mmap() requires size to be a multiple of PAGE_SIZE */
> > +                       text_size = roundup(text_size, PAGE_SIZE);
> > +                       /* Get the cover size (= amount of bytes stored) */
> > +                       ret = text_size;
> > +                       kcov->size = text_size / sizeof(unsigned long);
> > +                       kcov_debug("text size = 0x%lx, roundup = 0x%x, kcov->size = 0x%x\n",
> > +                                       ((unsigned long)&_etext) - ((unsigned long)&_stext),
> > +                                       text_size,
> > +                                       kcov->size);
> > +                       kcov->mode = KCOV_MODE_INIT_UNIQUE;
> > +               } else {
> > +                       if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> > +                               return -EINVAL;
> > +                       kcov->size = size;
> > +                       kcov->mode = KCOV_MODE_INIT_TRACE;
> > +               }
> > +               return ret;
>
> Thanks!
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CA%2BfCnZcTi%3DQLGC_LCdhs%2BfMrxkqX66kXEuM5ewOmjVjifKzUrw%40mail.gmail.com.

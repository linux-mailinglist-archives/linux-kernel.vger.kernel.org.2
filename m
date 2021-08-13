Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4953EBBB2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhHMRu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHMRux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:50:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF2C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 10:50:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d6so16554321edt.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IBpWJjn84n0VTFtyOrHeTuSf3jIt26LKBlRRRr/JZ/Y=;
        b=pUH01TKoDh+E8iipMmLUDmQY9M36LVOXuT/+IEuhsLjS2JAgTbwJiUIuiZ5d00CkLf
         4bTS3iE86wJRPh+spU2w4CaQWM4mqMyImn6LT4RBxY6JgefFYyr8x+xTfPGHVQx2ohUM
         cFxPvA3k+DQSL2Ls4YFSa7e+vpK1bh3QcFV0oS6bOfIpqf3sfAEQ4AvIgkfCUmk8ryfi
         kMR9rmsjTqfgs+4f4mvDPZnwCsy7OIq1GCTg/H5WFfFiKnaua4+1L5az5OeeGAPlMrFw
         /lqPVm7oOwjQp8pUVkm4HrV3a64+puqik/kbuIoIaUbwu+53GGHl6nlXYUMSQSR4s2Br
         hf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IBpWJjn84n0VTFtyOrHeTuSf3jIt26LKBlRRRr/JZ/Y=;
        b=m2fHtDmXsFzMdevGiJpKMb2+AiCbyKHaGyzH9dpxyBYqhJslcMjXE1yr2U2JvDE2CF
         aq3TUlVcD5giOHZDH6mxMwNpuWDZratNuYP9MyPGGJcGuabsJt8vQn+w39VhmzloU5gE
         wydYSx0cMGnI/lFF5eQlvwiJUbFdzn7Z7EKBXo6lYXB/cWWFo2GKeN7VnZs9zasdY9rr
         yUnNfzqmzjB+wsZ22fH+4GYuCQhgtwd5KttKswW4Tq+epqjW61Tz0GxM1Yox/7e4p7Nb
         s3ehz9OsdSLpyEpxnqK93W4zY4kSwNydHjPLm3KOfmORYvvh6tE/6ztdD3gLzAgOg8MQ
         ROXA==
X-Gm-Message-State: AOAM531PzeY594HUgKM9YZwaBfUNwKBaZx/HLQCTSh60LMlu3GRUlI6o
        RVND28zFdTM/R0YwR8l3usdU+fxSIHzZ4PTT/c4=
X-Google-Smtp-Source: ABdhPJzjGYEsRCpQMt3NJ1mJtR7JmMAcPeiq3QbaMNB63MTz0xMlDDG1uLnH0UDQmF+u/Rlo349Wl89b202l0hEd7Pg=
X-Received: by 2002:a05:6402:31f2:: with SMTP id dy18mr4581611edb.267.1628877024028;
 Fri, 13 Aug 2021 10:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210813151734.1236324-1-jim.cromie@gmail.com>
 <20210813151734.1236324-4-jim.cromie@gmail.com> <YRaU6fbGjcV7BGC/@smile.fi.intel.com>
In-Reply-To: <YRaU6fbGjcV7BGC/@smile.fi.intel.com>
From:   jim.cromie@gmail.com
Date:   Fri, 13 Aug 2021 11:49:57 -0600
Message-ID: <CAJfuBxzkWuK-Xh-2gynmLeHx+gb6bwhbKTG02pydYvQzNBiPjA@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] dyndbg: add DEFINE_DYNAMIC_DEBUG_CATEGORIES and callbacks
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > There is still plenty of bikeshedding to do.
>
> > ---
> > v4+:
> >
> > . rename to DEFINE_DYNAMIC_DEBUG_CATEGORIES from DEFINE_DYNDBG_BITMAP
> > . in query, replace hardcoded "i915" w kp->mod->name
> > . static inline the stubs
> > . const *str in structs, const array. -Emil
> > . dyndbg: add do-nothing DEFINE_DYNAMIC_DEBUG_CATEGORIES if !DD_CORE
> > . call MOD_PARM_DESC(name, "$desc") for users
> > . simplify callback, remove bit-change detection
> > . config errs reported by <lkp@intel.com>
> >
> > ddh-helpers
>
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> So, it is signed or not? I didn't get (perhaps due to misplaced changlog?).
>

It might be my --- snip, and reliance on format-patch -s

would it work if I used --  2char snip ?

> ...
>
> >  } __attribute__((aligned(8)));
> >
> >
>
> Do we need two blank lines here?
>
> > +struct kernel_param;
>
> ...
>
> > +int param_set_dyndbg(const char *instr, const struct kernel_param *kp)
> > +{
> > +     unsigned long inbits;
> > +     int rc, i, chgct = 0, totct = 0;
> > +     char query[OUR_QUERY_SIZE];
> > +     struct dyndbg_bitdesc *bitmap = (struct dyndbg_bitdesc *) kp->data;
>
> So you need space after ')' ?
>
> > +     rc = kstrtoul(instr, 0, &inbits);
> > +     if (rc) {
> > +             pr_err("set_dyndbg: failed\n");
>
> > +             return -EINVAL;
>
> Why not to return rc?
>
> > +     }
> > +     vpr_info("set_dyndbg: input 0x%lx\n", inbits);
> > +
> > +     for (i = 0; !!bitmap[i].prefix; i++) {
>
> Hmm... Why not simply
>
>         for (bitmap = ...; bitmap->prefix; bitmap++) {
>
> ?
>
> > +
>
> Redundant blank line.
>
> > +             sprintf(query, "format '^%s' %cp", bitmap[i].prefix,
> > +                     test_bit(i, &inbits) ? '+' : '-');
>
> snprintf() ?
>
> > +
> > +             chgct = dynamic_debug_exec_queries(query, kp->mod->name);
> > +
> > +             v2pr_info("bit-%d: %d changes by '%s'\n", i, chgct, query);
> > +             totct += chgct;
> > +     }
> > +     vpr_info("total changes: %d\n", totct);
> > +     return 0;
> > +}
>
> ...
>
> > +     return scnprintf(buffer, PAGE_SIZE, "%u\n",
> > +                      *((unsigned int *)kp->arg));
>
> One line.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472F437A254
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhEKIko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:40:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E9EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 01:39:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a10-20020a05600c068ab029014dcda1971aso723013wmn.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YW4M4L/7AHlbX388X4aHywuWSD5VXnrjQHVqx3UIEg8=;
        b=XSrEV44EGgV+69Znk/NICoQRS+BUTAcAlvvz58OmkeAD4uThmdRUd9ya+4m5DJYRTv
         BQM1Izx2bf9xG3clqERbzYn/MOVhBs7o5G3ASaOoUrsKvxQ1tjAZHVd33WTd3N8skpzi
         QQ8YBYb9faOVcW4Gdvs2SVcfiTIHWT88eABjjsTmCGk4j6VQIs8Wq1/qPHmDKKyHSY0A
         0BXD5kbGLdoHqTjOl8ZYZce7jueVqhDOMdXjxN0v7WxiyUweaPwPqFCrhV4753JgyA1j
         vQ+4t55UjBctsMrilbmmx1ae1uBIxrrypZC9yVkoRUO4Q1t67qXxKJuTRicpAe62br6S
         j/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YW4M4L/7AHlbX388X4aHywuWSD5VXnrjQHVqx3UIEg8=;
        b=k0Wfu+kAaIFW2gi3TkhXtkxbq2kp1NEpzjbTNmTefAuJ3l22e732rt2Dh9FOvg4MAs
         3p1HqHGyi/9/3U60cI/14VmLslNLibDGzg0Oq2tFKrUMNgGWFC/ExUgpnH2D/diGTnCa
         9E5jiI8ewnibkJPH/hbRFJyIY6oeguv6xYl9rL5zYtUKxfE13PHkOz7D8zIzRoxLmdn4
         aNBrFQEc/IjmCj/aTGuxbQrZLPnjfMXez8UvfBNapyT892zZSpsSyM8MiYjlcmOZhNYp
         1lH8SzTMeiOi+CeICf/fiiilIoVR/a1O1e2rsHHc/h5+9xJAmJRAsHWN0AWd+haJvdlr
         k2ww==
X-Gm-Message-State: AOAM532EM2Y1wos2jsLVbJ+dCqtURmF+v/jK9GJPsCzu1exYNUDd1ukk
        SVezSXfYP8NVSrdGoRH0jgaAo6rnLUDW/yX1Yu2NHw==
X-Google-Smtp-Source: ABdhPJyCmMLeQh+SyPnzTmL/vDHbEwP5Nopp4dkQPFgA0EDG9jy2E1OOwPnJW5bfNcQOc4sadnO83iAhQg2VI2voYeE=
X-Received: by 2002:a1c:2704:: with SMTP id n4mr1089154wmn.147.1620722369062;
 Tue, 11 May 2021 01:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210429084410.783998-1-amistry@google.com> <20210429184101.RFC.v2.1.Iadd904c1764f3bfe260db30fe41bdb9b8f98533d@changeid>
 <878s4wdwyy.ffs@nanos.tec.linutronix.de>
In-Reply-To: <878s4wdwyy.ffs@nanos.tec.linutronix.de>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Tue, 11 May 2021 18:39:15 +1000
Message-ID: <CAATStaOmBw1nr9Y5pZw9MXK0Y4TMvyOe0M6-PZpy7RQnS0szyA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] x86/speculation: Allow per-process control of
 when to issue IBPB
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Joel Fernandes <joelaf@google.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jay Lang <jaytlang@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2021 at 18:48, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Anand,
>
> On Thu, Apr 29 2021 at 18:44, Anand K. Mistry wrote:
> >
> > -static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
> > +static inline unsigned long mm_mangle_tif_spec_ib_on_leave(
> > +     struct task_struct *next)
> >  {
> >       unsigned long next_tif = task_thread_info(next)->flags;
> > -     unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
> > +     unsigned long spec_disabled =
> > +             (next_tif >> TIF_SPEC_IB) & ~(next_tif >> TIF_NO_IBPB_LEAVE);
> > +     unsigned long ibpb = spec_disabled & LAST_USER_MM_IBPB;
> >
> >       return (unsigned long)next->mm | ibpb;
> >  }
> >
> > +static inline bool ibpb_on_entry(struct task_struct *next)
> > +{
> > +     unsigned long next_tif = task_thread_info(next)->flags;
> > +     unsigned long spec_disabled =
> > +             (next_tif >> TIF_SPEC_IB) & ~(next_tif >> TIF_NO_IBPB_ENTRY);
> > +     return spec_disabled & 1;
> > +}
>
> Why exactly do we need _three_ TIF bits and this non-intuitive inverted
> logic?

The inverted logic is to avoid any side effects of flag bits
defaulting to 0, which should keep the existing behaviour of doing an
IBPB on both entry and exit.

>
> The existing mode is: Issue IBPB when scheduling in and when scheduling out.
>
> Ergo the obvious approach for making it more finegrained is to split the
> existing TIF_SPEC_IB into TIF_SPEC_IB_IN and TIF_SPEC_IB_OUT and have
> the existing mode both bits set.

Agreed. The problem is the existing bit doesn't just control IBPB
behaviour. It also controls STIBP, which you can kinda control
separately on the command line when booting with the spectre_v2_user
flag. The code, however, uses the same flag for both (see
arch/x86/include/asm/spec-ctrl.h).

Maybe this is another cleanup I should do prior to this change?
Separating IBPB and STIBP flags in the implementation.

>
> Thanks,
>
>         tglx
>
>

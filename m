Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB7145E79A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 06:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352091AbhKZGAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242483AbhKZF6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 00:58:15 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C2C061757
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 21:55:03 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y68so17431456ybe.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 21:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYm+Oj5b5DS7c4h2uMaSXgxaMKweYGTC9dYrubjKWhA=;
        b=DaOCr9/ufE6o0ZxwS7+ToZ7ghJ9pgXP7PM83y7WAtfJfYqy2LxHfIrC3MqmVxo2082
         GRUnl7Fwyxu24siDEAZGBp9oCXdV3dqCitgwrshVFehZoU9j/XpstJgvugfB+1iCdsxf
         H2JPGQR5w6U3am4/0zio/bera3YU2bGe9EaRJbUYSbzaaXu9u81iNGbmjrNrKzntbrhs
         gJGcDy2FW4AJQYVuw/dSnFa42Tnw1DG56u1/ZNTRPWzFHY+/8PivpGyRUo2fEKFnr/BE
         hU8+PJV4amp6UxhathDhGCb39Od9Yca+eniG6t8TyzCfHVeF5HBiE7yf/KSNcgMxfjSX
         Gsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYm+Oj5b5DS7c4h2uMaSXgxaMKweYGTC9dYrubjKWhA=;
        b=It5hta5/n4p9fODLa2+yP789zyyKzccvSYR09Kxb6WWKu6Smp9hK9hBqEx+C7ylp4e
         1XY8oUb7t4/RGccg2J7siXkmdhnVHt7+/WUhqtJ91s5gvEW+sEFx9c1Z6NOdbbDw31NY
         0Wf+6OcXSQ3C2g/sx3YtusWOQOvWDprGKtBEsDnuwIYU/FOpU/8MmdVxYBanZwgBt4cz
         6esR86Sz8Y6PpPwxRBpG/k97CxG9JjEm0CzgiiJk7FmFA591ZvSvaPIg6hvsUeWPv3ih
         UASr1NXjqbgF5gym8tHXtaF43Tm5Yk+7T006fNnxix3ipHsfvGjk1+QUvwMRYWkQzudm
         3osg==
X-Gm-Message-State: AOAM5319PZNhM0ke0LNf/EGyd4VaZCHbRe74KPAi5uiMaZgbkawI1/hf
        pxEgRglKE+cLtcZdLl86u+6hB8AWs66PypHygGxqDA==
X-Google-Smtp-Source: ABdhPJwkgwRRLS9LLDsz5qXSVgIlxlrkuVWkoLPGg1tSYn5NJ7OXaQMZ2gammsjPvPa8LknqFrX04hwyA7njdkp91/A=
X-Received: by 2002:a25:d2ca:: with SMTP id j193mr12308424ybg.419.1637906102695;
 Thu, 25 Nov 2021 21:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20211119065831.31406-1-songmuchun@bytedance.com>
 <396ef026-c299-6560-fe7c-7b9932164fe3@intel.com> <CAMZfGtVDgbLAS3uyB0QPHpDsA8Mam0sVYFdq9HhU4rSjqZG0qw@mail.gmail.com>
 <87a6hsms2v.ffs@tglx>
In-Reply-To: <87a6hsms2v.ffs@tglx>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 26 Nov 2021 13:54:23 +0800
Message-ID: <CAMZfGtV0=gCmOGTwP44U=7BMrP3U2MdWEbNdMVA8kck4D0upwQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] x86/fault: move might_sleep() out of
 mmap read lock
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 6:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Muchun, Dave!
>
> On Mon, Nov 22 2021 at 14:59, Muchun Song wrote:
> > On Fri, Nov 19, 2021 at 11:04 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >> >
> >> > +     might_sleep();
> >> > +
> >> >       /*
> >> >        * Kernel-mode access to the user address space should only occur
> >> >        * on well-defined single instructions listed in the exception
> >> > @@ -1346,13 +1348,6 @@ void do_user_addr_fault(struct pt_regs *regs,
> >> >               }
> >> >  retry:
> >> >               mmap_read_lock(mm);
> >> > -     } else {
> >> > -             /*
> >> > -              * The above down_read_trylock() might have succeeded in
> >> > -              * which case we'll have missed the might_sleep() from
> >> > -              * down_read():
> >> > -              */
> >> > -             might_sleep();
> >> >       }
> >> >
> >> >       vma = find_vma(mm, address);
> >>
> >> The comment is stale, which isn't great.  The might_sleep() is already
> >> in the fast path.  So, moving it up above makes a lot of sense just in
> >> terms of simplicity.
>
> I don't think so. The point is:
>
>         if (unlikely(!mmap_read_trylock(mm))) {
>                 if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
>                         /*
>                          * Fault from code in kernel from
>                          * which we do not expect faults.
>                          */
>                         bad_area_nosemaphore(regs, error_code, address);
>                         return;
>                 }
>
> Moving it up will make the might_sleep() splat more important than an
> unexpected fault when the unexpected fault happens in e.g. a preemption
> disabled region. That's wrong because the important information in this
> case is not the might sleep splat. The important information is the
> fault itself.
>
> But moving it up is even more wrong for spurious faults which are
> correctly handled in that case via:
>
>      bad_area_nosemaphore()
>        __bad_area_nosemaphore()
>          kernelmode_fixup_or_oops()
>             handle(AMD erratum #91)
>               is_prefetch()
>
> So if such a spurious fault happens in a condition which would trigger
> the might_sleep() splat then moving might_sleep() before the trylock()
> will cause false positives. So, no. It's going to stay where it is.

Got it. I didn't realize those cases. Thank you for your patient
explanation.


>
> > Without this patch, I didn't see the might_sleep() in the fast path. What
> > am I missing here?
>
> I have no idea what you are doing. If the trylock() succeeds and the
> fault happened in e.g. a preemption disabled region then the
> might_sleep() in the else path will trigger no matter what.
>
> Thanks,
>
>         tglx

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CA2458986
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhKVHDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhKVHDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:03:39 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:00:33 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id f186so10419232ybg.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A51ZtMlfDXyYxWqI49ku+X7L29fI6CV3Wh9mGunfMEU=;
        b=YFVj4Bx+rwQ21Jk/UsCGiPLytBUGZ3j2HFdj3r5YUvU+ggZn/55c/bpNkFBPic619u
         PgzoCTk0VKydBMagr2jOxQWrGT/w+4erXHHrObJCyKlDpybmWta5a2pOBUfPzr7GhDCL
         mDUDvTfaj0JrDJEb9svu1oe4xyP+K18vF7rftyuRHvXUlrCwmPijzSj4Q1YoGq9WEcAv
         VXJFxW89L/dlw3f8PbnaYNrldATJnjko5T9Zf7rDEAh0+uMUa21rTvC02eFBnzH21seS
         9tz0nFX4fKuFOxnkY6RnjhH0bepKDxhiepi+lvMitwgb5VOeBLWqDODLkA5p0JeKKOdd
         ZpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A51ZtMlfDXyYxWqI49ku+X7L29fI6CV3Wh9mGunfMEU=;
        b=rrwqtha1xtZqE17hptOCPRR2IlyNzlzaINYPg/304LcnEG8lKaXGjd56VYhRwRV9Zn
         rPeCFryW5qJu1rOkKkzhCdTK5kBm84IQC5EwZae8NRxRmuPfVWL38vqtO7qIr4qkNEWu
         Pqv8JmG+UEcMllWWsa8uqJ2/igNfagL8Eq5iugY3aDgZDXjWHSVCHfZV9oR4t+H+Ktz0
         9IuqISa2qAOtu4MssoqWGQgdojCBL7EvBdslIAQ98tMkSa1RSMDyjGhir09gk835n0/9
         p5pUOAVxXDsgS9Exk7VTN6Tb/lqE/J69aGGbDshEqz7zF0A0hDRdtaoRCwiU7p+BdREE
         rtug==
X-Gm-Message-State: AOAM533VlZLQBMEBgGlJC/D8xDhZeRHYpfSTAa/kgY74pIn6cSvkYq6F
        L7ERVV3rzc5FTQctmHa03DhCTatK1ov4UkYZe/no/Q==
X-Google-Smtp-Source: ABdhPJzFpa6yAWmp7+JqT29L5+gq3ZxFaHUyh7WrfXSxOBwJHlsWdaSfjGGc6oi94TCqyEy2mUrN5qvWsg1haQKd2hY=
X-Received: by 2002:a05:6902:1144:: with SMTP id p4mr4456751ybu.404.1637564432229;
 Sun, 21 Nov 2021 23:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20211119065831.31406-1-songmuchun@bytedance.com> <396ef026-c299-6560-fe7c-7b9932164fe3@intel.com>
In-Reply-To: <396ef026-c299-6560-fe7c-7b9932164fe3@intel.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 22 Nov 2021 14:59:54 +0800
Message-ID: <CAMZfGtVDgbLAS3uyB0QPHpDsA8Mam0sVYFdq9HhU4rSjqZG0qw@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/fault: move might_sleep() out of mmap read lock
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 11:04 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/18/21 10:58 PM, Muchun Song wrote:
> > The mmap lock is supposed to be a contended lock sometimes, scheduling
> > to other task with holding mmap read lock does not seems to be a wise
> > choice. So move it to the front of mmap_read_trylock(). Although
> > mmap_read_lock() implies a might_sleep(), I think redundant check is
> > not a problem since this task is about to sleep and it is not a hot
> > path.
>
> This justification doesn't really do it for me.  There are a billion
> ways to sleep in the fault path while the mmap lock is held.  Adding one
> more cond_resched() doesn't seem like it would do much.

I agree with you that there are lots of ways to sleep in the
fault path. Just try my best to not sleep with mmap lock.

>
> In other words, I don't think there's a performance justification here.
>
> That said...
>
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 4bfed53e210e..22fd1dfafa3d 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1323,6 +1323,8 @@ void do_user_addr_fault(struct pt_regs *regs,
> >       }
> >  #endif
> >
> > +     might_sleep();
> > +
> >       /*
> >        * Kernel-mode access to the user address space should only occur
> >        * on well-defined single instructions listed in the exception
> > @@ -1346,13 +1348,6 @@ void do_user_addr_fault(struct pt_regs *regs,
> >               }
> >  retry:
> >               mmap_read_lock(mm);
> > -     } else {
> > -             /*
> > -              * The above down_read_trylock() might have succeeded in
> > -              * which case we'll have missed the might_sleep() from
> > -              * down_read():
> > -              */
> > -             might_sleep();
> >       }
> >
> >       vma = find_vma(mm, address);
>
> The comment is stale, which isn't great.  The might_sleep() is already
> in the fast path.  So, moving it up above makes a lot of sense just in
> terms of simplicity.

Without this patch, I didn't see the might_sleep() in the fast path. What
am I missing here?

Thanks.

>
> The might_sleep() does need a comment, though, about what it's _doing_
> there.
>
> So, right idea, good result, but for the wrong reasons.
>
> If you want to revise the justification and add a comment, I think this
> is something we can take.

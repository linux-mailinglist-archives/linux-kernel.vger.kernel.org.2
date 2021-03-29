Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247C634D639
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhC2RqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhC2RqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:46:07 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 10:46:06 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso13072061otq.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQKkZ6Ug92WKVE3kMUgFwD2xtwQ5flzTIZnOczAKft4=;
        b=mcP8xaGRZwMkDj1Qn5ZmTkvj3oKV7IA/5psShr7lH1lBPM3dFr8DTdRTE1HQ8e9DdV
         eqQtjM/f32h5k9oX4VqjKwSGsozy78u2h6wG7J3hz0S3bQhu/cb9eib1zQlwXr7K8NK8
         4GmIEVsxwOSu0K+zYi47gBFaXQcbWftXhNqJ5WSfsXF5d3xP+2+QT9hKQpDnV6w3H1S6
         YF3IqbY98ZmtNc/49Q5kHjr8DDA2LV1AGl8n0ive8taKPPvsukRtm0yHS3D0sfXETkFD
         PImLPWYfdJvOaPKnZqgEYaTOe6HJ0mP+NsYnXbmtTd20MVvo+awXXg0WT4bKTGQlNBGu
         J40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQKkZ6Ug92WKVE3kMUgFwD2xtwQ5flzTIZnOczAKft4=;
        b=HnHOYi/ouy2XuTe/lT7wRw7lLdHMUvWbQZWUANXPvH0MqN1kZqPSeZHINnwlMVDt0m
         jU5O3uwpHU/Ae4UQwC6Yh5A5xdt7IB0f7oZuL9XmOn+p9/j8gkLJa8hOaMRTg3zNRNB0
         1CmB+bSRD5pH2kVIMaCDsf8J8zC4i9CEGOze+tF9YXGI2IeG5KhTtWWjMnV8X6dBfiMJ
         YTTIG+NKFrCgbSB4LH35B843p+MIbOLX4Q7P9idqfxF9RE3X27a0oc5Kyf7TbHIpXQ8u
         +P/pSZzCZhlTrXktn5SLvnX+SYrPK+dq0ufM7k0u1aAvQVtoAKK6sMDx0IYJA37emK6c
         mzOg==
X-Gm-Message-State: AOAM532RCbmm50z7gIg1WQ6dlXQGyfJpvZ4hw+Qy+LLUAHP5+U5EUkl5
        22ozbkKKJzShY3SgEkkxQJQglO2njMpeNRcwsXfkMw==
X-Google-Smtp-Source: ABdhPJwI3CW1GvqXIdh+5roVEauaGWQxqiSWxba/K29H/WAJHncRfA1BmGgyd7qwGLHvXAKHKf4swPmQaUc4Z9TKig8=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr23850224otg.17.1617039965937;
 Mon, 29 Mar 2021 10:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <d60bba0e6f354cbdbd0ae16314edeb9a@intel.com> <66f453a79f2541d4b05bcd933204f1c9@intel.com>
 <YGIDBAboELGgMgXy@elver.google.com> <796ff05e-c137-cbd4-252b-7b114abaced9@intel.com>
In-Reply-To: <796ff05e-c137-cbd4-252b-7b114abaced9@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 29 Mar 2021 19:45:53 +0200
Message-ID: <CANpmjNP4Jjo2W2K_2nVv3UmOGB8c5k9Z0iOFRFD9bQpeWr+8mA@mail.gmail.com>
Subject: Re: I915 CI-run with kfence enabled, issues found
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 at 19:32, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 3/29/21 9:40 AM, Marco Elver wrote:
> > It looks like the code path from flush_tlb_one_kernel() to
> > invalidate_user_asid()'s this_cpu_ptr() has several feature checks, so
> > probably some feature difference between systems where it triggers and
> > it doesn't.
> >
> > As far as I'm aware, there is no restriction on where
> > flush_tlb_one_kernel() is called. We could of course guard it but I
> > think that's wrong.
> >
> > Other than that, I hope the x86 maintainers know what's going on here.
> >
> > Just for reference, the stack traces in the above logs start with:
> >
> > | <3> [31.556004] BUG: using smp_processor_id() in preemptible [00000000] code: dmesg/1075
> > | <4> [31.556070] caller is invalidate_user_asid+0x13/0x50
> > | <4> [31.556078] CPU: 6 PID: 1075 Comm: dmesg Not tainted 5.12.0-rc4-gda4a2b1a5479-kfence_1+ #1
> > | <4> [31.556081] Hardware name: Hewlett-Packard HP Pro 3500 Series/2ABF, BIOS 8.11 10/24/2012
> > | <4> [31.556084] Call Trace:
> > | <4> [31.556088]  dump_stack+0x7f/0xad
> > | <4> [31.556097]  check_preemption_disabled+0xc8/0xd0
> > | <4> [31.556104]  invalidate_user_asid+0x13/0x50
> > | <4> [31.556109]  flush_tlb_one_kernel+0x5/0x20
> > | <4> [31.556113]  kfence_protect+0x56/0x80
> > |     ...........
>
> Our naming here isn't great.
>
> But, the "one" in flush_tlb_one_kernel() really refers to two "ones":
> 1. Flush one single address
> 2. Flush that address from one CPU's TLB
>
> The reason preempt needs to be off is that it doesn't make any sense to
> flush one TLB entry from a "random" CPU.  It only makes sense to flush
> it when preempt is disabled and you *know* which CPU's TLB you're flushing.

Thanks for the rationale behind needing preempt off.

Though in our case it really is best-effort, as long as we hit the CPU
of the currently running task most of the time.

Doing it to all CPUs is too expensive, and we can tolerate this being
approximate (nothing bad will happen, KFENCE might just miss a bug and
that's ok).

> I think kfence needs to be using flush_tlb_kernel_range().  That does
> all the IPI fanciness to flush the TLBs on *ALL* CPUs, not just the
> current one.

The other problem is that this code can be called from interrupts.
This is already documented in arch/x86/include/asm/kfence.h

> BTW, the preempt checks in flush_tlb_one_kernel() are dependent on KPTI
> being enabled.  That's probably why you don't see this everywhere.  We
> should probably have unconditional preempt checks in there.

In which case I'll add a preempt_disable/enable() pair to
kfence_protect_page() in arch/x86/include/asm/kfence.h.

Thanks,
-- Marco

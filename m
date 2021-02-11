Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1D1318361
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhBKCBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhBKByJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 20:54:09 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FF1C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 17:51:48 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z18so3752664ile.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 17:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5zl/FSJ37PsyuUaMrLNNteEx4fjuak9wAGRwR+vlfU=;
        b=Y0LrnYsQlFTrZeS/fJ1d+QlE+rQ/QYWKEr2a8yWpuS+aVZ2gI06At84V2GB3sCmker
         Z6sP102pBH5CqVLCKeIwsXZw7KRWtRvVHN/Eo4uGH7jTSyfuLInOzXUZySqZqpo+CO61
         N2K6lUgjpFOG6HQ/sv3Cn+b1xUHr79RqS26HCbhHbJLIUYA6Xsbqf0ffX/4UPuusMxdN
         zBH4mqIb55pHRExndYjBqlzs7i9zD12RUDSw0tICHrt798Xs8L0Y89X+AaXcY88y8/mt
         mMFdnEui9/I8aKrV5pxORXbwDYtbdrkWY+zUiyaPSAw2PnOGRySjhqZJE4oAjFMLX5rE
         QZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5zl/FSJ37PsyuUaMrLNNteEx4fjuak9wAGRwR+vlfU=;
        b=kFywD51jMHAEYtEojSbICUIxczAYld+2tlwJLUZYYYq/EAuhZv5hneVJXk5CNK4CT2
         BuV3YuIqalF0mzvX1nx3vC0Y64WwfEX4cAY2M9ai7dPHmORk6sjGJS8LprhfI7wkMqo0
         oc6cF5ODGr7SgMfBg/17s/4hgWEOpQoRfBqd1eC/r5Gk2wCuP3UBaE+7M7U7ZAsHgwEr
         ROu9TTWuh4i2VdsDopVSMZKkRpcFcHbcsoKGAaipmjLLfVREMjHvqGVjplFz9PZmUenB
         NqSpZrlFz2oqeDU5hDM8kLviUoNDlWNN4d3oCeAj3doLQAhyQghG+tUrhqqZok/FecEs
         zARw==
X-Gm-Message-State: AOAM530hd6B5YlHizhL0mSRDTP1/mw/IrvA6tgkBlMlcEQk94zxCgerp
        IptLWnO+J1Wac9eG2NtOzAXNmpELBz3ybO3lRbc=
X-Google-Smtp-Source: ABdhPJxXpHi7uVFoXv2Ttaecc0PsHC83hfgvDmYUb1ISP0q5Kpc98k6JvwKyjTNDoqG2O5WyQ190svn29/3JSYixhTA=
X-Received: by 2002:a92:d689:: with SMTP id p9mr34169iln.94.1613008308371;
 Wed, 10 Feb 2021 17:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20210210133917.2414-1-jiangshanlai@gmail.com> <20210210234228.GB75203@linux.intel.com>
In-Reply-To: <20210210234228.GB75203@linux.intel.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 11 Feb 2021 09:51:37 +0800
Message-ID: <CAJhGHyA9RHiOAOcUxVfSPsPJpWnofG0ZCzOb916Xe0UwrqP4vw@mail.gmail.com>
Subject: Re: [PATCH V4 0/6] x86: Don't abuse tss.sp1
To:     Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Balbir Singh <sblbir@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

Thank you for your reply.

On Thu, Feb 11, 2021 at 7:42 AM mark gross <mgross@linux.intel.com> wrote:
>
> On Wed, Feb 10, 2021 at 09:39:11PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > In x86_64, tss.sp1 is reused as cpu_current_top_of_stack.  We'd better
> > directly use percpu since CR3 and gs_base is correct when it is used.
> Be more direct if not using percpu is incorrect in some way.

Sure, I will abstract the most important reason from changelogs to
cover letter in the future.

> >
> > In x86_32, tss.sp1 is resued as thread.sp0 in three places in entry
> s/resued/reused

Sorry, I made it wrong in every cover letter even I noticed it after V2
was sent.  I forgot to use a spellchecker on the cover letter.

> > code.  We have the correct CR3 and %fs at two of the places.  The last
> > one is sysenter.  This patchset makes %fs available earlier so that
> > we can also use percpu in sysenter.  And add a percpu cpu_current_thread_sp0
> > for thread.sp0 instead of tss.sp1
> >
> > [V3]: https://lore.kernel.org/lkml/20210127163231.12709-1-jiangshanlai@gmail.com/
> > [V2]: https://lore.kernel.org/lkml/20210125173444.22696-1-jiangshanlai@gmail.com/
> > [V1]: https://lore.kernel.org/lkml/20210123084900.3118-1-jiangshanlai@gmail.com/
> >
> > Changed from V3:
> >       Update subjects as Borislav's imperative request. ^_^
> >       Update changelog as Borislav suggested.
> >       Change EXPORT_PER_CPU_SYMBOL to EXPORT_PER_CPU_SYMBOL_GPL.
> >
> > Changed from V2:
> >       Add missing "%ss:" reported by Brian Gerst.
> >
> > Changed from V1:
> >       Requested from Andy to also fix sp1 for x86_32.
> >       Update comments in the x86_64 patch as Andy sugguested.
> >
> > Lai Jiangshan (6):
> >   x86/entry/64: Move cpu_current_top_of_stack out of TSS
> >   x86/entry/32: Use percpu instead of offset-calculation to get
> >     thread.sp0 in SWITCH_TO_KERNEL_STACK
> >   x86/entry/32: Switch to the task stack without emptying the entry
> >     stack
> >   x86/entry/32: Restore %fs before switching stack
> >   x86/entry/32: Use percpu to get thread.sp0 in SYSENTER
> >   x86/entry/32: Introduce cpu_current_thread_sp0 to replace
> >     cpu_tss_rw.x86_tss.sp1
> >
> >  arch/x86/entry/entry_32.S          | 38 +++++++++++++++++-------------
> >  arch/x86/include/asm/processor.h   | 12 ++--------
> >  arch/x86/include/asm/switch_to.h   |  8 +------
> >  arch/x86/include/asm/thread_info.h |  6 -----
> >  arch/x86/kernel/asm-offsets.c      |  1 -
> >  arch/x86/kernel/asm-offsets_32.c   | 10 --------
> >  arch/x86/kernel/cpu/common.c       | 12 +++++++++-
> >  arch/x86/kernel/process.c          |  7 ------
> >  arch/x86/mm/pti.c                  |  7 +++---
> >  9 files changed, 39 insertions(+), 62 deletions(-)
> >
> > --
> > 2.19.1.6.gb485710b
> >

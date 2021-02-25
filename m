Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6D93254C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhBYRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBYRuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:50:25 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACC2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:49:44 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id i18so5650671ilq.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJnQze4s7vswISnbCGhHflL3OZsJL4Q4R5lNZ0nK1fM=;
        b=uqliQ2HiXjIlljT41RRdBjWbql98IXfonVNnsJ8p4wEwWJlJT/qgnfwfgE1TgHWJSL
         oFgsAKmLf62KPP9v3dnv23ogV7UrTyC3k7q3g/+FZHFbRoJWGLivcDvRgeDG5Jd0z51N
         MvV1+O0xAzm1qlUJfmsyTyQCQJNgZk0d5b1OtEYLbq4rbEsBAqES3pVvP5D1LmjqTiBh
         U7YFjx3KBBERlE+s3u/mtfNY22QEoKrBUHqHfDJYjGS0K1m1g6bQ7OQvgOzsqJONy18Y
         n1XtEv3Jezg0ODRxxDEpH2Yk1TaQBixWcVhyco+Zedq7g0b54wkzDnfFgSrLN34yLIpN
         4v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJnQze4s7vswISnbCGhHflL3OZsJL4Q4R5lNZ0nK1fM=;
        b=H5Bpm+XbC/w18Ez0qXH0Go5qqKo/iGog5XNCGhzhwPsvuW3+f8BT7xVqS5gmdNVDD9
         fk9uyFnZkVPe6vcxtu4qlfjtn/r+2ezw1HF5Mac8vTZqKrUoVroGTzmyA1HcZZNbwgWL
         RJSX/7KjYCIk+HX6/aQsrsXyvDBn2Lkj+qHVJbMbKI8XY2Km6nn1Q2DYTD5FwMzX2Ns6
         oRb4p07uGSCgrKPz7DdIfDW6mPelEUmLa4++gC2EOvz9XFDpSY3zjsmFMc9/98U7TjuF
         yDuTi/0O1L+qAGvJCZdApeg+eoyIX5obfR9T+v7WGUd83oys8VQtfKYdtq8E79ZYEYbj
         9N4Q==
X-Gm-Message-State: AOAM532tgAN3XT6Mv6BOVs3z86mgm6J35W4jSOq765aTkdzbeBnEITLf
        IepMIM0m2yanhAm3edgbo6YJLaIhSGz+DUjeMwL6TA==
X-Google-Smtp-Source: ABdhPJxRfypj7tZiS+BTmPCM/z3vDlkHH9RIC5lMCuFP7wUiggbVRnTPOj21kcRQ+dCpMmznHlbmqjeyoZRZIeuZW7g=
X-Received: by 2002:a05:6e02:1c8d:: with SMTP id w13mr3503003ill.301.1614275384038;
 Thu, 25 Feb 2021 09:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20210219004824.2899045-1-axelrasmussen@google.com>
 <20210219004824.2899045-2-axelrasmussen@google.com> <6aefd704-f720-35dc-d71c-da9840dc93a6@oracle.com>
In-Reply-To: <6aefd704-f720-35dc-d71c-da9840dc93a6@oracle.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 25 Feb 2021 09:49:07 -0800
Message-ID: <CAJHvVch4iweAW274Ub5Q_oKgZaTHvEkGnE4=jo6SfxOs1qCf6A@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] userfaultfd: add minor fault registration mode
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 4:26 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/18/21 4:48 PM, Axel Rasmussen wrote:
> <snip>
> > @@ -401,8 +398,10 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> >
> >       BUG_ON(ctx->mm != mm);
> >
> > -     VM_BUG_ON(reason & ~(VM_UFFD_MISSING|VM_UFFD_WP));
> > -     VM_BUG_ON(!(reason & VM_UFFD_MISSING) ^ !!(reason & VM_UFFD_WP));
> > +     /* Any unrecognized flag is a bug. */
> > +     VM_BUG_ON(reason & ~__VM_UFFD_FLAGS);
> > +     /* 0 or > 1 flags set is a bug; we expect exactly 1. */
> > +     VM_BUG_ON(!reason || !!(reason & (reason - 1)));
>
> I may be confused, but that seems to be checking for a flag value of 1
> as opposed to one flag being set?

(Assuming I implemented it correctly!) It's the logical negation of
this trick: https://graphics.stanford.edu/~seander/bithacks.html#DetermineIfPowerOf2
So, it's "VM_BUG_ON(reason is *not* a power of 2)".

Maybe the double negation makes it overly confusing? It ought to be
equivalent if we remove it and just say:
VM_BUG_ON(!reason || (reason & (reason - 1)));

>
> >
> >       if (ctx->features & UFFD_FEATURE_SIGBUS)
> >               goto out;
> <snip>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 3bfba75f6cbd..0388107da4b1 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4352,6 +4352,38 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >                               VM_FAULT_SET_HINDEX(hstate_index(h));
> >                       goto backout_unlocked;
> >               }
> > +
> > +             /* Check for page in userfault range. */
> > +             if (userfaultfd_minor(vma)) {
> > +                     u32 hash;
> > +                     struct vm_fault vmf = {
> > +                             .vma = vma,
> > +                             .address = haddr,
> > +                             .flags = flags,
> > +                             /*
> > +                              * Hard to debug if it ends up being used by a
> > +                              * callee that assumes something about the
> > +                              * other uninitialized fields... same as in
> > +                              * memory.c
> > +                              */
> > +                     };
> > +
> > +                     unlock_page(page);
> > +
> > +                     /*
> > +                      * hugetlb_fault_mutex and i_mmap_rwsem must be dropped
> > +                      * before handling userfault.  Reacquire after handling
> > +                      * fault to make calling code simpler.
> > +                      */
> > +
> > +                     hash = hugetlb_fault_mutex_hash(mapping, idx);
> > +                     mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +                     i_mmap_unlock_read(mapping);
> > +                     ret = handle_userfault(&vmf, VM_UFFD_MINOR);
> > +                     i_mmap_lock_read(mapping);
> > +                     mutex_lock(&hugetlb_fault_mutex_table[hash]);
> > +                     goto out;
> > +             }
> >       }
> >
> >       /*
> >
>
> I'm good with the hugetlb.c changes.  Since this in nearly identical to
> the other handle_userfault() in this routine, it might be good to create
> a common wrapper.  But, that is not required.

Makes sense, I can send a v9 with a helper for this defined. I'll wait
until at least next week to do so, to pick up any other comments v8
may get in the meantime.

Thanks!

> --
> Mike Kravetz

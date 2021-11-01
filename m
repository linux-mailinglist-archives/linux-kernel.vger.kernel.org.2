Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2FE441C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhKAOZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhKAOZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:25:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE8C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:23:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d23so28332470ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDzQzAKmrO4cE12pbgUF6sOtfYcuXG+MDS8ZFstUnZs=;
        b=A8I+yiJOK6RGvfYlNHU859Gr6ZKPAJIavCw93TUSQA/psdn1XnKFa1ouGoJ1WSawOt
         NEuLktnHURzeQafTm4cn87bl3HoJNfpJLwCLS24aCcQZjSrTxkBHaNWKZHiO5xdKdcsq
         KPBzvs7/MVNl4Z4Z60n5M05PRhYHlxin56Fy6vW5SpUkSRVQ1RnCEVByU+HoxkVPakMk
         TEEhAJLE/PPgLTo0i7NaL43ZZlXwjggucMSw5pFgLHfsU7wnm7FsELBd4EiStLZ0d8/e
         EbtjN+COC37/C75r4Tfl2mTJAUgvE3fDGomiZAU8gkiCm6eNg94FYN8I/I4DSPRQDC2q
         zOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDzQzAKmrO4cE12pbgUF6sOtfYcuXG+MDS8ZFstUnZs=;
        b=WfccaarWDxhWody9xkvv7m2m4Il2WdGuDTOc6M/lPvQkDafW0AzLea9t/Ip5cQYe+Y
         ru6MrkIHYHJzpC2ImL5N/cdiAak7qzpYZPB05TDHMBExvknD+kG3GrK3ENet50cExCLC
         UiPlIiyUIzjfeTddmCC9sUIVuOs3T33H6r3aumGbkf7TGmtKXeCFlvFq56DIFYZwN8P8
         1xsx/fsJs6RN5KSQEi9e+d7JSHvH/6XzzymD+H5Jesv6f4fTvoQOrRX+YdeXJzL9NrJk
         hG8O3aDD1SXf4bGYpn94v63yrXrCpJrBVOfwxxC0rqSimKGu9UDAA7oqzCxIQeL6jVhh
         jPCA==
X-Gm-Message-State: AOAM5334reHz7xqddrzby7ycYwhzjFnsJDipng2dMRWafE3gypn1D9nX
        WJRSAMCXfTs57kVaMnnYo5J53lrSMkzZHjXW2IqJ6A==
X-Google-Smtp-Source: ABdhPJw2SDdjdrCAgvF2ObKwyMwAY8ht9SsxgV39b77Et+zkpNgad6QMEQngm1Q75lk8lMfydQmMHUB46JiVHGbLEAA=
X-Received: by 2002:a05:651c:104b:: with SMTP id x11mr28045714ljm.422.1635776598895;
 Mon, 01 Nov 2021 07:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-4-pasha.tatashin@soleen.com> <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
 <CA+CK2bD6x01PevPqshzYqkO3aokjP2jBbt_4e5H5U3DVEdcJ5Q@mail.gmail.com>
 <b346cafd-d8b8-57a4-c7b9-6574b256a400@nvidia.com> <CA+CK2bBiomTe-vOuxM_R+0CMAippyrfZ6AgpXQGqps3ZFQCtRA@mail.gmail.com>
 <19d16b40-355f-3f79-dcba-e1d8d2216d33@nvidia.com>
In-Reply-To: <19d16b40-355f-3f79-dcba-e1d8d2216d33@nvidia.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 1 Nov 2021 10:22:43 -0400
Message-ID: <CA+CK2bBn81pz5NqCvS9jz+DvXbGG6d52Q=xTySJvJuqNRmFkkg@mail.gmail.com>
Subject: Re: [RFC 3/8] mm: Avoid using set_page_count() in set_page_recounted()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Yes, you are just repeating what the diffs say.
> >>
> >> But it's still not good to have this function name doing something completely
> >> different than its name indicates.
> >
> > I see, I can rename it to: 'set_page_recounted/get_page_recounted' ?
> >
>
> What? No, that's not where I was going at all. The function is already
> named set_page_refcounted(), and one of the problems I see is that your
> changes turn it into something that most certainly does not
> set_page_refounted(). Instead, this patch *increments* the refcount.
> That is not the same thing.
>
> And then it uses a .config-sensitive assertion to "prevent" problems.
> And by that I mean, the wording throughout this series seems to equate
> VM_BUG_ON_PAGE() assertions with real assertions. They are only active,
> however, in CONFIG_DEBUG_VM configurations, and provide no protection at
> all for normal (most distros) users. That's something that the wording,
> comments, and even design should be tweaked to account for.

VM_BUG_ON and BUG_ON should be treated the same. Yes, they are config
sensitive, but in both cases *BUG_ON() means that there is an
unrecoverable problem that occured. The only difference between the
two is that VM_BUG_ON() is not enabled when distros decide to reduce
the size of their kernel and improve runtime performance by skipping
some extra checking.

There is no logical separation between VM_BUG_ON and BUG_ON, there is
been a lengthy discussion about this:

https://lore.kernel.org/lkml/CA+55aFy6a8BVWtqgeJKZuhU-CZFVZ3X90SdQ5z+NTDDsEOnpJA@mail.gmail.com/
"so *no*. VM_BUG_ON() is no less deadly than a regular BUG_ON(). It
just allows some people to build smaller kernels, but apparently
distro people would rather have debugging than save a few kB of RAM."

Losing control of ref_count is an unrecoverable problem because it
leads to security sensitive memory corruptions. It is better to crash
the kernel when that happens instead of ending up with some pages
mapped into the wrong address space.

The races are tricky to spot, but set_page_count() is inherently
dangerous, so I am removing it entirely and replacing it with safer
operations which do the same thing.

One example is this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=7118fc29

> >>>> I understand where this patchset is going, but this intermediate step is
> >>>> not a good move.
> >>>>
> >>>> Also, for the overall series, if you want to change from
> >>>> "set_page_count()" to "inc_and_verify_val_equals_one()", then the way to
> >>>> do that is *not* to depend solely on VM_BUG*() to verify. Instead,
> >>>> return something like -EBUSY if incrementing the value results in a
> >>>> surprise, and let the caller decide how to handle it.

In set_page_refcounted() we already have:

VM_BUG_ON_PAGE(page_ref_count(page), page);
set_page_count(page, 1);

I am pointing out that above code is racy:

Between the check VM_BUG_ON_PAGE() check and unconditional set to 1
the value of page->_refcount can change.

I am replacing it with an identical version of code that is not racy.
There is no need to complicate the code by introducing new -EBUSY
returns here, as it would reduce the fragility of this could even
farther.

> >>> Actually, -EBUSY would be OK if the problems were because we failed to

I am not sure -EBUSY would be OK here, it means we had a race which we
were not aware about, and which could have led to memory corruptions.

> >>> modify refcount for some reason, but if we modified refcount and got
> >>> an unexpected value (i.e underflow/overflow) we better report it right
> >>> away instead of waiting for memory corruption to happen.
> >>>
> >>
> >> Having the caller do the BUG() or VM_BUG*() is not a significant delay.

I agree, however, helper functions exist to remove code duplications.
If we must verify the assumption of set_page_refcounted() that non
counted page is turned into a counted page, it is better to do it in
one place than at every call site. We do it today in thus helper
function, I do not see why we would change that.

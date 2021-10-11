Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25BF4285A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhJKD6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhJKD6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:58:24 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11702C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:56:25 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id i7so288211vsm.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hm/WnPjACRBoXScfbY0rQ9zM9UXlZisRQsmhTz6cU6o=;
        b=NoJf0g/i/EvNgprP5JthR3UA1KqGONFpUy/5x+DhivykLN5l0jCd5xucAoiKuGMtlj
         1esRKukL5+qMFwAD3s8JLv4dyBintdVA1qWN/37qCJWo03eXayAUGRhAsOh4QKcJe3IY
         O81MlB9w+DvTDWVe4y7ybit5SIb4vCTFD6BAIWVZswck6kRo7G1QkteU8cSFbiMoF04/
         y2WLC9dqj6ka9lkxiQ68OIOV/ArRx/D+L8SJbsrA0WEJrE51vYOlGGHwC5Rv6wobQ6Jp
         JjJkRvYhXs5sEsoSwA6nV+dPv+svBSAkBM50kfZqC0eTkz1OSN58aVJjAuOk2Rohkhoj
         cQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hm/WnPjACRBoXScfbY0rQ9zM9UXlZisRQsmhTz6cU6o=;
        b=hrWARTj2A/QcSGGGNffs9ZZKmRbkl2kgjGQ9c+rWzE30H7wU/+Xd6lpsvgNUWgBrnI
         ASP1gyllZUn+xKJdaV+LYiCsQIfER8t0ERUnmm7PJTku7ZOZ6FpAF/j6d6Uh6I65PzUe
         ByecJHnWXtndVGdJX3hcAg/bAvHg7xhkfufewuBA8dSOjS+RGblLkWj7leCBWK1gQBkz
         XGaaF86P7QfOsCr+L4Ew+kc+nyjq6WPgl9x1Sx9y0QAX+55XAjGeGVdaH7GQiqbkzpx3
         XocOOJt5CxzXKPzyK+HJL2U+dGJyq8OttpGKzyl5KD0ccPLuImF0cQ+efenUTAuLAp6J
         DN+w==
X-Gm-Message-State: AOAM532jvd1C9BUQAmcB8BccL1jOH5l/MyciOFpOXQQII6vv5AYTMMnp
        vVrOnPYzBRe+KbGHblYKNBHv6sjysf2nWdS7C8s=
X-Google-Smtp-Source: ABdhPJwnwkAkJ1q/wmyPmrl6FYjETg+oftnturOvq1SlZkbfBqz+4zN1f0ODqYkUFzRtNZHipE0d3p+CxoXOFaRJkPo=
X-Received: by 2002:a67:dc0c:: with SMTP id x12mr1008048vsj.17.1633924583922;
 Sun, 10 Oct 2021 20:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aLPxJCiVTqqwiz00oMNiqHggB84sXB3x=tv_HUAd5UktQ@mail.gmail.com>
 <20211008095123.73b4bubwrpdj6tuz@box.shutemov.name> <CAPm50a+E6mm_qA9h9MSvh4K+WA8Qf6mU=2yig5GyVw9GFJzr8g@mail.gmail.com>
 <aece8474-4881-4c9-362-a7cb211e5933@google.com>
In-Reply-To: <aece8474-4881-4c9-362-a7cb211e5933@google.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Mon, 11 Oct 2021 11:55:52 +0800
Message-ID: <CAPm50aL6vD-nP9Nh8dTLubpTUkRKveXon4izjHG-_aE3L=AD1A@mail.gmail.com>
Subject: Re: [PATCH v2] mm/huge_memory.c: disable THP with large THP size on
 small present memory
To:     David Rientjes <rientjes@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 6:43 AM David Rientjes <rientjes@google.com> wrote:
>
> On Sat, 9 Oct 2021, Hao Peng wrote:
>
> > > > After setting the page size to 64k on ARM64, the supported huge page
> > > > size is 512M and 1TB. Therefore, if the thp is enabled, the size
> > > > of the thp is 512M. But if THP is enabled, min_free_kbytes will
> > > > be recalculated. At this time, min_free_kbytes is calculated based
> > > > on the size of THP.
> > > >
> > > > On an arm64 server with 64G memory, the page size is 64k, with thp
> > > > enabled.
> > > > cat /proc/sys/vm/min_free_kbytes
> > > > 3335104
> > > >
> > > > Therefore, when judging whether to enable THP by default, consider
> > > > the size of thp.
> > > >
> > > > V2: title suggested by David Hildenbrand
> > > >
> > > > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > > > ---
> > > >  mm/huge_memory.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index 5e9ef0fc261e..03c7f571b3ae 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -437,7 +437,7 @@ static int __init hugepage_init(void)
> > > >          * where the extra memory used could hurt more than TLB overhead
> > > >          * is likely to save.  The admin can still enable it through /sys.
> > > >          */
> > > > -       if (totalram_pages() < (512 << (20 - PAGE_SHIFT))) {
> > > > +       if (totalram_pages() < (512 << (HPAGE_PMD_SHIFT - PAGE_SHIFT))) {
> > >
> > > On x86-64 HPAGE_PMD_SHIFT is 21, so you double the amount of memory
> > > required to enabled THP by default. It doesn't seem to be the intent of
> > > the patch.
> > >
> > > What about something like
> > >
> > >         if (totalram_pages() < 256 * HPAGE_PMD_NR)
> > >
> > > ?
> > >
> > I think that setting the threshold to 512M here is also a rough
> > estimate. If it is 512M
> > of memory and 2M of THP is used, there are only 256 pages in total.
> > This is actually
> > too small.
>
> So does this mean that the original intent of the patch is what you
> proposed?  It's not discussed in the changelog so it's unclear.
>
I have considered this point, but I think the initial threshold is only a
rough estimate. And THP can be enabled at runtime, so this threshold
does not need to be accurate.
> The "extra memory used could hurt more..." statement in the comment
> depends on other system-wide settings like max_ptes_none and whether you
> default to faulting hugepages if eligible.  There are scenarios where
> there is no extra memory used, so I think the intent is for sane default
> behavior and, as you mention, it can always be enabled at runtime as well.
>
> By using 64KB native page sizes on small memory capacity systems, you're
> already opting into this memory bloat.
>
If it is on an arm64 machine with a small memory system, such as a mobile phone,
it generally uses 4KB native page size, so the page size of THP is 2MB.
> If we are trying to avoid memory bloat then we likely shouldn't be
> defaulting max_ptes_none to 511 either and that would be a bigger
> consideration than a minimum memory capacity to enable thp.
>
> Or maybe you are questioning the adjustment to min_free_kbytes and whether
> that is rational or not for small machine sizes (but large page sizes).
>
The main reason for my modification is that excessively large THP page
size may make
min_free_kbytes too large when enabled, especially on systems without
swap that easily
trigger OOM.
> > In addition, THP is disabled by default, but you can also enable THP
> > dynamically.
> > Thanks.
>

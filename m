Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6594419486
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhI0MrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhI0MrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:47:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2423FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:45:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i25so77385872lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6AC5eSoepb2bNyO+Jia6IE49hxeFqqw1JuenYNorqo4=;
        b=vXniwCEdXDi2T3uDIXy9oa0b+6aeI50sj6hLwIQuxpGCZ7uGCzvfHiqO5cH+Puuqsi
         VYQd+KbHgmF2V9P4r+5L1DQQi3craYId+eZW+Bd8hRyKRC8jFI6p1VM48YSZB4y2r6UE
         DnEpS8+eGR3QUBmFIS5wMQnttd34NOGooB2UsUXpin7LlGWXKe914n0N9cFpesbG22Cf
         ufNV3MBCD2WWb03RFb/935AS0OXHtgt8+ftwL1cQ4J80QoGKlnl2pAhMt6KDMH/cKK4e
         +lvcvyd05sLmAZQv4besER/2f8A74izsJpPCdTj6AagxbuKLi1aB9XtI/jAr5g3S6/v4
         C+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6AC5eSoepb2bNyO+Jia6IE49hxeFqqw1JuenYNorqo4=;
        b=uJy745uhXhubDsU8bqw3y3gP7f6fygbAa3BXvESIhL1ZPgFDYurlcZSysuKX6SrfWz
         SpBnG1bwx6GPKNbp8RRSVNCoXDT3+Oiu4rNbuySQPO4a6UeSkR4dB3zbELLSSNpGX4zs
         J5v4pI0FmZ6v/XktA8vGkLTd4sS3n8+dIL3o4C1Q8kTHNg3Iygsp1rTdcq0GrTgTca79
         6T9oHMqfadT56w/ZyTQHQdAt/WJSjseRPuV8Hapm9tLvAwwjlbAWfp4TuAvOBaGQVA9s
         nu11LBEcAiAjcGYo61aQ/U7zo5vJ29qCkGnDYq+F8kU8Mh1kWOudfqiyAzKfFllwQd/l
         hKgA==
X-Gm-Message-State: AOAM530pyLF8N3GfxAqaN6HKR1PiF21antiUoY7sdqLyxjkVYoYrOBOS
        YSdUzdAzNeTT2jV4mTAL5J5qNw==
X-Google-Smtp-Source: ABdhPJw9SyzSSubOBfwLsvSDXlJtTzZUfkcyEOR9rF8BfRzzh4S+j3fEJINDTCHQEBUy8+e5X1jtKA==
X-Received: by 2002:a05:6512:22c1:: with SMTP id g1mr25454128lfu.169.1632746720060;
        Mon, 27 Sep 2021 05:45:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j24sm1587249lfh.302.2021.09.27.05.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:45:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id EE2B4102FD9; Mon, 27 Sep 2021 15:45:18 +0300 (+03)
Date:   Mon, 27 Sep 2021 15:45:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/8] mm/madvise: propagate vma->vm_end changes
Message-ID: <20210927124518.gjas4itro5c3park@box.shutemov.name>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-2-namit@vmware.com>
 <20210927090852.sc5u65ufwvfx57rl@box.shutemov.name>
 <A923D77C-8C45-41B0-A1B2-55F68168D058@gmail.com>
 <20210927115507.6xfpugeg3swookbh@box>
 <4211F6D4-A282-4AB4-8D96-E273C5ABE0DF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4211F6D4-A282-4AB4-8D96-E273C5ABE0DF@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 05:33:39AM -0700, Nadav Amit wrote:
> 
> 
> > On Sep 27, 2021, at 4:55 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Mon, Sep 27, 2021 at 03:11:20AM -0700, Nadav Amit wrote:
> >> 
> >>> On Sep 27, 2021, at 2:08 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >>> 
> >>> On Sun, Sep 26, 2021 at 09:12:52AM -0700, Nadav Amit wrote:
> >>>> From: Nadav Amit <namit@vmware.com>
> >>>> 
> >>>> The comment in madvise_dontneed_free() says that vma splits that occur
> >>>> while the mmap-lock is dropped, during userfaultfd_remove(), should be
> >>>> handled correctly, but nothing in the code indicates that it is so: prev
> >>>> is invalidated, and do_madvise() will therefore continue to update VMAs
> >>>> from the "obsolete" end (i.e., the one before the split).
> >>>> 
> >>>> Propagate the changes to end from madvise_dontneed_free() back to
> >>>> do_madvise() and continue the updates from the new end accordingly.
> >>> 
> >>> Could you describe in details a race that would lead to wrong behaviour?
> >> 
> >> Thanks for the quick response.
> >> 
> >> For instance, madvise(MADV_DONTNEED) can race with mprotect() and cause
> >> the VMA to split.
> >> 
> >> Something like:
> >> 
> >>  CPU0				CPU1
> >>  ----				----
> >>  madvise(0x10000, 0x2000, MADV_DONTNEED)
> >>  -> userfaultfd_remove()
> >>   [ mmap-lock dropped ]
> >> 				mprotect(0x11000, 0x1000, PROT_READ)
> >> 				[splitting the VMA]
> >> 
> >> 				read(uffd)
> >> 				[unblocking userfaultfd_remove()]
> >> 
> >>   [ resuming ]
> >>   end = vma->vm_end
> >>   [end == 0x11000]
> >> 
> >>   madvise_dontneed_single_vma(vma, 0x10000, 0x11000)
> >> 
> >>  Following this operation, 0x11000-0x12000 would not be zapped.
> > 
> > Okay, fair enough.
> > 
> > Wouldn't something like this work too:
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 0734db8d53a7..0898120c5c04 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -796,6 +796,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > 			 */
> > 			return -ENOMEM;
> > 		}
> > +		*prev = vma;
> > 		if (!can_madv_lru_vma(vma))
> > 			return -EINVAL;
> > 		if (end > vma->vm_end) {
> 
> Admittedly (embarrassingly?) I didn’t even consider it since all the
> comments say that once the lock is dropped prev should be invalidated.
> 
> Let’s see, considering the aforementioned scenario and that there is
> initially one VMA between 0x10000-0x12000.
> 
> Looking at the code from do_madvise()):
> 
> [ end == 0x12000 ]
> 
>                 tmp = vma->vm_end;
> 
> [ tmp == 0x12000 ]
> 
>                 if (end < tmp)
>                         tmp = end;
> 
>                 /* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
> 
>                 error = madvise_vma(vma, &prev, start, tmp, behavior);
> 
> [ prev->vm_end == 0x11000 after the split]
> 
>                 if (error)
>                         goto out;
>                 start = tmp;
> 
> [ start == 0x12000 ]
> 
>                 if (prev && start < prev->vm_end)
>                         start = prev->vm_end;
> 
> [ The condition (start < prev->vm_end) is false, start not updated ]
> 
>                 error = unmapped_error;
>                 if (start >= end)
>                         goto out;
> 
> [ start >= end; so we end without updating the second part of the split ]
> 
> So it does not work.
> 
> Perhaps adding this one on top of yours? I can test it when I wake up.
> It is cleaner, but I am not sure if I am missing something.

It should work.

BTW, shouldn't we bring madvise_willneed() and madvise_remove() to the
same scheme?

-- 
 Kirill A. Shutemov

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AAC39EF05
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFHG4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:56:22 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46768 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHG4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:56:20 -0400
Received: by mail-ot1-f48.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso19291932otl.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=wI8/E9Ndy/3LMDe9hwhGdl+KBmAOuXY4O1VsWixwA0M=;
        b=tDEj3Ou0++IfS/cUyGFXbgxlgM6SWPRG/Uaqf6Pw2TUU4XnBoZEOKl/TVW9nB2G9hP
         erb8FUncst1gmY1A8sTFsFt8tMQ2EVuCWHFNj/zALw449SbxZNjPeqxCAgxApHvV5j4D
         KImPaZpnpvj0rqppVkCz6f39vW35IceI3GRW16MSlNxS3daL6NPS62pwNE0nDvVJOqrd
         JDHMEtlMR6WPrRRK0XiwBo3pGEyAgxT6KFWRRYwaiLKgvXf6IpjUsZekQNUNc8JxnFEd
         HvC924vuPpExQLjC5JEiofAr6ITLpMmhabHtaqlc3gkYM21FWB0tI+ytYSP5rlh+0kb3
         EALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=wI8/E9Ndy/3LMDe9hwhGdl+KBmAOuXY4O1VsWixwA0M=;
        b=kA3dlQJ/YlkIiTu8mtzc1s0BrmjratmP/+3Ge8cGd7h2ZPSG6nSvqwE7w5o95u/fOq
         RqAo5eoZkct9FClklkY33RFHN7pnOeAIOaHI9pQXYGDBjcLu0nHSahUwwTo8j5tO7Okn
         Lu9yDj1WmMpPZZmkRbxzE4RNEl/aisYAk9K4X888Tc5f5yDWVig1J5ztLsHFMQ19Ahxl
         fP19io6PJVd7iY4ItDHuVZOQyMrLPYQcWYB6AFSAIbZ4P6DBpYCMKKQ2BFiYqCZsA8aB
         V4fYMW1OojLylmjtNu4WRe2a3voE4k/DJLDWPle3+4FiItcL5v33F+NhbMi3wwlLnCDp
         ZU8Q==
X-Gm-Message-State: AOAM532owE7J+3QcAVy6NS0Swwwx0IOdtvRTOffSpnpkd/TFMUI94iEh
        fiVHeNFOKiuXQ72lB8szAeiWfA==
X-Google-Smtp-Source: ABdhPJwxDGnjMYIONraimWoGS2kJXtSP1FkAsbGWvBICnURsZ6NkUMXpGelCDMv5I0LX/OwMAI6dJg==
X-Received: by 2002:a9d:a09:: with SMTP id 9mr7752708otg.126.1623135207688;
        Mon, 07 Jun 2021 23:53:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l29sm152167ots.4.2021.06.07.23.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 23:53:27 -0700 (PDT)
Date:   Mon, 7 Jun 2021 23:53:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yu Xu <xuyu@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        gavin.dg@linux.alibaba.com, Greg Thelen <gthelen@google.com>,
        Wei Xu <weixugc@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
In-Reply-To: <49d5601c-6ea5-5973-bcbe-bee0c1d4f7de@linux.alibaba.com>
Message-ID: <a547b066-6960-4411-1f3d-2bc3f15b6a73@google.com>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com> <alpine.LSU.2.11.2106010947370.1090@eggly.anvils> <b05ab98d-3a0d-ec23-96dd-5c970aa61580@linux.alibaba.com> <alpine.LSU.2.11.2106020831590.6388@eggly.anvils>
 <6c4e0df7-1f06-585f-d113-f38db6c819b5@linux.alibaba.com> <b9db2528-e3fa-da5a-ba30-4fc5d217957a@google.com> <49d5601c-6ea5-5973-bcbe-bee0c1d4f7de@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021, Yu Xu wrote:
> On 6/8/21 12:44 PM, Hugh Dickins wrote:
> > On Mon, 7 Jun 2021, Yu Xu wrote:
> >> On 6/2/21 11:57 PM, Hugh Dickins wrote:
> >>> On Wed, 2 Jun 2021, Yu Xu wrote:
> >>>> On 6/2/21 12:55 AM, Hugh Dickins wrote:
> >>>>> On Wed, 2 Jun 2021, Xu Yu wrote:
> >>>>>
> >>>>>> We notice that hung task happens in a conner but practical scenario
> >>>>>> when
> >>>>>> CONFIG_PREEMPT_NONE is enabled, as follows.
> >>>>>>
> >>>>>> Process 0                       Process 1                     Process
> >>>>>> 2..Inf
> >>>>>> split_huge_page_to_list
> >>>>>>        unmap_page
> >>>>>>            split_huge_pmd_address
> >>>>>>                                    __migration_entry_wait(head)
> >>>>>>                                                                  __migration_entry_wait(tail)
> >>>>>>        remap_page (roll back)
> >>>>>>            remove_migration_ptes
> >>>>>>                rmap_walk_anon
> >>>>>>                    cond_resched
> >>>>>>
> >>>>>> Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
> >>>>>> copy_to_user, which will immediately fault again without rescheduling,
> >>>>>> and thus occupy the cpu fully.
> >>>>>>
> >>>>>> When there are too many processes performing __migration_entry_wait on
> >>>>>> tail page, remap_page will never be done after cond_resched.
> >>>>>>
> >>>>>> This relaxes __migration_entry_wait on tail page, thus gives remap_page
> >>>>>> a chance to complete.
> >>>>>>
> >>>>>> Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
> >>>>>> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> >>>>>
> >>>>> Well caught: you're absolutely right that there's a bug there.
> >>>>> But isn't cond_resched() just papering over the real bug, and
> >>>>> what it should do is a "page = compound_head(page);" before the
> >>>>> get_page_unless_zero()? How does that work out in your testing?
> >>>>
> >>>> compound_head works. The patched kernel is alive for hours under
> >>>> our reproducer, which usually makes the vanilla kernel hung after
> >>>> tens of minutes at most.
> >>>
> >>> Oh, that's good news, thanks.
> >>>
> >>> (It's still likely that a well-placed cond_resched() somewhere in
> >>> mm/gup.c would also be a good idea, but none of us have yet got
> >>> around to identifying where.)
> >>
> >> We neither. If really have to do it outside of __migration_entry_wait,
> >> return value of __migration_entry_wait is needed, and many related
> >> functions have to updated, which may be undesirable.
> > 
> > No, it would not be necessary to plumb through a return value from
> > __migration_entry_wait(): I didn't mean that this GUP cond_resched()
> > should be done only for the migration case, but (I guess) on any path
> > where handle_mm_fault() returns "success" for a retry, yet the retry
> > of follow_page_mask() fails.
> > 
> > But now that I look, I see there is already a cond_resched() there!
> 
> Do you mean might_sleep in mmap_read_trylock within do_user_addr_fault?
> 
> If so, our environment has CONFIG_PREEMPT_NONE is enabled, and the
> __migration_entry_wait happens in kernel when do something like
> copy_to_user (e.g., fstat).

Oh, I am sorry: now I see that you did mention copy_to_user() in your
original post, but I'm afraid I was fixated on get_user_pages() all
along: a different way in which the kernel handles a fault on user
address space without returning to userspace immediately afterwards.

So, the GUP case has its cond_resched() and is okay, but the
arch/whatever/mm/fault.c case is the one which probably deserves a
cond_resched() somewhere (on the architecture in question anyway - x86?).

I was reluctant to suggest where to place it in GUP, I am even more
reluctant to say where in arch/whatever/mm/fault.c: I haven't thought
through that code in years.  x86, somewhere in do_user_addr_fault(),
probably yes; but it's better to cond_resched() without holding a
lock; and better to avoid it on first entry too.

But we don't need to decide that, if the compound_head() is a
satisfactory solution for you in practice.  Sorry for confusing
you with my own confusion, and thank you for clearing it up.

Hugh

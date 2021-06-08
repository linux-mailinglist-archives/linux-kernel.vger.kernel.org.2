Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2139EDCA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 06:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFHEqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 00:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhFHEqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 00:46:36 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D39C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 21:44:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id h9so20381042oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 21:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=eI9WpruPyWKw92wMSqJrQVTncfzMx2r6y0zhdbuc8fM=;
        b=wG9ALyp9OyK2vkueE1eCucRSMpL5av0MBbtxOmf7q8HMBwTl7+XVTS/gd88J62d4qG
         nTtldCmdkQ4GliLKr4V/rB20niT8kjnwDsxSfAXnsQDappXin/48tK5xw4a0uZE6A8Ss
         70CNraCJ3Fz3BW58wsFz17f6sSFyVlTeH9AOH8ZRJ+4v2x+G3AuXWld802RqRO43PnWu
         9Xs7p46iIEEyHGJ+RZWM44V6q35hF+HH6LZyj1UXsGnDyHI5R/75aWaurs8AWEFhzgk/
         sz4bIqtZeIK27xEO+tODzM3FcSK7FvC01s2zC1wllKmBYy4v/+ENkua/D6fmtECq7wOz
         1Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=eI9WpruPyWKw92wMSqJrQVTncfzMx2r6y0zhdbuc8fM=;
        b=lwQYHANDWfOLnAe1/6CY97NRTO+6Vq3PsfQiP9EPInFrRUMcOYiCno0WdQ5N1kJZeC
         ax8Jun1LQ0gKVnuB0Zn5HXaow4jbU+37c3ebsA+gwkhnOlSklmZWxf7iFJDZqQvLgMF0
         bZgjvWCO9sYHuY2g4eSNVWYp9vYwc/RZRdioke2zY9c7QXPrsGqoNyJN+P8v+rBdD1IK
         RMpRUPmL3zyvpegbkOUFUb7SSY06tB8na8L5nXsCUbb2UbNABm4XYCf64+RPNRj0JlbD
         w8Sb4PIzSrleJGNHxfsFfoUpOEQvDoZ1HR377g7Rhsikd/a7UKgikD4szwlGabHunpyx
         CVVg==
X-Gm-Message-State: AOAM530FsJMwiOtK8fCH5oZTuwUG0Xi8kU88kn9GXyD+5yuSBcEwFvpn
        sDrSBClc6aa026OmgtcsiUONPw==
X-Google-Smtp-Source: ABdhPJy0Rc/+Em+nHY2t5BDwqzkC/D+6qN8fJi8d11KkB2i5pAU2+YQa//2MIkNJ4SqgjJ/JDFsKXA==
X-Received: by 2002:a54:4195:: with SMTP id 21mr1625589oiy.131.1623127470866;
        Mon, 07 Jun 2021 21:44:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v22sm2655004oic.37.2021.06.07.21.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:44:30 -0700 (PDT)
Date:   Mon, 7 Jun 2021 21:44:12 -0700 (PDT)
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
In-Reply-To: <6c4e0df7-1f06-585f-d113-f38db6c819b5@linux.alibaba.com>
Message-ID: <b9db2528-e3fa-da5a-ba30-4fc5d217957a@google.com>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com> <alpine.LSU.2.11.2106010947370.1090@eggly.anvils> <b05ab98d-3a0d-ec23-96dd-5c970aa61580@linux.alibaba.com> <alpine.LSU.2.11.2106020831590.6388@eggly.anvils>
 <6c4e0df7-1f06-585f-d113-f38db6c819b5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021, Yu Xu wrote:
> On 6/2/21 11:57 PM, Hugh Dickins wrote:
> > On Wed, 2 Jun 2021, Yu Xu wrote:
> >> On 6/2/21 12:55 AM, Hugh Dickins wrote:
> >>> On Wed, 2 Jun 2021, Xu Yu wrote:
> >>>
> >>>> We notice that hung task happens in a conner but practical scenario when
> >>>> CONFIG_PREEMPT_NONE is enabled, as follows.
> >>>>
> >>>> Process 0                       Process 1                     Process
> >>>> 2..Inf
> >>>> split_huge_page_to_list
> >>>>       unmap_page
> >>>>           split_huge_pmd_address
> >>>>                                   __migration_entry_wait(head)
> >>>>                                                                 __migration_entry_wait(tail)
> >>>>       remap_page (roll back)
> >>>>           remove_migration_ptes
> >>>>               rmap_walk_anon
> >>>>                   cond_resched
> >>>>
> >>>> Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
> >>>> copy_to_user, which will immediately fault again without rescheduling,
> >>>> and thus occupy the cpu fully.
> >>>>
> >>>> When there are too many processes performing __migration_entry_wait on
> >>>> tail page, remap_page will never be done after cond_resched.
> >>>>
> >>>> This relaxes __migration_entry_wait on tail page, thus gives remap_page
> >>>> a chance to complete.
> >>>>
> >>>> Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
> >>>> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> >>>
> >>> Well caught: you're absolutely right that there's a bug there.
> >>> But isn't cond_resched() just papering over the real bug, and
> >>> what it should do is a "page = compound_head(page);" before the
> >>> get_page_unless_zero()? How does that work out in your testing?
> >>
> >> compound_head works. The patched kernel is alive for hours under
> >> our reproducer, which usually makes the vanilla kernel hung after
> >> tens of minutes at most.
> > 
> > Oh, that's good news, thanks.
> > 
> > (It's still likely that a well-placed cond_resched() somewhere in
> > mm/gup.c would also be a good idea, but none of us have yet got
> > around to identifying where.)
> 
> We neither. If really have to do it outside of __migration_entry_wait,
> return value of __migration_entry_wait is needed, and many related
> functions have to updated, which may be undesirable.

No, it would not be necessary to plumb through a return value from
__migration_entry_wait(): I didn't mean that this GUP cond_resched()
should be done only for the migration case, but (I guess) on any path
where handle_mm_fault() returns "success" for a retry, yet the retry
of follow_page_mask() fails.

But now that I look, I see there is already a cond_resched() there!

So I'm puzzled as to how your cond_resched() in __migration_entry_wait()
appeared to help - well, you never actually said that it helped, but I
assume that it did, or you wouldn't have bothered to send that patch?

It's irrelevant, now that we've admitted there should be a
"page = compound_head(page)" in there, and you have said that helps,
and that's the patch we want to send now.  But it troubles me, to be
unable to explain it.  Two cond_resched()s are not twice as good as one.

> 
> > 
> >>
> >> If we use compound_head, the behavior of __migration_entry_wait(tail)
> >> changes from "retry fault" to "prevent THP from being split". Is that
> >> right?  Then which is preferred? If it were me, I would prefer "retry
> >> fault".
> > 
> > As Matthew remarked, you are asking very good questions, and split
> > migration entries are difficult to think about.  But I believe you'll
> > find it works out okay.
> > 
> > The point of *put_and_* wait_on_page_locked() is that it does drop
> > the page reference you acquired with get_page_unless_zero, as soon
> > as the page is on the wait queue, before actually waiting.
> > 
> > So splitting the THP is only prevented for a brief interval.  Now,
> > it's true that if there are very many tasks faulting on portions
> > of the huge page, in that interval between inserting the migration
> > entries and freezing the huge page's refcount to 0, they can reduce
> > the chance of splitting considerably.  But that's not an excuse for
> > for doing get_page_unless_zero() on the wrong thing, as it was doing.
> 
> We finally come to your solution, i.e., compound_head.
> 
> In that case, who should resend the compound_head patch to this issue?
> shall we do with your s.o.b?

I was rather expecting you to send the patch: with your s.o.b, not mine.
You could say "Suggested-by: Hugh Dickins <hughd@google.com>" if you like.

And I suggest that you put that "page = compound_head(page);" line
immediately after the "page = migration_entry_to_page(entry);" line,
so as not to interfere with the comment above get_page_unless_zero().

(No need for a comment on the compound_head(): it's self-explanatory.)

I did meanwhile research other callers of migration_entry_to_page():
it had been on my mind, that others might need a compound_head() too,
and perhaps it should be done inside migration_entry_to_page() itself.

But so far as I can tell (I don't really know about the s390 one),
the others are okay, and it would just be unnecessary overhead
(in particular, the mm_counter() stuff looks correct on a tail).

I *think* the right Fixes tag would be
Fixes: ba98828088ad ("thp: add option to setup migration entries during PMD split")
though I'm not sure of that; it's probably good enough.

(With all this direction, I did wonder if it would be kinder just to
send a patch myself, but using some of your comments: but I didn't
understand "conner" in your description, so couldn't do that.)

Thanks!
Hugh

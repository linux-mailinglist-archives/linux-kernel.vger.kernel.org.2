Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B23E854A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhHJVay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbhHJVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:30:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3110CC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:30:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k9so155944edr.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nbn6ZPqkgK9dtSMellsW60riYifwyh558pvvalRPKrw=;
        b=JPzruZzkNY8TxWgqhBBMdQvjW6YoxvvAopnMkvh2hTrFAg+C85ttcWO9Psot5KPfDE
         lh/2T/yr9Ki8TeU9rryUe9xIvoMcGErbBLGE+Fa4opsCNssoRLx8/c3cSN4tTV1RPzrZ
         6CVh8LyVnqz2OB53ssIOlsy0XYgveFJtVQgKFbsKTpkLW5ghlkU4Vor0oOtYQv0CaGbR
         sQEx9DysS9bpr5pxYHKUt9RQsgmOSVjBv4n6hl7rknlnY9uILeqjCdXvML+2TqklszXG
         qM+fvjkyAIO2WI7sOOcWkXG7/hGmGE1FovyF26P8Yk2urRlrOxMw2MuBHOQwKr/IMle+
         6HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nbn6ZPqkgK9dtSMellsW60riYifwyh558pvvalRPKrw=;
        b=QRXFp+o4d9sMkL9xTN3CodA8gj3UNgqM3o13s2CRLmtigLBs4+sJLfXe6qC1v+15Ml
         WvHVponmqU64Gz7ZASEEu7Yu272+Yr4w0ESWYyfaDYdju1CLgrt8MLAELd3vnW331Ynr
         vnHxiegafIVLtU8MVQ5a6UVNn1YR6VgOgHlNn6Nr32gjYHbe9NXa2a2lQzhCr8F/evjM
         DkThpASFykGGw8/c6bQr2RafGq3anwUNDHTiiB6f/b9cdioVvVFLyqDQnLT11fh+jFVT
         L05lvkREICXOLw8mp5hPvK8CtvzEg9ecjK7oG/m5t3KmSHqQUjXB3BI9htYeKELC+ZQw
         AsKw==
X-Gm-Message-State: AOAM5305elI//8gMZmTtAQ+SojfIGnGX8s4THy+/5OoDytURxu3vI9rn
        V7WmxaJcf5b3HajoOKt8xN6WYbHuVm1bBHn9eSI=
X-Google-Smtp-Source: ABdhPJy0Ly2Iny4PXe05m/prt89I1rf1FFGsHUuJxqu7RWbqp3XhREpyXk4ZcOVGXg2OkHxu3fCZawqTce83sSMl9Go=
X-Received: by 2002:a50:cdcb:: with SMTP id h11mr7363084edj.366.1628631028846;
 Tue, 10 Aug 2021 14:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210810202936.2672-1-shy828301@gmail.com> <20210810202936.2672-3-shy828301@gmail.com>
 <3983c910-a02b-e67b-8c2b-7a379c3d22e1@google.com>
In-Reply-To: <3983c910-a02b-e67b-8c2b-7a379c3d22e1@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 10 Aug 2021 14:30:17 -0700
Message-ID: <CAHbLzkqifgqAgytL_XGa=fE3tH-oU9x=uv-yNCYGzeO3QEGvFQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Revert "mm: swap: check if swap backing device is
 congested or not"
To:     Hugh Dickins <hughd@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 2:08 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 10 Aug 2021, Yang Shi wrote:
>
> > Due to the change about how block layer detects congestion the
> > justification of commit 8fd2e0b505d1 ("mm: swap: check if swap backing device
> > is congested or not") doesn't stand anymore, so the commit could be just
> > reverted in order to solve the race reported by commit 2efa33fc7f6e ("mm/shmem:
> > fix shmem_swapin() race with swapoff"). The fix was reverted by the
> > previous patch.
> >
> > Suggested-by: Hugh Dickins <hughd@google.com>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Miaohe Lin <linmiaohe@huawei.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Thanks for doing these,
> Acked-by: Hugh Dickins <hughd@google.com>
> to all three.
>
> I guess 1/3 will vanish now, since what it's reverting has not yet gone
> forward to Linus: it would have been nice for 2/3 to have mentioned that
> what it's reverting is kindof buggy: but then you'd have to explain the
> "kindof", and that takes more words than it's worth - maybe a lore Link
> to the discussion?

It is fine, I think this one is the best elaborated the problem:
https://lore.kernel.org/linux-mm/24187e5e-069-9f3f-cefe-39ac70783753@google.com/

>
> But you've done the work that I've not yet got around to:
> so thank you, and ignore my gripes.
>
> Hugh
>
> > ---
> >  mm/swap_state.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 1a29b4f98208..8d4104242100 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -628,13 +628,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
> >       if (!mask)
> >               goto skip;
> >
> > -     /* Test swap type to make sure the dereference is safe */
> > -     if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
> > -             struct inode *inode = si->swap_file->f_mapping->host;
> > -             if (inode_read_congested(inode))
> > -                     goto skip;
> > -     }
> > -
> >       do_poll = false;
> >       /* Read a page_cluster sized and aligned cluster around offset. */
> >       start_offset = offset & ~mask;
> > --
> > 2.26.2

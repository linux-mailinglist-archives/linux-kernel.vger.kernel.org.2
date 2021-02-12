Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E423199B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 06:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBLFZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 00:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhBLFZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 00:25:44 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE7C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 21:25:03 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id y35so2540446uad.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 21:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlvvpgbDtq3EsrCKWzaUcRyoxMuevQ6txCvKm+vROLc=;
        b=AuMDMMyMn/V587tbyjs4gw+8SJ59d2odZVH9gZ+mEk5fUR6H7be5oK6S1f/PFAknaw
         C853DiqBcqTzfdXKGNs3yrzBgBqnQZghVfe6XcKYIPxpIF455l5aafXwLthA5GeFmJxM
         hzU7AEjYsp10a1rkKXfva4RQX0ubVWIwiNe5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlvvpgbDtq3EsrCKWzaUcRyoxMuevQ6txCvKm+vROLc=;
        b=gkRso8BhIoB7dHijoWb1Xxw2ShxQABD+7pq/wYnwV3NAxjqRFUpDoiPmXgttcCJc10
         wUp0i7hbhbBCLGn9jch5r9+mhiQaX4ugHtB5vKiPs8HCPJnRqIqjLP859O8E6S3T0ZCi
         ZV/7MrbntAOJ8lyswk13LPuF+soeXp4z4kCq9qyCGkQpduvIXCFZeD0dhjkrwHltQW30
         my+6CQGkJERC+QaVD0SAA7zrZ+IhSR9tNeoOZxfateAcpZlKJ3lD5qtmaRjBK9DAitDg
         2FwXG5uHQwFSGhYZkPskEeqRosryE4Nw7KJzMFcD8Gb6RqqzmSU+LfODDdsfH3L1qMTc
         LX8w==
X-Gm-Message-State: AOAM532I3cwviJ9lDL/fjjkRXpWiRQgICp/NgsmGF1w57DyKfDljVvpD
        2F4ICiQCwK3lx12+Sfl0AKKVYFL0k0NWRpcSBdX/fQ==
X-Google-Smtp-Source: ABdhPJypHzv3OxmLMfoo/8bMqpHy3COfXu1try8ZXxeSFbqOvykSf11czKsKEnpjhy+bzA3Mia1hNZw8Jj+Y+MJahp8=
X-Received: by 2002:ab0:20d:: with SMTP id 13mr737385uas.27.1613107502890;
 Thu, 11 Feb 2021 21:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.6.Idc9c3110d708aa0df9d8fe5a6246524dc8469dae@changeid>
 <20210212045347.GM7190@magnolia> <20210212045902.GG7187@magnolia>
In-Reply-To: <20210212045902.GG7187@magnolia>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 12 Feb 2021 13:24:51 +0800
Message-ID: <CANMq1KDBiPN3mE4vQ=DJc-YirPm_OP9wDfeacuKZHMLhhEYj+w@mail.gmail.com>
Subject: Re: [PATCH 6/6] vfs: Disallow copy_file_range on generated file systems
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:59 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Feb 11, 2021 at 08:53:47PM -0800, Darrick J. Wong wrote:
> > On Fri, Feb 12, 2021 at 12:44:05PM +0800, Nicolas Boichat wrote:
> > > copy_file_range (which calls generic_copy_file_checks) uses the
> > > inode file size to adjust the copy count parameter. This breaks
> > > with special filesystems like procfs/sysfs/debugfs/tracefs, where
> > > the file size appears to be zero, but content is actually returned
> > > when a read operation is performed. Other issues would also
> > > happen on partial writes, as the function would attempt to seek
> > > in the input file.
> > >
> > > Use the newly introduced FS_GENERATED_CONTENT filesystem flag
> > > to return -EOPNOTSUPP: applications can then retry with a more
> > > usual read/write based file copy (the fallback code is usually
> > > already present to handle older kernels).
> > >
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > ---
> > >
> > >  fs/read_write.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > index 0029ff2b0ca8..80322e89fb0a 100644
> > > --- a/fs/read_write.c
> > > +++ b/fs/read_write.c
> > > @@ -1485,6 +1485,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> > >     if (flags != 0)
> > >             return -EINVAL;
> > >
> > > +   if (file_inode(file_in)->i_sb->s_type->fs_flags & FS_GENERATED_CONTENT)
> > > +           return -EOPNOTSUPP;
> >
> > Why not declare a dummy copy_file_range_nop function that returns
> > EOPNOTSUPP and point all of these filesystems at it?
> >
> > (Or, I guess in these days where function pointers are the enemy,
> > create a #define that is a cast of 0x1, and fix do_copy_file_range to
> > return EOPNOTSUPP if it sees that?)

I was pondering abusing ERR_PTR(-EOPNOTSUPP) for this purpose ,-P

>
> Oh, I see, because that doesn't help if the source file is procfs and
> the dest file is (say) xfs, because the generic version will try to do
> splice magic and *poof*.

Yep. I mean, we could still add a check if the
file_in->f_op->copy_file_range == copy_file_range_nop in
do_copy_file_range...
But then we'd need to sprinkle .copy_file_range = copy_file_range_nop
in many many places (~700 as a lower bound[1]), since the file
operation structure is defined at the file level, not at the FS level,
and people are likely to forget...

[1]
$ git grep "struct file_operations.*=" | grep debug | wc -l
631
$ git grep "struct file_operations.*=" | grep trace | wc -l
84

>
> I guess the other nit thatI can think of at this late hour is ... what
> about the other virtual filesystems like configfs and whatnot?  Should
> we have a way to flag them as "this can't be the source of a CFR
> request" as well?
>
> Or is it just trace/debug/proc/sysfs that have these "zero size but
> readable" speshul behaviors?

I did try to audit the other filesystems. The ones I spotted:
 - devpts should be fine (only device nodes in there)
 - I think pstore doesn't need the flag as it's RAM-backed and persistent.

But yes, I missed configfs, thanks for catching that. I think we need
to add the flag for that one (looks like the sizes are all 4K).

>
> --D
>
> >
> > --D
> >
> > > +
> > >     ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
> > >                                    flags);
> > >     if (unlikely(ret))
> > > --
> > > 2.30.0.478.g8a0d178c01-goog
> > >

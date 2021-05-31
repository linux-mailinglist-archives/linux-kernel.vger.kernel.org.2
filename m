Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E402439671E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhEaRd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhEaRdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:33:42 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05BC021990
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 09:30:48 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w15so15661722ljo.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD1cRRRxJ2EzPfJboyLphgi4kVVClR9Hk5LXwRtjq5E=;
        b=gR2e7GWNWXNfbMIlZg3sJ5r6uzjbQprXL315nC/CWrnzpu9R9fj+gWh9tvlJ5F+x+4
         7I+usEyEWCvJPoR2K7gdkYVyfnuxfbdcWEFddqNlZDHTC5lZbZ0o9+kXUV+GllmkLpXp
         RiWVYgthIGZir2tXKR7P815ZOu6sYxpwf6IRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD1cRRRxJ2EzPfJboyLphgi4kVVClR9Hk5LXwRtjq5E=;
        b=AyPTOc+901deVOqGdFcmxlwoVnav93ah/UE5iwaohdXf3WFhP8QGINEhKw0Sz8pDtX
         hRZPIlJv5BcFg+7/R7/S2/nvDjTYzzz7PQijRIVWhU9HCGHyUMJgmQhY0a6xnI4Pea6I
         TndaB4H3FIv2Jiz7Ua5r5PnzmSRVBWP0RdDqbkBOuERlkZVw9WQQSBLisXqNKQUfTdKH
         WEoBB6pcPULVdyDAdd9b58L0Nmk0A0gS+Z5+qxGbOC/7m8hYzZaMw0xCoqhN1HtRM1vS
         K97GZNImZtzr1KNdsCXaAAiEv8UR3paPP0TDW286XcDPRaOEZFFF8LsCOwYy29yBzEuh
         umVg==
X-Gm-Message-State: AOAM533DV36H34aLzJizITlaI2Su5hIZx9V7iZC2oiqyrP828WaszUsl
        skzJPaLNPVt6BnxRoqqeXtnmI27oFDJV6jw4
X-Google-Smtp-Source: ABdhPJw8wScA396Ct3qSUfwDLWkgfBFonsLXyjItbDjbYp8HsW2Br/IRLjq2h7Uyr7KapefeMeFiiw==
X-Received: by 2002:a05:651c:2121:: with SMTP id a33mr16954601ljq.281.1622478646647;
        Mon, 31 May 2021 09:30:46 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 18sm372092lft.211.2021.05.31.09.30.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 09:30:42 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id q1so17607656lfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 09:30:41 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr14981484lfs.377.1622478640992;
 Mon, 31 May 2021 09:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210531105606.228314-1-agruenba@redhat.com>
In-Reply-To: <20210531105606.228314-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 May 2021 06:30:25 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj8EWr_D65i4oRSj2FTbrc6RdNydNNCGxeabRnwtoU=3Q@mail.gmail.com>
Message-ID: <CAHk-=wj8EWr_D65i4oRSj2FTbrc6RdNydNNCGxeabRnwtoU=3Q@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes for v5.13-rc5
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding fsdevel, because this is not limited to gfs2 ]

On Mon, May 31, 2021 at 12:56 AM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> Andreas Gruenbacher (2):
>       gfs2: Fix mmap locking for write faults

This is bogus.

I've pulled it, but this is just wrong.

A write fault on a mmap IS NOT A WRITE to the filesystem.

It's a read.

Yes, it will later then allow writes to the page, but that's entirely
immaterial - because the write is going to happen not at fault time,
but long *after* the fault, and long *after* the filesystem has
installed the page.

The actual write will happen when the kernel returns from the user space.

And no, the explanation in that commit makes no sense either:

   "When a write fault occurs, we need to take the inode glock of the underlying
    inode in exclusive mode.  Otherwise, there's no guarantee that the
dirty page
    will be written back to disk"

the thing is, FAULT_FLAG_WRITE only says that the *currently* pending
access that triggered the fault was a write. That's entirely
irrelevant to a filesystem, because

 (a) it might be a private mapping, and a write to a page will cause a
COW by the VM layer, and it's not actually a filesystem write at all

AND

 (b) if it's a shared mapping, the first access that paged things in
is likely a READ, and the page will be marked writable (because it's a
shared mapping!) and subsequent writes will not cause any faults at
all.

In other words, a filesystem that checks for FAULT_FLAG_WRITE is
_doubly_ wrong. It's absolutely never the right thing to do. It
*cannot* be the right thing to do.

And yes, some other filesystems do this crazy thing too. If your
friends jumped off a bridge, would you jump too?

The xfs and ext3/ext4 cases are wrong too - but at least they spent
five seconds (but no more) thinking about it, and they added the check
for VM_SHARED. So they are only wrong for reason (b)

But wrong is wrong. The new code is not right in gfs2, and the old
code in xfs/ext4 is not right either.

Yeah, yeah, you can - and people do - do things like "always mark the
page readable on initial page fault, use mkwrite to catch when it
becomes writable, and do timestamps carefully, at at least have full
knowledge of "something might become dirty"

But even then it is ENTIRELY BOGUS to do things like write locking.

Really.

Because the actual write HASN'T HAPPENED YET, AND YOU WILL RELEASE THE
LOCK BEFORE IT EVER DOES! So the lock? It does nothing. If you think
it protects anything at all, you're wrong.

So don't do write locking. At an absolute most, you can do things like

 - update file times (and honestly, that's quite questionable -
because again - THE WRITE HASN'T HAPPENED YET - so any tests that
depend on exact file access times to figure out when the last write
was done is not being helped by your extra code, because you're
setting the WRONG time.

 - set some "this inode will have dirty pages" flag just for some
possible future use. But honestly, if this is about consistency etc,
you need to do it not for a fault, but across the whole mmap/munmap.

So some things may be less bogus - but still very very questionable.

But locking? Bogus. Reads and writes aren't really any different from
a timestamp standpoint (if you think you need to mtime for write
accesses, you should do atime for reads, so from a filesystem
timestamp standpoint read and write faults are exactly the same - and
both are bogus, because by definition for a mmap both the reads and
the writes can then happen long long long afterwards, and repeatedly).

And if that "set some flag" thing needs a write lock, but a read
doesn't, you're doing something wrong and odd.

Look at the VM code. The VM code does this right. The mmap_sem is
taken for writing for mmap and for munmap. But a page fault is always
a read lock, even if the access that caused the page fault is a write.

The actual real honest-to-goodness *write* happens much later, and the
only time the filesystem really knows when it is done is at writeback
time. Not at fault time. So if you take locks, logically you should
take them when the fault happens, and release them when the writeback
is done.

Are you doing that? No. So don't do the write lock over the read
portion of the page fault. It is not a sensible operation.

             Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8294037AA11
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhEKPBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231756AbhEKPBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620745215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KQy9BmsInGHBuMYQbKGo4/mFyEJldO4Fzjjuu4/Gw90=;
        b=NTqcCIqLeCrdtUZwi0XNYSABNPRv9XlVXxJXvLHzU44w+UcGk0NmmlyBH+zcRp/XPFR8v/
        7Z8fUR31Xc57+X+cjRj714kF9yYNvZiy/x2hl0p5T4WSIOoCMgyOy477i/uAznclmMDJC4
        pigq1n9ARYSUJYybfLcoND9D5ycjRfs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-PiZNJMVDPeW3vHFUi9NuNg-1; Tue, 11 May 2021 11:00:11 -0400
X-MC-Unique: PiZNJMVDPeW3vHFUi9NuNg-1
Received: by mail-wm1-f69.google.com with SMTP id o10-20020a05600c4fcab029014ae7fdec90so793863wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQy9BmsInGHBuMYQbKGo4/mFyEJldO4Fzjjuu4/Gw90=;
        b=PWAYIwdVakHlwloiPst0asDdc9RqnUHiUyB7D13hPktVSEQK5vRPsgyp1uj753aWaf
         QH7WEVD6+RUCTKG23Qzc6xdltwZEAcU5RiIysyETzI4LHRtp9unrKIskZitvxGXozJgr
         RdNQ6dO00jybOeFSpQMLBu2W+5l2vmAZnUq7V1CdKymSuaqYwL4RjodQEeSbo/I/z9Bo
         xxu2W9aoFtSRzVAZ/lRfZkFeip0lKm5Lt0NNEFExjqk09OfwpCcciJoqmzCZOxX6tKCR
         NdpsNUVzb0NylgWZUvgBGQRumYCBKbwciYCxG6XRRvTKZILsOV+EcrM1kCns8WeRxOaE
         ajMQ==
X-Gm-Message-State: AOAM533gQvs0jj+9Cxe1TXHbm1zad5cmHklQyd6xeFvhhTkuHI+6/t7T
        usvvBPjHelYbUJ/9qX98w8cjnl7kMXXquqz6wzTXhxwCJPbjMJ+RqMMqQMeLqSoWBcux8AUHl2y
        4gL/DttHpJG1garzettWI0tz68xm1GnEZXRhI0WGJ
X-Received: by 2002:a05:600c:21d5:: with SMTP id x21mr6111952wmj.149.1620745210683;
        Tue, 11 May 2021 08:00:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgE6ifBgFWpvncB4Yp/ueaUboNmb37R0/BTIg4dy1wyIvx0+2z3v12HkdeJg8oHTVE/aiLRx0h5iTD71Z5u+Q=
X-Received: by 2002:a05:600c:21d5:: with SMTP id x21mr6111920wmj.149.1620745210398;
 Tue, 11 May 2021 08:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210511140113.1225981-1-agruenba@redhat.com> <YJqQdKmBHz6oEqD1@casper.infradead.org>
In-Reply-To: <YJqQdKmBHz6oEqD1@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 11 May 2021 16:59:59 +0200
Message-ID: <CAHc6FU5LMhLfQO6wj8z0RD1Q3jv0reToP7=LSj5B-e50WYGnkA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Trigger retry from fault vm operation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 4:34 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, May 11, 2021 at 04:01:13PM +0200, Andreas Gruenbacher wrote:
> > we have a locking problem in gfs2 that I don't have a proper solution for, so
> > I'm looking for suggestions.
> >
> > What's happening is that a page fault triggers during a read or write
> > operation, while we're holding a glock (the cluster-wide gfs2 inode
> > lock), and the page fault requires another glock.  We can recognize and
> > handle the case when both glocks are the same, but when the page fault requires
> > another glock, there is a chance that taking that other glock would deadlock.
>
> So we're looking at something like one file on a gfs2 filesystem being
> mmaped() and then doing read() or write() to another gfs2 file with the
> mmaped address being the passed to read()/write()?

Yes, those kinds of scenarios. Here's an example that Jan Kara came up with:

Two independent processes P1, P2. Two files F1, F2, and two mappings M1, M2
where M1 is a mapping of F1, M2 is a mapping of F2. Now P1 does DIO to F1
with M2 as a buffer, P2 does DIO to F2 with M1 as a buffer. They can race
like:

P1                                      P2
read()                                  read()
  gfs2_file_read_iter()                   gfs2_file_read_iter()
    gfs2_file_direct_read()                 gfs2_file_direct_read()
      locks glock of F1                       locks glock of F2
      iomap_dio_rw()                          iomap_dio_rw()
        bio_iov_iter_get_pages()                bio_iov_iter_get_pages()
          <fault in M2>                           <fault in M1>
            gfs2_fault()                            gfs2_fault()
              tries to grab glock of F2               tries to grab glock of F1

With cluster-wide locks, we can obviously end up with distributed
deadlock scenarios as well, of course.

> Have you looked at iov_iter_fault_in_readable() as a solution to
> your locking order?  That way, you bring the mmaped page in first
> (see generic_perform_write()).

Yes. The problem there is that we need to hold the inode glock from
->iomap_begin to ->iomap_end; that's what guarantees that the mapping
returned by ->iomap_begin remains valid.

> > When we realize that we may not be able to take the other glock in gfs2_fault,
> > we need to communicate that to the read or write operation, which will then
> > drop and re-acquire the "outer" glock and retry.  However, there doesn't seem
> > to be a good way to do that; we can only indicate that a page fault should fail
> > by returning VM_FAULT_SIGBUS or similar; that will then be mapped to -EFAULT.
> > We'd need something like VM_FAULT_RESTART that can be mapped to -EBUSY so that
> > we can tell the retry case apart from genuine -EFAULT errors.
>
> We do have VM_FAULT_RETRY ... does that retry at the wrong level?

There's also VM_FAULT_NOPAGE, but that only triggers a retry at the VM
level and doesn't propagate out far enough.

My impression is that VM_FAULT_RETRY is similar to VM_FAULT_NOPAGE
except that it allows the lock dropping optimization implemented in
maybe_unlock_mmap_for_io(). That error code can also only be used when
FAULT_FLAG_ALLOW_RETRY is set it seems. Correct me if I'm getting this
wrong.

Thanks,
Andreas


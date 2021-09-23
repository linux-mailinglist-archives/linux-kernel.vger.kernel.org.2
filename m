Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5180A415754
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 06:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhIWETc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 00:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhIWETb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 00:19:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F70AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 21:18:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w17so13078907wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwz3xT4jz1lCoxKDZBldnsOpbclkpwP/7ynQgLAOUHM=;
        b=qvAwMSZBdrRC2mdukPHKwdwMPAfViwUcGfT54bhT915wZF00azFOpb+EOagOZQIEZp
         s6lkW+kIz+joW/JB5RYAI5LLUif+tjQmKWUjR4ImrNvPPvhSgjcHQhAqBhSGD2I7EKe2
         ySBvdn84LsBQMn9N5COawJaCKxkvk3lCffT5J86BWNCz+A4maVhwzxD9KrXQAR2YCW3y
         LAu9axc/H1F6z5x2ybrkw0tG+9DRO+biL0juaGL3lmlMIf8rzpzl2IK05hFEZN+23TTd
         ltciIc+P31jiXIht70EfdYUjydYPcbbkf13d62iY8uG4cn3bEhYEWBxKPJIPYnl29pI1
         OdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwz3xT4jz1lCoxKDZBldnsOpbclkpwP/7ynQgLAOUHM=;
        b=wEdrwJ6W9CoQeXcgzdOLyhScktvMxke/EWdSEEf2zDMKe/4l8x6/WMlOKROHPcUuji
         hhRRAdln8XiWqDHXTJtw1uflM6G3j3sJf5GQJs8z762Hi6jqiGCeKai4cwwAljoG5l5E
         Y6D9J9sm1j5SE+7Nc1lHpmAjHq3k2JYYTuICYB/lx23tCxryZkZmzZwimYwoJeQDv/lZ
         RsZb7KI5P4tDyqmSjkSAt92aaGTlY8tXtU7xV0qcg50L14PuhdQTxZvPgRjXQBlNg9EC
         5clEPkaRc7TViPEJLJAbkeHMrpf2fsTQiGG4yi1AJ5as2hYSByqqa7LziIGVsfkXbXv3
         GEJA==
X-Gm-Message-State: AOAM530y5T6tnAxGVK851cA1UTZC/CkuGhuXoS3MspQZej9lqe5XJPe6
        DIAx6I4+egyanYurKUdpYDz4Q4dAYQK0ICBimJQMBw==
X-Google-Smtp-Source: ABdhPJzzWDVXW7SYmpK56KayGBqKhCZCXE4NQ4dhCewYYN78rq+Cc8gA/Wd6cyZSlmCC1NptXnEaICo1LPucnW43vtM=
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr2124849wmh.137.1632370678382;
 Wed, 22 Sep 2021 21:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <YUoaDr2wsW8wtk5Z@t490s> <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
 <YUowr6phZU4v7dds@t490s> <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
 <YUp438W5p5VHL1Ch@t490s> <CAJHvVciZc0mpcw8OSPk71YsVzCTajY+ikymcD3+zBJKsZynYkg@mail.gmail.com>
 <YUtoyNic4Jxfv9f7@t490s> <CAJHvVcg6PRCK_JcYEhRqq2vPyypnc+ySOtLhtFf5GrcQjimsJQ@mail.gmail.com>
 <YUulep3+YADkwlUu@t490s> <CAJHvVcijQdS_hfUnasz7BhhQeiHmNu=C5j8xfX=uWsfVO9-+Eg@mail.gmail.com>
 <YUvBEXV1Qs5wC+Jc@t490s>
In-Reply-To: <YUvBEXV1Qs5wC+Jc@t490s>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 22 Sep 2021 21:17:46 -0700
Message-ID: <CADrL8HUhV9ag6n3=MT2pNhtfrp8xH1Y-9zgispubzLy0ye6frw@mail.gmail.com>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
To:     Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jue Wang <juew@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 4:49 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Sep 22, 2021 at 03:29:42PM -0700, Axel Rasmussen wrote:
> > On Wed, Sep 22, 2021 at 2:52 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Wed, Sep 22, 2021 at 01:54:53PM -0700, Axel Rasmussen wrote:
> > > > On Wed, Sep 22, 2021 at 10:33 AM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > Hello, Axel,
> > > > >
> > > > > On Wed, Sep 22, 2021 at 10:04:03AM -0700, Axel Rasmussen wrote:
> > > > > > Thanks for discussing the design Peter. I have some ideas which might
> > > > > > make for a nicer v2; I'll massage the code a bit and see what I can
> > > > > > come up with.
> > > > >
> > > > > Sure thing.  Note again that as I don't have a strong opinion on that, feel
> > > > > free to keep it.  However if you provide v2, I'll read.
> > > > >
> > > > > [off-topic below]
> > > > >
> > > > > Another thing I probably have forgot but need your confirmation is, when you
> > > > > worked on uffd minor mode, did you explicitly disable thp, or is it allowed?
> > > >
> > > > I gave a more detailed answer in the other thread, but: currently it
> > > > is allowed, but this was a bug / oversight on my part. :) THP collapse
> > > > can break the guarantees minor fault registration is trying to
> > > > provide.
> > >
> > > I've replied there:
> > >
> > > https://lore.kernel.org/linux-mm/YUueOUfoamxOvEyO@t490s/
> > >
> > > We can try to keep the discussion unified there regarding this.
> > >
> > > > But there's another scenario: what if the collapse happened well
> > > > before registration happened?
> > >
> > > Maybe yes, but my understanding of the current uffd-minor scenario tells me
> > > that this is fine too.  Meanwhile I actually have another idea regarding minor
> > > mode, please continue reading.
> > >
> > > Firstly, let me try to re-cap on how minor mode is used in your production
> > > systems: I believe there should have two processes A and B, if A is the main
> > > process, B could be the migration process.  B migrates pages in the background,
> > > while A so far should have been stopped and never ran.  When we want to start
> > > A, we should register A with uffd-minor upon the whole range (note: I think so
> > > far A does not have any pgtable mapped within uffd-minor range).  Then any page
> > > access of A should kick B and asking "whether it is the latest page", if yes
> > > then UFFDIO_CONTINUE, if no then B modifies the page, plus UFFDIO_CONTINUE
> > > afterwards.  Am I right above?
> > >
> > > So if that's the case, then A should have no page table at all.
> > >
> > > Then, is that a problem if the shmem file that A maps contains huge thps?  I
> > > think no - because UFFDIO_CONTINUE will only install small pages.
> > >
> > > Let me know if I'm understanding it right above; I'll be happy to be corrected.
> >
> > Right, except that our use case is even more similar to QEMU: the code
> > doing UFFDIO_CONTINUE / demand paging, and the code running the vCPUs,
> > are in the same process (same mm) - just different threads.
>
> I see.
>
> >
> > >
> > > Actually besides this scenario, I'm also thinking of another scenario of using
> > > minor fault in a single process - that's mostly what QEMU is doing right now,
> > > as QEMU has the vcpu threads and migration thread sharing a single mm/pgtable.
> > > So I think it'll be great to have a new madvise(MADV_ZAP) which will tear down
> > > all the file-backed memory pgtables of a specific range.  I think it'll suite
> > > perfectly for the minor fault use case, and it can be used for other things
> > > too.  Let me know what you think about this idea, and whether that'll help in
> > > your case too (e.g., if you worry a current process A mapped huge shmem thp
> > > somewhere, we can use madvise(MADV_ZAP) to drop it).
> >
> > Yes, this would be convenient for our implementation too. :) There are
> > workarounds if the feature doesn't exist, but it would be nice to
> > have.
>
> Could I know what's the workaround?  Normally if the workaround works solidly,
> then there's less need to introduce a kernel interface for that.  Otherwise I'm
> glad to look into such a formal proposal.

The workaround is, for the region that you want to zap, run through
this sequence of syscalls: mumap, mmap, and re-register with
userfaultfd if it was registered before. If we're using tmpfs, we can
use madvise(DONTNEED) instead, but this is kind of an abuse of the
API. I don't think there's a guarantee that the PTEs will get zapped,
but currently they will always get zapped if we're using tmpfs. I
really like the idea of adding a new madvise() mode that is guaranteed
to zap the PTEs.

>
> > It's also useful for memory poisoning, I think, if the host
> > decides some page(s) are "bad" and wants to intercept any future guest
> > accesses to those page(s).
>
> Curious: isn't hwpoison information come from MCEs; or say, host kernel side?
> Then I thought the host kernel will have full control of it already.
>
> Or there's other way that the host can try to detect some pages are going to be
> rotten?  So the userspace can do something before the kernel handles those
> exceptions?

Here's a general idea of how we would like to use userfaultfd to support MPR:

If a guest accesses a poisoned page for the first time, we will get an
MCE through the host kernel and send an MCE to the guest. The guest
will now no longer be able to access this page, and we have to enforce
this. After a live migration, the pages that were poisoned before
probably won't still be poisoned (from the host's perspective), so we
can't rely on the host kernel's MCE handling path. This is where
userfaultfd and this new madvise mode come in: we can just
madvise(MADV_ZAP) the poisoned page(s) on the target during a
migration. Now all accesses will be routed to the VMM and we can
inject an MCE. We don't *need* the new madvise mode, as we can also
use fallocate(PUNCH_HOLE) (works for tmpfs and hugetlbfs), but it
would be more convenient if we didn't have to use fallocate.

Jue Wang can provide more context here, so I've cc'd him. There may be
some things I'm wrong about, so Jue feel free to correct me.


- James


>
> --
> Peter Xu
>

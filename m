Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE341B78E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhI1Tag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbhI1Tae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:30:34 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD45C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:28:54 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d8so17985qtd.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=XsjdlDkMgrnWm86KRTDvDjoKxU8q2vnfS+JjL8NLogA=;
        b=FuzIcqUVNAcGSTyqmjq6CxJXt5JaO/UJ1whu6w1uLhzJ7tOgMiI/BqPIDYpo2yB/r5
         +3erNGPZZe0d46lwQuwh/6yQSJM7Nqom1N+KNlFPcllLtoxQwXLsYJqTbX15htYJgZMW
         Rz6JU+5qtGl8RFzK4PO9UFvtkeoAKb6OgrMAXDkxbjh1gTceM5WzVQ6uGhtiQkFPigi1
         949tlvot0OA+yAYo5MJN9/vXs8f0xcIuzHgVfs+0K5MDU8Fg+MVFKz/PDiBOE442+oZd
         Ely1QnldKyFWj6fomdpt4a7Bc6Y1q1zaMUSoCW5ggmvdwvG4vpAQPti4J46IAA4FauFI
         oZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=XsjdlDkMgrnWm86KRTDvDjoKxU8q2vnfS+JjL8NLogA=;
        b=1YkehTMdYSlPjKWbjo0lQZwVW4m0A0EGDvGBTDmNmOF6K6SGlaYbrhPjABnVXWTfV1
         o8YFZvashZwYC0LGAjxvc/1c0yv6huEoqURlnp5xpHsNaVaneSFYVT6yBxJIlMEZ0vTQ
         zEao1l4t4pfIWUO+ZIEMY6xEpHgaXVHUvdO6Sx5N1UVplax4KLbTMIFXSWnFFCDV0+uH
         +y2DV9912dFCOpkHFfzd9bRQArSpkC9yM1LFLM5mblGX7mPYEBwSXRTtpJfC1YlSnG4l
         xmIEwIhQzEVdpBgT/CNIBFqHwm8yWDGkaLwrj7QVRwVrMiGRsAtFnds3tvSRrhzgCiSk
         438w==
X-Gm-Message-State: AOAM53383FiAi/poUtoMmETD7ZZIXjUPJdborIUyQDda2k2lGy699yCK
        f2eoLecAVn+ksruC30hhQoI1g6yfm23KrA==
X-Google-Smtp-Source: ABdhPJzgk74SyZVdpo5IjXsggwCbj9+UHEjp9jdMROK0mNUg1gOkAOfCx5cXfOcLL/Ct6gcHSpTNWQ==
X-Received: by 2002:ac8:72d3:: with SMTP id o19mr7912437qtp.19.1632857333488;
        Tue, 28 Sep 2021 12:28:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k2sm24206qtg.35.2021.09.28.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:28:52 -0700 (PDT)
Date:   Tue, 28 Sep 2021 12:28:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v4 1/4] mm/shmem: Unconditionally set pte dirty in
 mfill_atomic_install_pte
In-Reply-To: <YVI195OZ7t3i3n6t@t490s>
Message-ID: <256c72c4-ac99-94fb-d76-fab08e5cf5f4@google.com>
References: <20210915181456.10739-1-peterx@redhat.com> <20210915181456.10739-2-peterx@redhat.com> <49fddb9a-4a52-1df-8b7c-dde2a89330bf@google.com> <YVI195OZ7t3i3n6t@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021, Peter Xu wrote:
> On Thu, Sep 23, 2021 at 08:56:33PM -0700, Hugh Dickins wrote:
> > I'm not going to NAK this, but you and I have different ideas of
> > "very nice cleanups".  Generally, you appear (understandably) to be
> > trying to offload pieces of work from your larger series, but often
> > I don't see the sense of them, here in isolation anyway.
> > 
> > Is this a safe transformation of the existing code? Yes, I believe so
> > (at least until someone adds some PTESAN checker which looks to see
> > if any ptes are dirty in vmas to which user never had write access).
> > But it took quite a lot of lawyering to arrive at that conclusion.
> 
> I can get your point there, but I keep a skeptical view if there'll be a tool
> called PTESAN that asserts VM_WRITE for pte_dirty.
> 
> After we've noticed the arm64 implementation of pte_mkdirty() last time, I've
> already started to not bind the ideas on VM_WRITE or pte_write() for pte dirty.

Yes, I know that there are good cases of pte_dirty() without pte_write():
that's why I said "never had write access" - never.

> 
> As I said before, that's quite natural when I think "the uffd-way", because
> uffd can easily arm a page with read-only but while the page is dirty.  I think
> you'll answer that with "we should mark the page dirty instead" in this case,
> as you stated below.  I also agree.  However if we see pte_dirty a major way to
> track data dirty information, and at last when it'll be converged into the
> PageDirty, I think it doesn't really matter a huge lot to us if we set pte or
> page dirty, or is it?

Please, imagine the faulting process has a PROT_READ,MAP_SHARED mmap of
/etc/passwd, or any of a million files you would not want it to write to.

The process serving that fault by doing the ioctl has (in my perhaps
mistaken mental model of userfaultfd) greater privilege, and is able
to fill in the contents of what /etc/passwd should contain: it fills the
right data into the page, which is preserved by being marked PageDirty.

The faulting process can never write to that page, and that pte ought
never to be marked dirty.

Marking the pte dirty is not a security problem: doing so does not
grant write access (though it's easy to imagine incorrect code elsewhere
that "deduces" pte_write() from pte_dirty() for some reason - I'm pretty
sure we have had such instances in the past, if not now).  But it is an
anomaly that would be better avoided.

Which is precisely why there is the "writable" check before doing it at
present ("writable" being a stand-in for the FAULT_FLAG_WRITE not visible
at this end).  (There is also "|| !page_in_cache" - that's to allow for a
read-only mmap of a page supplied by mcopy_atomic_pte(): which I argue
would be better with a SetPageDirty() in the caller than a pte_mkdirty()
here; but anonymous pages are less of a worry than shared file pages.)

So, as I said before, I believe what you're doing in this patch happens
to be a safe transformation of existing code; but not a nice cleanup.

> 
> > 
> > Is this a cleanup? No, it's a dirtyup.
> > 
> > shmem_mfill_atomic_pte() does SetPageDirty (before unlocking page)
> > because that's where the page contents are made dirty.  You could
> > criticise it for doing SetPageDirty even in the zeropage case:
> > yes, we've been lazy there; but that's a different argument.
> > 
> > If someone is faulting this page into a read-only vma, it's
> > surprising to make the pte dirty there.  What would be most correct
> > would be to keep the SetPageDirty in shmem_mfill_atomic_pte()
> > (with or without zeropage optimization), and probably SetPageDirty
> > in some other places in mm/userfaultfd.c (I didn't look where) when
> > the page is filled with supplied data, and mfill_atomic_install_pte()
> > only do that pte_mkdirty() when it's serving a FAULT_FLAG_WRITE.
> 
> That's a good point, and yeah if we can unconditionally mark PageDirty it'll be
> great too; I think what bothered me most in the past was that the condition to
> check dirty is too complicated, for which myself has been debugging for two
> cases where we should apply the dirty bit but we forgot; each of the debugging
> process took me a few days or more to figure out, thanks to my awkward
> debugging skills.
> 
> Then I noticed, why not we do the way around if for 99% of the cases they're
> dirty in real systems?  Say, let's set dirty unconditionally and see when there
> (could have, which I still doubt) is a negative effect on having some page
> dirty, we track that from a "degraded" performance results.  Then we convert
> some hard-to-debug data corrupt issues into "oh previously this programs runs
> at speed 100x, now it runs 99x, why I got 1% performance lost?"  I even highly
> doubt whether it'll come true: for the uffd case (which is the only case I
> modified in this patch), I can hardly tell how many people would like to use
> the mappings read-only, and how much they'll suffer from that extra dirty bit
> or PageDirty.
> 
> That's why I really like this patch to happen, I want to save time for myself,
> and for anyone who will be fighting for another dirty lost issues.

I've lost time on missed dirties too, so I ought to be more sympathetic
to your argument than I am: I'm afraid I read it as saying that you don't
really understand "dirty", so want to do it more often to be "safe".
Not a persuasive argument.

> 
> > 
> > I haven't looked again (I have a pile of mails to respond to!),
> > but when I looked before I think I found that the vmf flags are
> > not available to the userfaultfd ioctler.  If so, then it would
> > be more appropriate to just leave the mkdirty to the hardware on
> > return from fault (except - and again I cannot spend time researching
> > this - perhaps I'm too x86-centric, and there are other architectures
> > on which the software *must* do the mkdirty fixup to avoid refaulting
> > forever - though probably userfaultfd state would itself prevent that).
> 
> If it's based on the fact that we'll set PageDirty for file-backed, then it
> looks okay, but not usre.
> 
> One thing to mention is pte_mkdirty() also counts in soft dirty by nature.  I'm
> imagining a program that was soft-dirty tracked and somehow using UFFDIO_COPY
> as the major data filler (so the task itself may not write to the page directly
> hence HW won't set dirty bit there).  If with pte_mkdirty the other userspace
> tracker with soft-dirty can still detect this, while with PageDirty I believe
> it can't.  From that POV I'm not sure whether I can say that as proactively
> doing pte_mkdirty is a safer approach just in case such an use case exist, as
> myself can't say they're illegal, so pte_dirty is a superset of PageDirty not
> vice versa.

And this is not persuasive either: without much deeper analysis
(which I'll decline to do!), it's impossible to tell whether an excess of
pte_mkdirty()s is good or bad for the hypothetical uffd+softdirty tracker:
you're guessing good, I'm guessing bad.

How about a compromise (if you really want to continue with this patch):
you leave the SetPageDirty(page) in shmem_mfill_atomic_pte(), where I
feel a responsibility for it; but you do whatever works for you with
pte_mkdirty() at the mm/userfaultfd.c end?

(In the course of writing this, it has occurred to me that a much nicer
solution might be to delete mfill_atomic_install_pte() altogether, and
change the userfaultfd protocol so that handle_userfault() returns the
page supplied by ioctler, for process to map into its own userspace
in its usual way. But that's a big change, that neither of would be
keen to make; and it would not be surprising if it turned out actually
to be a very bad change - perhaps tried and abandoned before the "atomic"
functions were decided on. I wouldn't even dare mention it, unless that
direction might happen to fit in with something else you're plannng.)

Hugh

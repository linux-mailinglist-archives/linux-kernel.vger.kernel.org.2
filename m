Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4114841A14C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhI0VXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236723AbhI0VXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632777724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CNcx8v2v7/Q1JkZW9wrIhOcG3aBXZCVs/MVlBQr4E4c=;
        b=BFA4WmKKeLPr0bNPYTcgYfDNfog6I+37quZq/QgZ4otkwmr/vuE22F+3CYoytmiiqfR+ES
        K7921OJVLx6ri7sl5nhb871nXHaMHJqFcHb3sGriK3nVvjPqoat2o2HQh6X9pnZ9/VaEcY
        KzaKf7GZzVMeyP3YcuzktkOjc6p5CWY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-0h5-sOR0PzezfaZWFy_7Tg-1; Mon, 27 Sep 2021 17:22:02 -0400
X-MC-Unique: 0h5-sOR0PzezfaZWFy_7Tg-1
Received: by mail-qt1-f199.google.com with SMTP id 70-20020aed20cc000000b002a69b3ea30aso76849164qtb.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CNcx8v2v7/Q1JkZW9wrIhOcG3aBXZCVs/MVlBQr4E4c=;
        b=2gRv0h9EFzPo8xpYjpUiDRS7jiCM2J3CTr4XEoSAExrUN943m4pg2Y/xGdCNkf1Qy0
         Hh5dvz2zQzUAW43e0WNoyMybdy1CdBqsqwQ440V8omopVrr2ZFOPSfufQrr1LGClrFtB
         xacb6px/4DTEdaT1dSjRJboCDAH69xeCPmhkCXmO1aQsWPOrRL6A5jFw1acqhWoh4zu3
         F9c5+IsWd/NYT7nSOKNCM7q0naXFolYhuo27mWioSgLtpfwMfvUoyW6QK6KGAw0SzJkH
         HZEmfyZxLtqw+6Qs19s40Tg2pxi/cxo+WY0l18fYz8+ifAfGoD41nAivAs5HKAc5vc+k
         yH6g==
X-Gm-Message-State: AOAM53076JTdB3XmKFwScWVZnBDEaZB3buakjYp5UeMU3GCpjEN5yutz
        Tqu0CKHd06FSeinQZXA2bA2FU9k9Li2tilQpKX4AfpFylweulmxstfskx78XAX5KUKAuWRnOkFE
        0BZOoRe4wxMdWErtvTriOiq2G
X-Received: by 2002:a37:6350:: with SMTP id x77mr2171231qkb.356.1632777722259;
        Mon, 27 Sep 2021 14:22:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwISkoed9UXoiAqTN8bES3IbX9Ui3yea3fvmKgs1vmmm3coVx2bqhq2jtnWHDgGdBKpwK/YJA==
X-Received: by 2002:a37:6350:: with SMTP id x77mr2171196qkb.356.1632777721864;
        Mon, 27 Sep 2021 14:22:01 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id s10sm13075677qko.134.2021.09.27.14.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 14:22:01 -0700 (PDT)
Date:   Mon, 27 Sep 2021 17:21:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
Message-ID: <YVI195OZ7t3i3n6t@t490s>
References: <20210915181456.10739-1-peterx@redhat.com>
 <20210915181456.10739-2-peterx@redhat.com>
 <49fddb9a-4a52-1df-8b7c-dde2a89330bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49fddb9a-4a52-1df-8b7c-dde2a89330bf@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh,

On Thu, Sep 23, 2021 at 08:56:33PM -0700, Hugh Dickins wrote:
> I'm not going to NAK this, but you and I have different ideas of
> "very nice cleanups".  Generally, you appear (understandably) to be
> trying to offload pieces of work from your larger series, but often
> I don't see the sense of them, here in isolation anyway.
> 
> Is this a safe transformation of the existing code? Yes, I believe so
> (at least until someone adds some PTESAN checker which looks to see
> if any ptes are dirty in vmas to which user never had write access).
> But it took quite a lot of lawyering to arrive at that conclusion.

I can get your point there, but I keep a skeptical view if there'll be a tool
called PTESAN that asserts VM_WRITE for pte_dirty.

After we've noticed the arm64 implementation of pte_mkdirty() last time, I've
already started to not bind the ideas on VM_WRITE or pte_write() for pte dirty.

As I said before, that's quite natural when I think "the uffd-way", because
uffd can easily arm a page with read-only but while the page is dirty.  I think
you'll answer that with "we should mark the page dirty instead" in this case,
as you stated below.  I also agree.  However if we see pte_dirty a major way to
track data dirty information, and at last when it'll be converged into the
PageDirty, I think it doesn't really matter a huge lot to us if we set pte or
page dirty, or is it?

> 
> Is this a cleanup? No, it's a dirtyup.
> 
> shmem_mfill_atomic_pte() does SetPageDirty (before unlocking page)
> because that's where the page contents are made dirty.  You could
> criticise it for doing SetPageDirty even in the zeropage case:
> yes, we've been lazy there; but that's a different argument.
> 
> If someone is faulting this page into a read-only vma, it's
> surprising to make the pte dirty there.  What would be most correct
> would be to keep the SetPageDirty in shmem_mfill_atomic_pte()
> (with or without zeropage optimization), and probably SetPageDirty
> in some other places in mm/userfaultfd.c (I didn't look where) when
> the page is filled with supplied data, and mfill_atomic_install_pte()
> only do that pte_mkdirty() when it's serving a FAULT_FLAG_WRITE.

That's a good point, and yeah if we can unconditionally mark PageDirty it'll be
great too; I think what bothered me most in the past was that the condition to
check dirty is too complicated, for which myself has been debugging for two
cases where we should apply the dirty bit but we forgot; each of the debugging
process took me a few days or more to figure out, thanks to my awkward
debugging skills.

Then I noticed, why not we do the way around if for 99% of the cases they're
dirty in real systems?  Say, let's set dirty unconditionally and see when there
(could have, which I still doubt) is a negative effect on having some page
dirty, we track that from a "degraded" performance results.  Then we convert
some hard-to-debug data corrupt issues into "oh previously this programs runs
at speed 100x, now it runs 99x, why I got 1% performance lost?"  I even highly
doubt whether it'll come true: for the uffd case (which is the only case I
modified in this patch), I can hardly tell how many people would like to use
the mappings read-only, and how much they'll suffer from that extra dirty bit
or PageDirty.

That's why I really like this patch to happen, I want to save time for myself,
and for anyone who will be fighting for another dirty lost issues.

> 
> I haven't looked again (I have a pile of mails to respond to!),
> but when I looked before I think I found that the vmf flags are
> not available to the userfaultfd ioctler.  If so, then it would
> be more appropriate to just leave the mkdirty to the hardware on
> return from fault (except - and again I cannot spend time researching
> this - perhaps I'm too x86-centric, and there are other architectures
> on which the software *must* do the mkdirty fixup to avoid refaulting
> forever - though probably userfaultfd state would itself prevent that).

If it's based on the fact that we'll set PageDirty for file-backed, then it
looks okay, but not usre.

One thing to mention is pte_mkdirty() also counts in soft dirty by nature.  I'm
imagining a program that was soft-dirty tracked and somehow using UFFDIO_COPY
as the major data filler (so the task itself may not write to the page directly
hence HW won't set dirty bit there).  If with pte_mkdirty the other userspace
tracker with soft-dirty can still detect this, while with PageDirty I believe
it can't.  From that POV I'm not sure whether I can say that as proactively
doing pte_mkdirty is a safer approach just in case such an use case exist, as
myself can't say they're illegal, so pte_dirty is a superset of PageDirty not
vice versa.

> 
> But you seem to think that doing the dirtying in an unnatural place
> helps somehow; and for all I know, that may be so in your larger
> series, though this change certainly raises suspicions of that.
> 
> I'm sorry to be so discouraging, but you have asked for my opinion,
> and here at last you have it.  Not a NAK, but no enthusiasm at all.

Thanks a lot for still looking at these patches; even if most of them are
negative and they come a bit late for sure.. I still appreciate your time.

As you mentioned you're busy with all the things and I'm aware of it.  And
that's really what this patch wants to achieve too - to save time for all,
where my point stands at "maintaining 100% accurate dirty bit does not worth it
here".

Thanks,

-- 
Peter Xu


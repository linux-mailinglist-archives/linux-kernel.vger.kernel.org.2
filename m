Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FBC380A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhENNT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhENNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620998326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Qai09ABkyx5du95Ox4wpA5Z6s77EwapfOJRz22dS3w=;
        b=UAXcpjlv3euHmCCmmxK9Q+EgcTEDLxWUI1nA9jtzaP2HV9AuP79qO4mrk/frCbDUvjkMA7
        a1A+/PxNTf//AadKewlz4UaM4yHK1C7XmUO+iNI4Ej7hr2UoQyLggkFVjB6Wb5iCsGz3T3
        DoPdvjb1+yYADlN28ENsvDSn0v8xuN8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-L2MtvI4RPCGd58HdMaEDmg-1; Fri, 14 May 2021 09:18:44 -0400
X-MC-Unique: L2MtvI4RPCGd58HdMaEDmg-1
Received: by mail-qk1-f198.google.com with SMTP id d201-20020ae9efd20000b02902e9e9d8d9dcso21785713qkg.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 06:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Qai09ABkyx5du95Ox4wpA5Z6s77EwapfOJRz22dS3w=;
        b=gBRCorPjiAkUjHcCHlitUzD/HIiYRJXjMCbK+IV0omMXqfwQZx+Ucm8B3LIzrgQHUS
         h5aiZ1C15ygVyA6GbfXB/jKYxqZUPVHGMxHBODm5TYGi/mgwQuyUa3razYj+s5gzragh
         lNuVcWY6WjTjOhuOWuVPedOh1CkjgK7jAmbJ05BE/Cb6Qh3vNL7wIlwChJpb4mcGnA1q
         gBWLIuUHo7j8BqYwfPBpBi8R4z0tIg2S1W1zkz9EncU/ZXxCFtwPrMcjZktMvQWDPMFL
         bpJfrlre2x+2dtd3lcPX5UttnOYVvbSWS9Nvl1qfYrkYbezRrv16W7M1WN4wdmYFNpAW
         C/xw==
X-Gm-Message-State: AOAM531wz452E/bkxagPmbrQudQs5p/JjLVvCMS3IjUlKQclKropvFfP
        qUn600im/YsF0BrL8Hc8MKAiO+ELXKrpUg4GA+eEvs8vKYcJrXWGMFX7V9+xyI/JEDfbCbYZWEI
        0oLEV9ufVXBN90ofm4l6zV4we
X-Received: by 2002:ac8:7f83:: with SMTP id z3mr33555903qtj.239.1620998324355;
        Fri, 14 May 2021 06:18:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3kctbzKjpHxKCqh39AwL0aUlnZiYbR9dALp56fd/jcHwHnn1BUyd8IvocfrZuPfoOuUfHDQ==
X-Received: by 2002:ac8:7f83:: with SMTP id z3mr33555862qtj.239.1620998323921;
        Fri, 14 May 2021 06:18:43 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id l10sm4983447qtn.28.2021.05.14.06.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:18:43 -0700 (PDT)
Date:   Fri, 14 May 2021 09:18:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 00/24] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <YJ54sgmMoV+bVU7Q@t490s>
References: <20210427161317.50682-1-peterx@redhat.com>
 <YJwl1wNM18trv7px@t490s>
 <alpine.LSU.2.11.2105132312350.3969@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2105132312350.3969@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh,

On Fri, May 14, 2021 at 12:07:38AM -0700, Hugh Dickins wrote:
> On Wed, 12 May 2021, Peter Xu wrote:
> > On Tue, Apr 27, 2021 at 12:12:53PM -0400, Peter Xu wrote:
> > > This is v2 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as a
> > > kernel full feature, as it only supports anonymous before this series.
> > 
> > Ping..
> > 
> > Thinking about a repost, as this series shouldn't be able to apply after we've
> > got more relevant patches into -mm.  E.g., the full minor fault, and also some
> > small stuff like pagemap, as we need one more patch to support shmem/hugetlbfs
> > too.
> > 
> > Hugh, haven't received any further comment from you on shmem side (or on the
> > general idea).  It would be great to still have some of your input.
> > 
> > Let me know if you prefer to read a fresh new version otherwise.
> 
> I am very sorry to let you down, Peter, repeatedly; but it is now very
> clear that I shall *never* have time to review your patchset - I am too
> slow, have too much else to attend to, and take too long each time to
> sink myself deep enough into userfaultfd.

Never mind!  It's just that I'm kind of obliged to ask for your opinion as you
contributed part of the idea while you are also the shmem maintainer. :) So
that's what I did before I start to bother Andrew (since I know Andrew is 100%
busy.. that's also why I tend to not ask Andrew for review pings as best as I
can for all my works; while Andrew can chim in anytime anyways as in the loop).

> 
> I realize that you're being considerate, and expecting no more than
> a few comments from me, rather than asking for formal review; but it's
> still too much for me to get into.

I'm actually even be prepared to receive a full-series NACK anytime. :) To me
it's more important to have the right direction first, as I didn't receive that
during RFC so I moved on, assuming no one thinks it wrong.  However it's indeed
true that you never let me down (as far as I see from the other discussions)
that you do very in-depth review to hunt down any single potential risks you
may have noticed even in an rare error path - that's just too attractive a
reviewer to all the patch writters!

> 
> The only reason I was involved at all, was when you were wondering how
> to handle the pagetable entries for shmem.  I suggested one encoding,
> Andrea suggested slightly differently: Andrea's was more elegant (no
> "swap type" required), and it looked like you went with his - good.
> 
> I wonder whether you noticed
> https://lore.kernel.org/linux-mm/20210407084238.20443-2-apopple@nvidia.com/
> which might interfere.  I've had no more time to look at that than yours,
> so no opinion on it (and I don't know what happened to it after that).

Thanks for the pointer.  Looks like there'll be some slight rebase work and
totally orthogonal on the ideas, then we'll see who will do the rebase (yeh
probably me :).

Hmm, meanwhile if that's the initial versions I might go and suggest a renaming
of pfn_swap_entry_to_page() to start with pte_swp_*() as it operates on swp pte
not a pfn.  However probably too late for a v8 series so I'll give up.  It also
has mentioned something like "special swap pte", hope that won't get confused
with what this series is proposing.  We'll see when it becomes a problem, so
far seems still okay.

> 
> Please keep uppermost in mind when modifying mm/shmem.c for userfaultfd,
> the difference between shared and private; and be on guard against the
> ways in which CONFIG_USERFAULTFD=y might open a door to abuse.

Will do.  Then I'll move this series on.

Re shared/private, let me mention one thing just in case for any use of peace
of mind: the most dangerous place for uffd-wp+shmem should be the
UFFDIO_WRITEPROTECT page resolving ioctl when we want to re-grant the write bit
to ptes if needed (for minor mode, the danger point is UFFDIO_CONTINUE
instead), however it should be even safer than UFFDIO_CONTINUE as
UFFDIO_WRITEPROTECT never grants the write bit for real but leave that all to
page fault handler (in change_pte_range()):

                } else if (uffd_wp_resolve) {
                        /*
                         * Leave the write bit to be handled
                         * by PF interrupt handler, then
                         * things like COW could be properly
                         * handled.
                         */
                        ptent = pte_clear_uffd_wp(ptent);
                }

While the newprot will never have the write bit either afaik, mwriteprotect_range():

		newprot = vm_get_page_prot(dst_vma->vm_flags);

The last risk is the dirty_accountable trick in change_pte_range(), but as you
analyzed in the other thread, userfaultfd never uses MM_CP_DIRTY_ACCT, so it
should be safe too.

Thanks,

-- 
Peter Xu


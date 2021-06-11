Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2163A4A68
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFKU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:59:48 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:36825 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKU7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:59:47 -0400
Received: by mail-pg1-f171.google.com with SMTP id 27so3415860pgy.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=86GE3iJFe57gPcNnM1NqsAKQeiV3rJ6CpUslpmU8WeM=;
        b=tnEDRvvXNBUvAbGAIPcS8JqwdD2xlGDrV8VHeQBphNRNSYhFfIKBCDJ88l42Q1wISY
         CW51sVoUvgCAnhLAPjNEuhxAnvwq0xecPPJyhsxm5oZz7wdUASqbWScALJfgIDFxhK+1
         OAaxOX97yttQjs/1Fo0C5rjr+B3+NrJI+o/iht+9KY7O9Xc9kZu960NCGQwHa/45mTWw
         Xst0HwgHofzuK7/uI7q5lwMRAPI+dMruwxU3ypqWLFlRauGE4l+VxdRWiQF48SQwbVjY
         HZb0BxAKnUCZq1FEJN7+YaUDgyHgZvdcKNhlNfGFnWVgD8wFMSkQAoz2mP+U0IbcrPAl
         soAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=86GE3iJFe57gPcNnM1NqsAKQeiV3rJ6CpUslpmU8WeM=;
        b=PPvpp4DgmGE110Px09+wgz77BsmInrdRllL2PC15tk8qNNAQnzSijJI+nd9s6Yi+Vv
         0j7vtPYXxz8A2ZilTCtw9s1s5vEYvOpyfZtYz1s0uebR7D4SVsUgZThjJf9FF+/nxob2
         GvjLIDZF+XGTGu7mo8Us+dxT1bSu7SvjcO2FOaKl1ti5PLS1ohAE9RA4qm8xL/uQX5hS
         dI4QRQNYZuQNvu1ipgvGy1v5f966Opk+rMBwLTNlV2WK35LtyKkkPDAtecdkXVr/tzTe
         rcM5GYQQ6+xHtQ1d4/s8U0Znxl2Mh4zc8AugnMJepU9YKp3dedt3A1S9Khdg9eEzXcbO
         aoWw==
X-Gm-Message-State: AOAM530Kzqfn3VITD+BkIXKVcNplooYtcQISP+qbA8Ie01dllUwlaaM5
        lDjVasGX9mnrQz5l8ON6FfKJtw==
X-Google-Smtp-Source: ABdhPJwbBb9krf9s+H47pXMzgo0PdcZ8+M76PdtboMylSGEhPIT07WIJRLZZzWimzSeGcBJzgxnGHA==
X-Received: by 2002:a63:684a:: with SMTP id d71mr1241120pgc.25.1623445008809;
        Fri, 11 Jun 2021 13:56:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o9sm6352409pfh.217.2021.06.11.13.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:56:48 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:56:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Alistair Popple <apopple@nvidia.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] mm/thp: fix THP splitting unmap BUGs and
 related
In-Reply-To: <1697169.ADtCEf3Xva@nvdebian>
Message-ID: <494c929d-5253-58b0-6329-dec8395199cc@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com> <2014832.e7zRqyNrDn@nvdebian> <b27e866-a06c-d32-20aa-3b16f58549@google.com> <1697169.ADtCEf3Xva@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021, Alistair Popple wrote:
> On Friday, 11 June 2021 10:15:51 AM AEST Hugh Dickins wrote:
> > 
> > Sorry to give you the bother, Alistair: it's worked out as a bad moment
> > to rewrite swapops.h and rmap.c, I'm afraid.
> 
> Indeed, but I don't think it's too bad. I've just tried rebasing it on this
> series and it didn't run into too many problems. Obviously I ran into the same
> issue Andrew did but I was able to fix that up. It also means try_to_migrate()
> now returns 'void' instead of 'bool'.

Yes, void try_to_migrate().

> 
> Which brings me to the only real question I had during the rebase - does
> migration also need to accept the TTU_SYNC flag? I think it does because if I
> understand correctly we can still hit the same race with zap_pte_range() when
> trying to establish migration entries which previously also returned the status
> of page_mapped().

Yes, try_to_migrate() needs to accept TTU_SYNC too.

> 
> > And the only help I've had time to give you was pointing Peter at your
> > series - many thanks to Peter, and to Shakeel.
> 
> Yes, thanks for the help there. I think the main questions I had for you were
> around checking vma flags under the ptl in try_to_munlock_one but Shakeel was
> able to clear that up for me. Thanks!
> 
> > Several times I've been on the point of asking you to keep the familiar
> > migration_entry_to_page(), along with your new pfn_swap_entry_to_page();
> > but each time I've looked, seen that it's hard to retain it sensibly at
> > the same time as overdue cleanup of the device_private_entry_to_page()s.
> 
> Yeah, it would make things a bit funny to retain it IMHO. At least any fixups
> should just be simple substitutions.
> 
> > So I guess I'm resigned to losing it; but there are at least three
> > bugs currently under discussion or fixes in flight, which border on
> > migration_entry_to_page() - Jann Horn's smaps syzbot bug, Xu Yu's
> > __migration_entry_wait() fix, my __split_huge_pmd_locked() fix
> > (and page_vma_mapped_walk() cleanup).
> > 
> > And regarding huge_memory.c's unmap_page(): I did not recognize the
> > "helps handle cases when i_size" comment you added there.  What I
> > ended up with (and thought was in mmotm-adjust.tar but seems not):
> > 
> >         /*
> >          * Anon pages need migration entries to preserve them, but file
> >          * pages can simply be left unmapped, then faulted back on demand.
> >          * If that is ever changed (perhaps for mlock), update remap_page().
> >          */
> 
> My comment was based somewhat on the commit message for the original change but
> yours is much clearer so will incorporate it into my rebase, thanks.

Oh, you did better than I, I didn't think to look there on this occasion.
But even so, the i_size business is just one detail, and the new comment
better I think (I also disliked comment on an else without { } around it).

> 
> As to sending my rebased series I suppose it would be best to wait until
> linux-mm has been updated with whatever other fixes are needed before resending
> it based on top of that. So far rebasing on this series didn't require too many
> drastic changes to my v10 series. The most significant was to incorporate your
> changes to unmap_page(). The remaining were just adding the TTU_SYNC case to
> try_to_migrate{_one} and a single s/migration_entry_to_page/pfn_swap_entry_to_page/
> in huge_memory.c

Yes, I think that's it.  But check your try_to_migrate_one(), it may
want the same range.end vma_address_end() mod I made in try_to_unmap_one().

And does try_to_migrate_one() still have a comment referring to
try_to_unmap() when it should say try_to_migrate() there?

I've now located the diffs I missed from sending akpm before,
and diffed the diffs, and those are the points I see there;
but sending them now will just be a waste of everyones time.
No substitute for me checking your end result when it comes,
though I fear to do so since there's much more in your series
than I can wrap my head around without a lot more education.

Hugh

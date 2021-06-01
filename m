Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9D1397B83
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhFAVF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAVF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:05:27 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B34C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:03:44 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id x196so295186oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=l/l+v5X+oLRJBHDUXRGrjTZKpv5YVsX+2isDeYmnVg4=;
        b=HrFwY4QYFqbMigF5BpUSwMk4+GZcIcMT7Mtfaqk4R/yAp78dWUz1NA9ybUroyCv7jY
         18fxx93VRlGq4kX7zjZ7Dlkq6mVpZJmwfk0pMIZXqg8EDMMZBhxUJPW2pxJOqYASszLI
         9rVD3LQFJvsP0kSZRLe2eFoRV+ksRau7QszbY3ET+JNpxltMovrQSDT3ARKEL4UWeRMt
         CSnoY2ZE11R5GanhfLciPU1hmhTNFlqtshIZpiZFQNqvedELzuOUiVVtgIVBPIrzJ8Rm
         Qpm2oLIsH/X5MPA980hp4OlHuvy6NKfTfhcBInY5fsUk6whYTrlc6+pPnSEV4/nfavO+
         B43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=l/l+v5X+oLRJBHDUXRGrjTZKpv5YVsX+2isDeYmnVg4=;
        b=FTLbfoi16hLU3FFcJbeU+rh3ex7c9WBsXGkDH3pR5pNNm9cPUrNLwzp29MSqiFvZCh
         CnWOYitujmTjXewRPxuvdMsN+B4N8NuoMlB/9w18IYVlK2nuOfLXET5hdTqOStTEU8c7
         8D26bkfhKRH7W55HibRRXpErPhLXjxRAc8bB9XCCaZ8L1s1HOHgTZeoELYMv9joZJKu+
         dTt8SxoyLC8geptN5PWLuBAyNPnge8yE0VoPxojPHAaRTGLqU/u1T6CojJS2XaykPylw
         WLWFuj9Qh0H1u0ZL2A82xAn/xrPeRZFDcDd211fvSwH0RlaJGEbkqvRaXpSIHRSHAyX5
         +L6g==
X-Gm-Message-State: AOAM530KhtcQGcLgg2LIEe7u4+ra+8UwMvWIq4znZVRm2kDbMmyvWeJn
        q10Hp7Z3AQdyV2yLg9AbkljT9g==
X-Google-Smtp-Source: ABdhPJx3CVgQjugIPj4M0vJd5OW1nmLCCa4/Os/1sEr5qKc1o6SZm+6H0i2O9eCoQ1wTtPY+KlMgdA==
X-Received: by 2002:a05:6808:a87:: with SMTP id q7mr19559940oij.38.1622581423647;
        Tue, 01 Jun 2021 14:03:43 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l131sm3609558oia.0.2021.06.01.14.03.42
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 14:03:43 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:03:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] mm/thp: fix THP splitting unmap BUGs and related
Message-ID: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a batch of long-standing THP bug fixes that I had not got
around to sending before, but prompted now by Wang Yugui's report
https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/

Wang Yugui has tested a rollup of these fixes applied to 5.10.39,
and they have done no harm, but have *not* fixed that issue:
something more is needed and I have no idea of what.

But at least these clear up related issues, and should go to stable
(except for the last, which is just an optimization: it would be
fine in stable, but it's not required there).

These are against 5.13-rc4: easy for others to try out, but my next
task is to work out how to shoehorn them into mmotm and linux-next.

I would have said just before Yang Shi's related
mm-thp-replace-debug_vm-bug-with-vm_warn-when-unmap-fails-for-split.patch
except that (which should also go to stable) is currently placed after
Alistair Popple's "Add support for SVM atomics in Nouveau" series,
mm-rmap-split-try_to_munlock-from-try_to_unmap.patch etc.
I expect I shall offer you some rediffs of Alistair's, we'll see.

1/7 mm/thp: fix __split_huge_pmd_locked() on shmem migration entry
2/7 mm/thp: try_to_unmap() use TTU_SYNC for safe DEBUG_VM splitting
3/7 mm/thp: fix vma_address() if virtual address below file offset
4/7 mm/thp: fix page_address_in_vma() on file THP tails
5/7 mm/thp: fix page_vma_mapped_walk() if huge page mapped by ptes
6/7 mm/thp: unmap_mapping_page() to fix THP truncate_cleanup_page()
7/7 mm/thp: remap_page() is only needed on anonymous THP

 include/linux/mm.h   |    3 
 include/linux/rmap.h |    3 
 mm/huge_memory.c     |   47 ++++++++----
 mm/internal.h        |   54 ++++++++++----
 mm/memory.c          |   40 ++++++++++
 mm/page_vma_mapped.c |  163 ++++++++++++++++++++++++++-----------------
 mm/pgtable-generic.c |    5 -
 mm/rmap.c            |   39 +++++++---
 mm/truncate.c        |   43 +++++------
 9 files changed, 266 insertions(+), 131 deletions(-)

Hugh

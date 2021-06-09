Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A033A0AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhFIENE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFIEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:13:03 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 21:11:09 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u11so23883582oiv.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version;
        bh=/lR22JItVYcAEN4FGPywBWFlZb0TSLLrPjU/wXDo3Sc=;
        b=vinCl5o9Q8OTsG5hsJkUF5TFAzRnt6GEPgf97h5LzW1+iheOjwP/HmR62ZPNFDHuen
         7bCHs4e+AWwwNTWU06tCxa7rwMKAwYZiFoAPVok2uW/Jl0swCfxO6/Ti6N3KRms6fW8w
         Sk8WvGECAz8K2PAa17dO8v2OBiz8h4VgHyjJcEhk9OXPlAbGjzHbuZylI+LkHYwqUCAF
         fDymbURitBN/BTfde4774wYUY0lciZxVKKCifXOVjRciMu7kBI3Vg16vig7i1pzwPgEU
         SaL29mPI30j5mQJHst16lPVB7IJG7rRbFVllQzFvidwGi9q29R+2fU6/5qM+XTe2jTzC
         BIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version;
        bh=/lR22JItVYcAEN4FGPywBWFlZb0TSLLrPjU/wXDo3Sc=;
        b=oONq9cdHcy4QBx5DMb8o7JhgApSIBsvdgSRulePSFmxU6y8quLXqC10Wm7c4T0eMrd
         wc63ETxkRSBGjJl0wjA28D5cydS6mEaKx8rKa2XUHy3jJZIdChnTq8fjBtavoUzhLsmk
         jC6VgKPCABu1maKJ6II4AdJ8tv89p9XaRjC4S/OQjTBDQ9063n5mG6vqqWfwpbLcmHg6
         XgY7PKncsehnIY5mf5JojvY0NKSge0EDCK3+SnnU80oUxoC6wdVUIsOMaXvFfUExFiyj
         Q3+cHXuhnEayFrsjWLRiuPfA5uIQ6epqXx32BIHsymQjX/jEKtjS87tAoWOEecbgf90q
         sUvQ==
X-Gm-Message-State: AOAM530P1xIxDNK9zQm91D0xCjR5x6mIHneQUc88EnwY1m7FRgPcPVKC
        1X90YDWgxkAkmSfmBURlkJgggg==
X-Google-Smtp-Source: ABdhPJxIhMh6Tt99l8btGNfMAxGvrSvqDHoIFxZT1KfgzZxoGY7jN/1yrTcDXMQpz3H3+JP2DR428Q==
X-Received: by 2002:aca:758b:: with SMTP id q133mr5035476oic.33.1623211868738;
        Tue, 08 Jun 2021 21:11:08 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 88sm3500044otb.7.2021.06.08.21.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:11:08 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:11:06 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] mm/thp: fix THP splitting unmap BUGs and related
 (fwd)
Message-ID: <f7fc2e72-b8b1-f132-cdb2-1b256a6f2de@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Tue, 8 Jun 2021 20:57:34 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>,
    Kirill A. Shutemov <kirill.shutemov@linux.intel.com>,
    Yang Shi <shy828301@gmail.com>, Wang Yugui <wangyugui@e16-tech.com>,
    Matthew Wilcox <willy@infradead.org>,
    Naoya Horiguchi <naoya.horiguchi@nec.com>,
    Alistair Popple <apopple@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
    Zi Yan <ziy@nvidia.com>, Miaohe Lin <linmiaohe@huawei.com>,
    Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
    Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
    Shakeel Butt <shakeelb@google.com>, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 00/10] mm/thp: fix THP splitting unmap BUGs and related

Here is v2 batch of long-standing THP bug fixes that I had not got
around to sending before, but prompted now by Wang Yugui's report
https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/

Wang Yugui has tested a rollup of these fixes applied to 5.10.39,
and they have done no harm, but have *not* fixed that issue:
something more is needed and I have no idea of what.

But at least these clear up related issues, and should go to stable
(except for the last three).  Some of these are fully reviewed and
tags added, others have been waiting on this v2 respin.

For now I've left out the bigger page_vma_mapped_walk() one (was 5/7):
I'm still working on splitting that up for Kirill's review, better get
the rest out before completing and posting that as a separate series.

2/10 here replaces part of 1/7 before; 7/10 and 8/10 from Yang Shi
inserted; 10/10 added to apply TTU_SYNC in mm/memory-failure.c.

These are against 5.13-rc5: expect mmotm conflicts with a couple of
Alistair Popple's "Add support for SVM atomics in Nouveau" series:
mm-remove-special-swap-entry-functions.patch
mm-rmap-split-try_to_munlock-from-try_to_unmap.patch

Suggested adjustments to Alistair's sent June 3rd, but I've not
rechecked (a couple of changes since v1 should reduce the damage
slightly).

01/10 mm/thp: fix __split_huge_pmd_locked() on shmem migration entry
02/10 mm/thp: make is_huge_zero_pmd() safe and quicker
03/10 mm/thp: try_to_unmap() use TTU_SYNC for safe splitting
04/10 mm/thp: fix vma_address() if virtual address below file offset
05/10 mm/thp: fix page_address_in_vma() on file THP tails
06/10 mm/thp: unmap_mapping_page() to fix THP truncate_cleanup_page()
07/10 mm: thp: replace DEBUG_VM BUG with VM_WARN when unmap fails for split
08/10 mm: rmap: make try_to_unmap() void function
09/10 mm/thp: remap_page() is only needed on anonymous THP
10/10 mm: hwpoison_user_mappings() try_to_unmap() with TTU_SYNC

 include/linux/huge_mm.h |    8 ++++-
 include/linux/mm.h      |    3 ++
 include/linux/rmap.h    |    3 +-
 mm/huge_memory.c        |   61 +++++++++++++++++++++++-------------------
 mm/internal.h           |   51 ++++++++++++++++++++++++++---------
 mm/memory-failure.c     |   17 +++++------
 mm/memory.c             |   40 +++++++++++++++++++++++++++
 mm/page_vma_mapped.c    |   27 +++++++++++-------
 mm/pgtable-generic.c    |    5 +--
 mm/rmap.c               |   38 +++++++++++++++-----------
 mm/truncate.c           |   43 +++++++++++++----------------
 mm/vmscan.c             |    3 +-
 12 files changed, 195 insertions(+), 104 deletions(-)

Hugh

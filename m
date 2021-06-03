Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2018C39AE7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhFCXF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFCXF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:05:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F11EB6140C;
        Thu,  3 Jun 2021 23:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622761436;
        bh=wByxFJxnTm7v9o+6E3GNLvXbUPJPgwB/67F9gWvAVDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NkrdoEWtnPYLNUZLyjrdXKwXShdPr3gw3NC6L5F+XGesj9h8qzYD9feJw6Zuq9pEL
         BSZvlhsCGwgdNSbsZSLmChCZGeRV4V6bDCNKXxEu54BKDRCBLAYWP031EmWQMpW5Io
         GL3peBGdSKhL3NhGgz46dK9/kbDXVVttWSMcUnCQ=
Date:   Thu, 3 Jun 2021 16:03:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] mm/thp: fix THP splitting unmap BUGs and related
Message-Id: <20210603160355.2f73daab711ece5b85f6d82e@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2106031441040.11704@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
        <alpine.LSU.2.11.2106031441040.11704@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 15:21:35 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> And here's my attempt to rewrite history: mmotm-adjust.tar contains
> 
> before/series
> before/mm-remove-special-swap-entry-functions.patch
> before/mm-rmap-split-try_to_munlock-from-try_to_unmap.patch
> before/mm-huge_memoryc-remove-unnecessary-tlb_remove_page_size-for-huge-zero-pmd.patch
> after/series
> after/mm-remove-special-swap-entry-functions.patch
> after/mm-rmap-split-try_to_munlock-from-try_to_unmap.patch
> after/mm-huge_memoryc-remove-unnecessary-tlb_remove_page_size-for-huge-zero-pmd.patch
> 
> "before" contains the originals from mmotm .DATE=2021-06-01-19-57:
> your series file, two patches from Alistair and one from Miaohe, which
> gave rejects when I inserted this 1-7/7 patchset and Yang Shi's 1-2/2
> earlier.  All other patches applied cleanly, but could be refreshed.
> 
> "after" contains my replacements to those: adjusting them to how they
> would have been written if this patchset and Yang Shi's went first
> (and in adjusting some of the comments in Alistair's, I did not
> recognize the reason given for unmap_page() using try_to_unmap()
> on file THPs, so substituted my own explanation).
> 
> As diff'ing the series will show, first thing is to delete the old
> 
> mm-rmap-make-try_to_unmap-void-function-fix-fix.patch
> mm-rmap-make-try_to_unmap-void-function-fix.patch
> mm-rmap-make-try_to_unmap-void-function.patch
> mm-thp-replace-debug_vm-bug-with-vm_warn-when-unmap-fails-for-split.patch
> mm-thp-check-total_mapcount-instead-of-page_mapcount-fix-fix-fix.patch
> 
> Then insert, from the mailing list
> 
> hughd1.patch
> hughd2.patch
> hughd3.patch
> hughd4.patch
> hughd5.patch
> hughd6.patch
> yangshi1.patch
> yangshi2.patch
> hughd7.patch

There have been some significant-appearing review comments coming in on
hughdN.patch just today.

So...  I think I'll pass for now.  How about when the dust has settled
you send out a complete series of the hughd and yahgshi patches against
Linus mainline?


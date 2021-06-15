Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C9E3A7E52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFOMm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFOMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:42:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7AAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xxwRxDnh0VFVSsnf3fNZemBZlcC0v4L/I7gFw2Rsxr0=; b=qQpMlxK0xqbmG70o+ix3Upt+LC
        EHUJjQSjaPIiCOLPWNUqdZS+rtwxovhVzx7paeOOsEQdTI5dGoP9e2ygWsBC05Pf9QQhYRoj3uIE+
        nUkpQYqLikGOMhnf6NvhhJYXl0DzCVcC6492Vg6L5bCVmrweD9zKRzUxQpuctsDSf4Qj3/9VTU42/
        mAFpDRxIm3Yzxrugdu0fqowsCbhU8HsTmAgi66hQAcQi11B1p9/WRUiJwH0FtN1TpLRPpSfUCinuA
        qEIb5nYGxBqxI1SGzzW2kzHRDFTTp0bhnBzx7B3FudymDsHOHaq/yPMA+WxV7E7asgLYh87WJCPKS
        R8dgPQ4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt8Mm-006lyA-PL; Tue, 15 Jun 2021 12:40:32 +0000
Date:   Tue, 15 Jun 2021 13:40:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: page refcount race between prep_compound_gigantic_page() and
 __page_cache_add_speculative()?
Message-ID: <YMifvD723USsnWRH@casper.infradead.org>
References: <CAG48ez23q0Jy9cuVnwAe7t_fdhMk2S7N5Hdi-GLcCeq5bsfLxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez23q0Jy9cuVnwAe7t_fdhMk2S7N5Hdi-GLcCeq5bsfLxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 01:03:53PM +0200, Jann Horn wrote:
> The messier path, as the original commit describes, is "gigantic" page
> allocation. In that case, we'll go through the following path (if we
> ignore CMA):
> 
>   alloc_fresh_huge_page():
>     alloc_gigantic_page()
>       alloc_contig_pages()
>         __alloc_contig_pages()
>           alloc_contig_range()
>             isolate_freepages_range()
>               split_map_pages()
>                 post_alloc_hook() [FOR EVERY PAGE]
>                   set_page_refcounted()
>                     set_page_count(page, 1)
>     prep_compound_gigantic_page()
>       set_page_count(p, 0) [FOR EVERY TAIL PAGE]
> 
> so all the tail pages are initially allocated with refcount 1 by the
> page allocator, and then we overwrite those refcounts with zeroes.
> 
> 
> Luckily, the only non-__init codepath that can get here is
> __nr_hugepages_store_common(), which is only invoked from privileged
> writes to sysfs/sysctls.

Argh.  What if we passed __GFP_COMP into alloc_contig_pages()?
The current callers of alloc_contig_range() do not pass __GFP_COMP,
so it's no behaviour change for them, and __GFP_COMP implies this
kind of behaviour.  I think that would imply _not_ calling
split_map_pages(), which implies not calling post_alloc_hook(),
which means we probably need to do a lot of the parts of
post_alloc_hook() in alloc_gigantic_page().  Yuck.


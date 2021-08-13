Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028213EB6AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbhHMO0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbhHMO0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:26:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1F9C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EYb/9zUimDNR2w9ad52P1RefLWJn4cpBhY0HIgJB8H8=; b=TpP99k5NnxUB/d+6P2Rlg29XNC
        Ef04mLJa7TxZjQPx/SU1CvoztFpDz2TF1EG7jZQcdCjttY7axZtHEKc+QqvGFTEKlqM4OAontYZWt
        IvVCYUjAMALot0VK40Yh4SAlToVdkUpJz40L5l6NMe/W86lIREOLjfSGdSzg3vo5TfGkYuDAdgSfJ
        LG/dMHAI9IPfmOO4suOtYHMTcExe4XzEuFmCP8vLW5MbWYzxWEO5PB5jtmgfxCNOncVm/lWquEUKg
        1kcBoGaaJYLcUrIbylJfE0F6RVp5XDDO85p00iq1l0+Se0VC1FUu4Pc3jr2lYx0Qv2VN5Uuvfvs4c
        OzjSrTUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEY71-00FkUQ-BW; Fri, 13 Aug 2021 14:24:50 +0000
Date:   Fri, 13 Aug 2021 15:24:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        william.kucharski@oracle.com, kirill.shutemov@linux.intel.com,
        dhowells@redhat.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove redundant compound_head() calling
Message-ID: <YRaAq1RUjleXFPid@casper.infradead.org>
References: <20210811101431.83940-1-songmuchun@bytedance.com>
 <808194f6-e5d0-59e4-ffd5-2c77a907232c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <808194f6-e5d0-59e4-ffd5-2c77a907232c@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 04:02:33PM +0200, Vlastimil Babka wrote:
> On 8/11/21 12:14 PM, Muchun Song wrote:
> > There is a READ_ONCE() in the macro of compound_head(), which will
> > prevent compiler from optimizing the code when there are more than
> > once calling of it in a function. Remove the redundant calling of
> > compound_head() from page_to_index() and page_add_file_rmap() for
> > better code generation.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Seems to be compatible with folio/for-next and not made redundant by that (yet?
> didn't check the branches planned for future versions), so OK. But long-term I'd
> expect these optimizations to be obsoleted by the folio work.

Yes, I haven't touched page_add_file_rmap() in my tree yet.  Trying to
keep my focus on page cache instead of working on more generic mm stuff.
Hopefully other people will work on those pieces once the folio work
lands.

Looking at page_add_file_rmap(), it needs someone to think in detail
about what 'compound' means in the context of sub-PMD-sized compound
pages.  I suspect it really means "map_as_pmd".

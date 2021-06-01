Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C785D397BC7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhFAVfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbhFAVfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:35:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14299C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VtQlTRq3lnMUDQP6n+cCL3Pr5EYfmGRzRcuenjvwhbg=; b=jSvFOe6oQvEot8Hy2t2tjZ0oly
        +rAFW4iWTtIqeDktq4WT7ML2dlJCIplA38nSg/xAGJY75rlRjDfLqPbXQrdXnrp0L4LnkpenIQItQ
        cRDow56xi46pK/14vztTUe4E1B4LcEngFPWGqOXgFUL6kNx1eaC7OyXbF3Lxg0JD0cbXsB2SRlS+k
        FOFkai8VEjxQjw7PCuFVE+7Ph6a/TpMfz0V/18nzZ7I4qphlSN5LAddPVzvsB4J5v9pJ6xkLJPw2U
        yys9VKEnH6YavCFZ4wJOD7v69DJ8bRArY2dFpZl0bhAgQqsxtkvo5fOa1mEWf5/3rcYyuuOiVmt3s
        JQk0VzXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1loC0F-00ASGe-N8; Tue, 01 Jun 2021 21:32:50 +0000
Date:   Tue, 1 Jun 2021 22:32:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] mm/thp: fix page_address_in_vma() on file THP tails
Message-ID: <YLanf/fmB2D5B1Ew@casper.infradead.org>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011409390.2148@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106011409390.2148@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 02:11:22PM -0700, Hugh Dickins wrote:
> From: Jue Wang <juew@google.com>
> 
> Anon THP tails were already supported, but memory-failure may need to use
> page_address_in_vma() on file THP tails, which its page->mapping check did
> not permit: fix it.
> 
> hughd adds: no current usage is known to hit the issue, but this does fix
> a subtle trap in a general helper: best fixed in stable sooner than later.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Signed-off-by: Jue Wang <juew@google.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

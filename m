Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7113C7147
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhGMNh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhGMNhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:37:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D4C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZA1DadVLZD9AXCRqiJYuLnFt7xfm1nC1fZG/MI97rdM=; b=HriJ5bDBCfYBYTVSac9JD4q1xz
        0vElAdekSpQqBF8NY1bpD6ZVjsRGrX6nHyEZhAayovdMJTQg9Eo254iWVQXLyF2vMGxzvQ9GSV3mI
        j3tpqg3TTvwD1Cy5khcA9YFL5DZlPBEi890JPIC1Myi0cgKioerdCaG2FyPqDu7vrAiLdLbr3zYGb
        a/EIgnfOzvX/2HoiKnIYuP/Ebq8lGSD+YabVi06wepWRD6Y/dngXef8Y+JTuIJhemSm+Ap+CxRLww
        RcdjCznkOeDFs1+jpEjTK6clBBSTuGxQC8b3c3jR5nf6AGFP7zpWG0hXy0RDIiUXtanyQf3v9n1dF
        sDLmLiWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3IY7-0018fv-GO; Tue, 13 Jul 2021 13:34:16 +0000
Date:   Tue, 13 Jul 2021 14:34:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, vbabka@suse.cz, axboe@kernel.dk,
        iamjoonsoo.kim@lge.com, alexs@kernel.org, apopple@nvidia.com,
        minchan@kernel.org, david@redhat.com, shli@fb.com,
        hillf.zj@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
Message-ID: <YO2WUx0a5go71Vhm@casper.infradead.org>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-2-linmiaohe@huawei.com>
 <YOvtmy9ggJA4KUIQ@dhcp22.suse.cz>
 <9409189e-44f7-2608-68af-851629b6d453@huawei.com>
 <YO1dGvcTLaRJplRQ@dhcp22.suse.cz>
 <ec86d902-1da5-2f49-7324-a796d32ac979@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec86d902-1da5-2f49-7324-a796d32ac979@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 09:13:51PM +0800, Miaohe Lin wrote:
> >> When the MADV_FREE pages are redirtied before they could be reclaimed, the pages
> >> should be put back to anonymous LRU list by setting SwapBacked flag, thus the
> >> pages will be reclaimed in normal swapout way.
> > 
> > Agreed. But the question is why this needs an explicit handling here
> > when we already do handle this case when trying to unmap the page.
> 
> This makes me think more. It seems even the page_ref_freeze call is guaranteed to
> success as no one can grab the page refcnt after the page is successfully unmapped.

NO!  This is wrong.  Every page can have its refcount speculatively raised
(and then lowered).  The two prime candidates for this are lockless GUP
and page cache lookups, but there can be others too.


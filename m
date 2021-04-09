Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12053359452
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhDIFHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:07:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:35732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233187AbhDIFG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:06:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B480BAEE5;
        Fri,  9 Apr 2021 05:06:45 +0000 (UTC)
Date:   Fri, 9 Apr 2021 07:06:43 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, weixugc@google.com,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return
 nr_succeeded
Message-ID: <YG/g49rCrId0ALra@localhost.localdomain>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183223.80F1E291@viggo.jf.intel.com>
 <YG7XjTG9tiK29y1j@localhost.localdomain>
 <CAHbLzkqoaSnuBJMAe_heQt01FuPWODYQHJ955gaJNNojwbUjrw@mail.gmail.com>
 <YG9IthpDC/lri4Qh@localhost.localdomain>
 <CAHbLzkqt0_xM=rAaNiSwKn=kY=wmWiFe3N+CEuqH_ryU-o1ysQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqt0_xM=rAaNiSwKn=kY=wmWiFe3N+CEuqH_ryU-o1ysQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:40:33PM -0700, Yang Shi wrote:
> Thanks a lot for the example code. You didn't miss anything. At first
> glance, I thought your suggestion seemed neater. Actually I
> misunderstood what Dave said about "That could really have caused some
> interesting problems." with multiple calls to migrate_pages(). I was
> thinking about:
> 
> unsigned long foo()
> {
>     unsigned long *ret_succeeded;
> 
>     migrate_pages(..., ret_succeeded);
> 
>     migrate_pages(..., ret_succeeded);
> 
>     return *ret_succeeded;
> }

But that would not be a problem as well. I mean I am not sure what is
foo() supposed to do.
I assume is supposed to return the *total* number of pages that were
migrated?

Then could do something like:

 unsigned long foo()
 {
     unsigned long ret_succeeded;
     unsigned long total_succeeded = 0;

     migrate_pages(..., &ret_succeeded);
     total_succeeded += ret_succeeded;

     migrate_pages(..., &ret_succeeded);
     total_succeeded += ret_succeeded;

     return *total_succeeded;
 }

 But AFAICS, you would have to do that with Wei Xu's version and with
 mine, no difference there.

IIUC, Dave's concern was that nr_succeeded was only set to 0 at the beginning
of the function, and never reset back, which means, we would carry the
sum of previous nr_succeeded instead of the nr_succeeded in that round.
That would be misleading for e.g: reclaim in case we were to call
migrate_pages() several times, as instead of a delta value, nr_succeeded
would accumulate.

But that won't happen neither with Wei Xu's version nor with mine. 

-- 
Oscar Salvador
SUSE L3

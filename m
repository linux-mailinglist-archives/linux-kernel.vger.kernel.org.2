Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744A433A8A8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhCNWxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCNWxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:53:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EDAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A0OezzK32+IGjKBiA324CA3NskKswq6TgwFHq4vAqF8=; b=aEp6MWbOmqGVvlG0u2hf6+NaMl
        Sv10jZkYI/dk7hQ5OIg5Wk1aiQTyIDTSr5mg+qtD7tLG/837fWSHUN6hhi3FqHVHMUBDO1mBd6nQb
        O5c5ggX9enZQLtbICYRWgFMduJ61jHQ3G7BmEOsHpoQm/jxEHyDOcxkTFaCa/baMNIjelrJKqDqJ1
        cxaY78mu9xEjPJouhGMOmQhY6zZ94sNF6W9TVmcWjNHkLL4lCppQr16xQdt+ct50dKcnt6IqgQ54j
        hZK6DnEdCP9PXfJX/929SrczT7GhXZV2EqWtgIaLk7DDjEWZFRNb4pncbQxmHv2rzlwvGtj/VN0Ng
        hXiHggTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLZZf-00Gm6m-Us; Sun, 14 Mar 2021 22:51:07 +0000
Date:   Sun, 14 Mar 2021 22:51:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 06/14] mm, x86: support the access bit on non-leaf PMD
 entries
Message-ID: <20210314225103.GQ2577561@casper.infradead.org>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-7-yuzhao@google.com>
 <74C83FFE-DC78-40CD-B6BE-00614DC8F125@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74C83FFE-DC78-40CD-B6BE-00614DC8F125@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 06:12:42PM -0400, Zi Yan wrote:
> On 13 Mar 2021, at 2:57, Yu Zhao wrote:
> 
> > Some architectures support the accessed bit on non-leaf PMD entries
> > (parents) in addition to leaf PTE entries (children) where pages are
> > mapped, e.g., x86_64 sets the accessed bit on a parent when using it
> > as part of linear-address translation [1]. Page table walkers who are
> > interested in the accessed bit on children can take advantage of this:
> > they do not need to search the children when the accessed bit is not
> > set on a parent, given that they have previously cleared the accessed
> > bit on this parent in addition to its children.
> >
> > [1]: Intel 64 and IA-32 Architectures Software Developer's Manual
> >      Volume 3 (October 2019), section 4.8
> 
> Just curious. Does this also apply to non-leaf PUD entries? Do you
> mind sharing which sentence from the manual gives the information?

The first few sentences from 4.8:

: For any paging-structure entry that is used during linear-address
: translation, bit 5 is the accessed flag. For paging-structure
: entries that map a page (as opposed to referencing another paging
: structure), bit 6 is the dirty flag. These flags are provided for
: use by memory-management software to manage the transfer of pages and
: paging structures into and out of physical memory.

: Whenever the processor uses a paging-structure entry as part of
: linear-address translation, it sets the accessed flag in that entry
: (if it is not already set).

The way they differentiate between the A and D bits makes it clear to
me that the A bit is set at each level of the tree, but the D bit is
only set on leaf entries.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB894462FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 12:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhKELwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 07:52:46 -0400
Received: from out1.migadu.com ([91.121.223.63]:55991 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhKELwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:52:45 -0400
Date:   Fri, 5 Nov 2021 20:49:54 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636113004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=PstElwx1eHISZknSHtmk0mKL3v3w5arvXKrkYvDW1AA=;
        b=oa9juKgR5gf24x1lNqNPzbpYlKMamJvPc5ehAtL+FdcVMCrIdMPG4JAyNMT+EbAL6o6A86
        factHVWknALHVa2daYZdj3NK3ikQ7VbvnufWo34/YgOOtFAj08nTH1ivGJ9JCWlfxUf+50
        RKoUN68yCgm3EnDGrAavu2UcdHVUqKI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     David Hildenbrand <david@redhat.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] mm/hwpoison: fix unpoison_memory()
Message-ID: <20211105114954.GA3163106@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6935141-3aeb-540d-afb8-292051166a82@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 11:58:15AM +0100, David Hildenbrand wrote:
> On 05.11.21 06:50, Naoya Horiguchi wrote:
> > Hi,
> > 
> > I updated the unpoison patchset based ou discussions over v2.
> > Please see individual patches for details of updates.
> > 
> > ----- (cover letter copied from v2) -----
> > Main purpose of this series is to sync unpoison code to recent changes
> > around how hwpoison code takes page refcount.  Unpoison should work or
> > simply fail (without crash) if impossible.
> > 
> > The recent works of keeping hwpoison pages in shmem pagecache introduce
> > a new state of hwpoisoned pages, but unpoison for such pages is not
> > supported yet with this series.
> > 
> > It seems that soft-offline and unpoison can be used as general purpose
> > page offline/online mechanism (not in the context of memory error).
> 
> I'm not sure what the target use case would be TBH ... for proper memory
> offlining/memory hotunplug we have to offline whole memory blocks. For
> memory ballooning based mechanisms we simply allocate random free pages
> and eventually trigger reclaim to make more random free pages available.
> For memory hotunplug via virtio-mem we're using alloc_contig_range() to
> allocate ranges of interest we logically unplug.

I heard about it from two people independently and I think that that's maybe
a rough idea, so if no one shows the clear use case or someone logically
shows that we don't need it, I do not head for it.

> 
> The only benefit compared to alloc_contig_range() might be that we can
> offline smaller chunks -- alloc_contig_range() isn't optimized for
> sub-MAX_ORDER granularity yet. But then, alloc_contig_range() should
> much rather be extended.

If alloc_contig_range() supports memory offline in arbitrary size of
granurality (including a single page), maybe soft offline can be (partially
I guess) unified to it.

Thanks,
Naoya Horiguchi

> 
> Long story short, I'm not sure there is a sane use case for this
> "general purpose page offline/online mechanism" ...


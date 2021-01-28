Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F56306D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 06:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhA1FxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 00:53:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:37214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhA1FxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 00:53:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C450FAB92;
        Thu, 28 Jan 2021 05:52:24 +0000 (UTC)
Date:   Thu, 28 Jan 2021 06:52:21 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/5] hugetlb: only set HPageMigratable for migratable
 hstates
Message-ID: <20210128055221.GA3166@localhost.localdomain>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-4-mike.kravetz@oracle.com>
 <20210127103523.GI827@dhcp22.suse.cz>
 <2196d93e-f573-7163-183e-0ad2cec7555e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2196d93e-f573-7163-183e-0ad2cec7555e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 03:36:41PM -0800, Mike Kravetz wrote:
> Yes, this patch is somewhat optional.  It should be a minor improvement
> in cases where we are dealing with hpages in a non-migratable hstate.
> Although, I do not believe this is the common case.
> 
> The real reason for even looking into this was a comment by Oscar.  With
> the name change to HPageMigratable, it implies that the page is migratable.
> However, this is not the case if the page's hstate does not support migration.
> So, if we check the hstate when setting the flag we can eliminate those
> cases where the page is certainly not migratable.
> 
> I don't really love this patch.  It has minimal functional value.
> 
> Oscar, what do you think about dropping this?

Yeah, I remember this topic arose during a discussion of patch#2 in the
early versions, about whether the renaming to HPageMigratable made
sense.

Back then I thought that we could have this in one place at fault-path [1],
which should have made this prettier, but it is not the case.
True is that the optimization is little, so I am fine with dropping this
patch.

unmap_and_move_huge_page() fences off pages belonging to non-migratable
hstates.

[1] https://patchwork.kernel.org/project/linux-mm/patch/20210120013049.311822-3-mike.kravetz@oracle.com/#23914033

Thanks

-- 
Oscar Salvador
SUSE L3

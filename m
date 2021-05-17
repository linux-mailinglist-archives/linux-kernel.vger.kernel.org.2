Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E8B383781
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbhEQPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:44:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:41048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244839AbhEQP2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:28:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F64FB038;
        Mon, 17 May 2021 15:27:23 +0000 (UTC)
Date:   Mon, 17 May 2021 16:27:21 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Yang Shi <shy828301@gmail.com>
Cc:     kirill.shutemov@linux.intel.com, ziy@nvidia.com, mhocko@suse.com,
        ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 3/7] mm: thp: refactor NUMA fault handling
Message-ID: <20210517152721.GW3672@suse.de>
References: <20210413212416.3273-1-shy828301@gmail.com>
 <20210413212416.3273-4-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210413212416.3273-4-shy828301@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:24:12PM -0700, Yang Shi wrote:
> When the THP NUMA fault support was added THP migration was not supported yet.
> So the ad hoc THP migration was implemented in NUMA fault handling.  Since v4.14
> THP migration has been supported so it doesn't make too much sense to still keep
> another THP migration implementation rather than using the generic migration
> code.
> 
> This patch reworked the NUMA fault handling to use generic migration implementation
> to migrate misplaced page.  There is no functional change.
> 
> After the refactor the flow of NUMA fault handling looks just like its
> PTE counterpart:
>   Acquire ptl
>   Prepare for migration (elevate page refcount)
>   Release ptl
>   Isolate page from lru and elevate page refcount
>   Migrate the misplaced THP
> 
> If migration is failed just restore the old normal PMD.
> 
> In the old code anon_vma lock was needed to serialize THP migration
> against THP split, but since then the THP code has been reworked a lot,
> it seems anon_vma lock is not required anymore to avoid the race.
> 
> The page refcount elevation when holding ptl should prevent from THP
> split.
> 
> Use migrate_misplaced_page() for both base page and THP NUMA hinting
> fault and remove all the dead and duplicate code.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

I did not spot any big problems and FWIW, the series overall passed a
series of tests that exercise NUMA balancing migrations so...

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs

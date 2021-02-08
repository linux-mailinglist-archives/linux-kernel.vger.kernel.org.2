Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D59F3129D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 05:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBHEle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 23:41:34 -0500
Received: from foss.arm.com ([217.140.110.172]:56100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhBHEk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 23:40:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D80131B;
        Sun,  7 Feb 2021 20:40:11 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60FB63F719;
        Sun,  7 Feb 2021 20:40:05 -0800 (PST)
Subject: Re: [RFC 0/3] mm/page_alloc: Fix pageblock_order with
 HUGETLB_PAGE_SIZE_VARIABLE
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
References: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4e90b823-0f36-3dc6-fd00-e5ba27590550@arm.com>
Date:   Mon, 8 Feb 2021 10:10:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/21 12:31 PM, Anshuman Khandual wrote:
> The following warning gets triggered while trying to boot a 64K page size
> without THP config kernel on arm64 platform.
> 
> WARNING: CPU: 5 PID: 124 at mm/vmstat.c:1080 __fragmentation_index+0xa4/0xc0
> Modules linked in:
> CPU: 5 PID: 124 Comm: kswapd0 Not tainted 5.11.0-rc6-00004-ga0ea7d62002 #159
> Hardware name: linux,dummy-virt (DT)
> [    8.810673] pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
> [    8.811732] pc : __fragmentation_index+0xa4/0xc0
> [    8.812555] lr : fragmentation_index+0xf8/0x138
> [    8.813360] sp : ffff0000864079b0
> [    8.813958] x29: ffff0000864079b0 x28: 0000000000000372
> [    8.814901] x27: 0000000000007682 x26: ffff8000135b3948
> [    8.815847] x25: 1fffe00010c80f48 x24: 0000000000000000
> [    8.816805] x23: 0000000000000000 x22: 000000000000000d
> [    8.817764] x21: 0000000000000030 x20: ffff0005ffcb4d58
> [    8.818712] x19: 000000000000000b x18: 0000000000000000
> [    8.819656] x17: 0000000000000000 x16: 0000000000000000
> [    8.820613] x15: 0000000000000000 x14: ffff8000114c6258
> [    8.821560] x13: ffff6000bff969ba x12: 1fffe000bff969b9
> [    8.822514] x11: 1fffe000bff969b9 x10: ffff6000bff969b9
> [    8.823461] x9 : dfff800000000000 x8 : ffff0005ffcb4dcf
> [    8.824415] x7 : 0000000000000001 x6 : 0000000041b58ab3
> [    8.825359] x5 : ffff600010c80f48 x4 : dfff800000000000
> [    8.826313] x3 : ffff8000102be670 x2 : 0000000000000007
> [    8.827259] x1 : ffff000086407a60 x0 : 000000000000000d
> [    8.828218] Call trace:
> [    8.828667]  __fragmentation_index+0xa4/0xc0
> [    8.829436]  fragmentation_index+0xf8/0x138
> [    8.830194]  compaction_suitable+0x98/0xb8
> [    8.830934]  wakeup_kcompactd+0xdc/0x128
> [    8.831640]  balance_pgdat+0x71c/0x7a0
> [    8.832327]  kswapd+0x31c/0x520
> [    8.832902]  kthread+0x224/0x230
> [    8.833491]  ret_from_fork+0x10/0x30
> [    8.834150] ---[ end trace 472836f79c15516b ]---
> 
> This warning comes from __fragmentation_index() when the requested order
> is greater than MAX_ORDER.
> 
> static int __fragmentation_index(unsigned int order,
> 				 struct contig_page_info *info)
> {
>         unsigned long requested = 1UL << order;
> 
>         if (WARN_ON_ONCE(order >= MAX_ORDER)) <===== Triggered here
>                 return 0;
> 
> Digging it further reveals that pageblock_order has been assigned a value
> which is greater than MAX_ORDER failing the above check. But why this
> happened ? Because HUGETLB_PAGE_ORDER for the given config on arm64 is
> greater than MAX_ORDER.
> 
> The solution involves enabling HUGETLB_PAGE_SIZE_VARIABLE which would make
> pageblock_order a variable instead of constant HUGETLB_PAGE_ORDER. But that
> change alone also did not really work as pageblock_order still got assigned
> as HUGETLB_PAGE_ORDER in set_pageblock_order(). HUGETLB_PAGE_ORDER needs to
> be less than MAX_ORDER for its appropriateness as pageblock_order otherwise
> just fallback to MAX_ORDER - 1 as before. While here it also fixes a build
> problem via type casting MAX_ORDER in rmem_cma_setup().
> 
> This series applies in v5.11-rc6 and has been slightly tested on arm64. But
> looking for some early feedbacks particularly with respect to concerns in
> subscribing HUGETLB_PAGE_SIZE_VARIABLE on a platform where the hugetlb page
> size is config dependent but not really a runtime variable. Even though it
> appears that HUGETLB_PAGE_SIZE_VARIABLE is used only while computing the
> pageblock_order, could there be other implications ?
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Probably missed some more folks, adding them here.

+ Michal Hocko <mhocko@kernel.org>
+ Vlastimil Babka <vbabka@suse.cz>
+ Mike Kravetz <mike.kravetz@oracle.com>
+ Matthew Wilcox <willy@infradead.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0B38C0B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhEUH0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:26:49 -0400
Received: from foss.arm.com ([217.140.110.172]:40262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbhEUH0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:26:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D747511B3;
        Fri, 21 May 2021 00:25:25 -0700 (PDT)
Received: from [10.163.81.51] (unknown [10.163.81.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECC053F73D;
        Fri, 21 May 2021 00:25:21 -0700 (PDT)
Subject: Re: [PATCH v2] mm: migrate: fix missing update page_private to
 hugetlb_page_subpool
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mike.kravetz@oracle.com, mhocko@suse.com,
        david@redhat.com, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, zhengqi.arch@bytedance.com,
        fam.zheng@bytedance.com, Randy Dunlap <rdunlap@infradead.org>
References: <20210521022747.35736-1-songmuchun@bytedance.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c528e29d-c395-1651-4943-27642b9e5168@arm.com>
Date:   Fri, 21 May 2021 12:56:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210521022747.35736-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 7:57 AM, Muchun Song wrote:
> Since commit d6995da31122 ("hugetlb: use page.private for hugetlb specific
> page flags") converts page.private for hugetlb specific page flags. We
> should use hugetlb_page_subpool() to get the subpool pointer instead of
> page_private().
> 
> This 'could' prevent the migration of hugetlb pages. page_private(hpage)
> is now used for hugetlb page specific flags.  At migration time, the
> only flag which could be set is HPageVmemmapOptimized.  This flag will
> only be set if the new vmemmap reduction feature is enabled.  In
> addition, !page_mapping() implies an anonymous mapping.  So, this will
> prevent migration of hugetb pages in anonymous mappings if the vmemmap
> reduction feature is enabled.
> 
> In addition, that if statement checked for the rare race condition of a
> page being migrated while in the process of being freed.  Since that
> check is now wrong, we could leak hugetlb subpool usage counts.
> 
> The commit forgot to update it in the page migration routine. So fix it.
> 
> Fixes: d6995da31122 ("hugetlb: use page.private for hugetlb specific page flags")
> Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Tested on all page size configs and HugeTLB migrations work as expected.

Tested-by: Anshuman Khandual <anshuman.khandual@arm.com> #arm64

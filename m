Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57AE36D0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 05:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhD1DJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 23:09:58 -0400
Received: from foss.arm.com ([217.140.110.172]:59868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhD1DJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 23:09:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47FE41FB;
        Tue, 27 Apr 2021 20:09:13 -0700 (PDT)
Received: from [10.163.76.81] (unknown [10.163.76.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3E03F694;
        Tue, 27 Apr 2021 20:09:08 -0700 (PDT)
Subject: Re: [PATCH 0/5] Cleanup and fixup for huge_memory
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, william.kucharski@oracle.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
        rcampbell@nvidia.com, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, riel@surriel.com,
        hannes@cmpxchg.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210427133214.2270207-1-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1d86c821-89f6-cc46-ceb4-fac7748212e5@arm.com>
Date:   Wed, 28 Apr 2021 08:40:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210427133214.2270207-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/21 7:02 PM, Miaohe Lin wrote:
> Hi all,
> This series contains cleanups to remove dedicated macro and remove
> unnecessary tlb_remove_page_size() for huge zero pmd. Also this adds
> missing read-only THP checking for transparent_hugepage_enabled() and
> avoids discarding hugepage if other processes are mapping it. More
> details can be found in the respective changelogs. Thanks!
> 
> Miaohe Lin (5):
>   mm/huge_memory.c: remove dedicated macro HPAGE_CACHE_INDEX_MASK
>   mm/huge_memory.c: use page->deferred_list
>   mm/huge_memory.c: add missing read-only THP checking in
>     transparent_hugepage_enabled()
>   mm/huge_memory.c: remove unnecessary tlb_remove_page_size() for huge
>     zero pmd
>   mm/huge_memory.c: don't discard hugepage if other processes are
>     mapping it

I guess it might be just better to split the series into cleans-ups
without functional change and then fixes separately.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B22932F80A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 04:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCFDTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 22:19:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12702 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCFDSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 22:18:48 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DsqWg6ZtSzlT1B;
        Sat,  6 Mar 2021 11:16:31 +0800 (CST)
Received: from [10.174.179.20] (10.174.179.20) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Sat, 6 Mar 2021 11:18:39 +0800
Subject: Re: [PATCH 4/5] khugepaged: remove unnecessary mem_cgroup_uncharge()
 in collapse_[file|huge_page]
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>, <riel@redhat.com>,
        <kirill.shutemov@linux.intel.com>, <ebru.akagunduz@gmail.com>,
        <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210304123013.23560-1-linmiaohe@huawei.com>
 <20210304123013.23560-5-linmiaohe@huawei.com>
 <20210305173809.ufg6rfgmvgbvwxih@box>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <06f49699-6657-30f1-292d-b3d94d35d9f6@huawei.com>
Date:   Sat, 6 Mar 2021 11:18:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210305173809.ufg6rfgmvgbvwxih@box>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.20]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/6 1:38, Kirill A. Shutemov wrote:
> On Thu, Mar 04, 2021 at 07:30:12AM -0500, Miaohe Lin wrote:
>> Since commit 7ae88534cdd9 ("mm: move mem_cgroup_uncharge out of
>> __page_cache_release()"), the mem_cgroup will be uncharged when hpage is
>> freed. Uncharge mem_cgroup here is harmless but it looks confusing and
>> buggy: if mem_cgroup charge failed, we will call mem_cgroup_uncharge()
>> uncorrectly in error path because hpage is not IS_ERR_OR_NULL().
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Hm. I'm not sure about this patch.
> 
> For !NUMA the page will get allocated and freed very early: in
> khugepaged_do_scan() and with the change mem_cgroup_charge() may get
> called twice for two different mm_structs.

Many thanks for point it out.

> > Is it safe?

I'am sorry I missed the !NUMA case! :(

In !NUMA case, hpage may not be freed in the khugepaged_do_scan() while loop. Thus mem_cgroup_charge()
may get called twice for two different mm_structs. In fact, mem_cgroup_uncharge() may also get called
twice __but__ it's safe to do this.

The imbalance of mem_cgroup_charge() and mem_cgroup_uncharge() looks buggy and weird __but__ it's safe
to call mem_cgroup_uncharge() many times with or without a successful mem_cgroup_charge() call.
So I would drop this patch.

> 

Thanks again.

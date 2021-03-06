Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1732F7E7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 03:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCFCpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 21:45:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13131 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCFCog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 21:44:36 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dspmn6NrHz16GZ5;
        Sat,  6 Mar 2021 10:42:49 +0800 (CST)
Received: from [10.174.179.20] (10.174.179.20) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 6 Mar 2021 10:44:29 +0800
Subject: Re: [PATCH 0/5] Cleanup and fixup for khugepaged
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>, <riel@redhat.com>,
        <kirill.shutemov@linux.intel.com>, <ebru.akagunduz@gmail.com>,
        <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210304123013.23560-1-linmiaohe@huawei.com>
 <20210305174009.ugxpn223j7aoi4bc@box>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d3bca0bf-0d0c-f40a-5a12-33ab6d333ca3@huawei.com>
Date:   Sat, 6 Mar 2021 10:44:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210305174009.ugxpn223j7aoi4bc@box>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.20]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/6 1:40, Kirill A. Shutemov wrote:
> On Thu, Mar 04, 2021 at 07:30:08AM -0500, Miaohe Lin wrote:
>> Hi all,
>> This series contains cleanups to remove unneeded return value, use
>> helper function and so on. And there is one fix to correct the wrong
>> result value for trace_mm_collapse_huge_page_isolate().
>>
>> More details can be found in the respective changelogs. Thanks!
>>
>> Miaohe Lin (5):
>>   khugepaged: remove unneeded return value of
>>     khugepaged_collapse_pte_mapped_thps()
>>   khugepaged: reuse the smp_wmb() inside __SetPageUptodate()
>>   khugepaged: use helper khugepaged_test_exit() in __khugepaged_enter()
>>   khugepaged: remove unnecessary mem_cgroup_uncharge() in
>>     collapse_[file|huge_page]
>>   khugepaged: fix wrong result value for
>>     trace_mm_collapse_huge_page_isolate()
>>
>>  mm/khugepaged.c | 47 ++++++++++++++++++++---------------------------
>>  1 file changed, 20 insertions(+), 27 deletions(-)
> 
> Apart from patch 4/5, looks fine. For the rest, you can use:
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Many thanks for review and ack! :)

> 


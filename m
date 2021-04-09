Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF335959A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhDIGgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:36:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16494 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbhDIGgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:36:20 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGpH05ts5zPpXF;
        Fri,  9 Apr 2021 14:33:16 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 14:36:04 +0800
Subject: Re: [PATCH 3/4] mm/hugeltb: fix potential wrong gbl_reserve value for
 hugetlb_acct_memory()
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <n-horiguchi@ah.jp.nec.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-4-linmiaohe@huawei.com>
 <20afccd5-2bc4-9db9-695e-dd6175b0b42b@oracle.com>
 <1311fcfe-bc5f-e878-3912-ca9a9e0eed90@huawei.com>
 <ecd3e4c9-1add-c304-5f26-7e34e5e6494c@oracle.com>
 <ddec1fba-25ea-ebb3-fb87-41671db5cb92@huawei.com>
 <0ebaa062-80e8-b380-c02e-7eb72e67f973@huawei.com>
 <90188b1a-a206-5586-2da9-683f7537f960@oracle.com>
 <8dfe32a3-1789-6a40-b650-304c2cfb6531@huawei.com>
 <83e5f2a0-bf92-ab42-c5ff-52a07eab9ee8@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b3658faa-ed18-2421-9960-df732f7a59cc@huawei.com>
Date:   Fri, 9 Apr 2021 14:36:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <83e5f2a0-bf92-ab42-c5ff-52a07eab9ee8@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/9 12:37, Mike Kravetz wrote:
> On 4/8/21 8:01 PM, Miaohe Lin wrote:
>> On 2021/4/9 6:53, Mike Kravetz wrote:
>>>
>>> Yes, add a comment to hugetlb_unreserve_pages saying that !resv_map
>>> implies freed == 0.
>>>
>>
>> Sounds good!
>>
>>> It would also be helpful to check for (chg - freed) == 0 and skip the
>>> calls to hugepage_subpool_put_pages() and hugetlb_acct_memory().  Both
>>> of those routines may perform an unnecessary lock/unlock cycle in this
>>> case.
>>>
>>> A simple
>>> 	if (chg == free)
>>> 		return 0;
>>> before the call to hugepage_subpool_put_pages would work.
>>
>> This may not be really helpful because hugepage_subpool_put_pages() and hugetlb_acct_memory()
>> both would handle delta == 0 case without unnecessary lock/unlock cycle.
>> Does this make sense for you? If so, I will prepare v2 with the changes to add a comment
>> to hugetlb_unreserve_pages() __without__ the check for (chg - freed) == 0.
> 
> Sorry, I forgot about the recent changes to check for delta == 0.
> No need for the check here, just the comment.
> 

That's all right. Will add the comment in V2.
Thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E163A8DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhFPAnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:43:20 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:30706 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhFPAnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:43:14 -0400
Received: from [0.0.0.0] (unknown [116.24.56.76])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 944CEE0193;
        Wed, 16 Jun 2021 08:41:04 +0800 (CST)
Subject: Re: [PATCH v1 2/6] mm/hwpoison: remove race consideration
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
 <20210614021212.223326-3-nao.horiguchi@gmail.com>
 <25c69dc8-0ce2-8330-dfb0-506481dc9a53@sangfor.com.cn>
 <20210616001141.GA1924716@hori.linux.bs1.fc.nec.co.jp>
From:   Ding Hui <dinghui@sangfor.com.cn>
Message-ID: <7b8f576b-b61b-ad68-c84b-476c96f89156@sangfor.com.cn>
Date:   Wed, 16 Jun 2021 08:40:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616001141.GA1924716@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQh1JGFYeTU4dTx5PQ0hPGktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6Qgw4HT8LTk8QKkw2EwI3
        KxgwFENVSlVKTUlIQ0tPS01MSENCVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSk1VSU9VTk1VTE1ZV1kIAVlBSEJCQjcG
X-HM-Tid: 0a7a1243bd0f2c17kusn944cee0193
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/16 8:11, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Jun 15, 2021 at 08:57:06PM +0800, Ding Hui wrote:
>> On 2021/6/14 10:12, Naoya Horiguchi wrote:
>>> @@ -1956,17 +1938,6 @@ int unpoison_memory(unsigned long pfn)
>>>    		goto unlock_mutex;
>>>    	}
>>> -	/*
>>> -	 * unpoison_memory() can encounter thp only when the thp is being
>>> -	 * worked by memory_failure() and the page lock is not held yet.
>>> -	 * In such case, we yield to memory_failure() and make unpoison fail.
>>> -	 */
>>> -	if (!PageHuge(page) && PageTransHuge(page)) {
>>> -		unpoison_pr_info("Unpoison: Memory failure is now running on %#lx\n",
>>> -				 pfn, &unpoison_rs);
>>> -		goto unlock_mutex;
>>> -	}
>>> -
>>
>> if a huge page is in process of alloc or free, HUGETLB_PAGE_DTOR can be set
>> after __SetPageHead() or be cleared before __ClearPageHead(), so this
>> condition may be true in racy.
> 
> Hi Ding,
> 
> We confirm PageHWPoison() before reaching this if-block and hwpoisoned pages
> are prohibited from allocation, so it seems to me that this check never
> races with hugetlb allocation.
> 
> And according to the original patch introduced this if-block (0cea3fdc416d:
> "mm/hwpoison: fix race against poison thp"), this if-block intended to close
> the race between memory_failure() and unpoison_memory(), so that's no longer
> necessary due to mf_mutex.
> 

I got it and thanks for your explanation.

>> Do we need the racy test for this situation?
> 
> I'm not sure, but I think that we need more stress/fuzz testing focusing on
> this subsystem, and "unpoison vs allocation" race can be covered in the topic.
> 
> Thank you,
> Naoya Horiguchi
> 


-- 
Thanks,
- Ding Hui

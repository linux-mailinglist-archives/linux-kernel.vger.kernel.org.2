Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860E23A7E84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFOM7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:59:19 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:48084 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFOM7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:59:18 -0400
Received: from [0.0.0.0] (unknown [116.24.56.76])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 2A0CFE03EC;
        Tue, 15 Jun 2021 20:57:10 +0800 (CST)
Subject: Re: [PATCH v1 2/6] mm/hwpoison: remove race consideration
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
 <20210614021212.223326-3-nao.horiguchi@gmail.com>
From:   Ding Hui <dinghui@sangfor.com.cn>
Message-ID: <25c69dc8-0ce2-8330-dfb0-506481dc9a53@sangfor.com.cn>
Date:   Tue, 15 Jun 2021 20:57:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614021212.223326-3-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGU0fTlZIT0MdSBpPQ0hPTUNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxA6Qxw4Kz8KK0hDTxY#PCxK
        GjQKFEpVSlVKTUlITE1KQ0hKTE5DVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSk1VSU9VTk1VTE1ZV1kIAVlBSUxCSjcG
X-HM-Tid: 0a7a0fbf46472c17kusn2a0cfe03ec
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/14 10:12, Naoya Horiguchi wrote:
> @@ -1956,17 +1938,6 @@ int unpoison_memory(unsigned long pfn)
>   		goto unlock_mutex;
>   	}
>   
> -	/*
> -	 * unpoison_memory() can encounter thp only when the thp is being
> -	 * worked by memory_failure() and the page lock is not held yet.
> -	 * In such case, we yield to memory_failure() and make unpoison fail.
> -	 */
> -	if (!PageHuge(page) && PageTransHuge(page)) {
> -		unpoison_pr_info("Unpoison: Memory failure is now running on %#lx\n",
> -				 pfn, &unpoison_rs);
> -		goto unlock_mutex;
> -	}
> -

if a huge page is in process of alloc or free, HUGETLB_PAGE_DTOR can be 
set after __SetPageHead() or be cleared before __ClearPageHead(), so 
this condition may be true in racy.

Do we need the racy test for this situation?

>   	if (!get_hwpoison_page(p, flags)) {
>   		if (TestClearPageHWPoison(p))
>   			num_poisoned_pages_dec();
-- 
Thanks,
- Ding Hui

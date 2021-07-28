Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C063D8C78
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhG1LIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:08:55 -0400
Received: from mail-m17640.qiye.163.com ([59.111.176.40]:41590 "EHLO
        mail-m17640.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhG1LIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:08:54 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 07:08:54 EDT
Received: from [0.0.0.0] (unknown [119.136.90.116])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id A34FC54056F;
        Wed, 28 Jul 2021 19:00:10 +0800 (CST)
Subject: Re: [PATCH v1 5/6] mm/hwpoison: make some kernel pages handlable
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, mike.kravetz@oracle.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        huangcun@sangfor.com.cn
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
 <20210614021212.223326-6-nao.horiguchi@gmail.com>
From:   Ding Hui <dinghui@sangfor.com.cn>
Message-ID: <271d0f41-0599-9d5d-0555-47189f476243@sangfor.com.cn>
Date:   Wed, 28 Jul 2021 18:59:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614021212.223326-6-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMfGUhWQ0pMHR1LS0tKHR
        hLVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6KRw4Kz9WLTpCLx8ONVZD
        QxJPCglVSlVKTUlMT0xLS0pKTktIVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSkJVSkhNVUJLVUpKTVlXWQgBWUFMT0lCNwY+
X-HM-Tid: 0a7aecc59b13d995kuwsa34fc54056f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/14 10:12, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> HWPoisonHandlable() introduced by patch "mm,hwpoison: fix race with hugetlb
> page allocation" filters error events by page type, and only limited events
> reach get_page_unless_zero() to avoid race >

I want to report a bug which has relationship with "mm,hwpoison: fix 
race with hugetlb page allocation", hugetlb pmd shared and also this patch.

Recently, when test hugetlb and soft offline, I encountered a crash like 
this:
[449901.638605] huge_test[16596]: segfault at 8 ip 00007f5f64c39a12 sp 
00007fff2105c020 error 4 in ld-2.23.so[7f5f64c2a000+26000]
[449901.638612] Code: 48 8d 35 2c 03 01 00 48 8d 3d 31 03 01 00 ba b5 00 
00 00 e8 f0 a5 00 00 53 49 89 fa 89 f6 48 8d 14 76 48 83 ec 10 48 8b 47 
68 <48> 8b 78 08 49 8b 82 f8 00 00 00 48 8b 40 08 4c 8d 04 d0 49 8b 42
[449901.638885] BUG: Bad rss-counter state mm:00000000a1ce68ac idx:0 val:358
[449901.638894] ------------[ cut here ]------------
[449901.638962] BUG: Bad rss-counter state mm:00000000a1ce68ac idx:1 val:26
[449901.638966] BUG: non-zero pgtables_bytes on freeing mm: 28672
[449901.639045] kernel BUG at fs/hugetlbfs/inode.c:443!
[449901.639193] invalid opcode: 0000 [#1] SMP NOPTI

After a few days of digging and reproduce, it turns out that there is a 
mechanism conflict between the get_hwpoison_page() and hugetlb pmd share:

In huge_pmd_unshare(), the page_count is used to determine whether the 
page is shared, it is not safe.

My case is the same page's refcount was increaseed by 
get_hwpoison_page() little before if (page_count(virt_to_page(ptep)) == 
1) in huge_pmd_unshare(), so huge_pmd_unshare() went to wrong branch.

> Actually this is too restictive because get_hwpoison_page always fails
> to take refcount for any types of kernel page, leading to
> MF_MSG_KERNEL_HIGH_ORDER.  This is not critical (no panic), but less
> informative than MF_MSG_SLAB or MF_MSG_PAGETABLE, so extend
> HWPoisonHandlable() to some basic types of kernel pages (slab, pgtable,
> and reserved pages).
> 

After "mm,hwpoison: fix race with hugetlb page allocation"，the 
PageTable(page) is blocked to get_page_unless_zero() due to 
"restictive", this bug is just fixed by side effect.

> The "handling" for these types are still primitive (just taking refcount
> and setting PG_hwpoison) and some more aggressive actions for memory
> error containment are possible and wanted.  But compared to the older code,
> these cases never enter the code block of page locks (note that
> page locks is not well-defined on these pages), so it's a little safer
> for functions intended for user pages not to be called for kernel pages.
> 

But the root cause is still existed, the bug may come back at any time 
by unconsciously, like this patch, if the PageTable(page) is allowed to 
get_page_unless_zero(), the risk is come back.

I'm not sure is there any other way to determine whether the pmd page is 
shared, so I add Mike Kravetz here, and report the risk to you.

> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>   mm/memory-failure.c | 28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git v5.13-rc5/mm/memory-failure.c v5.13-rc5_patched/mm/memory-failure.c
> index b986936e50eb..0d51067f0129 100644
> --- v5.13-rc5/mm/memory-failure.c
> +++ v5.13-rc5_patched/mm/memory-failure.c
> @@ -1113,7 +1113,8 @@ static int page_action(struct page_state *ps, struct page *p,
>    */
>   static inline bool HWPoisonHandlable(struct page *page)
>   {
> -	return PageLRU(page) || __PageMovable(page);
> +	return PageLRU(page) || __PageMovable(page) ||
> +		PageSlab(page) || PageTable(page) || PageReserved(page);
>   }
>    >   static int __get_hwpoison_page(struct page *page)
> @@ -1260,12 +1261,6 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>   	struct page *hpage = *hpagep;
>   	bool mlocked = PageMlocked(hpage);
>   
> -	/*
> -	 * Here we are interested only in user-mapped pages, so skip any
> -	 * other types of pages.
> -	 */
> -	if (PageReserved(p) || PageSlab(p))
> -		return true;
>   	if (!(PageLRU(hpage) || PageHuge(p)))
>   		return true;
>   
> @@ -1670,7 +1665,10 @@ int memory_failure(unsigned long pfn, int flags)
>   				action_result(pfn, MF_MSG_BUDDY, res);
>   				res = res == MF_RECOVERED ? 0 : -EBUSY;
>   			} else {
> -				action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
> +				if (PageCompound(p))
> +					action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
> +				else
> +					action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
>   				res = -EBUSY;
>   			}
>   			goto unlock_mutex;
> @@ -1681,6 +1679,20 @@ int memory_failure(unsigned long pfn, int flags)
>   		}
>   	}
>   
> +	if (PageSlab(p)) {
> +		action_result(pfn, MF_MSG_SLAB, MF_IGNORED);
> +		res = -EBUSY;
> +		goto unlock_mutex;
> +	} else if (PageTable(p)) {
> +		action_result(pfn, MF_MSG_PAGETABLE, MF_IGNORED);
> +		res = -EBUSY;
> +		goto unlock_mutex;
> +	} else if (PageReserved(p)) {
> +		action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
> +		res = -EBUSY;
> +		goto unlock_mutex;
> +	}
> +
>   	if (PageTransHuge(hpage)) {
>   		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
>   			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
> 


-- 
Thanks,
- Ding Hui

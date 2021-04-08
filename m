Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D67E358F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhDHVeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:34:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:12619 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232236AbhDHVet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:34:49 -0400
IronPort-SDR: LTQKux3mraW19BxQUdgEWMeRa2mJiz+yHK9DLVnZyimBHNjZnc/ekb9CYamHKHkK1Hu1CNXxK3
 lA8xrfCo7HjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193751288"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="193751288"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 14:34:31 -0700
IronPort-SDR: RQ8llsF18AjTDJ3fMupU3UimpX8MtU7KzcNM3kgcLAeXBSbVi/sKYReRdS9qrbxHfnRTaz09Wb
 4h/AWY5K2guA==
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="422427802"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.1.104])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 14:34:30 -0700
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@suse.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, alex.shi@linux.alibaba.com, willy@infradead.org,
        minchan@kernel.org, richard.weiyang@gmail.com,
        ying.huang@intel.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-3-linmiaohe@huawei.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <7684b3de-2824-9b1f-f033-d4bc14f9e195@linux.intel.com>
Date:   Thu, 8 Apr 2021 14:34:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210408130820.48233-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/21 6:08 AM, Miaohe Lin wrote:
> When I was investigating the swap code, I found the below possible race
> window:
> 
> CPU 1					CPU 2
> -----					-----
> do_swap_page
>   synchronous swap_readpage
>     alloc_page_vma
> 					swapoff
> 					  release swap_file, bdev, or ...

Perhaps I'm missing something.  The release of swap_file, bdev etc
happens after we have cleared the SWP_VALID bit in si->flags in destroy_swap_extents
if I read the swapoff code correctly.
 

>       swap_readpage
> 	check sis->flags is ok
> 	  access swap_file, bdev...[oops!]
> 					    si->flags = 0

This happens after we clear the si->flags
					synchronize_rcu()
					release swap_file, bdev, in destroy_swap_extents()

So I think if we have get_swap_device/put_swap_device in do_swap_page,
it should fix the race you've pointed out here.  
Then synchronize_rcu() will wait till we have completed do_swap_page and
call put_swap_device.
					
> 
> Using current get/put_swap_device() to guard against concurrent swapoff for
> swap_readpage() looks terrible because swap_readpage() may take really long
> time. And this race may not be really pernicious because swapoff is usually
> done when system shutdown only. To reduce the performance overhead on the
> hot-path as much as possible, it appears we can use the percpu_ref to close
> this race window(as suggested by Huang, Ying).

I think it is better to break this patch into two.

One patch is to fix the race in do_swap_page and swapoff
by adding get_swap_device/put_swap_device in do_swap_page.

The second patch is to modify get_swap_device and put_swap_device
with percpu_ref. But swapoff is a relatively rare events.  

I am not sure making percpu_ref change for performance is really beneficial.
Did you encounter a real use case where you see a problem with swapoff?
The delay in swapoff is primarily in try_to_unuse to bring all
the swapped off pages back into memory.  Synchronizing with other
CPU for paging in probably is a small component in overall scheme
of things.

Thanks.

Tim


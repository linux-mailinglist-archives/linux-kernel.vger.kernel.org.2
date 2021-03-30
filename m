Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBE134DF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhC3Dop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:44:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:19924 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230358AbhC3Dol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:44:41 -0400
IronPort-SDR: IAL81lUGMvNXzYiZloyfY1djX49AgpliYRN40D6wIevSjK+iz6IphPezmJEf29rOwp1RIOfF6I
 WN5DejjCp44g==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="189431173"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="189431173"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 20:44:40 -0700
IronPort-SDR: u8TygG76tgB2/BF8eHsxidPX/jPZXbGq7FdywqnQRECn/F92ZI599I8g9QGb5zptNpFuQbbskQ
 iUnn34uvPOPw==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="417968992"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 20:44:37 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        "Minchan Kim" <minchan@kernel.org>
Subject: Re: [Question] Is there a race window between swapoff vs
 synchronous swap_readpage
References: <364d7ce9-ccb7-fa04-7067-44a96be87060@huawei.com>
        <8735wdbdy4.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <0cb765aa-1783-cd62-c4a4-b3fbc620532d@huawei.com>
Date:   Tue, 30 Mar 2021 11:44:35 +0800
In-Reply-To: <0cb765aa-1783-cd62-c4a4-b3fbc620532d@huawei.com> (Miaohe Lin's
        message of "Tue, 30 Mar 2021 11:15:52 +0800")
Message-ID: <87h7kt9ufw.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2021/3/30 9:57, Huang, Ying wrote:
>> Hi, Miaohe,
>> 
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>> 
>>> Hi all,
>>> I am investigating the swap code, and I found the below possible race window:
>>>
>>> CPU 1							CPU 2
>>> -----							-----
>>> do_swap_page
>>>   skip swapcache case (synchronous swap_readpage)
>>>     alloc_page_vma
>>> 							swapoff
>>> 							  release swap_file, bdev, or ...
>>>       swap_readpage
>>> 	check sis->flags is ok
>>> 	  access swap_file, bdev or ...[oops!]
>>> 							    si->flags = 0
>>>
>>> The swapcache case is ok because swapoff will wait on the page_lock of swapcache page.
>>> Is this will really happen or Am I miss something ?
>>> Any reply would be really grateful. Thanks! :)
>> 
>> This appears possible.  Even for swapcache case, we can't guarantee the
>
> Many thanks for reply!
>
>> swap entry gotten from the page table is always valid too.  The
>
> The page table may change at any time. And we may thus do some useless work.
> But the pte_same() check could handle these races correctly if these do not
> result in oops.
>
>> underlying swap device can be swapped off at the same time.  So we use
>> get/put_swap_device() for that.  Maybe we need similar stuff here.
>
> Using get/put_swap_device() to guard against swapoff for swap_readpage() sounds
> really bad as swap_readpage() may take really long time. Also such race may not be
> really hurtful because swapoff is usually done when system shutdown only.
> I can not figure some simple and stable stuff out to fix this. Any suggestions or
> could anyone help get rid of such race?

Some reference counting on the swap device can prevent swap device from
swapping-off.  To reduce the performance overhead on the hot-path as
much as possible, it appears we can use the percpu_ref.

Best Regards,
Huang, Ying

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE5F34DDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhC3B6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:58:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:48469 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhC3B6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:58:01 -0400
IronPort-SDR: Djkd01zS5ZCH+2c2EGsRs2AnrWiCBlFLiFLUPlohgmZ0lD0sAVC8wRhpLm3EQXgJktMtmTOHTt
 BHCKafYtiDBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191696215"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="191696215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 18:58:00 -0700
IronPort-SDR: oZrfYiEFLYHlv33w1/1ygwjh5hfSEQi2PdpgjdsJ55B6ynmAGxF5Xsq+49kCowZkCbOsI1+dWM
 sAPTeRzemSmg==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="417938943"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 18:57:58 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [Question] Is there a race window between swapoff vs
 synchronous swap_readpage
References: <364d7ce9-ccb7-fa04-7067-44a96be87060@huawei.com>
Date:   Tue, 30 Mar 2021 09:57:55 +0800
In-Reply-To: <364d7ce9-ccb7-fa04-7067-44a96be87060@huawei.com> (Miaohe Lin's
        message of "Mon, 29 Mar 2021 21:18:20 +0800")
Message-ID: <8735wdbdy4.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Miaohe,

Miaohe Lin <linmiaohe@huawei.com> writes:

> Hi all,
> I am investigating the swap code, and I found the below possible race window:
>
> CPU 1							CPU 2
> -----							-----
> do_swap_page
>   skip swapcache case (synchronous swap_readpage)
>     alloc_page_vma
> 							swapoff
> 							  release swap_file, bdev, or ...
>       swap_readpage
> 	check sis->flags is ok
> 	  access swap_file, bdev or ...[oops!]
> 							    si->flags = 0
>
> The swapcache case is ok because swapoff will wait on the page_lock of swapcache page.
> Is this will really happen or Am I miss something ?
> Any reply would be really grateful. Thanks! :)

This appears possible.  Even for swapcache case, we can't guarantee the
swap entry gotten from the page table is always valid too.  The
underlying swap device can be swapped off at the same time.  So we use
get/put_swap_device() for that.  Maybe we need similar stuff here.

Best Regards,
Huang, Ying

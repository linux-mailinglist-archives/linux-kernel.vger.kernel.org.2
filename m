Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E835F8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351603AbhDNQOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:14:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:24333 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233932AbhDNQOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:14:40 -0400
IronPort-SDR: 7sRCmvIdqpiusw+8iidomoRnKXRRL7p0UKoooYkNxtUPEfaCnqs06Md2iI48xPXCioIYdNWv34
 tQsdlmc0B8jg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="215167456"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="215167456"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 09:13:04 -0700
IronPort-SDR: f4nPpK0iMTfkJ0nsaX2aEchOnpQWwut2Lw5JjWzvSuQ5RNhD/T/jlNJPcrL79E+ZDSSy3qwHNc
 FtF1368Fy44A==
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="389443810"
Received: from unknown (HELO schen9-mobl.amr.corp.intel.com) ([10.209.63.115])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 09:13:02 -0700
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, alex.shi@linux.alibaba.com, willy@infradead.org,
        minchan@kernel.org, richard.weiyang@gmail.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-3-linmiaohe@huawei.com>
 <87o8ejug76.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <c9bb0a8a-72ca-d9b4-4c31-d4d8cfde0b4c@linux.intel.com>
 <878s5lu16i.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <7ce9d6a2-6a9a-1203-0566-8a3bf478876f@linux.intel.com>
Date:   Wed, 14 Apr 2021 09:13:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <878s5lu16i.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/21 6:04 PM, Huang, Ying wrote:
> Tim Chen <tim.c.chen@linux.intel.com> writes:
> 
>> On 4/12/21 6:27 PM, Huang, Ying wrote:
>>
>>>
>>> This isn't the commit that introduces the race.  You can use `git blame`
>>> find out the correct commit.  For this it's commit 0bcac06f27d7 "mm,
>>> swap: skip swapcache for swapin of synchronous device".
>>>
>>> And I suggest to merge 1/5 and 2/5 to make it easy to get the full
>>> picture.
>>
>> I'll suggest make fix to do_swap_page race with get/put_swap_device
>> as a first patch. Then the per_cpu_ref stuff in patch 1 and patch 2 can
>> be combined together.
> 
> The original get/put_swap_device() use rcu_read_lock/unlock().  I don't
> think it's good to wrap swap_read_page() with it.  After all, some
> complex operations are done in swap_read_page(), including
> blk_io_schedule().
> 

In that case then have the patches to make get/put_swap_device to use
percpu_ref first.  And the patch to to fix the race in do_swap_page
later in another patch.

Patch 2 is mixing the two.

Tim

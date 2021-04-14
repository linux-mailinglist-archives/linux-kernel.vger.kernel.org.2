Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99B35EA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 03:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348945AbhDNBEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 21:04:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:46680 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343683AbhDNBEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 21:04:33 -0400
IronPort-SDR: bNOwz/3bRiwly6FoCWtZWwISTG7iW0PNOLhym1YPMpmh9ZaQqhXf33TEYgp+6ETufxkccXJY15
 //pjCGu8sqhg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="255855759"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="255855759"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:04:12 -0700
IronPort-SDR: d7U9oFOTWCLb+5LmgnBKRP2tjlMQBm+FQYsb54WaiIHq/+YczaLTHSv5IBteFo5kqaaqI3aPhg
 T8ofDXTE9IHA==
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="424495027"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:04:08 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <vbabka@suse.cz>, <alex.shi@linux.alibaba.com>,
        <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <hughd@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
References: <20210408130820.48233-1-linmiaohe@huawei.com>
        <20210408130820.48233-3-linmiaohe@huawei.com>
        <87o8ejug76.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <c9bb0a8a-72ca-d9b4-4c31-d4d8cfde0b4c@linux.intel.com>
Date:   Wed, 14 Apr 2021 09:04:05 +0800
In-Reply-To: <c9bb0a8a-72ca-d9b4-4c31-d4d8cfde0b4c@linux.intel.com> (Tim
        Chen's message of "Tue, 13 Apr 2021 12:24:15 -0700")
Message-ID: <878s5lu16i.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen <tim.c.chen@linux.intel.com> writes:

> On 4/12/21 6:27 PM, Huang, Ying wrote:
>
>> 
>> This isn't the commit that introduces the race.  You can use `git blame`
>> find out the correct commit.  For this it's commit 0bcac06f27d7 "mm,
>> swap: skip swapcache for swapin of synchronous device".
>> 
>> And I suggest to merge 1/5 and 2/5 to make it easy to get the full
>> picture.
>
> I'll suggest make fix to do_swap_page race with get/put_swap_device
> as a first patch. Then the per_cpu_ref stuff in patch 1 and patch 2 can
> be combined together.

The original get/put_swap_device() use rcu_read_lock/unlock().  I don't
think it's good to wrap swap_read_page() with it.  After all, some
complex operations are done in swap_read_page(), including
blk_io_schedule().

Best Regards,
Huang, Ying

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE235E702
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbhDMTYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:24:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:16148 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhDMTYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:24:45 -0400
IronPort-SDR: hQ9PY7ww3vuuG533NQFdj4ayX6yaBbT/VhXeBYfxCnTQEDxygbewUKHjROHmJNjUFZqYSTgmxt
 JDmiBeFByqag==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="181997762"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="181997762"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 12:24:19 -0700
IronPort-SDR: 2yoHeovCI3a6lwDX15UkiP+br97TlGA4ZUuiWGsE3zX4jQw45Wy2CkHVPqR70e+/2rirbrrRrU
 RZUTBeZgmudw==
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="443539373"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.18.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 12:24:17 -0700
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
To:     "Huang, Ying" <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        willy@infradead.org, minchan@kernel.org, richard.weiyang@gmail.com,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-3-linmiaohe@huawei.com>
 <87o8ejug76.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <c9bb0a8a-72ca-d9b4-4c31-d4d8cfde0b4c@linux.intel.com>
Date:   Tue, 13 Apr 2021 12:24:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87o8ejug76.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/21 6:27 PM, Huang, Ying wrote:

> 
> This isn't the commit that introduces the race.  You can use `git blame`
> find out the correct commit.  For this it's commit 0bcac06f27d7 "mm,
> swap: skip swapcache for swapin of synchronous device".
> 
> And I suggest to merge 1/5 and 2/5 to make it easy to get the full
> picture.

I'll suggest make fix to do_swap_page race with get/put_swap_device
as a first patch. Then the per_cpu_ref stuff in patch 1 and patch 2 can
be combined together.

Tim

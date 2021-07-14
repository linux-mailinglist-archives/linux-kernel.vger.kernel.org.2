Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FDC3C80A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhGNIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:51:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:60271 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238432AbhGNIvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:51:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="207292799"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="207292799"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 01:48:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="494378636"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.169.74]) ([10.249.169.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 01:48:18 -0700
Subject: Re: [LKP] Re: [mm/vmalloc] 5c1f4e690e:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
References: <20210713142414.GA28943@xsang-OptiPlex-9020>
 <CAHk-=wj_uJayxT_6CFaGMkU5h4YYSgBhS=xYoN7iUVSs7BjnBA@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <2f012f0a-11f5-ba3c-65b0-027eed5bcb98@intel.com>
Date:   Wed, 14 Jul 2021 16:48:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj_uJayxT_6CFaGMkU5h4YYSgBhS=xYoN7iUVSs7BjnBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2021 3:52 AM, Linus Torvalds wrote:
> [ I've asked for this before, but I'll ask for it again.. ]
> 
> On Tue, Jul 13, 2021 at 7:06 AM kernel test robot <oliver.sang@intel.com> wrote:
>>
>>
>> [  131.014885] BUG: sleeping function called from invalid context at mm/page_alloc.c:4992
>> [  131.019428] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2928, name: trinity-c6
>> [  131.023996] no locks held by trinity-c6/2928.
>> [  131.027987] irq event stamp: 283042
>> [  131.031844] hardirqs last  enabled at (283041): [<ffffffff8643af22>] _raw_spin_unlock_irqrestore+0x42/0x50
>> [  131.036625] hardirqs last disabled at (283042): [<ffffffff81656d71>] __alloc_pages_bulk+0xae1/0xf20
>> [  131.041305] softirqs last  enabled at (281858): [<ffffffff86800623>] __do_softirq+0x623/0x9db
>> [  131.046157] softirqs last disabled at (281853): [<ffffffff8116dfee>] irq_exit_rcu+0xce/0xf0
>> [  131.050925] CPU: 0 PID: 2928 Comm: trinity-c6 Not tainted 5.13.0+ #1
>> [  131.055391] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>> [  131.060133] Call Trace:
>> [  131.064110]  dump_stack+0xa5/0xe6
>> [  131.068192]  ___might_sleep.cold+0x147/0x177
>> [  131.072324]  __alloc_pages+0x462/0x650
> 
> Btw, can I ask the kernel test robot to do the same thing I asked
> syzbot to do - namely get better backtrace annotations?

Hi Linus,

Sorry for this, we enabled COMPILE_TEST for randconfig which is conflict
with DEBUG_INFO, then "scripts/decode_stacktrace.sh" was ignored in this
case, we'll fix it asap and have a double check next time.

Best Regards,
Rong Chen


> 
> It requires debug info in the kernel (but I think DEBUG_INFO_REDUCED
> is sufficient, no need for the full one that blows sizes up a lot),
> but it makes things _soo_ much easier to read. Not just because of
> line numbers, but particularly with inlining information.
> 
> It's easy enough to do: just run the kernel output through
> "scripts/decode_stacktrace.sh".
> 
> That will also do the "Code:" line instruction disassembly, which is
> less critical, since that can be done later at any time with no loss
> of information, but it can be a convenience.
> 
>                 Linus
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

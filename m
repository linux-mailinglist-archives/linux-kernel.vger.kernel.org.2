Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CD036D405
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbhD1Idb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:33:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:34912 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237143AbhD1Id3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:33:29 -0400
IronPort-SDR: SQjHh7guguMLAubE5IfTwtecWGkGz5Ds7MUiw3LAjSE1WbyHi9X82+IEp6JnJPURtgQftKl7bG
 MXSjAbTUQ06w==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="176171157"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="176171157"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:32:33 -0700
IronPort-SDR: fHoMiy74TBiV48hO5Iu9KKuts6xJl9cMkBg19lPUDClkh07IFesxFZ5oYmhW0uJ/5VxG33ol/3
 WpG6cC3x+kmQ==
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="403600948"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.46]) ([10.238.4.46])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:32:30 -0700
Subject: Re: [LKP] Re: [mm/vunmap] e47110e905:
 WARNING:at_mm/vmalloc.c:#__vunmap
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Harish Sriram <harish@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
References: <20210423063227.GA17429@xsang-OptiPlex-9020>
 <CAHk-=wg8iAG6bBB+zdoZvZx1XYmyAXrWL0gPs_eTrTt+tXN0Tw@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <4b0fd107-5509-3d2a-1151-335f9296f8e5@linux.intel.com>
Date:   Wed, 28 Apr 2021 16:32:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg8iAG6bBB+zdoZvZx1XYmyAXrWL0gPs_eTrTt+tXN0Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 4/24/2021 1:18 AM, Linus Torvalds wrote:
> On Thu, Apr 22, 2021 at 11:15 PM kernel test robot
> <oliver.sang@intel.com> wrote:
>>
>> commit: e47110e90584a22e9980510b00d0dfad3a83354e ("mm/vunmap: add cond_resched() in vunmap_pmd_range")
> 
> Funky. That commit doesn't seem to have anything to do with the oops.
> 
> The oops is odd too:
> 
>> [  198.731223] WARNING: CPU: 0 PID: 1948 at mm/vmalloc.c:2247 __vunmap (kbuild/src/consumer/mm/vmalloc.c:2247 (discriminator 1))
> 
> That's the warning for an unaligned vunmap():
> 
>    2247          if (WARN(!PAGE_ALIGNED(addr), "Trying to vfree() bad
> address (%p)\n",
>    2248                          addr))
>    2249                  return;
> 
>> [  198.744933] Call Trace:
>> [  198.745229] free_module (kbuild/src/consumer/kernel/module.c:2251)
> 
>    2248          /* This may be empty, but that's OK */
>    2249          module_arch_freeing_init(mod);
>    2250          module_memfree(mod->init_layout.base);

We add debug code to print logs when mod->init_layout.base is NULL, 
after more than 100 times test, we find that when mod->init_layout.base 
is NULL, no align warning happened. From the descriptions of vfree, if 
@addr is NULL, no operation is performed. So when the warning happened, 
the mod->init_layout.base is not a NULL.

void vfree(const void *addr)
{
	BUG_ON(in_nmi());

	kmemleak_free(addr);

	might_sleep_if(!in_interrupt());

	if (!addr)
		return;

	__vfree(addr);
}

static void __vfree(const void *addr)
{
	if (unlikely(in_interrupt()))
		__vfree_deferred(addr);
	else
		__vunmap(addr, 1);
}


>    2251          kfree(mod->args);
> 
> That's the "module_memfree()" - the return address points to the
> return point, which is the next line.
> 
> And as far as I can tell, the only thing that assigns anything but
> NULL to that init_layout.base is
> 
>                  ptr = module_alloc(mod->init_layout.size);
> 
> which uses __vmalloc_node_range() for the allocation.
> 
> So absolutely nothing in this report makes sense to me. I suspect it's
> some odd memory corruption.
> 
> Oliver - how reliable is that bisection?
> 
> Does anybody else see what might be up?
> 
>              Linus
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing

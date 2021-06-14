Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6242A3A5FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhFNKVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:21:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:17504 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232691AbhFNKVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:21:34 -0400
IronPort-SDR: MetQReKyOefVXPJQb2remfPusKiH7XgEAK1NNQUoE8b8nFLydXSDP5NHVGeH3OmvspuDUHQyMD
 oJjRPWH7bN7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="269636835"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="269636835"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 03:19:30 -0700
IronPort-SDR: QqSBibJxh4ghU3APa2uoHfGYe2GnszhfwINMtrgEiG+3Hz6Y4Ad+4AwszUVsxdk+PimR0Pf+fO
 uGmWKBBeACQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="449847045"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2021 03:19:28 -0700
Subject: Re: [PATCH v2] xhci: solve a double free problem while doing s4
To:     "Zhangjiantao (Kirin, nanjing)" <water.zhangjiantao@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xuetao (kirin)" <xuetao09@huawei.com>,
        "chenyu (U)" <chenyu56@huawei.com>,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>
References: <1623403104-121391-1-git-send-email-xuetao09@huawei.com>
 <3f5f7a1a46a847ca8bb793050cf30b98@huawei.com> <YMNhZdRN/qsySpSp@kroah.com>
 <42e90d95-0544-cb46-a066-85d0cea0be48@huawei.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <dd66b8ce-3d81-fc10-99e9-b2ef765f2dc9@linux.intel.com>
Date:   Mon, 14 Jun 2021 13:21:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <42e90d95-0544-cb46-a066-85d0cea0be48@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.6.2021 15.08, Zhangjiantao (Kirin, nanjing) wrote:
> 
> On 2021/6/11 21:13, gregkh@linuxfoundation.org wrote :
>> On Fri, Jun 11, 2021 at 11:08:30AM +0000, Zhangjiantao (Kirin, nanjing) wrote:
>>> when system is doing s4, the process of xhci_resume may be as below:
>>> 1、xhci_mem_cleanup
>>> 2、xhci_init->xhci_mem_init->xhci_mem_cleanup(when memory is not enough).
>>> xhci_mem_cleanup will be executed twice when system is out of memory.
>>> xhci->port_caps is freed in xhci_mem_cleanup,but it isn't set to NULL.
>>> It will be freed twice when xhci_mem_cleanup is called the second time.
>>>
>>> We got following bug when system resumes from s4:
>>>
>>> kernel BUG at mm/slub.c:309!
>>> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>> CPU: 0 PID: 5929 Tainted: G S   W   5.4.96-arm64-desktop #1
>>> pc : __slab_free+0x5c/0x424
>>> lr : kfree+0x30c/0x32c
>>>
>>> Call trace:
>>>   __slab_free+0x5c/0x424
>>>   kfree+0x30c/0x32c
>>>   xhci_mem_cleanup+0x394/0x3cc
>>>   xhci_mem_init+0x9ac/0x1070
>>>   xhci_init+0x8c/0x1d0
>>>   xhci_resume+0x1cc/0x5fc
>>>   xhci_plat_resume+0x64/0x70
>>>   platform_pm_thaw+0x28/0x60
>>>   dpm_run_callback+0x54/0x24c
>>>   device_resume+0xd0/0x200
>>>   async_resume+0x24/0x60
>>>   async_run_entry_fn+0x44/0x110
>>>   process_one_work+0x1f0/0x490
>>>   worker_thread+0x5c/0x450
>>>   kthread+0x158/0x160
>>>   ret_from_fork+0x10/0x24
>>>
>>> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
>>> Signed-off-by: Tao Xue <xuetao09@huawei.com>
>>> ---
>>>   drivers/usb/host/xhci-mem.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c index f66815f..e4b0c04 100644
>>> --- a/drivers/usb/host/xhci-mem.c
>>> +++ b/drivers/usb/host/xhci-mem.c
>>> @@ -1924,6 +1924,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
>>>       xhci->hw_ports = NULL;
>>>       xhci->rh_bw = NULL;
>>>       xhci->ext_caps = NULL;
>>> +    xhci->port_caps = NULL;
>>>         xhci->page_size = 0;
>>>       xhci->page_shift = 0;
>>> -- 
>>> 2.7.4
>>>
>>
>> Hi,
>>
>> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
>> a patch that has triggered this response.  He used to manually respond
>> to these common problems, but in order to save his sanity (he kept
>> writing the same thing over and over, yet to different people), I was
>> created.  Hopefully you will not take offence and will fix the problem
>> in your patch and resubmit it so that it can be accepted into the Linux
>> kernel tree.
>>
>> You are receiving this message because of the following common error(s)
>> as indicated below:
>>
>> - This looks like a new version of a previously submitted patch, but you
>>    did not list below the --- line any changes from the previous version.
>>    Please read the section entitled "The canonical patch format" in the
>>    kernel file, Documentation/SubmittingPatches for what needs to be done
>>    here to properly describe this.
>>
>> If you wish to discuss this problem further, or you have questions about
>> how to resolve this issue, please feel free to respond to this email and
>> Greg will reply once he has dug out from the pending patches received
>> from other developers.
>>
>> thanks,
>>
>> greg k-h's patch email bot
> 
> Yes,there is no change of code line. I only added
> "Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>" in the comments.
> thanks，
>    Jiantao Zhang
> 

I'll pick this up, add stable and fixes tags and send it forward.

Thanks
-Mathias

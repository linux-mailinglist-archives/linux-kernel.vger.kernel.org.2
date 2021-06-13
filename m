Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF43A5837
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhFMMKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 08:10:53 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6466 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhFMMKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 08:10:52 -0400
Received: from nkgeml706-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G2tZq6RCNzZgn6;
        Sun, 13 Jun 2021 20:05:55 +0800 (CST)
Received: from [10.136.108.160] (10.136.108.160) by
 nkgeml706-chm.china.huawei.com (10.98.57.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 13 Jun 2021 20:08:48 +0800
Subject: Re: [PATCH v2] xhci: solve a double free problem while doing s4
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xuetao (kirin)" <xuetao09@huawei.com>,
        "chenyu (U)" <chenyu56@huawei.com>,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>
References: <1623403104-121391-1-git-send-email-xuetao09@huawei.com>
 <3f5f7a1a46a847ca8bb793050cf30b98@huawei.com> <YMNhZdRN/qsySpSp@kroah.com>
From:   "Zhangjiantao (Kirin, nanjing)" <water.zhangjiantao@huawei.com>
Message-ID: <42e90d95-0544-cb46-a066-85d0cea0be48@huawei.com>
Date:   Sun, 13 Jun 2021 20:08:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMNhZdRN/qsySpSp@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.108.160]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 nkgeml706-chm.china.huawei.com (10.98.57.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/6/11 21:13, gregkh@linuxfoundation.org wrote :
> On Fri, Jun 11, 2021 at 11:08:30AM +0000, Zhangjiantao (Kirin, nanjing) wrote:
>> when system is doing s4, the process of xhci_resume may be as below:
>> 1、xhci_mem_cleanup
>> 2、xhci_init->xhci_mem_init->xhci_mem_cleanup(when memory is not enough).
>> xhci_mem_cleanup will be executed twice when system is out of memory.
>> xhci->port_caps is freed in xhci_mem_cleanup,but it isn't set to NULL.
>> It will be freed twice when xhci_mem_cleanup is called the second time.
>>
>> We got following bug when system resumes from s4:
>>
>> kernel BUG at mm/slub.c:309!
>> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>> CPU: 0 PID: 5929 Tainted: G S   W   5.4.96-arm64-desktop #1
>> pc : __slab_free+0x5c/0x424
>> lr : kfree+0x30c/0x32c
>>
>> Call trace:
>>   __slab_free+0x5c/0x424
>>   kfree+0x30c/0x32c
>>   xhci_mem_cleanup+0x394/0x3cc
>>   xhci_mem_init+0x9ac/0x1070
>>   xhci_init+0x8c/0x1d0
>>   xhci_resume+0x1cc/0x5fc
>>   xhci_plat_resume+0x64/0x70
>>   platform_pm_thaw+0x28/0x60
>>   dpm_run_callback+0x54/0x24c
>>   device_resume+0xd0/0x200
>>   async_resume+0x24/0x60
>>   async_run_entry_fn+0x44/0x110
>>   process_one_work+0x1f0/0x490
>>   worker_thread+0x5c/0x450
>>   kthread+0x158/0x160
>>   ret_from_fork+0x10/0x24
>>
>> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
>> Signed-off-by: Tao Xue <xuetao09@huawei.com>
>> ---
>>   drivers/usb/host/xhci-mem.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c index f66815f..e4b0c04 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -1924,6 +1924,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
>>   	xhci->hw_ports = NULL;
>>   	xhci->rh_bw = NULL;
>>   	xhci->ext_caps = NULL;
>> +	xhci->port_caps = NULL;
>>   
>>   	xhci->page_size = 0;
>>   	xhci->page_shift = 0;
>> --
>> 2.7.4
>>
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>    did not list below the --- line any changes from the previous version.
>    Please read the section entitled "The canonical patch format" in the
>    kernel file, Documentation/SubmittingPatches for what needs to be done
>    here to properly describe this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

Yes,there is no change of code line. I only added
"Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>" in the comments.
thanks，
    Jiantao Zhang


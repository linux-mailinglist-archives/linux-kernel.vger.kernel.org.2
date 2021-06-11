Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505D73A3CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhFKHVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:21:23 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5384 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFKHVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:21:22 -0400
Received: from nkgeml706-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G1XDc4bV5z6vDR;
        Fri, 11 Jun 2021 15:15:28 +0800 (CST)
Received: from [10.136.108.160] (10.136.108.160) by
 nkgeml706-chm.china.huawei.com (10.98.57.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 15:19:21 +0800
Subject: Re: [PATCH] xhci: solve a double free problem while doing s4
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Xuetao (kirin)" <xuetao09@huawei.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenyu (U)" <chenyu56@huawei.com>,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>
References: <1623244292-108534-1-git-send-email-xuetao09@huawei.com>
 <1428e2d7b7b74fccb3493384f96c521a@huawei.com>
 <e6ca9524-67a6-1eef-a44f-b9a1acd5205c@linux.intel.com>
 <YMIbUN3HkyKjn6am@kroah.com>
 <417ae6d7-a602-6803-9407-bf0cf809bb5a@linux.intel.com>
From:   "Zhangjiantao (Kirin, nanjing)" <water.zhangjiantao@huawei.com>
Message-ID: <01ba47a1-c226-947e-9f7b-dea4e28d4209@huawei.com>
Date:   Fri, 11 Jun 2021 15:18:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <417ae6d7-a602-6803-9407-bf0cf809bb5a@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.108.160]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 nkgeml706-chm.china.huawei.com (10.98.57.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/6/11 3:27, Mathias Nyman wrote:
> On 10.6.2021 17.01, gregkh@linuxfoundation.org wrote:
>> On Thu, Jun 10, 2021 at 04:45:54PM +0300, Mathias Nyman wrote:
>>> On 9.6.2021 17.22, Zhangjiantao (Kirin, nanjing) wrote:
>>>> when system is doing s4, the process of xhci_resume may be as below:
>>>> 1、xhci_mem_cleanup
>>>> 2、xhci_init->xhci_mem_init->xhci_mem_cleanup(when memory is not enough).
>>>> xhci_mem_cleanup will be executed twice when system is out of memory.
>>>> xhci->port_caps is freed in xhci_mem_cleanup,but it isn't set to NULL.
>>>> It will be freed twice when xhci_mem_cleanup is called the second time.
>>>>
>>> Thanks, nice catch
>>>
>>>> We got following bug when system resumes from s4:
>>>>
>>>> kernel BUG at mm/slub.c:309!
>>>> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>>> CPU: 0 PID: 5929 Tainted: G S   W   5.4.96-arm64-desktop #1
>>>> pc : __slab_free+0x5c/0x424
>>>> lr : kfree+0x30c/0x32c
>>>>
>>>> Call trace:
>>>>   __slab_free+0x5c/0x424
>>>>   kfree+0x30c/0x32c
>>>>   xhci_mem_cleanup+0x394/0x3cc
>>>>   xhci_mem_init+0x9ac/0x1070
>>>>   xhci_init+0x8c/0x1d0
>>>>   xhci_resume+0x1cc/0x5fc
>>>>   xhci_plat_resume+0x64/0x70
>>>>   platform_pm_thaw+0x28/0x60
>>>>   dpm_run_callback+0x54/0x24c
>>>>   device_resume+0xd0/0x200
>>>>   async_resume+0x24/0x60
>>>>   async_run_entry_fn+0x44/0x110
>>>>   process_one_work+0x1f0/0x490
>>>>   worker_thread+0x5c/0x450
>>>>   kthread+0x158/0x160
>>>>   ret_from_fork+0x10/0x24
>>>>
>>>> Signed-off-by: Tao Xue <xuetao09@huawei.com>
>>> Checkpatch complains:
>>> ERROR: Missing Signed-off-by: line by nominal patch author 'Zhangjiantao (Kirin, nanjing) <water.zhangjiantao@huawei.com>'
>>>
>>> Is Zhangjiantao (Kirin, nanjing)  the correct author? If yes can I add
>>> "Signed-off-by: Zhangjiantao (Kirin, nanjing) <water.zhangjiantao@huawei.com>?
>> Please note that it is generally a bad thing for others to add someone
>> else's s-o-b line, as it is a legal agreement.  It is best for them to
>> send it instead.
> Good point.
> Zhangjiantao (Kirin, nanjing), could you resend with Author/Signed-off-by corrected.

Yes, I amd  and  Tao Xue are both the correct author, I will resend soon;

Thanks

--Zhangjiantao




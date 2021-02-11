Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77231922E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhBKSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:24:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:16147 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232530AbhBKSO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:14:56 -0500
IronPort-SDR: DUbP009B2Q1IiPZ9nMGnkq8ANgJUwjGTcVMa4W1mzZYkHamLR8VUGokfUcgp46UWEwVwJIbgC8
 kf0L8a+gCxUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="169962196"
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="169962196"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 10:14:11 -0800
IronPort-SDR: /R3mK1yfGZFnrBcEXRKHbESUhFdzohJjo8E7JTP8uTrI0u7lChxlmPwpQDxjc2sCGJ5yAMoZ4Z
 1St8v362d0uA==
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="362590428"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.225.14]) ([10.212.225.14])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 10:14:10 -0800
Subject: Re: [PATCH v4] driver core: auxiliary bus: Fix calling stage for
 auxiliary bus init
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20210211174249.1618488-1-dave.jiang@intel.com>
 <YCVwjUUW+y4SaDoK@kroah.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <0e684581-aaa6-9d57-915b-7928f203b0b4@intel.com>
Date:   Thu, 11 Feb 2021 11:14:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCVwjUUW+y4SaDoK@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/11/2021 10:59 AM, Greg KH wrote:
> On Thu, Feb 11, 2021 at 10:42:49AM -0700, Dave Jiang wrote:
>> When the auxiliary device code is built into the kernel, it can be executed
>> before the auxiliary bus is registered. This causes bus->p to be not
>> allocated and triggers a NULL pointer dereference when the auxiliary bus
>> device gets added with bus_add_device(). Call the auxiliary_bus_init()
>> under driver_init() so the bus is initialized before devices.
>>
>> Below is the kernel splat for the bug:
>> [ 1.948215] BUG: kernel NULL pointer dereference, address: 0000000000000060
>> [ 1.950670] #PF: supervisor read access in kernel mode
>> [ 1.950670] #PF: error_code(0x0000) - not-present page
>> [ 1.950670] PGD 0
>> [ 1.950670] Oops: 0000 1 SMP NOPTI
>> [ 1.950670] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-intel-nextsvmtest+ #2205
>> [ 1.950670] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> [ 1.950670] RIP: 0010:bus_add_device+0x64/0x140
>> [ 1.950670] Code: 00 49 8b 75 20 48 89 df e8 59 a1 ff ff 41 89 c4 85 c0 75 7b 48 8b 53 50 48 85 d2 75 03 48 8b 13 49 8b 85 a0 00 00 00 48 89 de <48> 8
>> 78 60 48 83 c7 18 e8 ef d9 a9 ff 41 89 c4 85 c0 75 45 48 8b
>> [ 1.950670] RSP: 0000:ff46032ac001baf8 EFLAGS: 00010246
>> [ 1.950670] RAX: 0000000000000000 RBX: ff4597f7414aa680 RCX: 0000000000000000
>> [ 1.950670] RDX: ff4597f74142bbc0 RSI: ff4597f7414aa680 RDI: ff4597f7414aa680
>> [ 1.950670] RBP: ff46032ac001bb10 R08: 0000000000000044 R09: 0000000000000228
>> [ 1.950670] R10: ff4597f741141b30 R11: ff4597f740182a90 R12: 0000000000000000
>> [ 1.950670] R13: ffffffffa5e936c0 R14: 0000000000000000 R15: 0000000000000000
>> [ 1.950670] FS: 0000000000000000(0000) GS:ff4597f7bba00000(0000) knlGS:0000000000000000
>> [ 1.950670] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1.950670] CR2: 0000000000000060 CR3: 000000002140c001 CR4: 0000000000f71ef0
>> [ 1.950670] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [ 1.950670] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>> [ 1.950670] PKRU: 55555554
>> [ 1.950670] Call Trace:
>> [ 1.950670] device_add+0x3ee/0x850
>> [ 1.950670] __auxiliary_device_add+0x47/0x60
>> [ 1.950670] idxd_pci_probe+0xf77/0x1180
>> [ 1.950670] local_pci_probe+0x4a/0x90
>> [ 1.950670] pci_device_probe+0xff/0x1b0
>> [ 1.950670] really_probe+0x1cf/0x440
>> [ 1.950670] ? rdinit_setup+0x31/0x31
>> [ 1.950670] driver_probe_device+0xe8/0x150
>> [ 1.950670] device_driver_attach+0x58/0x60
>> [ 1.950670] __driver_attach+0x8f/0x150
>> [ 1.950670] ? device_driver_attach+0x60/0x60
>> [ 1.950670] ? device_driver_attach+0x60/0x60
>> [ 1.950670] bus_for_each_dev+0x79/0xc0
>> [ 1.950670] ? kmem_cache_alloc_trace+0x323/0x430
>> [ 1.950670] driver_attach+0x1e/0x20
>> [ 1.950670] bus_add_driver+0x154/0x1f0
>> [ 1.950670] driver_register+0x70/0xc0
>> [ 1.950670] __pci_register_driver+0x54/0x60
>> [ 1.950670] idxd_init_module+0xe2/0xfc
>> [ 1.950670] ? idma64_platform_driver_init+0x19/0x19
>> [ 1.950670] do_one_initcall+0x4a/0x1e0
>> [ 1.950670] kernel_init_freeable+0x1fc/0x25c
>> [ 1.950670] ? rest_init+0xba/0xba
>> [ 1.950670] kernel_init+0xe/0x116
>> [ 1.950670] ret_from_fork+0x1f/0x30
>> [ 1.950670] Modules linked in:
>> [ 1.950670] CR2: 0000000000000060
>> [ 1.950670] --[ end trace cd7d1b226d3ca901 ]--
>>
>> Fixes: 7de3697e9cbd ("Add auxiliary bus support")
>> Reported-by: Jacob Pan <jacob.jun.pan@intel.com>
>> Acked-by: Dave Ertman <david.m.ertman@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>
>> v4:
>> - Remove remaining module bits as it's not a kernel module. (GregKH)
>> v3:
>> - Change init function to return void. (GregKH)
>> v2:
>> - Call in driver_init() to ensure aux bus gets init before devices.  (GregKH)
>>
>>   drivers/base/base.h      |  5 +++++
>>   drivers/base/auxiliary.c | 18 +++---------------
>>   drivers/base/init.c      |  1 +
>>   3 files changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>> index f5600a83124f..52b3d7b75c27 100644
>> --- a/drivers/base/base.h
>> +++ b/drivers/base/base.h
>> @@ -119,6 +119,11 @@ static inline int hypervisor_init(void) { return 0; }
>>   extern int platform_bus_init(void);
>>   extern void cpu_dev_init(void);
>>   extern void container_dev_init(void);
>> +#ifdef CONFIG_AUXILIARY_BUS
>> +extern void auxiliary_bus_init(void);
>> +#else
>> +static inline void auxiliary_bus_init(void) { }
>> +#endif
>>   
>>   struct kobject *virtual_device_parent(struct device *dev);
>>   
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index 8336535f1e11..adc199dfba3c 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/string.h>
>>   #include <linux/auxiliary_bus.h>
>> +#include "base.h"
>>   
>>   static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
>>   							    const struct auxiliary_device *auxdev)
>> @@ -260,20 +261,7 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv)
>>   }
>>   EXPORT_SYMBOL_GPL(auxiliary_driver_unregister);
>>   
>> -static int __init auxiliary_bus_init(void)
>> +void __init auxiliary_bus_init(void)
>>   {
>> -	return bus_register(&auxiliary_bus_type);
>> +	WARN_ON(bus_register(&auxiliary_bus_type));
>>   }
>> -
>> -static void __exit auxiliary_bus_exit(void)
>> -{
>> -	bus_unregister(&auxiliary_bus_type);
>> -}
>> -
>> -module_init(auxiliary_bus_init);
>> -module_exit(auxiliary_bus_exit);
>> -
>> -MODULE_LICENSE("GPL v2");
>> -MODULE_DESCRIPTION("Auxiliary Bus");
>> -MODULE_AUTHOR("David Ertman <david.m.ertman@intel.com>");
>> -MODULE_AUTHOR("Kiran Patil <kiran.patil@intel.com>");
>> diff --git a/drivers/base/init.c b/drivers/base/init.c
>> index 908e6520e804..a9f57c22fb9e 100644
>> --- a/drivers/base/init.c
>> +++ b/drivers/base/init.c
>> @@ -32,6 +32,7 @@ void __init driver_init(void)
>>   	 */
>>   	of_core_init();
>>   	platform_bus_init();
>> +	auxiliary_bus_init();
>>   	cpu_dev_init();
>>   	memory_dev_init();
>>   	container_dev_init();
>> -- 
>> 2.26.2
>>
> This is already in my tree, you got an email about it.  Do the module
> removal as a separate patch as it has nothing to do with this one as the
> code could never be built as a module, your patch did not change it, so
> you are doing 2 different things here.

Ok I will send a separate patch.


>
> {sigh}
>
> Intel owes me a new bottle of whisky.

Thank you for your patience, and I apologize for any future vexing. I 
can't speak for Intel, but I can certainly try to accommodate that at a 
future conference. :)


>
> greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F331595E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhBIWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:23:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:11939 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233509AbhBITmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:42:25 -0500
IronPort-SDR: s2T8tgh7OK1g4LI0K8OSjVVaSe41HBozbc5Q2FlYy32JQ6QQQCUbWupgIU4rxoQ6lFfZOOukX1
 BNqbvsziiHnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="169626612"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="169626612"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 11:38:08 -0800
IronPort-SDR: HwhPdUv0eiEltXSGpS7CnWCYGd4ajZclVv0MJCTCVrSyv4Ouym4YSWbAdVhVBCorJwrLYhQ83H
 niAYB86Dy68A==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="396365865"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.123.115]) ([10.212.123.115])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 11:38:08 -0800
Subject: Re: [PATCH] driver core: auxiliary bus: Fix calling stage for
 auxiliary bus init
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
References: <161289750572.1086235.9903492973331406876.stgit@djiang5-desk3.ch.intel.com>
 <YCLfETxDjOUPISpw@kroah.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <8ac05dcb-398c-a357-d6e5-48f45e4c6b12@intel.com>
Date:   Tue, 9 Feb 2021 12:38:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCLfETxDjOUPISpw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/9/2021 12:14 PM, Greg KH wrote:
> On Tue, Feb 09, 2021 at 12:05:05PM -0700, Dave Jiang wrote:
>> When the auxiliary device code is built into the kernel, it can be executed
>> before the auxiliary bus is registered. This causes bus->p to be not
>> allocated and triggers a NULL pointer dereference when the auxiliary bus
>> device gets added with bus_add_device(). Change the init of auxiliary bus
>> to subsys_initcall() from module_init() to ensure the bus is registered
>> before devices.
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
>>   drivers/base/auxiliary.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index 8336535f1e11..53f93a506626 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -270,7 +270,7 @@ static void __exit auxiliary_bus_exit(void)
>>   	bus_unregister(&auxiliary_bus_type);
>>   }
>>   
>> -module_init(auxiliary_bus_init);
>> +subsys_initcall(auxiliary_bus_init);
> Ah, the linker priority dance.  Are you _SURE_ this will solve this?
>
> Why not just call this explicitly in driver_init() so that you know it
> will be ok?  Just like we do for the platform bus?

It would require making auxiliary_bus part of the base just like 
platform instead of a module. Is that ok?


>
> thanks,
>
> greg k-h

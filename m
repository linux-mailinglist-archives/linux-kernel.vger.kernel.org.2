Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0F13CCE0D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhGSGpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 02:45:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7030 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhGSGpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 02:45:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GSsYy4cKXzYd9Y;
        Mon, 19 Jul 2021 14:36:22 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 14:42:06 +0800
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 14:42:05 +0800
Subject: Re: [PATCH 1/1] firmware: fix use-after-free in _request_firmware()
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ming Lei <ming.lei@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210713024942.2881-1-thunder.leizhen@huawei.com>
 <20210716195628.a2pz73hdudrsf7vu@garbanzo>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7fbab4de-d52d-8587-159e-e36e9f03459a@huawei.com>
Date:   Mon, 19 Jul 2021 14:42:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210716195628.a2pz73hdudrsf7vu@garbanzo>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/17 3:56, Luis Chamberlain wrote:
> On Tue, Jul 13, 2021 at 10:49:42AM +0800, Zhen Lei wrote:
>> 		CPU0			CPU1
>> __device_uncache_fw_images():		assign_fw():
>> 					fw_cache_piggyback_on_request()
>> 					<----- P0
>> 	spin_lock(&fwc->name_lock);
>> 	...
>> 	list_del(&fce->list);
>> 	spin_unlock(&fwc->name_lock);
>>
>> 	uncache_firmware(fce->name);
>> 					<----- P1
>> 					kref_get(&fw_priv->ref);
>>
>> If CPU1 is interrupted at position P0, the new 'fce' has been added to the
>> list fwc->fw_names by the fw_cache_piggyback_on_request(). In this case,
>> CPU0 executes __device_uncache_fw_images() and will be able to see it when
>> it traverses list fwc->fw_names. Before CPU1 executes kref_get() at P1, if
>> CPU0 further executes uncache_firmware(), the count of fw_priv->ref may
>> decrease to 0, causing fw_priv to be released in advance.
>>
>> Move kref_get() to the lock protection range of fwc->name_lock to fix it.
>>
>> Fixes: ac39b3ea73aa ("firmware loader: let caching firmware piggyback on loading firmware")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> Good catch! Can you resend a v2 patch describing how this race is rather
> difficult to run into given it likely involves looping modprobe / rmod on a
> driver while doing the suspend / resume cycle? I can't see how else to
> trigger this. Additionally if you can describe in the patch how you
> found this, (code inspection, a robot code system which looks for UAF?)
> it would be good for the commit log.


Hi, Luis:
  I will update the description and resend v2. Our fuzz testing reported a
"KASAN: use-after-free Read in firmware_fallback_sysfs", I checked the code in
the entire drivers/base/firmware_loader/ directory. Other than this race, there's
nothing suspicious, maybe it's just that I didn't find. It's hard to explain
the UAF call trace, so I didn't attach it to avoid confusion.

The following is the complete exception information:

platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x24/0xb4 lib/list_debug.c:23
Read of size 8 at addr ffff0000d7471490 by task syz-executor.1/6045

CPU: 1 PID: 6045 Comm: syz-executor.1 Not tainted 5.10.0-02190-ge9a844e2c44c-dirty #7
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x2d0 arch/arm64/kernel/stacktrace.c:132
 show_stack+0x28/0x34 arch/arm64/kernel/stacktrace.c:196
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x110/0x164 lib/dump_stack.c:118
 print_address_description+0x78/0x5c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report+0x148/0x1e4 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:183 [inline]
 __asan_load8+0xb4/0xbc mm/kasan/generic.c:252
 __list_add_valid+0x24/0xb4 lib/list_debug.c:23
 __list_add include/linux/list.h:67 [inline]
 list_add include/linux/list.h:86 [inline]
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:516 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:581 [inline]
 firmware_fallback_sysfs+0x2a8/0x588 drivers/base/firmware_loader/fallback.c:657
 _request_firmware+0x728/0x814 drivers/base/firmware_loader/main.c:831
 request_firmware+0x48/0x68 drivers/base/firmware_loader/main.c:875
 reg_reload_regdb+0x40/0x148 net/wireless/reg.c:1083
 nl80211_reload_regdb+0x10/0x18 net/wireless/nl80211.c:7067
 genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x6e8/0x784 net/netlink/genetlink.c:800
 netlink_rcv_skb+0xe0/0x1bc net/netlink/af_netlink.c:2494
 genl_rcv+0x34/0x48 net/netlink/genetlink.c:811
 netlink_unicast_kernel+0x170/0x228 net/netlink/af_netlink.c:1304
 netlink_unicast+0x118/0x208 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x3f8/0x4b4 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg net/socket.c:671 [inline]
 ____sys_sendmsg+0x314/0x470 net/socket.c:2353
 ___sys_sendmsg net/socket.c:2407 [inline]
 __sys_sendmsg+0x10c/0x1d8 net/socket.c:2440
 __do_sys_sendmsg net/socket.c:2449 [inline]
 __se_sys_sendmsg net/socket.c:2447 [inline]
 __arm64_sys_sendmsg+0x4c/0x5c net/socket.c:2447
 __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
 el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
 do_el0_svc+0x120/0x290 arch/arm64/kernel/syscall.c:220
 el0_svc+0x1c/0x28 arch/arm64/kernel/entry-common.c:367
 el0_sync_handler+0x98/0x170 arch/arm64/kernel/entry-common.c:383
 el0_sync+0x140/0x180 arch/arm64/kernel/entry.S:670

Allocated by task 6022:
 stack_trace_save+0x80/0xb8 kernel/stacktrace.c:121
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0xdc/0x120 mm/kasan/common.c:461
 kasan_kmalloc+0xc/0x14 mm/kasan/common.c:475
 kmem_cache_alloc_trace include/linux/slab.h:450 [inline]
 kmalloc include/linux/slab.h:552 [inline]
 kzalloc include/linux/slab.h:664 [inline]
 __allocate_fw_priv drivers/base/firmware_loader/main.c:186 [inline]
 alloc_lookup_fw_priv+0xb0/0x344 drivers/base/firmware_loader/main.c:250
 _request_firmware_prepare drivers/base/firmware_loader/main.c:744 [inline]
 _request_firmware+0x1ac/0x814 drivers/base/firmware_loader/main.c:806
 request_firmware+0x48/0x68 drivers/base/firmware_loader/main.c:875
 reg_reload_regdb+0x40/0x148 net/wireless/reg.c:1083
 nl80211_reload_regdb+0x10/0x18 net/wireless/nl80211.c:7067
 genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x6e8/0x784 net/netlink/genetlink.c:800
 netlink_rcv_skb+0xe0/0x1bc net/netlink/af_netlink.c:2494
 genl_rcv+0x34/0x48 net/netlink/genetlink.c:811
 netlink_unicast_kernel+0x170/0x228 net/netlink/af_netlink.c:1304
 netlink_unicast+0x118/0x208 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x3f8/0x4b4 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg net/socket.c:671 [inline]
 ____sys_sendmsg+0x314/0x470 net/socket.c:2353
 ___sys_sendmsg net/socket.c:2407 [inline]
 __sys_sendmsg+0x10c/0x1d8 net/socket.c:2440
 __do_sys_sendmsg net/socket.c:2449 [inline]
 __se_sys_sendmsg net/socket.c:2447 [inline]
 __arm64_sys_sendmsg+0x4c/0x5c net/socket.c:2447
 __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
 el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
 do_el0_svc+0x120/0x290 arch/arm64/kernel/syscall.c:220
 el0_svc+0x1c/0x28 arch/arm64/kernel/entry-common.c:367
 el0_sync_handler+0x98/0x170 arch/arm64/kernel/entry-common.c:383
 el0_sync+0x140/0x180 arch/arm64/kernel/entry.S:670

Freed by task 6022:
 stack_trace_save+0x80/0xb8 kernel/stacktrace.c:121
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track+0x38/0x6c mm/kasan/common.c:56
 kasan_set_free_info+0x20/0x40 mm/kasan/generic.c:355
 __kasan_slab_free+0x124/0x150 mm/kasan/common.c:422
 kasan_slab_free+0x10/0x1c mm/kasan/common.c:431
 slab_free_hook mm/slub.c:1544 [inline]
 slab_free_freelist_hook mm/slub.c:1577 [inline]
 slab_free mm/slub.c:3142 [inline]
 kfree+0x104/0x38c mm/slub.c:4124
 uvc_delete drivers/media/usb/uvc/uvc_driver.c:1987 [inline]
 kref_put+0x1f8/0x250 include/linux/kref.h:65
 free_fw_priv drivers/base/firmware_loader/main.c:289 [inline]
 firmware_free_data drivers/base/firmware_loader/main.c:584 [inline]
 release_firmware drivers/base/firmware_loader/main.c:1053 [inline]
 _request_firmware+0x534/0x814 drivers/base/firmware_loader/main.c:839
 request_firmware+0x48/0x68 drivers/base/firmware_loader/main.c:875
 reg_reload_regdb+0x40/0x148 net/wireless/reg.c:1083
 nl80211_reload_regdb+0x10/0x18 net/wireless/nl80211.c:7067
 genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x6e8/0x784 net/netlink/genetlink.c:800
 netlink_rcv_skb+0xe0/0x1bc net/netlink/af_netlink.c:2494
 genl_rcv+0x34/0x48 net/netlink/genetlink.c:811
 netlink_unicast_kernel+0x170/0x228 net/netlink/af_netlink.c:1304
 netlink_unicast+0x118/0x208 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x3f8/0x4b4 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg net/socket.c:671 [inline]
 ____sys_sendmsg+0x314/0x470 net/socket.c:2353
 ___sys_sendmsg net/socket.c:2407 [inline]
 __sys_sendmsg+0x10c/0x1d8 net/socket.c:2440
 __do_sys_sendmsg net/socket.c:2449 [inline]
 __se_sys_sendmsg net/socket.c:2447 [inline]
 __arm64_sys_sendmsg+0x4c/0x5c net/socket.c:2447
 __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
 el0_svc_common arch/arm64/kernel/syscall.c:158 [inline]
 do_el0_svc+0x120/0x290 arch/arm64/kernel/syscall.c:220
 el0_svc+0x1c/0x28 arch/arm64/kernel/entry-common.c:367
 el0_sync_handler+0x98/0x170 arch/arm64/kernel/entry-common.c:383
 el0_sync+0x140/0x180 arch/arm64/kernel/entry.S:670

The buggy address belongs to the object at ffff0000d7471400
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 144 bytes inside of
 256-byte region [ffff0000d7471400, ffff0000d7471500)
The buggy address belongs to the page:
page:0000000001e413c8 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x117470
head:0000000001e413c8 order:2 compound_mapcount:0 compound_pincount:0
flags: 0x5ffc00000010200(slab|head)
raw: 05ffc00000010200 dead000000000100 dead000000000122 ffff0000c0003b00
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d7471380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000d7471400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff0000d7471480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff0000d7471500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000d7471580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================



> 
> Having a possible impact described in the commit log is useful for folks
> who may want to put effort into backporting this for for older kernels
> in case it does not apply as-is.
> 
>  Luis
> .
> 

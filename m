Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8BC4568D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhKSDz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:55:58 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27145 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhKSDz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:55:57 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HwN3n6bMCz1DJZv
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 11:50:29 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 11:52:55 +0800
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 11:52:54 +0800
To:     <linux-kernel@vger.kernel.org>
CC:     "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
Subject: [BUG] kmemleak: unable to handle page fault for address:
 fffffbfff4182000
Message-ID: <c85edd7f-b26d-b511-6807-cb9b126bf6cc@huawei.com>
Date:   Fri, 19 Nov 2021 11:52:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.155]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We found that the kmemleak not worked very well with KASAN enabled on 
linux master
when we insmod and rmmod modules frequently:

BUG: unable to handle page fault for address: fffffbfff4182000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 123fd0067 P4D 123fd0067 PUD 123fcc067 PMD 107a61067 PTE 0
Oops: 0000 [#1] SMP KASAN
CPU: 2 PID: 185 Comm: kmemleak Not tainted 5.15.0 #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:crc32_le_base+0x78/0x590
Code: ec 48 89 44 24 10 48 8d 44 05 fc 48 bd 00 00 00 00 00 fc ff df 48 
89 04 24 e8 84 94 04 ff 49 8d 7c 24 04 48 89 f8 48 c1 e8 03 <0f> b6 14 
28 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 d3
RSP: 0018:ffff888012507dd0 EFLAGS: 00010806
RAX: 1ffffffff4182000 RBX: 0000000000003600 RCX: 0000000000000000
RDX: ffff8880124c0040 RSI: ffffffff823e5ddc RDI: ffffffffa0c10000
RBP: dffffc0000000000 R08: 0000000000000004 R09: ffffed10024a0fbd
R10: 0000000000000003 R11: ffffed10024a0fbd R12: ffffffffa0c0fffc
R13: ffffffffa0c0fffc R14: ffff88801dac87fc R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88810b700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4182000 CR3: 000000004a66d005 CR4: 0000000000770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
? _raw_spin_unlock_irqrestore+0x40/0x60
kmemleak_scan+0x735/0xca0
? scan_gray_list+0x430/0x430
? __mutex_lock_slowpath+0x10/0x10
? __mutex_unlock_slowpath.isra.18+0x320/0x320
? __kthread_parkme+0xc7/0x140
? kmemleak_write.cold.31+0x29/0x29
kmemleak_scan_thread+0x98/0xb3
kthread+0x346/0x420
? set_kthread_struct+0x110/0x110
ret_from_fork+0x1f/0x30
Modules linked in: ubi(+) nandsim [last unloaded: nandsim]
CR2: fffffbfff4182000
---[ end trace 122ede50ee8d0c8a ]---

and we found the address belongs to kasan shadow region. the kmemleak 
and kasan may not handle concurrency very well. I have tried disable 
kasan instrumentation of kmemleak but not solved it.
the problem was also found in linux-5.10. And linux-5.10 got another 
stack sometimes, I'm not
sure If the problem is the same:

BUG: unable to handle page fault for address: fffffbfff40b7000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 123fd0067 P4D 123fd0067 PUD 123fcc067 PMD 10aa2c067 PTE 0
Oops: 0000 [#1] SMP KASAN
CPU: 0 PID: 179 Comm: kmemleak Tainted: G    B 
5.10.0-10155-g3681f87982b3-dirty #154
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:scan_block+0x5d/0x240
Code: eb 0f 83 98 01 00 00 49 bc 00 00 00 00 00 fc ff df e8 17 ff ff ff 
85 c0 0f 85 81 01 00 00 e8 0a 4f fa ff 48 89 d8 48 c1 e8 03 <42> 80 3c 
20 00 0f 85 87 01 00 00 48 8b 2b e8 d0 4e fa ff 48 39 2d
RSP: 0018:ffff88800faa7db8 EFLAGS: 00010806
RAX: 1ffffffff40b7000 RBX: ffffffffa05b8000 RCX: ffffffff811f89cb
RDX: 1ffff110204991a0 RSI: 0000000000000008 RDI: ffff8881024c8d00
RBP: ffffffffa05b9000 R08: ffffed10204991a1 R09: ffffed10204991a1
R10: ffff8881024c8d07 R11: fffed10204991a0 R12: dffffc0000000000
R13: ffffffffa05b8ff9 R14: ffff8880457e1488 R15: 0000000000000046
FS:  0000000000000000(0000) GS:ffff88810b400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff40b7000 CR3: 000000006e88a005 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
scan_gray_list+0x25a/0x430
kmemleak_scan+0x672/0xd80
? kmemleak_seq_show+0x170/0x170
? __mutex_lock_slowpath+0x10/0x10
? kmemleak_write.cold.21+0x29/0x29
kmemleak_scan_thread+0x98/0xb3
kthread+0x32d/0x3f0
? __kthread_cancel_work+0x190/0x190
ret_from_fork+0x1f/0x30
Modules linked in: ubifs ubi nandsim [last unloaded: nandsim]
CR2: fffffbfff40b7000
---[ end trace 48e75df3be17140f ]---

Kind regards,

Yongqiang Liu


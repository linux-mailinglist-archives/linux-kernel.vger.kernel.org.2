Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B50145D589
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhKYHhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:37:32 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15865 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbhKYHfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:35:23 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J08hH5mwVz914Z;
        Thu, 25 Nov 2021 15:31:43 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 15:32:11 +0800
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 15:32:10 +0800
Subject: [BUG] use-after-free in ksm_might_need_to_copy with KSM and swap
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <hughd@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sunnanyong <sunnanyong@huawei.com>
References: <9f33d4a1-6cd5-ed3d-abfd-d6d434ae8925@huawei.com>
Message-ID: <f3220392-800d-f273-eae0-0f3cc0e94cb7@huawei.com>
Date:   Thu, 25 Nov 2021 15:32:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9f33d4a1-6cd5-ed3d-abfd-d6d434ae8925@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.79]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hughd and mm experts,

We have a problem that KASAN catches several times of use-after-free in 
ksm_might_need_to_copy+0x12e/0x5b0,

code is at do_swap_page -> ksm_might_need_to_copy

struct page *ksm_might_need_to_copy(struct page *page,
                         struct vm_area_struct *vma, unsigned long address)
{
         struct anon_vma *anon_vma = page_anon_vma(page);
         struct page *new_page;

         if (PageKsm(page)) {
                 if (page_stable_node(page) &&
                     !(ksm_run & KSM_RUN_UNMERGE))
                         return page;    /* no need to copy it */
         } else if (!anon_vma) {
                 return page;            /* no need to copy it */
         } else if (anon_vma->root  ======>this pointer trigger the 
use-after-free when run this line

The anon_vma from page->mapping was freed before.


Reproduce scenario:

Intel platform server, enable KSM and swap, with 7 virtual machines 
repeatly do suspend and resume so that

host will do swap out and swap in, VMs consume same content pages so 
that host will raise KSM merging.


KASAN report:

Log1:

[1023457.339223] 
==================================================================
[1023457.339236] BUG: KASAN: use-after-free in 
ksm_might_need_to_copy+0x12e/0x5b0
[1023457.339238] Read of size 8 at addr ffff88be9977dbd0 by task 
khugepaged/694
[1023457.339239]
[1023457.339243] CPU: 8 PID: 694 Comm: khugepaged Kdump: loaded Tainted: 
G           OE    --------- -  - 4.18.0.x86_64
[1023457.339245] Hardware name: Huawei 1288H V5/BC11SPSC0, BIOS 7.93 
01/14/2021
[1023457.339246] Call Trace:
[1023457.339254]  dump_stack+0xf1/0x19b
[1023457.339272]  print_address_description+0x70/0x360
[1023457.339276]  kasan_report+0x1b2/0x330
[1023457.339285]  ksm_might_need_to_copy+0x12e/0x5b0
[1023457.339327]  do_swap_page+0x452/0xe70
[1023457.339380]  __collapse_huge_page_swapin+0x24b/0x720
[1023457.339410]  khugepaged_scan_pmd+0xcae/0x1ff0
[1023457.339464]  khugepaged+0x8ee/0xd70
[1023457.339506]  kthread+0x1a2/0x1d0
[1023457.339511]  ret_from_fork+0x1f/0x40
[1023457.339513]
[1023457.339515] Allocated by task 2306153:
[1023457.339517]  kasan_kmalloc+0xa0/0xd0
[1023457.339519]  kmem_cache_alloc+0xc0/0x1c0
[1023457.339521]  anon_vma_clone+0xf7/0x380
[1023457.339522]  anon_vma_fork+0xc0/0x390
[1023457.339526]  copy_process+0x447b/0x4810
[1023457.339527]  _do_fork+0x118/0x620
[1023457.339531]  do_syscall_64+0x112/0x360
[1023457.339533]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[1023457.339534]
[1023457.339535] Freed by task 2306242:
[1023457.339537]  __kasan_slab_free+0x130/0x180
[1023457.339538]  kmem_cache_free+0x78/0x1d0
[1023457.339540]  unlink_anon_vmas+0x19c/0x4a0
[1023457.339542]  free_pgtables+0x137/0x1b0
[1023457.339544]  exit_mmap+0x133/0x320
[1023457.339546]  mmput+0x15e/0x390
[1023457.339547]  do_exit+0x8c5/0x1210
[1023457.339549]  do_group_exit+0xb5/0x1b0
[1023457.339550]  __x64_sys_exit_group+0x21/0x30
[1023457.339552]  do_syscall_64+0x112/0x360
[1023457.339554]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[1023457.339555]
[1023457.339557] The buggy address belongs to the object at 
ffff88be9977dba0
  which belongs to the cache anon_vma_chain of size 64
[1023457.339559] The buggy address is located 48 bytes inside of
  64-byte region [ffff88be9977dba0, ffff88be9977dbe0)
[1023457.339560] The buggy address belongs to the page:
[1023457.339562] page:ffffea00fa65df40 count:1 mapcount:0 
mapping:ffff888107717800 index:0x0
[1023457.347802] flags: 0x17ffffc0000100(slab)


Log2:

==================================================================
BUG: KASAN: slab-out-of-bounds in ksm_might_need_to_copy+0x12e/0x5b0
Read of size 8 at addr ffff889e042facb0 by task CPU 1/KVM/93525
CPU: 8 PID: 93525 Comm: CPU 1/KVM Kdump: loaded Tainted: G O -----
---- - - 4.18.0.x86_64 #1
Hardware name: Suma H620-G30/65N32-US, BIOS CQL1051209 05/12/2021
Call Trace:
dump_stack+0xf1/0x19b
print_address_description+0x70/0x360
kasan_report+0x1b2/0x330
ksm_might_need_to_copy+0x12e/0x5b0
do_swap_page+0x452/0xe70
__handle_mm_fault+0x96b/0xa20
handle_mm_fault+0x1bd/0x450
__get_user_pages+0x476/0x10e0
get_user_pages_unlocked+0x1e0/0x380
__gfn_to_pfn_memslot+0x728/0xb20 [kvm]
try_async_pf+0x138/0x5d0 [kvm]
tdp_page_fault+0x336/0x730 [kvm]
kvm_mmu_page_fault+0x17c/0xcd0 [kvm]
npf_interception+0xf4/0x200 [kvm_amd]
handle_exit+0x7a9/0x9a0 [kvm_amd]
vcpu_enter_guest+0x8eb/0x2950 [kvm]
kvm_arch_vcpu_ioctl_run+0x4d4/0xa30 [kvm]
kvm_vcpu_ioctl+0x675/0xb50 [kvm]
do_vfs_ioctl+0x134/0xa10
ksys_ioctl+0x70/0x80
__x64_sys_ioctl+0x3d/0x50
do_syscall_64+0x112/0x360
entry_SYSCALL_64_after_hwframe+0x65/0xca
RIP: 0033:0x7fa429acb527
Code: b3 66 90 48 8b 05 79 19 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff 
ff ff c3
66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 
73 01 c3
48 8b 0d 49 19 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fa4232ecde8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007fa429acb527
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000019
RBP: 0000000000000000 R08: 00007fa429888af0 R09: 0000000000000001
R10: 0000000000000002 R11: 0000000000000246 R12: 000055d23727b240
R13: 000055d23727b2de R14: 0000000000000000 R15: 0000000000000000

Allocated by task 99792:
kasan_kmalloc+0xa0/0xd0
kmem_cache_alloc_trace+0xf3/0x1e0
single_open+0x36/0xe0
do_dentry_open+0x373/0x680
path_openat+0xca2/0x29d0
do_filp_open+0x177/0x220
do_sys_open+0x2d0/0x3a0
do_syscall_64+0x112/0x360
entry_SYSCALL_64_after_hwframe+0x65/0xca

Freed by task 99792:
__kasan_slab_free+0x130/0x180
kfree+0x90/0x1b0
single_release+0x51/0x60
__fput+0x1df/0x490
task_work_run+0x13f/0x190
exit_to_usermode_loop+0x1a2/0x1b0
do_syscall_64+0x326/0x360
entry_SYSCALL_64_after_hwframe+0x65/0xca

The buggy address belongs to the object at ffff889e042fac90
which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
32-byte region [ffff889e042fac90, ffff889e042facb0)
The buggy address belongs to the page:
page:ffffea007810be80 count:1 mapcount:0 mapping:ffff888107c10580 index:0x0
flags: 0x57ffffc0000100(slab)
raw: 0057ffffc0000100 ffffea0077a2bd88 ffffea007857dc08 ffff888107c10580
raw: 0000000000000000 0000000000550055 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
Memory state around the buggy address:
ffff889e042fab80: fb fb fc fc fb fb fb fb fc fc fb fb fb fb fc fc
ffff889e042fac00: fb fb fb fb fc fc fb fb fb fb fc fc fb fb fb fb
 >ffff889e042fac80: fc fc fb fb fb fb fc fc fb fb fb fb fc fc fb fb
^
ffff889e042fad00: fb fb fc fc fb fb fb fb fc fc fb fb fb fb fc fc
ffff889e042fad80: fb fb fb fb fc fc fb fb fb fb fc fc fb fb fb fb
==================================================================
Disabling lock debugging due to kernel taint

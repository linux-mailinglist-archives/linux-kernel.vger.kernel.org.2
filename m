Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3415945FEB0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 13:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351221AbhK0M5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 07:57:47 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28184 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhK0Mzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 07:55:46 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J1WgH4KGfz8vW2;
        Sat, 27 Nov 2021 20:50:35 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 20:52:29 +0800
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 20:52:28 +0800
Subject: Re: [BUG] use-after-free in ksm_might_need_to_copy with KSM and swap
To:     <hughd@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <9f33d4a1-6cd5-ed3d-abfd-d6d434ae8925@huawei.com>
 <f3220392-800d-f273-eae0-0f3cc0e94cb7@huawei.com>
From:   Nanyong Sun <sunnanyong@huawei.com>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <liam.howlett@oracle.com>, <linmiaohe@huawei.com>,
        <songmuchun@bytedance.com>, <chenli@uniontech.com>,
        <bharata@linux.ibm.com>, <aarcange@redhat.com>
Message-ID: <81416741-d11c-61d4-26f9-4546dd874581@huawei.com>
Date:   Sat, 27 Nov 2021 20:52:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f3220392-800d-f273-eae0-0f3cc0e94cb7@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.79]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest release kernel v5.15.5 can also reproduce this problem,  it 
seems related to KSM because

we cann't reproduce this when disable KSM by "echo 0 > 
/sys/kernel/mm/ksm/run".

I have analysed the vmcore and it shows that the page is in swap cache, 
its _mapcount is -1(0xffffffff).

Kasan report on v5.15.5:

[ 2921.508794] 
==================================================================
[ 2921.508799] BUG: KASAN: use-after-free in 
ksm_might_need_to_copy+0x65/0x390
[ 2921.508809] Read of size 8 at addr ffff888bd2380690 by task CPU 
1/KVM/101903

[ 2921.508816] CPU: 12 PID: 101903 Comm: CPU 1/KVM Tainted: G S        
I       5.15.5 #1
[ 2921.508821] Hardware name: Huawei 2288H V5/BC11SPSCB0, BIOS 1.09 
01/31/2019
[ 2921.508825] Call Trace:
[ 2921.508828]  <TASK>
[ 2921.508830]  dump_stack_lvl+0x34/0x44
[ 2921.508839]  print_address_description.constprop.0+0x1d/0xa0
[ 2921.508852]  __kasan_report.cold+0x37/0x87
[ 2921.508870]  kasan_report+0x38/0x50
[ 2921.508876]  ksm_might_need_to_copy+0x65/0x390
[ 2921.508885]  do_swap_page+0x37a/0xd40
[ 2921.508891]  __handle_mm_fault+0x8fd/0xac0
[ 2921.508915]  handle_mm_fault+0x103/0x380
[ 2921.508920]  __get_user_pages+0x2eb/0x5d0
[ 2921.508932]  get_user_pages_unlocked+0x129/0x400
[ 2921.508950]  hva_to_pfn+0x196/0x480 [kvm]
[ 2921.509631]  kvm_faultin_pfn+0x10e/0x470 [kvm]
[ 2921.510524]  direct_page_fault+0x243/0x500 [kvm]
[ 2921.510931]  kvm_mmu_page_fault+0x9c/0x260 [kvm]
[ 2921.511153]  vmx_handle_exit+0x11/0x80 [kvm_intel]
[ 2921.511193]  vcpu_enter_guest+0x1054/0x1c30 [kvm]
[ 2921.512289]  vcpu_run+0xa6/0x3a0 [kvm]
[ 2921.512464]  kvm_arch_vcpu_ioctl_run+0x112/0x390 [kvm]
[ 2921.512638]  kvm_vcpu_ioctl+0x3c6/0x860 [kvm]
[ 2921.513180]  __x64_sys_ioctl+0xb9/0xf0
[ 2921.513185]  do_syscall_64+0x5c/0x80
[ 2921.513249]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2921.513256] RIP: 0033:0x7f1098993527
[ 2921.513260] Code: b3 66 90 48 8b 05 79 19 0c 00 64 c7 00 26 00 00 00 
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 49 19 0c 00 f7 d8 64 89 01 48
[ 2921.513265] RSP: 002b:00007f1096223de8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[ 2921.513271] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 
00007f1098993527
[ 2921.513275] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 
0000000000000019
[ 2921.513278] RBP: 0000000000000000 R08: 00007f1098750ab0 R09: 
00007f10987fb300
[ 2921.513281] R10: 0000000000000000 R11: 0000000000000246 R12: 
000055db8febd780
[ 2921.513284] R13: 000055db8febd81e R14: 000055db8fed47e0 R15: 
00007ffeb0b3c140
[ 2921.513288]  </TASK>

[ 2921.513292] Allocated by task 91947:
[ 2921.513294]  kasan_save_stack+0x1b/0x40
[ 2921.513300]  __kasan_slab_alloc+0x61/0x80
[ 2921.513304]  kmem_cache_alloc+0x133/0x2b0
[ 2921.513309]  __anon_vma_prepare+0x191/0x260
[ 2921.513313]  do_huge_pmd_anonymous_page+0x514/0x750
[ 2921.513318]  __handle_mm_fault+0xab7/0xac0
[ 2921.513322]  handle_mm_fault+0x103/0x380
[ 2921.513326]  __get_user_pages+0x2eb/0x5d0
[ 2921.513331]  get_user_pages_unlocked+0x129/0x400
[ 2921.513335]  hva_to_pfn+0x196/0x480 [kvm]
[ 2921.513501]  kvm_faultin_pfn+0x10e/0x470 [kvm]
[ 2921.513682]  direct_page_fault+0x243/0x500 [kvm]
[ 2921.513864]  kvm_mmu_page_fault+0x9c/0x260 [kvm]
[ 2921.514049]  vmx_handle_exit+0x11/0x80 [kvm_intel]
[ 2921.514087]  vcpu_enter_guest+0x1054/0x1c30 [kvm]
[ 2921.514260]  vcpu_run+0xa6/0x3a0 [kvm]
[ 2921.514433]  kvm_arch_vcpu_ioctl_run+0x112/0x390 [kvm]
[ 2921.514606]  kvm_vcpu_ioctl+0x3c6/0x860 [kvm]
[ 2921.514771]  __x64_sys_ioctl+0xb9/0xf0
[ 2921.514774]  do_syscall_64+0x5c/0x80
[ 2921.514778]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[ 2921.514785] Freed by task 504:
[ 2921.514788]  kasan_save_stack+0x1b/0x40
[ 2921.514792]  kasan_set_track+0x1c/0x30
[ 2921.514797]  kasan_set_free_info+0x20/0x30
[ 2921.514802]  __kasan_slab_free+0xeb/0x120
[ 2921.514806]  kmem_cache_free+0x8b/0x2d0
[ 2921.514811]  __put_anon_vma+0x59/0x120
[ 2921.514814]  remove_rmap_item_from_tree+0x237/0x260
[ 2921.514818]  scan_get_next_rmap_item+0x104/0x7d0
[ 2921.514822]  ksm_scan_thread+0x12a/0x480
[ 2921.514826]  kthread+0x1a7/0x1d0
[ 2921.514832]  ret_from_fork+0x22/0x30

[ 2921.514839] The buggy address belongs to the object at ffff888bd2380690
                 which belongs to the cache anon_vma of size 80
[ 2921.514843] The buggy address is located 0 bytes inside of
                 80-byte region [ffff888bd2380690, ffff888bd23806e0)
[ 2921.514847] The buggy address belongs to the page:
[ 2921.514849] page:00000000fb434e9d refcount:1 mapcount:0 
mapping:0000000000000000 index:0x0 pfn:0xbd2380
[ 2921.514854] memcg:ffff8890a291f001
[ 2921.514856] flags: 
0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
[ 2921.514864] raw: 0017ffffc0000200 0000000000000000 0000000500000001 
ffff888100061680
[ 2921.514868] raw: 0000000000000000 0000000000220022 00000001ffffffff 
ffff8890a291f001
[ 2921.514870] page dumped because: kasan: bad access detected

[ 2921.514874] Memory state around the buggy address:
[ 2921.514877]  ffff888bd2380580: fc fc fc fc fa fb fb fb fb fb fb fb fb 
fb fc fc
[ 2921.514882]  ffff888bd2380600: fc fc fc fa fb fb fb fb fb fb fb fb fb 
fc fc fc
[ 2921.514885] >ffff888bd2380680: fc fc fa fb fb fb fb fb fb fb fb fb fc 
fc fc fc
[ 2921.514888]                          ^
[ 2921.514890]  ffff888bd2380700: fc fa fb fb fb fb fb fb fb fb fb fc fc 
fc fc fc
[ 2921.514893]  ffff888bd2380780: fa fb fb fb fb fb fb fb fb fb fc fc fc 
fc fc fa
[ 2921.514896] 
==================================================================

在 2021/11/25 15:32, Nanyong Sun 写道:
> Hi hughd and mm experts,
>
> We have a problem that KASAN catches several times of use-after-free 
> in ksm_might_need_to_copy+0x12e/0x5b0,
>
> code is at do_swap_page -> ksm_might_need_to_copy
>
> struct page *ksm_might_need_to_copy(struct page *page,
>                         struct vm_area_struct *vma, unsigned long 
> address)
> {
>         struct anon_vma *anon_vma = page_anon_vma(page);
>         struct page *new_page;
>
>         if (PageKsm(page)) {
>                 if (page_stable_node(page) &&
>                     !(ksm_run & KSM_RUN_UNMERGE))
>                         return page;    /* no need to copy it */
>         } else if (!anon_vma) {
>                 return page;            /* no need to copy it */
>         } else if (anon_vma->root  ======>this pointer trigger the 
> use-after-free when run this line
>
> The anon_vma from page->mapping was freed before.
>
>
> Reproduce scenario:
>
> Intel platform server, enable KSM and swap, with 7 virtual machines 
> repeatly do suspend and resume so that
>
> host will do swap out and swap in, VMs consume same content pages so 
> that host will raise KSM merging.
>
>
> KASAN report:
>
> Log1:
>
> [1023457.339223] 
> ==================================================================
> [1023457.339236] BUG: KASAN: use-after-free in 
> ksm_might_need_to_copy+0x12e/0x5b0
> [1023457.339238] Read of size 8 at addr ffff88be9977dbd0 by task 
> khugepaged/694
> [1023457.339239]
> [1023457.339243] CPU: 8 PID: 694 Comm: khugepaged Kdump: loaded 
> Tainted: G           OE    --------- -  - 4.18.0.x86_64
> [1023457.339245] Hardware name: Huawei 1288H V5/BC11SPSC0, BIOS 7.93 
> 01/14/2021
> [1023457.339246] Call Trace:
> [1023457.339254]  dump_stack+0xf1/0x19b
> [1023457.339272]  print_address_description+0x70/0x360
> [1023457.339276]  kasan_report+0x1b2/0x330
> [1023457.339285]  ksm_might_need_to_copy+0x12e/0x5b0
> [1023457.339327]  do_swap_page+0x452/0xe70
> [1023457.339380]  __collapse_huge_page_swapin+0x24b/0x720
> [1023457.339410]  khugepaged_scan_pmd+0xcae/0x1ff0
> [1023457.339464]  khugepaged+0x8ee/0xd70
> [1023457.339506]  kthread+0x1a2/0x1d0
> [1023457.339511]  ret_from_fork+0x1f/0x40
> [1023457.339513]
> [1023457.339515] Allocated by task 2306153:
> [1023457.339517]  kasan_kmalloc+0xa0/0xd0
> [1023457.339519]  kmem_cache_alloc+0xc0/0x1c0
> [1023457.339521]  anon_vma_clone+0xf7/0x380
> [1023457.339522]  anon_vma_fork+0xc0/0x390
> [1023457.339526]  copy_process+0x447b/0x4810
> [1023457.339527]  _do_fork+0x118/0x620
> [1023457.339531]  do_syscall_64+0x112/0x360
> [1023457.339533]  entry_SYSCALL_64_after_hwframe+0x65/0xca
> [1023457.339534]
> [1023457.339535] Freed by task 2306242:
> [1023457.339537]  __kasan_slab_free+0x130/0x180
> [1023457.339538]  kmem_cache_free+0x78/0x1d0
> [1023457.339540]  unlink_anon_vmas+0x19c/0x4a0
> [1023457.339542]  free_pgtables+0x137/0x1b0
> [1023457.339544]  exit_mmap+0x133/0x320
> [1023457.339546]  mmput+0x15e/0x390
> [1023457.339547]  do_exit+0x8c5/0x1210
> [1023457.339549]  do_group_exit+0xb5/0x1b0
> [1023457.339550]  __x64_sys_exit_group+0x21/0x30
> [1023457.339552]  do_syscall_64+0x112/0x360
> [1023457.339554]  entry_SYSCALL_64_after_hwframe+0x65/0xca
> [1023457.339555]
> [1023457.339557] The buggy address belongs to the object at 
> ffff88be9977dba0
>  which belongs to the cache anon_vma_chain of size 64
> [1023457.339559] The buggy address is located 48 bytes inside of
>  64-byte region [ffff88be9977dba0, ffff88be9977dbe0)
> [1023457.339560] The buggy address belongs to the page:
> [1023457.339562] page:ffffea00fa65df40 count:1 mapcount:0 
> mapping:ffff888107717800 index:0x0
> [1023457.347802] flags: 0x17ffffc0000100(slab)
>
>
> Log2:
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in ksm_might_need_to_copy+0x12e/0x5b0
> Read of size 8 at addr ffff889e042facb0 by task CPU 1/KVM/93525
> CPU: 8 PID: 93525 Comm: CPU 1/KVM Kdump: loaded Tainted: G O -----
> ---- - - 4.18.0.x86_64 #1
> Hardware name: Suma H620-G30/65N32-US, BIOS CQL1051209 05/12/2021
> Call Trace:
> dump_stack+0xf1/0x19b
> print_address_description+0x70/0x360
> kasan_report+0x1b2/0x330
> ksm_might_need_to_copy+0x12e/0x5b0
> do_swap_page+0x452/0xe70
> __handle_mm_fault+0x96b/0xa20
> handle_mm_fault+0x1bd/0x450
> __get_user_pages+0x476/0x10e0
> get_user_pages_unlocked+0x1e0/0x380
> __gfn_to_pfn_memslot+0x728/0xb20 [kvm]
> try_async_pf+0x138/0x5d0 [kvm]
> tdp_page_fault+0x336/0x730 [kvm]
> kvm_mmu_page_fault+0x17c/0xcd0 [kvm]
> npf_interception+0xf4/0x200 [kvm_amd]
> handle_exit+0x7a9/0x9a0 [kvm_amd]
> vcpu_enter_guest+0x8eb/0x2950 [kvm]
> kvm_arch_vcpu_ioctl_run+0x4d4/0xa30 [kvm]
> kvm_vcpu_ioctl+0x675/0xb50 [kvm]
> do_vfs_ioctl+0x134/0xa10
> ksys_ioctl+0x70/0x80
> __x64_sys_ioctl+0x3d/0x50
> do_syscall_64+0x112/0x360
> entry_SYSCALL_64_after_hwframe+0x65/0xca
> RIP: 0033:0x7fa429acb527
> Code: b3 66 90 48 8b 05 79 19 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff 
> ff ff ff c3
> 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 
> 73 01 c3
> 48 8b 0d 49 19 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007fa4232ecde8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007fa429acb527
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000019
> RBP: 0000000000000000 R08: 00007fa429888af0 R09: 0000000000000001
> R10: 0000000000000002 R11: 0000000000000246 R12: 000055d23727b240
> R13: 000055d23727b2de R14: 0000000000000000 R15: 0000000000000000
>
> Allocated by task 99792:
> kasan_kmalloc+0xa0/0xd0
> kmem_cache_alloc_trace+0xf3/0x1e0
> single_open+0x36/0xe0
> do_dentry_open+0x373/0x680
> path_openat+0xca2/0x29d0
> do_filp_open+0x177/0x220
> do_sys_open+0x2d0/0x3a0
> do_syscall_64+0x112/0x360
> entry_SYSCALL_64_after_hwframe+0x65/0xca
>
> Freed by task 99792:
> __kasan_slab_free+0x130/0x180
> kfree+0x90/0x1b0
> single_release+0x51/0x60
> __fput+0x1df/0x490
> task_work_run+0x13f/0x190
> exit_to_usermode_loop+0x1a2/0x1b0
> do_syscall_64+0x326/0x360
> entry_SYSCALL_64_after_hwframe+0x65/0xca
>
> The buggy address belongs to the object at ffff889e042fac90
> which belongs to the cache kmalloc-32 of size 32
> The buggy address is located 0 bytes to the right of
> 32-byte region [ffff889e042fac90, ffff889e042facb0)
> The buggy address belongs to the page:
> page:ffffea007810be80 count:1 mapcount:0 mapping:ffff888107c10580 
> index:0x0
> flags: 0x57ffffc0000100(slab)
> raw: 0057ffffc0000100 ffffea0077a2bd88 ffffea007857dc08 ffff888107c10580
> raw: 0000000000000000 0000000000550055 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> Memory state around the buggy address:
> ffff889e042fab80: fb fb fc fc fb fb fb fb fc fc fb fb fb fb fc fc
> ffff889e042fac00: fb fb fb fb fc fc fb fb fb fb fc fc fb fb fb fb
> >ffff889e042fac80: fc fc fb fb fb fb fc fc fb fb fb fb fc fc fb fb
> ^
> ffff889e042fad00: fb fb fc fc fb fb fb fb fc fc fb fb fb fb fc fc
> ffff889e042fad80: fb fb fb fb fc fc fb fb fb fb fc fc fb fb fb fb
> ==================================================================
> Disabling lock debugging due to kernel taint

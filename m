Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2973C3E87F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhHKCXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:23:02 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:35005 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbhHKCXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628648559; x=1660184559;
  h=to:from:subject:cc:message-id:date:mime-version:
   content-transfer-encoding;
  bh=uzfAKJW4QCRHleXsZCsSjYHBIkwZkBLJGOWRxJ2T+/c=;
  b=iAPlFfi0XAB7LCfuf+Dx+Dqr5vVXffz6UQeOyWY+NvX2MJEf6VfLyvgY
   +y6K+kGBbqUxoW6kLh4upJ0YXeYGPd09mLYtJomDSpHujsV+iC0IHNUoj
   RPRkKMaHVeYuIfEus/wwDLLKoFlJDw1wNfexKnUBnarHpqYk+CFPJILgP
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Aug 2021 19:22:39 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Aug 2021 19:22:38 -0700
Received: from [10.111.168.10] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 10 Aug
 2021 19:22:38 -0700
To:     Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Subject: Linux-next: crash in alloc_huge_page()
CC:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <846c4502-3332-0d25-87f5-cb3b71afc38f@quicinc.com>
Date:   Tue, 10 Aug 2021 22:22:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03e.na.qualcomm.com (10.85.0.48) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running a syscall fuzzer on the latest linux-next shortly will always trigger a crash in
alloc_huge_page(). It pointed to this line,

list_add(&page->lru, &h->hugepage_activelist);

and the page->lru has an address fffffffffffffffc for some reasons. Does it sound like some error code
had not been handled properly and had been propagated here instead? I tried reverting a few recent
commits for mm/hugetlb.c and mm/memblock.c without luck so far.


[ 8107.262232][T62705] Unable to handle kernel paging request at virtual address fffffffffffffffc
[ 8107.271516][T62705] Mem abort info:
[ 8107.275008][T62705]   ESR = 0x96000046
[ 8107.278754][T62705]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 8107.284760][T62705]   SET = 0, FnV = 0
[ 8107.288509][T62705]   EA = 0, S1PTW = 0
[ 8107.292342][T62705]   FSC = 0x06: level 2 translation fault
[ 8107.297912][T62705] Data abort info:
[ 8107.301487][T62705]   ISV = 0, ISS = 0x00000046
[ 8107.306021][T62705]   CM = 0, WnR = 1
[ 8107.309687][T62705] swapper pgtable: 64k pages, 48-bit VAs, pgdp=0000009f6e080000
[ 8107.317168][T62705] [fffffffffffffffc] pgd=1000009ffef90803, p4d=1000009ffef90803, pud=1000009ffef90803, pmd=0000000000000000
[ 8107.328836][T62705] Internal error: Oops: 96000046 [#1] SMP
[ 8107.334409][T62705] Modules linked in: cpufreq_userspace xfs loop cppc_cpufreq processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit nvme i2c_core mlx5_core nvme_core firmware_class
[ 8107.352873][T62705] CPU: 14 PID: 62705 Comm: trinity-c3 Not tainted 5.14.0-rc5-next-20210810+ #88
[ 8107.361742][T62705] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
[ 8107.370258][T62705] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 8107.377907][T62705] pc : alloc_huge_page+0x8f4/0xbe0
__list_add at /usr/src/linux-next/./include/linux/list.h:71
(inlined by) list_add at /usr/src/linux-next/./include/linux/list.h:86
(inlined by) alloc_huge_page at /usr/src/linux-next/mm/hugetlb.c:2821
[ 8107.382873][T62705] lr : alloc_huge_page+0x8ac/0xbe0
[ 8107.387830][T62705] sp : ffff800028a8f4a0
[ 8107.391830][T62705] x29: ffff800028a8f4a0 x28: 0000000000000000 x27: ffff80001bc22e00
[ 8107.399659][T62705] x26: ffff80001bc22d68 x25: fffffffffffffffc x24: ffff0093d2952c00
[ 8107.407487][T62705] x23: 0000ffff00000000 x22: fffffffffffffff4 x21: ffff008c06a478c8
[ 8107.415314][T62705] x20: 1ffff00005151ea8 x19: 0000000000000001 x18: 0000000000000004
[ 8107.423141][T62705] x17: 1ffff0000323bb8f x16: 0000000000000000 x15: ffff0093d2953628
[ 8107.430969][T62705] x14: 0000000000000004 x13: 0000000000039c7c x12: ffff700005151e87
[ 8107.438796][T62705] x11: 1ffff00005151e86 x10: ffff700005151e86 x9 : dfff800000000000
[ 8107.446623][T62705] x8 : 0000000000000003 x7 : 0000000000000001 x6 : ffff800028a8f430
[ 8107.454450][T62705] x5 : 0000000000000004 x4 : 1ffff000037845c9 x3 : 0000800000000000
[ 8107.462277][T62705] x2 : ffff80001bc22e40 x1 : ffff80001bc22e40 x0 : 0000000000000004
[ 8107.470104][T62705] Call trace:
[ 8107.473237][T62705]  alloc_huge_page+0x8f4/0xbe0
[ 8107.477848][T62705]  hugetlb_no_page+0x214/0xba0
hugetlb_no_page at /usr/src/linux-next/mm/hugetlb.c:4905
[ 8107.482459][T62705]  hugetlb_fault+0x928/0xc88
[ 8107.486896][T62705]  handle_mm_fault+0x360/0x418
[ 8107.491508][T62705]  do_page_fault+0x220/0x880
[ 8107.495947][T62705]  do_translation_fault+0x7c/0xb0
[ 8107.500818][T62705]  do_mem_abort+0x70/0x1c8
[ 8107.505081][T62705]  el1_abort+0x44/0x68
[ 8107.508998][T62705]  el1h_64_sync_handler+0xb4/0xd0
[ 8107.513868][T62705]  el1h_64_sync+0x74/0x78
[ 8107.518045][T62705]  futex_cleanup+0x5d0/0x820
[ 8107.522483][T62705]  futex_exit_release+0x28/0x80
[ 8107.527180][T62705]  exit_mm_release+0x24/0x40
[ 8107.531619][T62705]  exit_mm+0x98/0x598
[ 8107.535449][T62705]  do_exit+0x4a0/0x1430
[ 8107.539451][T62705]  __secure_computing+0x178/0x1c8
[ 8107.544323][T62705]  syscall_trace_enter+0x580/0x870
[ 8107.549283][T62705]  do_el0_svc+0x1ec/0x2a8
[ 8107.553460][T62705]  el0_svc+0x64/0x130
[ 8107.557290][T62705]  el0t_64_sync_handler+0xb0/0xb8
[ 8107.562161][T62705]  el0t_64_sync+0x180/0x184
[ 8107.566515][T62705] Code: 38e06860 35001300 91002320 d2d00003 (f90006c2) 
[ 8107.573296][T62705] ---[ end trace 452794220e0c3075 ]---
[ 8107.578601][T62705] Kernel panic - not syncing: Oops: Fatal exception
[ 8107.585033][T62705] SMP: stopping secondary CPUs
[ 8107.589652][T62705] Kernel Offset: disabled
[ 8107.593826][T62705] CPU features: 0x00000251,20000846
[ 8107.598869][T62705] Memory Limit: none
[ 8107.602611][T62705] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

[  249.512894][ T1511] Unable to handle kernel paging request at virtual address fffffffffffffffc
[  249.521628][ T1511] Mem abort info:
[  249.525118][ T1511]   ESR = 0x96000046
[  249.528866][ T1511]   EC = 0x25: DABT (current EL), IL = 32 bits
[  249.534871][ T1511]   SET = 0, FnV = 0
[  249.538618][ T1511]   EA = 0, S1PTW = 0
[  249.542450][ T1511]   FSC = 0x06: level 2 translation fault
[  249.548020][ T1511] Data abort info:
[  249.551591][ T1511]   ISV = 0, ISS = 0x00000046
[  249.556118][ T1511]   CM = 0, WnR = 1
[  249.559777][ T1511] swapper pgtable: 64k pages, 48-bit VAs, pgdp=0000009f6e080000
[  249.567257][ T1511] [fffffffffffffffc] pgd=1000009ffef90803, p4d=1000009ffef90803, pud=1000009ffef90803, pmd=0000000000000000
[  249.578698][ T1511] Internal error: Oops: 96000046 [#1] SMP
[  249.584270][ T1511] Modules linked in: loop cppc_cpufreq processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit nvme mlx5_core i2c_core nvme_core firmware_class
[  249.600819][ T1511] CPU: 6 PID: 1511 Comm: trinity-main Not tainted 5.14.0-rc5-next-20210810+ #54
[  249.609683][ T1511] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
[  249.618199][ T1511] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  249.625849][ T1511] pc : alloc_huge_page+0x8ec/0xbd8
[  249.630812][ T1511] lr : alloc_huge_page+0x8a4/0xbd8
[  249.635770][ T1511] sp : ffff800023c4f550
[  249.639770][ T1511] x29: ffff800023c4f550 x28: 0000000000000000 x27: ffff80001bc22dc0
[  249.647598][ T1511] x26: ffff80001bc22d28 x25: fffffffffffffffc x24: ffff00088ad17dc0
[  249.655425][ T1511] x23: 0000ffff20000000 x22: fffffffffffffff4 x21: ffff0008db38d9d0
[  249.663251][ T1511] x20: 1ffff00004789ebe x19: 0000000000000001 x18: 0000000000000003
[  249.671078][ T1511] x17: 0000000000000000 x16: 0000000000000000 x15: ffff00088ad187e8
[  249.678905][ T1511] x14: 0000000000000003 x13: 0000000000010579 x12: ffff700004789e9d
[  249.686732][ T1511] x11: 1ffff00004789e9c x10: ffff700004789e9c x9 : dfff800000000000
[  249.694559][ T1511] x8 : 0000000000000003 x7 : 0000000000000001 x6 : ffff800023c4f4e0
[  249.702385][ T1511] x5 : 0000000000000004 x4 : 1ffff000037845c1 x3 : 0000800000000000
[  249.710212][ T1511] x2 : ffff80001bc22e00 x1 : ffff80001bc22e00 x0 : 0000000000000004
[  249.718039][ T1511] Call trace:
[  249.721172][ T1511]  alloc_huge_page+0x8ec/0xbd8
[  249.725783][ T1511]  hugetlb_no_page+0x214/0xba0
[  249.730394][ T1511]  hugetlb_fault+0x928/0xc88
[  249.734831][ T1511]  follow_hugetlb_page+0x28c/0x970
[  249.739788][ T1511]  __get_user_pages+0x180/0x8c8
[  249.744486][ T1511]  populate_vma_page_range+0x16c/0x200
[  249.749791][ T1511]  __mm_populate+0x170/0x2e8
[  249.754227][ T1511]  vm_mmap_pgoff+0x128/0x1c8
[  249.758665][ T1511]  ksys_mmap_pgoff+0x1e0/0x380
[  249.763276][ T1511]  __arm64_sys_mmap+0xd4/0x150
[  249.767888][ T1511]  invoke_syscall.constprop.0+0xdc/0x1d8
[  249.773368][ T1511]  do_el0_svc+0xe4/0x2a8
[  249.777457][ T1511]  el0_svc+0x64/0x130
[  249.781289][ T1511]  el0t_64_sync_handler+0xb0/0xb8
[  249.786159][ T1511]  el0t_64_sync+0x180/0x184
[  249.790512][ T1511] Code: 38e06860 350012e0 91002320 d2d00003 (f90006c2) 
[  249.797293][ T1511] ---[ end trace 66b18ed31e8dd1b2 ]---
[  249.802598][ T1511] Kernel panic - not syncing: Oops: Fatal exception
[  249.809030][ T1511] SMP: stopping secondary CPUs
[  249.813650][ T1511] Kernel Offset: disabled
[  249.817824][ T1511] CPU features: 0x00000251,20000846
[  249.822868][ T1511] Memory Limit: none
[  249.826609][ T1511] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

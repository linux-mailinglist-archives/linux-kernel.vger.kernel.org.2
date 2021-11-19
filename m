Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E3A45686E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhKSDHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:07:50 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36887 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229909AbhKSDHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:07:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UxG4U3T_1637291086;
Received: from 30.240.104.212(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UxG4U3T_1637291086)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Nov 2021 11:04:47 +0800
Message-ID: <b1497f85-b7ca-fd3b-385e-8f54f5946711@linux.alibaba.com>
Date:   Fri, 19 Nov 2021 11:04:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2 1/2] arm64: trans_pgd: fix incorrect use of
 pmd_populate_kernel in copy_pte()
Content-Language: en-US
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        james.morse@arm.com, ardb@kernel.org, tabba@google.com,
        akpm@linux-foundation.org, rppt@kernel.org,
        anshuman.khandual@arm.com, kernelfans@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211030183200.51295-1-rongwei.wang@linux.alibaba.com>
 <20211114201650.5542-1-rongwei.wang@linux.alibaba.com>
 <20211114201650.5542-2-rongwei.wang@linux.alibaba.com>
In-Reply-To: <20211114201650.5542-2-rongwei.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard and Pingfan

This bug I had fix and send out Patch v1 in 31 Oct. And it seems my 
patch had been ignored, and Pingfan's patch had been reviewed:

This is link of Pingfan's patch:

https://lore.kernel.org/linux-arm-kernel/20211111060316.12438-1-kernelfans@gmail.com/#r

It seems that I am not subscribe linux-arm-kernel successfully.

Thanks!

On 11/15/21 4:16 AM, Rongwei Wang wrote:
> In commit 5de59884ac0e ("arm64: trans_pgd: pass NULL instead
> of init_mm to *_populate functions"), simply replace init_mm
> with NULL for pmd_populate_kernel. But in commit 59511cfd08f3
> ("arm64: mm: use XN table mapping attributes for user/kernel
> mappings"), adding the check of mm context in
> pmd_populate_kernel. And these changes will cause a crash when
> executing copy_pte/trans_pgd.c, as follows:
> 
> kernel BUG at arch/arm64/include/asm/pgalloc.h:79!
> Internal error: Oops - BUG: 0 [#1] SMP
> Modules linked in: rfkill(E) aes_ce_blk(E) aes_ce_cipher(E) ...
> CPU: 21 PID: 1617 Comm: a.out Kdump: loaded Tainted: ... 5.15.0-rc7-mm1+ #8
> Hardware name: ECS, BIOS 0.0.0 02/06/2015
> pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : trans_pgd_create_copy+0x4ac/0x4f0
> lr : trans_pgd_create_copy+0x34c/0x4f0
> sp : ffff80001bf2bc50
> x29: ffff80001bf2bc50 x28: ffff0010067f1000 x27: ffff800011072000
> x26: ffff001fffff8000 x25: ffff008000000000 x24: 0040000000000041
> x23: 0040000000000001 x22: ffff80001bf2bd68 x21: ffff80001188ded8
> x20: ffff800000000000 x19: ffff000000000000 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 00000000200004c0
> x14: ffff00003fffffff x13: ffff007fffffffff x12: ffff800010f882a8
> x11: 0000000000face57 x10: 0000000000000001 x9 : 0000000000000000
> x8 : ffff00100cece000 x7 : ffff001001c9f000 x6 : ffff00100ae40000
> x5 : 0000000000000040 x4 : 0000000000000000 x3 : ffff001fffff7000
> x2 : ffff000000200000 x1 : ffff000040000000 x0 : ffff00100cecd000
> Call trace:
>   trans_pgd_create_copy+0x4ac/0x4f0
>   machine_kexec_post_load+0x94/0x3bc
>   do_kexec_load+0x11c/0x2e0
>   __arm64_sys_kexec_load+0xa8/0xf4
>   invoke_syscall+0x50/0x120
>   el0_svc_common.constprop.0+0x58/0x190
>   do_el0_svc+0x2c/0x90
>   el0_svc+0x28/0xe0
>   el0t_64_sync_handler+0xb0/0xb4
>   el0t_64_sync+0x180/0x184
> Code: f90000c0 d5033a9f d5033fdf 17ffff7b (d4210000)
> ---[ end trace cc5461ffe1a085db ]---
> Kernel panic - not syncing: Oops - BUG: Fatal exception
> 
> This bug can be reproduced by a user case:
> 
> void execute_kexec_load(void)
> {
> 	syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> 	syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
> 	syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> 
> 	*(uint64_t*)0x200004c0 = 0;
> 	*(uint64_t*)0x200004c8 = 0;
> 	*(uint64_t*)0x200004d0 = 0;
> 	*(uint64_t*)0x200004d8 = 0;
> 	syscall(__NR_kexec_load, 0ul, 1ul, 0x200004c0ul, 0ul);
> }
> 
> And this patch make a simple change, just restoring init_mm
> for 'pmd_populate_kernel' in 'copy_pte'.
> 
> Fixes: 59511cfd08f3 ("arm64: mm: use XN table mapping attributes for user/kernel mappings")
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> ---
>   arch/arm64/mm/trans_pgd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> index d7da8ca40d2e..5275ca312360 100644
> --- a/arch/arm64/mm/trans_pgd.c
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -67,7 +67,7 @@ static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
>   	dst_ptep = trans_alloc(info);
>   	if (!dst_ptep)
>   		return -ENOMEM;
> -	pmd_populate_kernel(NULL, dst_pmdp, dst_ptep);
> +	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
>   	dst_ptep = pte_offset_kernel(dst_pmdp, start);
>   
>   	src_ptep = pte_offset_kernel(src_pmdp, start);
> 

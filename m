Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD493FB3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhH3Klq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236325AbhH3Klp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:41:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E79260F44;
        Mon, 30 Aug 2021 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630320051;
        bh=7qfLr0VtVSbY6W/H7Ge6jxOSj7hU+UemeOyR0BLGs7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQyzLmokeUJWuKnQGoiFODpH5hHsyVp7i2y8GTqJI4ywZkl3uD9cSQGpWZIGDV8tW
         p20znOkft40kCcg6kz4WmHm9nTz8XFAYVuncxo6912ks/12dFYsrlmmCXg5T7/Tisp
         Z8EoIQFR3la1ADN7mwXuVdKRQxkk0jcCWxivPQLx7ZyHI+IYgb/zJ2jhyo2ezOrT9k
         KuIG3EmaxQEuJyl248KCyip3zs7n2MiM2QF/d0zQ1NjvQUOzl9AJIGYzikLZwLkGfy
         sLJ0ARgw7ZCll8/MxK9wekfuAO7se8hM7Cexyyq1Vom33NVT+R8x99c9uyV6/rydQT
         xdJemCpc1ueBw==
Date:   Mon, 30 Aug 2021 13:40:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Chen Wandun <chenwandun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        nsaenz@kernel.org, anshuman.khandual@arm.com,
        geert+renesas@glider.be, rafael.j.wysocki@intel.com,
        robh@kernel.org, kirill.shtuemov@linux.intel.com,
        sfr@canb.auug.org.au, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        weiyongjun1@huawei.com, guohanjun@huawei.com
Subject: Re: [PATCH] arm64: kdump: Skip kmemleak scan reserved memory for
 kdump
Message-ID: <YSy1rB+Ph0PYBuXe@kernel.org>
References: <20210827092246.3565437-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827092246.3565437-1-chenwandun@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 05:22:46PM +0800, Chen Wandun wrote:
> Trying to boot with kdump + kmemleak, command will result in a crash:
> "echo scan > /sys/kernel/debug/kmemleak"
> 
> crashkernel reserved: 0x0000000007c00000 - 0x0000000027c00000 (512 MB)
> Kernel command line: BOOT_IMAGE=(hd1,gpt2)/vmlinuz-5.14.0-rc5-next-20210809+ root=/dev/mapper/ao-root ro rd.lvm.lv=ao/root rd.lvm.lv=ao/swap crashkernel=512M
> Unable to handle kernel paging request at virtual address ffff000007c00000
> Mem abort info:
>   ESR = 0x96000007
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x07: level 3 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000007
>   CM = 0, WnR = 0
> swapper pgtable: 64k pages, 48-bit VAs, pgdp=00002024f0d80000
> [ffff000007c00000] pgd=1800205ffffd0003, p4d=1800205ffffd0003, pud=1800205ffffd0003, pmd=1800205ffffc0003, pte=0068000007c00f06
> Internal error: Oops: 96000007 [#1] SMP
> pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : scan_block+0x98/0x230
> lr : scan_block+0x94/0x230
> sp : ffff80008d6cfb70
> x29: ffff80008d6cfb70 x28: 0000000000000000 x27: 0000000000000000
> x26: 00000000000000c0 x25: 0000000000000001 x24: 0000000000000000
> x23: ffffa88a6b18b398 x22: ffff000007c00ff9 x21: ffffa88a6ac7fc40
> x20: ffffa88a6af6a830 x19: ffff000007c00000 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: ffffffffffffffff
> x14: ffffffff00000000 x13: ffffffffffffffff x12: 0000000000000020
> x11: 0000000000000000 x10: 0000000001080000 x9 : ffffa88a6951c77c
> x8 : ffffa88a6a893988 x7 : ffff203ff6cfb3c0 x6 : ffffa88a6a52b3c0
> x5 : ffff203ff6cfb3c0 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000000001 x1 : ffff20226cb56a40 x0 : 0000000000000000
> Call trace:
>  scan_block+0x98/0x230
>  scan_gray_list+0x120/0x270
>  kmemleak_scan+0x3a0/0x648
>  kmemleak_write+0x3ac/0x4c8
>  full_proxy_write+0x6c/0xa0
>  vfs_write+0xc8/0x2b8
>  ksys_write+0x70/0xf8
>  __arm64_sys_write+0x24/0x30
>  invoke_syscall+0x4c/0x110
>  el0_svc_common+0x9c/0x190
>  do_el0_svc+0x30/0x98
>  el0_svc+0x28/0xd8
>  el0t_64_sync_handler+0x90/0xb8
>  el0t_64_sync+0x180/0x184
> 
> The reserved memory for kdump will be looked up by kmemleak, this area
> will be set invalid when kdump service is bring up. That will result in
> crash when kmemleak scan this area.
> 
> Fixes: 461ef12c4375 ("memblock: make memblock_find_in_range method private")

The commit id will change because patches in mmotm tree do not have stable
commit ids...

> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Andrew, can you please pick it up?

> ---
>  arch/arm64/mm/init.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index b16be52233c6..dc0c44622bfd 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -30,6 +30,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/hugetlb.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/kmemleak.h>
>  
>  #include <asm/boot.h>
>  #include <asm/fixmap.h>
> @@ -101,6 +102,7 @@ static void __init reserve_crashkernel(void)
>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>  		crash_base, crash_base + crash_size, crash_size >> 20);
>  
> +	kmemleak_ignore_phys(crash_base);
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
>  }
> -- 
> 2.18.0.huawei.25
> 

-- 
Sincerely yours,
Mike.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21B8368B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbhDWDbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbhDWDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:31:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3CBC061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:30:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id g16so7712015plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=P+KGPCybOpBTLIxqFZUXq9jQtCur/PgkoYcaeqi73OM=;
        b=ijT6VYkgPf6KT1zkyevJdPIOFt7wBBVnAd6GiE+QA2dvxyOgypKculval8AaeqRZru
         TYmVpZ7Ku7Aq/fyTzX9uhj5RkxPOkTRuaYdioxqB8YVDy6lF2080ev30EJeA5Gyhxp6T
         dCm36fGci/RH6hklN4bZ4mA1moRAzilWemNnx/US+EZNs0PpcbS4ZG+gtG0uofMv3y98
         0lNmxjswoaz4kRjU4wy6aYXd/3k5SkSzLRsfne85WFw8Q7NPR/CzscKGrQkHtC+z0SvY
         7genMihKufvmE67AunuJ0Ag6WuxDpqsYGTDCMpYo+PcvszpR3WhjIDgFFf958r+5Mcwh
         vVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=P+KGPCybOpBTLIxqFZUXq9jQtCur/PgkoYcaeqi73OM=;
        b=laZTD+QOrygc0AdEXjPhxQk+9YJy2Au8iimE8Pj85PmbU6DtbCztAsYCp9+dpUxdhO
         AZ7ZSVBl0fPxQkzfpFwlisb1d3TqgzgayiVjtcwxPrpIbYj9nTmJuj62gpaf+j0pY7zy
         A9CMlW6tk15Q44fof72lqvBpJx/Z2CIo2+S6VpFYkbRZN7gPlV2TC1juk3qUTWYdN9V6
         Tz0/X3JOcJHr6rm5eBj0iNaN7rhgz844gadTS2xj3yvrfMf5CRcAiWVwVotNov8dKx4R
         LNyBcawtu/ygXRH7twzUPcd8SVuv21MRuzibjzNVs9c2MHsKWQpQ9sFUjRaiuvXA0LBS
         0LpQ==
X-Gm-Message-State: AOAM5338ZFEbKMMJHgO3Tnh4yalCILBPzHtZGPjKv2Nm+oARbQJJYzT0
        kRa0Nis96bRiWH7EgFOLvVwHsA==
X-Google-Smtp-Source: ABdhPJzUHqQ+urmPQNixu2rmxzJ0Z/43d/PXa+8zuqofUpXLwpY0B30xP16jUJjAIK2RrvNVmOdbLg==
X-Received: by 2002:a17:90a:55c5:: with SMTP id o5mr2055142pjm.78.1619148649823;
        Thu, 22 Apr 2021 20:30:49 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a11sm3210267pfg.124.2021.04.22.20.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 20:30:49 -0700 (PDT)
Date:   Thu, 22 Apr 2021 20:30:49 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 20:30:22 PDT (-0700)
Subject:     Re: [PATCH v3 5/5] RISC-V: Add crash kernel support
In-Reply-To: <20210405085712.1953848-6-mick@ics.forth.gr>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, mickflemm@gmail.com,
        mick@ics.forth.gr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Message-ID: <mhng-87edd3c7-0ddf-4e6f-8138-b410e53dc3ad@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Apr 2021 01:57:12 PDT (-0700), mick@ics.forth.gr wrote:
> From: Nick Kossifidis <mickflemm@gmail.com>

This doesn't match the SOB.  I just fixed it up.  IIUC that's not 
generally the right way to go, but since it came from the right address 
I'm OK with it this time.

>
> This patch allows Linux to act as a crash kernel for use with
> kdump. Userspace will let the crash kernel know about the
> memory region it can use through linux,usable-memory property
> on the /memory node (overriding its reg property), and about the
> memory region where the elf core header of the previous kernel
> is saved, through a reserved-memory node with a compatible string
> of "linux,elfcorehdr". This approach is the least invasive and
> re-uses functionality already present.
>
> I tested this on riscv64 qemu and it works as expected, you
> may test it by retrieving the dmesg of the previous kernel
> through /proc/vmcore, using the vmcore-dmesg utility from
> kexec-tools.
>
> v3:
>  * Rebase
>
> v2:
>  * Use linux,usable-memory on /memory instead of a new binding
>  * Use a reserved-memory node for ELF core header
>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> ---
>  arch/riscv/Kconfig             | 10 ++++++++
>  arch/riscv/kernel/Makefile     |  1 +
>  arch/riscv/kernel/crash_dump.c | 46 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c      | 12 +++++++++
>  arch/riscv/mm/init.c           | 33 ++++++++++++++++++++++++
>  5 files changed, 102 insertions(+)
>  create mode 100644 arch/riscv/kernel/crash_dump.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 3716262ef..553c2dced 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -403,6 +403,16 @@ config KEXEC
>
>  	  The name comes from the similarity to the exec system call.
>
> +config CRASH_DUMP
> +	bool "Build kdump crash kernel"
> +	help
> +	  Generate crash dump after being started by kexec. This should
> +	  be normally only set in special crash dump kernels which are
> +	  loaded in the main kernel with kexec-tools into a specially
> +	  reserved region and then later executed after a crash by
> +	  kdump/kexec.
> +
> +	  For more details see Documentation/admin-guide/kdump/kdump.rst
>
>  endmenu
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 07f676ad3..bd66d2ce0 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -59,6 +59,7 @@ endif
>  obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
>  obj-$(CONFIG_KGDB)		+= kgdb.o
>  obj-${CONFIG_KEXEC}		+= kexec_relocate.o crash_save_regs.o machine_kexec.o
> +obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>
>  obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
>
> diff --git a/arch/riscv/kernel/crash_dump.c b/arch/riscv/kernel/crash_dump.c
> new file mode 100644
> index 000000000..86cc0ada5
> --- /dev/null
> +++ b/arch/riscv/kernel/crash_dump.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This code comes from arch/arm64/kernel/crash_dump.c
> + * Created by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + * Copyright (C) 2017 Linaro Limited
> + */
> +
> +#include <linux/crash_dump.h>
> +#include <linux/io.h>
> +
> +/**
> + * copy_oldmem_page() - copy one page from old kernel memory
> + * @pfn: page frame number to be copied
> + * @buf: buffer where the copied page is placed
> + * @csize: number of bytes to copy
> + * @offset: offset in bytes into the page
> + * @userbuf: if set, @buf is in a user address space
> + *
> + * This function copies one page from old kernel memory into buffer pointed by
> + * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
> + * copied or negative error in case of failure.
> + */
> +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> +			 size_t csize, unsigned long offset,
> +			 int userbuf)
> +{
> +	void *vaddr;
> +
> +	if (!csize)
> +		return 0;
> +
> +	vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> +	if (userbuf) {
> +		if (copy_to_user((char __user *)buf, vaddr + offset, csize)) {
> +			memunmap(vaddr);
> +			return -EFAULT;
> +		}
> +	} else
> +		memcpy(buf, vaddr + offset, csize);
> +
> +	memunmap(vaddr);
> +	return csize;
> +}
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 31866dce9..ff398a3d8 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -66,6 +66,9 @@ static struct resource code_res = { .name = "Kernel code", };
>  static struct resource data_res = { .name = "Kernel data", };
>  static struct resource rodata_res = { .name = "Kernel rodata", };
>  static struct resource bss_res = { .name = "Kernel bss", };
> +#ifdef CONFIG_CRASH_DUMP
> +static struct resource elfcorehdr_res = { .name = "ELF Core hdr", };
> +#endif
>
>  static int __init add_resource(struct resource *parent,
>  				struct resource *res)
> @@ -169,6 +172,15 @@ static void __init init_resources(void)
>  	}
>  #endif
>
> +#ifdef CONFIG_CRASH_DUMP
> +	if (elfcorehdr_size > 0) {
> +		elfcorehdr_res.start = elfcorehdr_addr;
> +		elfcorehdr_res.end = elfcorehdr_addr + elfcorehdr_size - 1;
> +		elfcorehdr_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +		add_resource(&iomem_resource, &elfcorehdr_res);
> +	}
> +#endif
> +
>  	for_each_reserved_mem_region(region) {
>  		res = &mem_res[res_idx--];
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e71b35cec..f66011816 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -13,6 +13,7 @@
>  #include <linux/swap.h>
>  #include <linux/sizes.h>
>  #include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/libfdt.h>
>  #include <linux/set_memory.h>
>  #include <linux/dma-map-ops.h>
> @@ -606,6 +607,18 @@ static void __init reserve_crashkernel(void)
>
>  	int ret = 0;
>
> +	/*
> +	 * Don't reserve a region for a crash kernel on a crash kernel
> +	 * since it doesn't make much sense and we have limited memory
> +	 * resources.
> +	 */
> +#ifdef CONFIG_CRASH_DUMP
> +	if (is_kdump_kernel()) {
> +		pr_info("crashkernel: ignoring reservation request\n");
> +		return;
> +	}
> +#endif
> +
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  				&crash_size, &crash_base);
>  	if (ret || !crash_size)
> @@ -660,6 +673,26 @@ static void __init reserve_crashkernel(void)
>  }
>  #endif /* CONFIG_KEXEC_CORE */
>
> +#ifdef CONFIG_CRASH_DUMP
> +/*
> + * We keep track of the ELF core header of the crashed
> + * kernel with a reserved-memory region with compatible
> + * string "linux,elfcorehdr". Here we register a callback
> + * to populate elfcorehdr_addr/size when this region is
> + * present. Note that this region will be marked as
> + * reserved once we call early_init_fdt_scan_reserved_mem()
> + * later on.
> + */
> +static int elfcore_hdr_setup(struct reserved_mem *rmem)
> +{
> +	elfcorehdr_addr = rmem->base;
> +	elfcorehdr_size = rmem->size;
> +	return 0;
> +}
> +
> +RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
> +#endif
> +
>  void __init paging_init(void)
>  {
>  	setup_vm_final();

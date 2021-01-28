Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954B5306B80
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 04:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhA1DTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 22:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhA1DTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:19:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99617C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 19:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:Subject:From:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UbhnRtk3/xl9K6cgMxwhQrXHAzvl/Xj/tYjyM/UDYBk=; b=wuOVJ5Yat7ok6Vs6Jw5azV5SDN
        UEevjhfIqyHHgdM9OkizgrI3OLZC63BmKbb6uttRLr3nVRLpx2vXmCVUIjUb7TDjdC8X7Jz2mepEa
        j6mxpLp0n1zO5V3AcA0H1QLI/UKyq+Yr2tumEgShzs1v0fQYQelvkX1X+kweKUx+Z3HWwO8MiyIb8
        5VBwFd3L5AeDXTrYWtunhFWmIFUBpAeUjAgDDJz/9Og81ukvr+fW/Stq7e10zYeMnr7XBaWRD3T+j
        GVpX07tJ6t8ZLzQZOuGwbIUywlCR3sEjWcyVND8Y/R+fcNfb0ea3xuvGSZ7AKD3epGVW149/jssFH
        J/aa6i6A==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4xp3-0005Kk-3E; Thu, 28 Jan 2021 03:18:17 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Kconfig-induced build errors: CONFIG_PAGE_OFFSET
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Message-ID: <b67f8941-6624-d814-e6d3-2ddfdfbdf7dd@infradead.org>
Date:   Wed, 27 Jan 2021 19:18:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I took a riscv-32 .config from kernel test robot (it was for a clang build)
and did a "make olddefconfig" (using gcc tools) and got build errors
due to this config item from arch/riscv/Kconfig;


config PAGE_OFFSET
	hex
	default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
	default 0x80000000 if 64BIT && !MMU
	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB

PAGE_OFFSET is undefined for the case of 32BIT && MAXPHYSMEM_2GB.
That causes lots of errors when _AC() is used to paste
CONFIG_PAGE_OFFSET to "UL", like these:

In file included from ../include/vdso/const.h:5,
                 from ../include/linux/const.h:4,
                 from ../include/linux/bits.h:5,
                 from ../include/linux/bitops.h:6,
                 from ../include/linux/kernel.h:11,
                 from ../init/do_mounts_initrd.c:3:
../arch/riscv/include/asm/uaccess.h: In function '__access_ok':
../arch/riscv/include/asm/page.h:34:46: error: 'UL' undeclared (first use in this function)
   34 | #define PAGE_OFFSET  _AC(CONFIG_PAGE_OFFSET, UL)
      |                                              ^~
../include/uapi/linux/const.h:20:23: note: in definition of macro '__AC'
   20 | #define __AC(X,Y) (X##Y)
      |                       ^
../arch/riscv/include/asm/page.h:34:22: note: in expansion of macro '_AC'
   34 | #define PAGE_OFFSET  _AC(CONFIG_PAGE_OFFSET, UL)
      |                      ^~~
../arch/riscv/include/asm/pgtable.h:26:27: note: in expansion of macro 'PAGE_OFFSET'
   26 | #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
      |                           ^~~~~~~~~~~
../arch/riscv/include/asm/pgtable.h:41:24: note: in expansion of macro 'VMALLOC_START'
   41 | #define VMEMMAP_START (VMALLOC_START - VMEMMAP_SIZE)
      |                        ^~~~~~~~~~~~~
../arch/riscv/include/asm/pgtable.h:50:26: note: in expansion of macro 'VMEMMAP_START'
   50 | #define PCI_IO_END       VMEMMAP_START
      |                          ^~~~~~~~~~~~~
../arch/riscv/include/asm/pgtable.h:51:27: note: in expansion of macro 'PCI_IO_END'
   51 | #define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
      |                           ^~~~~~~~~~
../arch/riscv/include/asm/pgtable.h:53:26: note: in expansion of macro 'PCI_IO_START'
   53 | #define FIXADDR_TOP      PCI_IO_START
      |                          ^~~~~~~~~~~~
../arch/riscv/include/asm/pgtable.h:59:27: note: in expansion of macro 'FIXADDR_TOP'
   59 | #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
      |                           ^~~~~~~~~~~
../arch/riscv/include/asm/pgtable.h:471:19: note: in expansion of macro 'FIXADDR_START'
  471 | #define TASK_SIZE FIXADDR_START
      |                   ^~~~~~~~~~~~~
../arch/riscv/include/asm/uaccess.h:56:17: note: in expansion of macro 'TASK_SIZE'
   56 |  return size <= TASK_SIZE && addr <= TASK_SIZE - size;


I suppose that it wants something like this, but someone else can
fix/use the correct default value here:

---

From: Randy Dunlap <rdunlap@infradead.org>

Provide a default value for PAGE_OFFSET for the case of
32BIT and MAXPHYSMEM_2GB.

Fixes many build errors.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 arch/riscv/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210125.orig/arch/riscv/Kconfig
+++ linux-next-20210125/arch/riscv/Kconfig
@@ -143,6 +143,7 @@ config PA_BITS
 config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
+	default 0x80000000 if 32BIT && MAXPHYSMEM_2GB
 	default 0x80000000 if 64BIT && !MMU
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>


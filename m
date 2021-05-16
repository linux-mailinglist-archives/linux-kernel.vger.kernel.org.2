Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7B382092
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 21:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhEPTLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 15:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhEPTLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 15:11:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D9C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=UKMFsY8/zFvweWvQhqbUk5fU84dFty1APN7OalYnItE=; b=mVeNtOKPwMidQA7Z/GB1LLI842
        Se6XVgXL+ys08gZu+mU0QTPmYh3GkWNIlCN+qQ2ki+CjoiG5YIjs3430p3wF4e71P5dg3VxnwEBK7
        7xbHxvtCebpefUf0zw7nnGBEF58SNh7e/Pf6+6Tfh4AOg23bMS4SXxrSHEar0TLF65bMXRDFfgWze
        yI+y6YAc8gPU0iEQk6YZizeVTbxPSFABK5s2qJ7Yz9JJ/wKoxo4jAuGt26TLr3wg53W2BACy8dIXc
        EKeN2RK5oQ9bw874fllvJQZF9OBauar6WvXADF1EG7E/rNgYgnJuySEB1tSLETNJThCEWcS5UaQv2
        x7grhlqQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1liM9K-00D9ue-IF; Sun, 16 May 2021 19:10:02 +0000
Subject: Re: arch/riscv/kernel/probes/kprobes.c:90:22: error: use of
 undeclared identifier 'PAGE_KERNEL_READ_EXEC'
To:     kernel test robot <lkp@intel.com>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
References: <202105070646.RiY8StjM-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <22c9edf5-1112-40e4-bd61-ad8ddf2d4732@infradead.org>
Date:   Sun, 16 May 2021 12:10:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <202105070646.RiY8StjM-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/21 3:11 PM, kernel test robot wrote:
> Hi Jisheng,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   38182162b50aa4e970e5997df0a0c4288147a153
> commit: cdd1b2bd358ffda2638fe18ff47191e84e18525f riscv: kprobes: Implement alloc_insn_page()
> date:   10 days ago
> config: riscv-randconfig-r006-20210506 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8f5a2a5836cc8e4c1def2bdeb022e7b496623439)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cdd1b2bd358ffda2638fe18ff47191e84e18525f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout cdd1b2bd358ffda2638fe18ff47191e84e18525f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from arch/riscv/kernel/probes/kprobes.c:3:
>    In file included from include/linux/kprobes.h:29:
>    In file included from include/linux/ftrace.h:10:
>    In file included from include/linux/trace_recursion.h:5:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:10:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:572:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            return inl(addr);
>                   ^~~~~~~~~
>    arch/riscv/include/asm/io.h:57:76: note: expanded from macro 'inl'
>    #define inl(c)          ({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
>                                                                            ~~~~~~~~~~ ^
>    arch/riscv/include/asm/mmio.h:89:76: note: expanded from macro 'readl_cpu'
>    #define readl_cpu(c)            ({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
>                                                                                         ^
>    include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from arch/riscv/kernel/probes/kprobes.c:3:
>    In file included from include/linux/kprobes.h:29:
>    In file included from include/linux/ftrace.h:10:
>    In file included from include/linux/trace_recursion.h:5:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:10:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:580:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            outb(value, addr);
>            ^~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/io.h:59:68: note: expanded from macro 'outb'
>    #define outb(v,c)       ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
>                                                                  ~~~~~~~~~~ ^
>    arch/riscv/include/asm/mmio.h:91:52: note: expanded from macro 'writeb_cpu'
>    #define writeb_cpu(v, c)        ((void)__raw_writeb((v), (c)))
>                                                              ^
>    In file included from arch/riscv/kernel/probes/kprobes.c:3:
>    In file included from include/linux/kprobes.h:29:
>    In file included from include/linux/ftrace.h:10:
>    In file included from include/linux/trace_recursion.h:5:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:10:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:588:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            outw(value, addr);
>            ^~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/io.h:60:68: note: expanded from macro 'outw'
>    #define outw(v,c)       ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
>                                                                  ~~~~~~~~~~ ^
>    arch/riscv/include/asm/mmio.h:92:76: note: expanded from macro 'writew_cpu'
>    #define writew_cpu(v, c)        ((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
>                                                                                      ^
>    In file included from arch/riscv/kernel/probes/kprobes.c:3:
>    In file included from include/linux/kprobes.h:29:
>    In file included from include/linux/ftrace.h:10:
>    In file included from include/linux/trace_recursion.h:5:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:10:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:596:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            outl(value, addr);
>            ^~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/io.h:61:68: note: expanded from macro 'outl'
>    #define outl(v,c)       ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
>                                                                  ~~~~~~~~~~ ^
>    arch/riscv/include/asm/mmio.h:93:76: note: expanded from macro 'writel_cpu'
>    #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
>                                                                                      ^
>    In file included from arch/riscv/kernel/probes/kprobes.c:3:
>    In file included from include/linux/kprobes.h:29:
>    In file included from include/linux/ftrace.h:10:
>    In file included from include/linux/trace_recursion.h:5:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:10:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:1005:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>                                                      ~~~~~~~~~~ ^
>>> arch/riscv/kernel/probes/kprobes.c:90:22: error: use of undeclared identifier 'PAGE_KERNEL_READ_EXEC'
>                                         GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
>                                                     ^
>    7 warnings and 1 error generated.
> 
> 
> vim +/PAGE_KERNEL_READ_EXEC +90 arch/riscv/kernel/probes/kprobes.c
> 
>     86	
>     87	void *alloc_insn_page(void)
>     88	{
>     89		return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
>   > 90					     GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
>     91					     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
>     92					     __builtin_return_address(0));
>     93	}
>     94	
> 
> ---

>>> arch/riscv/kernel/probes/kprobes.c:90:22: error: use of undeclared identifier 'PAGE_KERNEL_READ_EXEC'
>                                         GFP_KERNEL, PAGE_KERNEL_READ_EXEC,

is due to
# CONFIG_MMU is not set


-- 
~Randy


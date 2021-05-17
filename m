Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2B383972
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbhEQQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbhEQP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:59:09 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C52FC06134E
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=WGx65fce1oBfuRHn2aIcVVMFYx4c1v7iBP
        TdHW/wnEw=; b=KztkkXQPE8CSEQV4nqwurSnRUEDioLZNf4CtmOuJkfuV3lbGrp
        G4VmzOSyQZsGWqyzbAXbyHpaPyNGD8Ff2J1zlPms1wOuvipl1GALRqXM7isxfA7J
        aeLZoZYDJ40jI2In++30+pA9WTrf6/PGSOwvyeGoxCG97iEK3Id+QpExI=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDn7Z0PgaJgHhLyAA--.21660S2;
        Mon, 17 May 2021 22:43:27 +0800 (CST)
Date:   Mon, 17 May 2021 22:38:06 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jisheng Zhang <jszhang@kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: arch/riscv/kernel/probes/kprobes.c:90:22: error: use of
 undeclared identifier 'PAGE_KERNEL_READ_EXEC'
Message-ID: <20210517223752.425cbcf8@xhacker>
In-Reply-To: <22c9edf5-1112-40e4-bd61-ad8ddf2d4732@infradead.org>
References: <202105070646.RiY8StjM-lkp@intel.com>
        <22c9edf5-1112-40e4-bd61-ad8ddf2d4732@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDn7Z0PgaJgHhLyAA--.21660S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1rXw4kAF4fJF1kXrWkJFb_yoWfXrWDpF
        s5ur1qqFZ5Zr15Gws093W2y34Utw45G342yry5Wry29F17trWxuwn8urWDKF1vvr4q9ay8
        KrW7C3yagryUXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
        0_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
        6r4UYxBIdaVFxhVjvjDU0xZFpf9x07b0a0QUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 May 2021 12:10:01 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 5/6/21 3:11 PM, kernel test robot wrote:
> > Hi Jisheng,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   38182162b50aa4e970e5997df0a0c4288147a153
> > commit: cdd1b2bd358ffda2638fe18ff47191e84e18525f riscv: kprobes: Implement alloc_insn_page()
> > date:   10 days ago
> > config: riscv-randconfig-r006-20210506 (attached as .config)
> > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8f5a2a5836cc8e4c1def2bdeb022e7b496623439)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install riscv cross compiling tool for clang build
> >         # apt-get install binutils-riscv64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cdd1b2bd358ffda2638fe18ff47191e84e18525f
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout cdd1b2bd358ffda2638fe18ff47191e84e18525f
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=riscv 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
> >    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
> >                                                      ^
> >    In file included from arch/riscv/kernel/probes/kprobes.c:3:
> >    In file included from include/linux/kprobes.h:29:
> >    In file included from include/linux/ftrace.h:10:
> >    In file included from include/linux/trace_recursion.h:5:
> >    In file included from include/linux/interrupt.h:11:
> >    In file included from include/linux/hardirq.h:10:
> >    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:572:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            return inl(addr);
> >                   ^~~~~~~~~
> >    arch/riscv/include/asm/io.h:57:76: note: expanded from macro 'inl'
> >    #define inl(c)          ({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> >                                                                            ~~~~~~~~~~ ^
> >    arch/riscv/include/asm/mmio.h:89:76: note: expanded from macro 'readl_cpu'
> >    #define readl_cpu(c)            ({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
> >                                                                                         ^
> >    include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
> >    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
> >                                                      ^
> >    In file included from arch/riscv/kernel/probes/kprobes.c:3:
> >    In file included from include/linux/kprobes.h:29:
> >    In file included from include/linux/ftrace.h:10:
> >    In file included from include/linux/trace_recursion.h:5:
> >    In file included from include/linux/interrupt.h:11:
> >    In file included from include/linux/hardirq.h:10:
> >    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:580:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            outb(value, addr);
> >            ^~~~~~~~~~~~~~~~~
> >    arch/riscv/include/asm/io.h:59:68: note: expanded from macro 'outb'
> >    #define outb(v,c)       ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> >                                                                  ~~~~~~~~~~ ^
> >    arch/riscv/include/asm/mmio.h:91:52: note: expanded from macro 'writeb_cpu'
> >    #define writeb_cpu(v, c)        ((void)__raw_writeb((v), (c)))
> >                                                              ^
> >    In file included from arch/riscv/kernel/probes/kprobes.c:3:
> >    In file included from include/linux/kprobes.h:29:
> >    In file included from include/linux/ftrace.h:10:
> >    In file included from include/linux/trace_recursion.h:5:
> >    In file included from include/linux/interrupt.h:11:
> >    In file included from include/linux/hardirq.h:10:
> >    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:588:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            outw(value, addr);
> >            ^~~~~~~~~~~~~~~~~
> >    arch/riscv/include/asm/io.h:60:68: note: expanded from macro 'outw'
> >    #define outw(v,c)       ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> >                                                                  ~~~~~~~~~~ ^
> >    arch/riscv/include/asm/mmio.h:92:76: note: expanded from macro 'writew_cpu'
> >    #define writew_cpu(v, c)        ((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
> >                                                                                      ^
> >    In file included from arch/riscv/kernel/probes/kprobes.c:3:
> >    In file included from include/linux/kprobes.h:29:
> >    In file included from include/linux/ftrace.h:10:
> >    In file included from include/linux/trace_recursion.h:5:
> >    In file included from include/linux/interrupt.h:11:
> >    In file included from include/linux/hardirq.h:10:
> >    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:596:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            outl(value, addr);
> >            ^~~~~~~~~~~~~~~~~
> >    arch/riscv/include/asm/io.h:61:68: note: expanded from macro 'outl'
> >    #define outl(v,c)       ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> >                                                                  ~~~~~~~~~~ ^
> >    arch/riscv/include/asm/mmio.h:93:76: note: expanded from macro 'writel_cpu'
> >    #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
> >                                                                                      ^
> >    In file included from arch/riscv/kernel/probes/kprobes.c:3:
> >    In file included from include/linux/kprobes.h:29:
> >    In file included from include/linux/ftrace.h:10:
> >    In file included from include/linux/trace_recursion.h:5:
> >    In file included from include/linux/interrupt.h:11:
> >    In file included from include/linux/hardirq.h:10:
> >    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:1005:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
> >                                                      ~~~~~~~~~~ ^  
> >>> arch/riscv/kernel/probes/kprobes.c:90:22: error: use of undeclared identifier 'PAGE_KERNEL_READ_EXEC'  
> >                                         GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
> >                                                     ^
> >    7 warnings and 1 error generated.
> > 
> > 
> > vim +/PAGE_KERNEL_READ_EXEC +90 arch/riscv/kernel/probes/kprobes.c
> > 
> >     86	
> >     87	void *alloc_insn_page(void)
> >     88	{
> >     89		return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,  
> >   > 90					     GFP_KERNEL, PAGE_KERNEL_READ_EXEC,  
> >     91					     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> >     92					     __builtin_return_address(0));
> >     93	}
> >     94	
> > 
> > ---  
> 
> >>> arch/riscv/kernel/probes/kprobes.c:90:22: error: use of undeclared identifier 'PAGE_KERNEL_READ_EXEC'  
> >                                         GFP_KERNEL, PAGE_KERNEL_READ_EXEC,  
> 
> is due to
> # CONFIG_MMU is not set
> 
> 

I have sent out patch to fix this isue:
http://lists.infradead.org/pipermail/linux-riscv/2021-May/006291.html

thanks


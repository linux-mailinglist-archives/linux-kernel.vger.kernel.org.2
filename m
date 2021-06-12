Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D1A3A4F15
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFLN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLN0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:26:09 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98745C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=pu2uUIV6/scPzYym2326ulqu+tFHtiqIN0
        YOjUDnmbg=; b=U6k+fXWxoIY6w5PhUAiZxIDiRItZLBuXMtimejnRlukdO4NHmk
        xzIw6Gmsn2YRw4PhvGsnEn7RBaWWSkFjFBL95ZOmksY8KnlTnhaiWXFmA+TyPJHO
        ogCCd8zNr1T8YRcKCt/BFlK12WVwU5yPKF886delghjl8rEyWdRQUsLCs=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAHk6BntcRg9BTNAA--.64727S2;
        Sat, 12 Jun 2021 21:23:51 +0800 (CST)
Date:   Sat, 12 Jun 2021 21:18:21 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>, sboyd@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/clk/clk-k210.c:717:6: warning: variable 'reg' set but
 not used
Message-ID: <20210612211821.7f34fa81@xhacker>
In-Reply-To: <mhng-7814f596-6d02-4031-b90d-7db1cfed8970@palmerdabbelt-glaptop>
References: <DM6PR04MB7081C0499CCCA8C9B9E36610E73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
        <mhng-7814f596-6d02-4031-b90d-7db1cfed8970@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygAHk6BntcRg9BTNAA--.64727S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr15tryfWFyrWr4DZw48tFb_yoWfAry7pF
        Z5CFy8KFZ5Xr15Gw4q9F9Fv345tws8W34avry5W34jva9FqFW8Grn0krZ8KFyqvF4vka4x
        KrsrCa43WryUXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUq_b1DUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 20:55:41 -0700 (PDT)
Palmer Dabbelt <palmerdabbelt@google.com> wrote:

> On Thu, 03 Jun 2021 03:03:14 PDT (-0700), Damien Le Moal wrote:
> >> On 2021/06/03 18:35, kernel test robot wrote:
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   324c92e5e0ee0e993bdb106fac407846ed677f6b
> >> commit: c6ca7616f7d5c2ce166280107ba74db1d528fcb7 clk: Add RISC-V Canaan Kendryte K210 clock driver
> >> date:   3 months ago
> >> config: riscv-randconfig-r033-20210603 (attached as .config)
> >> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project d8e0ae9a76a62bdc6117630d59bf9967ac9bb4ea)
> >> reproduce (this is a W=1 build):
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # install riscv cross compiling tool for clang build
> >>         # apt-get install binutils-riscv64-linux-gnu
> >>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6ca7616f7d5c2ce166280107ba74db1d528fcb7
> >>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>         git fetch --no-tags linus master
> >>         git checkout c6ca7616f7d5c2ce166280107ba74db1d528fcb7
> >>         # save the attached .config to linux build tree
> >>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 
> >> 
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> 
> >> All warnings (new ones prefixed by >>):
> >> 
> >>    In file included from drivers/clk/clk-k210.c:8:
> >>    In file included from include/linux/io.h:13:
> >>    In file included from arch/riscv/include/asm/io.h:149:
> >>    include/asm-generic/io.h:556:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >>            return inb(addr);
> >>                   ^~~~~~~~~
> >>    arch/riscv/include/asm/io.h:55:76: note: expanded from macro 'inb'
> >>    #define inb(c)          ({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> >>                                                                            ~~~~~~~~~~ ^
> >>    arch/riscv/include/asm/mmio.h:87:48: note: expanded from macro 'readb_cpu'
> >>    #define readb_cpu(c)            ({ u8  __r = __raw_readb(c); __r; })
> >>                                                             ^
> >>    In file included from drivers/clk/clk-k210.c:8:
> >>    In file included from include/linux/io.h:13:
> >>    In file included from arch/riscv/include/asm/io.h:149:
> >>    include/asm-generic/io.h:564:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >>            return inw(addr);
> >>                   ^~~~~~~~~
> >>    arch/riscv/include/asm/io.h:56:76: note: expanded from macro 'inw'
> >>    #define inw(c)          ({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> >>                                                                            ~~~~~~~~~~ ^
> >>    arch/riscv/include/asm/mmio.h:88:76: note: expanded from macro 'readw_cpu'
> >>    #define readw_cpu(c)            ({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
> >>                                                                                         ^
> >>    include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
> >>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
> >>                                                      ^
> >>    In file included from drivers/clk/clk-k210.c:8:
> >>    In file included from include/linux/io.h:13:
> >>    In file included from arch/riscv/include/asm/io.h:149:
> >>    include/asm-generic/io.h:572:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >>            return inl(addr);
> >>                   ^~~~~~~~~
> >>    arch/riscv/include/asm/io.h:57:76: note: expanded from macro 'inl'
> >>    #define inl(c)          ({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> >>                                                                            ~~~~~~~~~~ ^
> >>    arch/riscv/include/asm/mmio.h:89:76: note: expanded from macro 'readl_cpu'
> >>    #define readl_cpu(c)            ({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
> >>                                                                                         ^
> >>    include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
> >>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
> >>                                                      ^
> >>    In file included from drivers/clk/clk-k210.c:8:
> >>    In file included from include/linux/io.h:13:
> >>    In file included from arch/riscv/include/asm/io.h:149:
> >>    include/asm-generic/io.h:580:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >>            outb(value, addr);
> >>            ^~~~~~~~~~~~~~~~~
> >>    arch/riscv/include/asm/io.h:59:68: note: expanded from macro 'outb'
> >>    #define outb(v,c)       ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> >>                                                                  ~~~~~~~~~~ ^
> >>    arch/riscv/include/asm/mmio.h:91:52: note: expanded from macro 'writeb_cpu'
> >>    #define writeb_cpu(v, c)        ((void)__raw_writeb((v), (c)))
> >>                                                              ^
> >>    In file included from drivers/clk/clk-k210.c:8:
> >>    In file included from include/linux/io.h:13:
> >>    In file included from arch/riscv/include/asm/io.h:149:
> >>    include/asm-generic/io.h:588:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >>            outw(value, addr);
> >>            ^~~~~~~~~~~~~~~~~
> >>    arch/riscv/include/asm/io.h:60:68: note: expanded from macro 'outw'
> >>    #define outw(v,c)       ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> >>                                                                  ~~~~~~~~~~ ^
> >>    arch/riscv/include/asm/mmio.h:92:76: note: expanded from macro 'writew_cpu'
> >>    #define writew_cpu(v, c)        ((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
> >>                                                                                      ^
> >>    In file included from drivers/clk/clk-k210.c:8:
> >>    In file included from include/linux/io.h:13:
> >>    In file included from arch/riscv/include/asm/io.h:149:
> >>    include/asm-generic/io.h:596:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >>            outl(value, addr);
> >>            ^~~~~~~~~~~~~~~~~
> >>    arch/riscv/include/asm/io.h:61:68: note: expanded from macro 'outl'
> >>    #define outl(v,c)       ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> >>                                                                  ~~~~~~~~~~ ^
> >>    arch/riscv/include/asm/mmio.h:93:76: note: expanded from macro 'writel_cpu'
> >>    #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
> >>                                                                                      ^
> >>    In file included from drivers/clk/clk-k210.c:8:
> >>    In file included from include/linux/io.h:13:
> >>    In file included from arch/riscv/include/asm/io.h:149:
> >>    include/asm-generic/io.h:1005:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >>            return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;

+ Christoph

This warning can only be reproduced with clang + W=1
The problem is that PCI_IOBASE isn't defined for NOMMU, so clang complains
null pointer arithmetic.


> >>                                                      ~~~~~~~~~~ ^  
> >>>> drivers/clk/clk-k210.c:717:6: warning: variable 'reg' set but not used [-Wunused-but-set-variable]  
> >>            u32 reg;
> >>                ^
> >>    8 warnings generated.

This warning can't be reproduced even with clang + W=1

> >> 
> >> 
> >> vim +/reg +717 drivers/clk/clk-k210.c
> >> 
> >>    710	
> >>    711	static int k210_clk_set_parent(struct clk_hw *hw, u8 index)
> >>    712	{
> >>    713		struct k210_clk *kclk = to_k210_clk(hw);
> >>    714		struct k210_sysclk *ksc = kclk->ksc;
> >>    715		struct k210_clk_cfg *cfg = &k210_clk_cfgs[kclk->id];
> >>    716		unsigned long flags;  
> >>  > 717		u32 reg;  
> >
> > Palmer,
> >
> > I do not think this driver is the real cause of this error. Did something change
> > recently with risc-v mmio readl()/writel() ?  
> 
> I have no idea what's going on here.  When I try to re-build that config 
> I don't get any warnings or errors.  That said...
> 
> >>    718	
> >>    719		spin_lock_irqsave(&ksc->clk_lock, flags);
> >>    720		reg = readl(ksc->regs + cfg->mux_reg);
> >>    721		if (index)
> >>    722			reg |= BIT(cfg->mux_bit);
> >>    723		else
> >>    724			reg &= ~BIT(cfg->mux_bit);
> >>    725		spin_unlock_irqrestore(&ksc->clk_lock, flags);  
> 
> Isn't reg unused here?  That's one of the warnings.
> 
> The void* casting has been there for a while and looks like a real bug, 
> but asm-generic adopted our {in,out}{bwlq} implementation so I'm just 
> going to toss ours.  I'm not quite sure why the generic ones aren't 
> doing arithmetic on void*, but I'm not getting warnings.
> 
> >>    726	
> >>    727		return 0;
> >>    728	}
> >>    729	
> >> 
> >> ---
> >> 0-DAY CI Kernel Test Service, Intel Corporation
> >> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >>   
> >
> >
> >-- 
> >Damien Le Moal
> >Western Digital Research
> >  
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



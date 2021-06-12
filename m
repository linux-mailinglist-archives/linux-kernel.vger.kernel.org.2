Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430113A4C85
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFLD5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLD5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:57:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:55:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso8179157pjx.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xldIaWK9sg7NVoAQhYOc4tzAvd8jQwjusXEXaSEXCb4=;
        b=mHnDwU5j5HKJl+3b27naK1uUsKJHsIx0/EjabcaJeiYn5/gW2UGfo2FdMlfXZenS8F
         W2xFBOOB7/2DT+0xxtjlb9RpzHMGJeDgVMc5CskAtns0iJo3adlgs0Tt3y3ZmPZY37Jk
         ZYHcjJc5gw3ZGwd/nQTt5yyFatrR9w8BRAOOHr3e2JVKeD+Sa2eEC8YcaQGQUu2qKEF1
         ttsRElmCax48NI3G/W3uHJRR74G49Ec+/ytrpMHDPxOv33mJzakabJ+kMgzxxNVJPqbH
         u4Ma3KCshYdHNmTRVw5FS6shA8hkHFB+jsLFCCisFvAUmrbsRp5+GAwb4gdFHU+rUZ9G
         4ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xldIaWK9sg7NVoAQhYOc4tzAvd8jQwjusXEXaSEXCb4=;
        b=VE/XBdFJh9bEtmNzplgtNzIKjdhQ1GP1TwQkZEzbVAooQsiZ9T/CNFg+bp14EJpb5B
         wXr018mUR0vbsGjk02s4fBCseFG7vx6KafIrKjfMyTfXgQbHIg1gljmlwrKrJq5EJbuP
         HJNv0uqv1R2ycZLofdEWejEFyUKLzu4aIgIcR+uz/ds8QWKlzyuXENvnEhdrTDqDQ0fX
         XolG7OJyB6ZVuSR2W5eCpuen+ZUN7g31u65e3+bq5yA7MOEKVE2PR2msCTmTDMJwIrPc
         fqSm6jZi/4LxOeakcrqg87GV2An558vIz8yYOQyvTuYEUiVZlDqDWCJmFEZMnUPyloCI
         TXBg==
X-Gm-Message-State: AOAM533rfp19Do6eYhHCirUmmYsmscWB8mquUhcpvjLUPQeOojlAVkQ2
        fp67x5Wy0O9KStChC+9puWCqmg==
X-Google-Smtp-Source: ABdhPJzlUeF1RtfU+gBaZf6zidWmxHiIcaFA5xb0fHqmUrUPvHhMBSREN4UbsxU1WLFXHseHQWS+dQ==
X-Received: by 2002:a17:90a:de15:: with SMTP id m21mr7698977pjv.87.1623470142344;
        Fri, 11 Jun 2021 20:55:42 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x206sm6400659pfc.211.2021.06.11.20.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:55:41 -0700 (PDT)
Date:   Fri, 11 Jun 2021 20:55:41 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Jun 2021 20:37:09 PDT (-0700)
Subject:     Re: drivers/clk/clk-k210.c:717:6: warning: variable 'reg' set but not used
In-Reply-To: <DM6PR04MB7081C0499CCCA8C9B9E36610E73C9@DM6PR04MB7081.namprd04.prod.outlook.com>
CC:     sboyd@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Message-ID: <mhng-7814f596-6d02-4031-b90d-7db1cfed8970@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jun 2021 03:03:14 PDT (-0700), Damien Le Moal wrote:
>> On 2021/06/03 18:35, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   324c92e5e0ee0e993bdb106fac407846ed677f6b
>> commit: c6ca7616f7d5c2ce166280107ba74db1d528fcb7 clk: Add RISC-V Canaan Kendryte K210 clock driver
>> date:   3 months ago
>> config: riscv-randconfig-r033-20210603 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project d8e0ae9a76a62bdc6117630d59bf9967ac9bb4ea)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install riscv cross compiling tool for clang build
>>         # apt-get install binutils-riscv64-linux-gnu
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6ca7616f7d5c2ce166280107ba74db1d528fcb7
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout c6ca7616f7d5c2ce166280107ba74db1d528fcb7
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 
>> 
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>> 
>> All warnings (new ones prefixed by >>):
>> 
>>    In file included from drivers/clk/clk-k210.c:8:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/riscv/include/asm/io.h:149:
>>    include/asm-generic/io.h:556:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>            return inb(addr);
>>                   ^~~~~~~~~
>>    arch/riscv/include/asm/io.h:55:76: note: expanded from macro 'inb'
>>    #define inb(c)          ({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
>>                                                                            ~~~~~~~~~~ ^
>>    arch/riscv/include/asm/mmio.h:87:48: note: expanded from macro 'readb_cpu'
>>    #define readb_cpu(c)            ({ u8  __r = __raw_readb(c); __r; })
>>                                                             ^
>>    In file included from drivers/clk/clk-k210.c:8:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/riscv/include/asm/io.h:149:
>>    include/asm-generic/io.h:564:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>            return inw(addr);
>>                   ^~~~~~~~~
>>    arch/riscv/include/asm/io.h:56:76: note: expanded from macro 'inw'
>>    #define inw(c)          ({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
>>                                                                            ~~~~~~~~~~ ^
>>    arch/riscv/include/asm/mmio.h:88:76: note: expanded from macro 'readw_cpu'
>>    #define readw_cpu(c)            ({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
>>                                                                                         ^
>>    include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
>>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>>                                                      ^
>>    In file included from drivers/clk/clk-k210.c:8:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/riscv/include/asm/io.h:149:
>>    include/asm-generic/io.h:572:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>            return inl(addr);
>>                   ^~~~~~~~~
>>    arch/riscv/include/asm/io.h:57:76: note: expanded from macro 'inl'
>>    #define inl(c)          ({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
>>                                                                            ~~~~~~~~~~ ^
>>    arch/riscv/include/asm/mmio.h:89:76: note: expanded from macro 'readl_cpu'
>>    #define readl_cpu(c)            ({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
>>                                                                                         ^
>>    include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
>>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>>                                                      ^
>>    In file included from drivers/clk/clk-k210.c:8:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/riscv/include/asm/io.h:149:
>>    include/asm-generic/io.h:580:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>            outb(value, addr);
>>            ^~~~~~~~~~~~~~~~~
>>    arch/riscv/include/asm/io.h:59:68: note: expanded from macro 'outb'
>>    #define outb(v,c)       ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
>>                                                                  ~~~~~~~~~~ ^
>>    arch/riscv/include/asm/mmio.h:91:52: note: expanded from macro 'writeb_cpu'
>>    #define writeb_cpu(v, c)        ((void)__raw_writeb((v), (c)))
>>                                                              ^
>>    In file included from drivers/clk/clk-k210.c:8:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/riscv/include/asm/io.h:149:
>>    include/asm-generic/io.h:588:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>            outw(value, addr);
>>            ^~~~~~~~~~~~~~~~~
>>    arch/riscv/include/asm/io.h:60:68: note: expanded from macro 'outw'
>>    #define outw(v,c)       ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
>>                                                                  ~~~~~~~~~~ ^
>>    arch/riscv/include/asm/mmio.h:92:76: note: expanded from macro 'writew_cpu'
>>    #define writew_cpu(v, c)        ((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
>>                                                                                      ^
>>    In file included from drivers/clk/clk-k210.c:8:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/riscv/include/asm/io.h:149:
>>    include/asm-generic/io.h:596:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>            outl(value, addr);
>>            ^~~~~~~~~~~~~~~~~
>>    arch/riscv/include/asm/io.h:61:68: note: expanded from macro 'outl'
>>    #define outl(v,c)       ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
>>                                                                  ~~~~~~~~~~ ^
>>    arch/riscv/include/asm/mmio.h:93:76: note: expanded from macro 'writel_cpu'
>>    #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
>>                                                                                      ^
>>    In file included from drivers/clk/clk-k210.c:8:
>>    In file included from include/linux/io.h:13:
>>    In file included from arch/riscv/include/asm/io.h:149:
>>    include/asm-generic/io.h:1005:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>            return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>>                                                      ~~~~~~~~~~ ^
>>>> drivers/clk/clk-k210.c:717:6: warning: variable 'reg' set but not used [-Wunused-but-set-variable]
>>            u32 reg;
>>                ^
>>    8 warnings generated.
>> 
>> 
>> vim +/reg +717 drivers/clk/clk-k210.c
>> 
>>    710	
>>    711	static int k210_clk_set_parent(struct clk_hw *hw, u8 index)
>>    712	{
>>    713		struct k210_clk *kclk = to_k210_clk(hw);
>>    714		struct k210_sysclk *ksc = kclk->ksc;
>>    715		struct k210_clk_cfg *cfg = &k210_clk_cfgs[kclk->id];
>>    716		unsigned long flags;
>>  > 717		u32 reg;
>
> Palmer,
>
> I do not think this driver is the real cause of this error. Did something change
> recently with risc-v mmio readl()/writel() ?

I have no idea what's going on here.  When I try to re-build that config 
I don't get any warnings or errors.  That said...

>>    718	
>>    719		spin_lock_irqsave(&ksc->clk_lock, flags);
>>    720		reg = readl(ksc->regs + cfg->mux_reg);
>>    721		if (index)
>>    722			reg |= BIT(cfg->mux_bit);
>>    723		else
>>    724			reg &= ~BIT(cfg->mux_bit);
>>    725		spin_unlock_irqrestore(&ksc->clk_lock, flags);

Isn't reg unused here?  That's one of the warnings.

The void* casting has been there for a while and looks like a real bug, 
but asm-generic adopted our {in,out}{bwlq} implementation so I'm just 
going to toss ours.  I'm not quite sure why the generic ones aren't 
doing arithmetic on void*, but I'm not getting warnings.

>>    726	
>>    727		return 0;
>>    728	}
>>    729	
>> 
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>> 
>
>
>-- 
>Damien Le Moal
>Western Digital Research
>

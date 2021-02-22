Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C75B320FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 04:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBVDZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 22:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBVDZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 22:25:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5901C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 19:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mtqfSdQ8NhvPLj9GjvLKevGYS4YlbfSgclAeqe+OYmk=; b=PWEdPZh8yA93qjBSmhZdBwIr9B
        /PbRNc2y8JCLZPQhBo3RQk9bpHeIR15/NKciyZV8doPCGv17PfGgOIjpnoF14JOvccehNun2Nyys/
        hZXF5TrZzoztst3sooug3TwG/WcQjjP4Ljy+d35n8GWnRr1zWDk6jh61u//0abh6Jax+uLy6PQ7S2
        0XMWPWOJfj3u6deAejQUqcpcgQzdU+qDK8hCZ6zuJb/CA1QISMQYgUks4sJVFcO+8aB5PgobRV1CN
        dzQMrt0n/K4y63LrMOf1BEz2aVJfhNB6ujeJyMEYcX/HPzz7tta7La00+cNCuYgeOa0iuWp4ZvJHN
        aUdfbzuA==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lE1qO-0003Mf-Hf; Mon, 22 Feb 2021 03:25:09 +0000
Subject: Re: arch/arm/kernel/patch.c:94:11: error: implicit declaration of
 function '__opcode_to_mem_thumb32'
To:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
References: <202102210300.uMKy3Arz-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e277fd86-c50a-0f58-19dc-3acc8a29ee1b@infradead.org>
Date:   Sun, 21 Feb 2021 19:25:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102210300.uMKy3Arz-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/21 11:08 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f40ddce88593482919761f74910f42f4b84c004b
> commit: 5a735583b764750726621b0396d03e4782911b77 arm/ftrace: Use __patch_text()
> date:   1 year, 3 months ago
> config: arm-randconfig-r014-20210220 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a735583b764750726621b0396d03e4782911b77
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5a735583b764750726621b0396d03e4782911b77
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm/kernel/patch.c: In function '__patch_text_real':
>>> arch/arm/kernel/patch.c:94:11: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]
>       94 |    insn = __opcode_to_mem_thumb32(insn);
>          |           ^~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +/__opcode_to_mem_thumb32 +94 arch/arm/kernel/patch.c
> 
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   55  
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   56  void __kprobes __patch_text_real(void *addr, unsigned int insn, bool remap)
> b21d55e98ac2bb Rabin Vincent 2012-02-18   57  {
> b21d55e98ac2bb Rabin Vincent 2012-02-18   58  	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   59  	unsigned int uintaddr = (uintptr_t) addr;
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   60  	bool twopage = false;
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   61  	unsigned long flags;
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   62  	void *waddr = addr;
> b21d55e98ac2bb Rabin Vincent 2012-02-18   63  	int size;
> b21d55e98ac2bb Rabin Vincent 2012-02-18   64  
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   65  	if (remap)
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   66  		waddr = patch_map(addr, FIX_TEXT_POKE0, &flags);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   67  	else
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   68  		__acquire(&patch_lock);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   69  
> b21d55e98ac2bb Rabin Vincent 2012-02-18   70  	if (thumb2 && __opcode_is_thumb16(insn)) {
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   71  		*(u16 *)waddr = __opcode_to_mem_thumb16(insn);
> b21d55e98ac2bb Rabin Vincent 2012-02-18   72  		size = sizeof(u16);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   73  	} else if (thumb2 && (uintaddr & 2)) {
> b21d55e98ac2bb Rabin Vincent 2012-02-18   74  		u16 first = __opcode_thumb32_first(insn);
> b21d55e98ac2bb Rabin Vincent 2012-02-18   75  		u16 second = __opcode_thumb32_second(insn);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   76  		u16 *addrh0 = waddr;
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   77  		u16 *addrh1 = waddr + 2;
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   78  
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   79  		twopage = (uintaddr & ~PAGE_MASK) == PAGE_SIZE - 2;
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   80  		if (twopage && remap)
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   81  			addrh1 = patch_map(addr + 2, FIX_TEXT_POKE1, NULL);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   82  
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   83  		*addrh0 = __opcode_to_mem_thumb16(first);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   84  		*addrh1 = __opcode_to_mem_thumb16(second);
> b21d55e98ac2bb Rabin Vincent 2012-02-18   85  
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   86  		if (twopage && addrh1 != addr + 2) {
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   87  			flush_kernel_vmap_range(addrh1, 2);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   88  			patch_unmap(FIX_TEXT_POKE1, NULL);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   89  		}
> b21d55e98ac2bb Rabin Vincent 2012-02-18   90  
> b21d55e98ac2bb Rabin Vincent 2012-02-18   91  		size = sizeof(u32);
> b21d55e98ac2bb Rabin Vincent 2012-02-18   92  	} else {
> b21d55e98ac2bb Rabin Vincent 2012-02-18   93  		if (thumb2)
> b21d55e98ac2bb Rabin Vincent 2012-02-18  @94  			insn = __opcode_to_mem_thumb32(insn);
> b21d55e98ac2bb Rabin Vincent 2012-02-18   95  		else
> b21d55e98ac2bb Rabin Vincent 2012-02-18   96  			insn = __opcode_to_mem_arm(insn);
> b21d55e98ac2bb Rabin Vincent 2012-02-18   97  
> ab0615e2d6fb07 Rabin Vincent 2014-04-24   98  		*(u32 *)waddr = insn;
> b21d55e98ac2bb Rabin Vincent 2012-02-18   99  		size = sizeof(u32);
> b21d55e98ac2bb Rabin Vincent 2012-02-18  100  	}
> b21d55e98ac2bb Rabin Vincent 2012-02-18  101  
> ab0615e2d6fb07 Rabin Vincent 2014-04-24  102  	if (waddr != addr) {
> ab0615e2d6fb07 Rabin Vincent 2014-04-24  103  		flush_kernel_vmap_range(waddr, twopage ? size / 2 : size);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24  104  		patch_unmap(FIX_TEXT_POKE0, &flags);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24  105  	} else
> ab0615e2d6fb07 Rabin Vincent 2014-04-24  106  		__release(&patch_lock);
> ab0615e2d6fb07 Rabin Vincent 2014-04-24  107  
> b21d55e98ac2bb Rabin Vincent 2012-02-18  108  	flush_icache_range((uintptr_t)(addr),
> b21d55e98ac2bb Rabin Vincent 2012-02-18  109  			   (uintptr_t)(addr) + size);
> b21d55e98ac2bb Rabin Vincent 2012-02-18  110  }
> b21d55e98ac2bb Rabin Vincent 2012-02-18  111  
> 
> :::::: The code at line 94 was first introduced by commit
> :::::: b21d55e98ac2bbcbbeec9a8cb091f717fd95b072 ARM: 7332/1: extract out code patch function from kprobes
> 
> :::::: TO: Rabin Vincent <rabin@rab.in>
> :::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>


This comes down to:

CONFIG_ARM_THUMB=y
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_CPU_ENDIAN_BE32=y

and <asm/opcodes.h>, where arch/arm/asm/opcodes.h says:

/*
 * On BE32 systems, using 32-bit accesses to store Thumb instructions will not
 * work in all cases, due to alignment constraints.  For now, a correct
 * version is not provided for BE32.
 */

Should we try to find a way to prevent this combination from happening?


-- 
~Randy


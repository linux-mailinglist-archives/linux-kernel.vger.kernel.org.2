Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83AB3EBF38
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbhHNBJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235870AbhHNBJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:09:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD825610FA;
        Sat, 14 Aug 2021 01:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628903346;
        bh=g+yGs1QxXqIF7fZn9mqGtHxhJ13Lzjmgxxhoh2KLeHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MNhjakI1i4ckxvyHmJ8qiH8Q8aNeoCHvIsMtV9qwGzgj54y0R3+mfWL0B0TdI9Cx/
         IXAXqN30GOHsG9Wvs+Act/RI1uLjczlNXeso7Dj4uV8QWg31Xzq0yKAXGgHqvI9qxR
         ugxWXbIfthQtvilktTwhR0fH7RHL5GMPKfobkxd+QHbbPCbjJvcNdiyBvr7MA821cs
         twgdJow+pLpeANMioY8RfALhU56FDH34Y+JseAtXw6WSREHvjXAIRheSOmAZNHsDYV
         RM6b+KNkIUZW0fyV9ZtkQzTUHbRdGN6F7NJQYgbGQSa3Csyyravwh67H4RA4leefOa
         ZE7xn4a2kPQUw==
Date:   Fri, 13 Aug 2021 18:09:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, clang-built-linux@googlegroups.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [block:io_uring-fops.v6 58/64] io_uring.c:undefined reference to
 `__compiletime_assert_833'
Message-ID: <YRcXr8o56PIYHY27@Ryzen-9-3900X.localdomain>
References: <202108140731.bUZsdUjG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108140731.bUZsdUjG-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 07:11:36AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git io_uring-fops.v6
> head:   4e0c34c9b129fe84c63d3f76053d2e55d944e8a9
> commit: 834d3e42c71acf4653f840ac3998f8601f37021c [58/64] io_uring: add infrastructure around io_uring_cmd_sqe issue type
> config: s390-randconfig-r033-20210813 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 62df4df41c939205b2dc0a2a3bfb75b8c1ed74fa)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=834d3e42c71acf4653f840ac3998f8601f37021c
>         git remote add block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>         git fetch --no-tags block io_uring-fops.v6
>         git checkout 834d3e42c71acf4653f840ac3998f8601f37021c
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    s390x-linux-gnu-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
>    coherent.c:(.text+0xc4): undefined reference to `memunmap'
>    s390x-linux-gnu-ld: coherent.c:(.text+0x1c4): undefined reference to `memunmap'
>    s390x-linux-gnu-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
>    coherent.c:(.text+0x2b4): undefined reference to `memremap'
>    s390x-linux-gnu-ld: coherent.c:(.text+0x564): undefined reference to `memunmap'
>    s390x-linux-gnu-ld: fs/io_uring.o: in function `io_uring_init':
> >> io_uring.c:(.init.text+0x30): undefined reference to `__compiletime_assert_833'
> >> s390x-linux-gnu-ld: io_uring.c:(.init.text+0x4a): undefined reference to `__compiletime_assert_835'
>    s390x-linux-gnu-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
>    fsl-edma.c:(.text+0x1bc): undefined reference to `devm_ioremap_resource'
>    s390x-linux-gnu-ld: fsl-edma.c:(.text+0x40a): undefined reference to `devm_ioremap_resource'
>    s390x-linux-gnu-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
>    idma64.c:(.text+0xc6): undefined reference to `devm_ioremap_resource'
>    s390x-linux-gnu-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>    xillybus_of.c:(.text+0xc4): undefined reference to `devm_platform_ioremap_resource'
>    s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
>    cistpl.c:(.text+0x1d6): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
>    cistpl.c:(.text+0xb10): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: cistpl.c:(.text+0xbbe): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: cistpl.c:(.text+0xf4e): undefined reference to `iounmap'
>    s390x-linux-gnu-ld: cistpl.c:(.text+0xf8c): undefined reference to `ioremap'
>    s390x-linux-gnu-ld: drivers/clocksource/timer-of.o: in function `timer_of_base_init':
>    timer-of.c:(.init.text+0x576): undefined reference to `of_iomap'
>    s390x-linux-gnu-ld: drivers/clocksource/timer-of.o: in function `timer_of_base_exit':
>    timer-of.c:(.init.text+0x17ba): undefined reference to `iounmap'

Grabbing Nick's patch [1] to support the error function attribute turns
this into:

fs/io_uring.c:10531:2: error: call to '__compiletime_assert_833' declared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct io_uring_cmd_sqe, user_data) != sqe_offsets[1].user_data
        BUILD_BUG_SQEC_ELEM(sqe_offsets[1].user_data,   __u64,  user_data);
        ^
fs/io_uring.c:10528:2: note: expanded from macro 'BUILD_BUG_SQEC_ELEM'
        __BUILD_BUG_VERIFY_ELEMENT(struct io_uring_cmd_sqe, eoffset, etype, ename)
        ^
fs/io_uring.c:10489:2: note: expanded from macro '__BUILD_BUG_VERIFY_ELEMENT'
        BUILD_BUG_ON(offsetof(stype, ename) != eoffset); \
        ^
./include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
        BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
        ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
./include/linux/compiler_types.h:310:2: note: expanded from macro '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
./include/linux/compiler_types.h:303:4: note: expanded from macro '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:17:1: note: expanded from here
__compiletime_assert_833
^
fs/io_uring.c:10532:2: error: call to '__compiletime_assert_835' declared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct io_uring_cmd_sqe, personality) != sqe_offsets[1].personality
        BUILD_BUG_SQEC_ELEM(sqe_offsets[1].personality, __u16,  personality);
        ^
fs/io_uring.c:10528:2: note: expanded from macro 'BUILD_BUG_SQEC_ELEM'
        __BUILD_BUG_VERIFY_ELEMENT(struct io_uring_cmd_sqe, eoffset, etype, ename)
        ^
fs/io_uring.c:10489:2: note: expanded from macro '__BUILD_BUG_VERIFY_ELEMENT'
        BUILD_BUG_ON(offsetof(stype, ename) != eoffset); \
        ^
./include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
        BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
        ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
./include/linux/compiler_types.h:310:2: note: expanded from macro '_compiletime_assert'
        __compiletime_assert(condition, msg, prefix, suffix)
        ^
./include/linux/compiler_types.h:303:4: note: expanded from macro '__compiletime_assert'
                        prefix ## suffix();                             \
                        ^
<scratch space>:25:1: note: expanded from here
__compiletime_assert_835
^
2 errors generated.

Is this a legitimate failure? I do not see this with GCC 11.2.0.

[1]: https://reviews.llvm.org/D106030 + https://lore.kernel.org/r/20210802202326.1817503-1-ndesaulniers@google.com/

Cheers,
Nathan

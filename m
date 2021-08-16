Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC483EDC1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhHPRL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhHPRLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:11:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:11:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y7so28353209ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+5s2IjYCm9VNRG19z4wqzmijC97Yf/esoVK52Hxj6E=;
        b=GUS5uGzPQ8IdFyzsDfmy3tIBuCxJoefG0xGFkHnm5y/PrEkS0b6PlJ4Xcg/VzDFZNK
         TqvdzV2xA9og8SxGzW3EX8FBeV4Zh7EMV6Rjk9Fhg2ozDv+y3UjtuZ8LUh2vOaq0+Iey
         LlCBPOlquTpFnMaichw6sQaK0C3Mee8udSIEvI/ZROvpk6g8YBmactVbKI9d6loqLCI7
         1E52n5dt06CYbRvb/56oulA1Z+jR4DHglaTMmFG3ReOcB+nAjIkPmYn1ysQBhcXupfO7
         p3CnGFqQLBSIp5fq82ia3HXD8qCetardZxsfJaBcaDhlEeoYxzIzylG9l7WtYugtDZsI
         VA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+5s2IjYCm9VNRG19z4wqzmijC97Yf/esoVK52Hxj6E=;
        b=JEQ61ElgDq9pHx69/q4Ljyl6HvnkSx+IKYg/ggm2gg5oJVACWR4bwWPsrzHgHaDUu0
         nK7or3ALXG8p1tbSZvdla7yPEJ9IwW0z4D+iqo++4G2/U6I8DxP5i3VZcLmBOV6fB0R+
         aIjja+E1qOzNuZaYAZsH2yCgGcYMjeV565M6ET90p/UNRfJM7coaBpdsMeVByHfDAnq3
         KOjDa2QAKE0wlmdpzlqoY8kkAPjFpDlhlma9AxnAAHS22QkFP8BDznEuBWf5ahQctjWx
         eWYkkofNoCAigcSFbjRZbDn77Vv5yiPn65j4LM1CWeU8RnYq6McXPa2Qf7rp8VfSwwDc
         V2fA==
X-Gm-Message-State: AOAM532CysCS24b6iaHWEhzXtbsHWzBPOdjUhvJ7gXmYnfB0TzPxTnRN
        U+9/eluqI25V5yDG1EaNb+fH1eFUKcDlPG+WtaQkhg==
X-Google-Smtp-Source: ABdhPJxUStS8PVfgzSzQTMUW3Y4NZ3GzVMnLBTTR0uumlIPHodISqDglIibtqXy+0KaF9366huH/n+7XlnllsC4Kc3c=
X-Received: by 2002:a2e:9ec1:: with SMTP id h1mr13469111ljk.0.1629133879847;
 Mon, 16 Aug 2021 10:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <202108140731.bUZsdUjG-lkp@intel.com> <YRcXr8o56PIYHY27@Ryzen-9-3900X.localdomain>
In-Reply-To: <YRcXr8o56PIYHY27@Ryzen-9-3900X.localdomain>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Aug 2021 10:11:08 -0700
Message-ID: <CAKwvOdnD=s-FnoL-EOmLSeywEEYfULnkmbiEpyNKQkgVRxnhog@mail.gmail.com>
Subject: Re: [block:io_uring-fops.v6 58/64] io_uring.c:undefined reference to `__compiletime_assert_833'
To:     Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     kernel test robot <lkp@intel.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 6:09 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Sat, Aug 14, 2021 at 07:11:36AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git io_uring-fops.v6
> > head:   4e0c34c9b129fe84c63d3f76053d2e55d944e8a9
> > commit: 834d3e42c71acf4653f840ac3998f8601f37021c [58/64] io_uring: add infrastructure around io_uring_cmd_sqe issue type
> > config: s390-randconfig-r033-20210813 (attached as .config)

^ Note: 390 randconfig. Not sure if that could have changed the offset
of some members?

> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 62df4df41c939205b2dc0a2a3bfb75b8c1ed74fa)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install s390 cross compiling tool for clang build
> >         # apt-get install binutils-s390x-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=834d3e42c71acf4653f840ac3998f8601f37021c
> >         git remote add block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >         git fetch --no-tags block io_uring-fops.v6
> >         git checkout 834d3e42c71acf4653f840ac3998f8601f37021c
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=s390 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    s390x-linux-gnu-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
> >    coherent.c:(.text+0xc4): undefined reference to `memunmap'
> >    s390x-linux-gnu-ld: coherent.c:(.text+0x1c4): undefined reference to `memunmap'
> >    s390x-linux-gnu-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
> >    coherent.c:(.text+0x2b4): undefined reference to `memremap'
> >    s390x-linux-gnu-ld: coherent.c:(.text+0x564): undefined reference to `memunmap'
> >    s390x-linux-gnu-ld: fs/io_uring.o: in function `io_uring_init':
> > >> io_uring.c:(.init.text+0x30): undefined reference to `__compiletime_assert_833'
> > >> s390x-linux-gnu-ld: io_uring.c:(.init.text+0x4a): undefined reference to `__compiletime_assert_835'
> >    s390x-linux-gnu-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
> >    fsl-edma.c:(.text+0x1bc): undefined reference to `devm_ioremap_resource'
> >    s390x-linux-gnu-ld: fsl-edma.c:(.text+0x40a): undefined reference to `devm_ioremap_resource'
> >    s390x-linux-gnu-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
> >    idma64.c:(.text+0xc6): undefined reference to `devm_ioremap_resource'
> >    s390x-linux-gnu-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
> >    xillybus_of.c:(.text+0xc4): undefined reference to `devm_platform_ioremap_resource'
> >    s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
> >    cistpl.c:(.text+0x1d6): undefined reference to `iounmap'
> >    s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
> >    cistpl.c:(.text+0xb10): undefined reference to `ioremap'
> >    s390x-linux-gnu-ld: cistpl.c:(.text+0xbbe): undefined reference to `iounmap'
> >    s390x-linux-gnu-ld: cistpl.c:(.text+0xf4e): undefined reference to `iounmap'
> >    s390x-linux-gnu-ld: cistpl.c:(.text+0xf8c): undefined reference to `ioremap'
> >    s390x-linux-gnu-ld: drivers/clocksource/timer-of.o: in function `timer_of_base_init':
> >    timer-of.c:(.init.text+0x576): undefined reference to `of_iomap'
> >    s390x-linux-gnu-ld: drivers/clocksource/timer-of.o: in function `timer_of_base_exit':
> >    timer-of.c:(.init.text+0x17ba): undefined reference to `iounmap'
>
> Grabbing Nick's patch [1] to support the error function attribute turns
> this into:
>
> fs/io_uring.c:10531:2: error: call to '__compiletime_assert_833' declared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct io_uring_cmd_sqe, user_data) != sqe_offsets[1].user_data
>         BUILD_BUG_SQEC_ELEM(sqe_offsets[1].user_data,   __u64,  user_data);
>         ^
> fs/io_uring.c:10528:2: note: expanded from macro 'BUILD_BUG_SQEC_ELEM'
>         __BUILD_BUG_VERIFY_ELEMENT(struct io_uring_cmd_sqe, eoffset, etype, ename)
>         ^
> fs/io_uring.c:10489:2: note: expanded from macro '__BUILD_BUG_VERIFY_ELEMENT'
>         BUILD_BUG_ON(offsetof(stype, ename) != eoffset); \
>         ^
> ./include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
>         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>         ^
> note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
> ./include/linux/compiler_types.h:310:2: note: expanded from macro '_compiletime_assert'
>         __compiletime_assert(condition, msg, prefix, suffix)
>         ^
> ./include/linux/compiler_types.h:303:4: note: expanded from macro '__compiletime_assert'
>                         prefix ## suffix();                             \
>                         ^
> <scratch space>:17:1: note: expanded from here
> __compiletime_assert_833
> ^
> fs/io_uring.c:10532:2: error: call to '__compiletime_assert_835' declared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct io_uring_cmd_sqe, personality) != sqe_offsets[1].personality
>         BUILD_BUG_SQEC_ELEM(sqe_offsets[1].personality, __u16,  personality);
>         ^
> fs/io_uring.c:10528:2: note: expanded from macro 'BUILD_BUG_SQEC_ELEM'
>         __BUILD_BUG_VERIFY_ELEMENT(struct io_uring_cmd_sqe, eoffset, etype, ename)
>         ^
> fs/io_uring.c:10489:2: note: expanded from macro '__BUILD_BUG_VERIFY_ELEMENT'
>         BUILD_BUG_ON(offsetof(stype, ename) != eoffset); \
>         ^
> ./include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
>         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>         ^
> note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
> ./include/linux/compiler_types.h:310:2: note: expanded from macro '_compiletime_assert'
>         __compiletime_assert(condition, msg, prefix, suffix)
>         ^
> ./include/linux/compiler_types.h:303:4: note: expanded from macro '__compiletime_assert'
>                         prefix ## suffix();                             \
>                         ^
> <scratch space>:25:1: note: expanded from here
> __compiletime_assert_835
> ^
> 2 errors generated.
>
> Is this a legitimate failure? I do not see this with GCC 11.2.0.
>
> [1]: https://reviews.llvm.org/D106030 + https://lore.kernel.org/r/20210802202326.1817503-1-ndesaulniers@google.com/
>
> Cheers,
> Nathan



-- 
Thanks,
~Nick Desaulniers

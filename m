Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA6236F2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 01:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhD2XB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 19:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhD2XB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:01:28 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49031C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 16:00:41 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 130so36857780ybd.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 16:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GY8+NFNznc0uHAnSET8Mqpt9HOn2PDRsyzqQPuaEzLU=;
        b=Nf2A9X+uMrg+yn9wRYcP32Q/OCmf8qpBLVncNs9qkU4PgOwNsVigargZmX7yQQxBHw
         sGbQrgdSIbvfeMEcxqUgeTfV6hJDaxBxon3maJK3VjFmvt5lmryM0s7xhdWYlpQGLvaY
         a2PLRsKPOgn3aC8ZRlA1cRmEA9gu89UoOUxoLL2FuWaOvM3ul/vLK/QAnojBFn1bWTgc
         VfIjvdGHcQKqCU53lhRPh4UQyc+AXZSorGFGQBYnBci//WGYwM2Ias3iqYTH/xnhlSSR
         /zVmnSvRk9PfkwlyStFJnLsD4kG+z6Zc61iShg5qhHaM9ijGhh8BnRwd5fFBPBdRZXbx
         gu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GY8+NFNznc0uHAnSET8Mqpt9HOn2PDRsyzqQPuaEzLU=;
        b=EV+qH4otBGMc/cxTy/DO5zOSXMOJZ/aVn+fiOYcJsGIJf3k76O6MyKKhWMrpXt4Y5c
         QRMHFA3ujXLEyU2Yible62k58x2fU/4SjoRHBKttU16mCXam42pwwMHQ8mBWzraFpE1I
         QMbjTJBnTUd9ubWh9y9u68Z4M93yiBXBHxvh8udL5PNx3z3bKDcB1J2nSdkJ5DmjBv0N
         ZI/+GIXJPEnSU1jtCUp/QlT8P1KcW88LtDgl3W4/H2cH5/mEZqK3MDl4O4iSlMRH6SiE
         NRpfhI7eV7KaZXzY60lwQIExdm0rOZy8srQQyZTcOW392Eoa95FxZJC0rAC576M5KtnB
         O/Ag==
X-Gm-Message-State: AOAM532RpuXc7AaMzwtwxbAL9m5qWL4KYq8xVNFAPRQ6DT0Vh9crMGnY
        963kgMBNQQvqewCXqZ3ruX0yX00bnjcFLKNYq8ivYA==
X-Google-Smtp-Source: ABdhPJxy0WJbYVXVo1Im7hWFsKPZKui5iuw08D08bq9lJQcA3ucNg9D+4u4mhVkPZDLnU24W4jfWEV1SFSbcq2i8YNk=
X-Received: by 2002:a25:d8cc:: with SMTP id p195mr2640360ybg.170.1619737240311;
 Thu, 29 Apr 2021 16:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210429150940.3256656-1-arnd@kernel.org> <202104300518.EF8t97XP-lkp@intel.com>
In-Reply-To: <202104300518.EF8t97XP-lkp@intel.com>
From:   Jian Cai <jiancai@google.com>
Date:   Thu, 29 Apr 2021 16:00:29 -0700
Message-ID: <CA+SOCLJX+KYQZTbY-22Enp5+TdNvHB7kr+LiW-KmGirfgu=0sQ@mail.gmail.com>
Subject: Re: [PATCH] smp: fix smp_call_function_single_async prototype
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch! Some of the stable kernels also have this
warning, but they don't seem to have the dependencies (4.14, 4,19,
5.4). Do we plan to fix those branches as well?


On Thu, Apr 29, 2021 at 2:46 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Arnd,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on next-20210429]
> [cannot apply to linux/master soc/for-next linus/master v5.12 v5.12-rc8 v5.12-rc7 v5.12]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/smp-fix-smp_call_function_single_async-prototype/20210429-231235
> base:    9e5cff2a1315fec1da1f497714395670366506b6
> config: arm64-randconfig-r022-20210429 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 9131a078901b00e68248a27a4f8c4b11bb1db1ae)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/be40015a8e0990182fa440f75adecf40cf5d0062
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Arnd-Bergmann/smp-fix-smp_call_function_single_async-prototype/20210429-231235
>         git checkout be40015a8e0990182fa440f75adecf40cf5d0062
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> kernel/smp.c:407:19: warning: passing 8-byte aligned argument to 32-byte aligned parameter 1 of '__csd_lock_wait' may result in an unaligned pointer access [-Walign-mismatch]
>                    __csd_lock_wait(csd);
>                                    ^
>    kernel/smp.c:515:19: warning: passing 8-byte aligned argument to 32-byte aligned parameter 1 of 'csd_lock_record' may result in an unaligned pointer access [-Walign-mismatch]
>                    csd_lock_record(csd);
>                                    ^
>    kernel/smp.c:516:14: warning: passing 8-byte aligned argument to 32-byte aligned parameter 1 of 'csd_unlock' may result in an unaligned pointer access [-Walign-mismatch]
>                    csd_unlock(csd);
>                               ^
>    kernel/smp.c:525:14: warning: passing 8-byte aligned argument to 32-byte aligned parameter 1 of 'csd_unlock' may result in an unaligned pointer access [-Walign-mismatch]
>                    csd_unlock(csd);
>                               ^
>    kernel/smp.c:684:6: warning: no previous prototype for function 'flush_smp_call_function_from_idle' [-Wmissing-prototypes]
>    void flush_smp_call_function_from_idle(void)
>         ^
>    kernel/smp.c:684:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void flush_smp_call_function_from_idle(void)
>    ^
>    static
>    5 warnings generated.
>
>
> vim +/__csd_lock_wait +407 kernel/smp.c
>
> 35feb60474bf4f Paul E. McKenney 2020-06-30  403
> be40015a8e0990 Arnd Bergmann    2021-04-29  404  static __always_inline void csd_lock_wait(struct __call_single_data *csd)
> 8d0968cc6b8ffd Juergen Gross    2021-03-01  405  {
> 8d0968cc6b8ffd Juergen Gross    2021-03-01  406         if (static_branch_unlikely(&csdlock_debug_enabled)) {
> 8d0968cc6b8ffd Juergen Gross    2021-03-01 @407                 __csd_lock_wait(csd);
> 8d0968cc6b8ffd Juergen Gross    2021-03-01  408                 return;
> 8d0968cc6b8ffd Juergen Gross    2021-03-01  409         }
> 8d0968cc6b8ffd Juergen Gross    2021-03-01  410
> 8d0968cc6b8ffd Juergen Gross    2021-03-01  411         smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
> 8d0968cc6b8ffd Juergen Gross    2021-03-01  412  }
> a5aabace5fb8ab Juergen Gross    2021-03-01  413
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

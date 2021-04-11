Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD3735B1D7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 07:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhDKFnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 01:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhDKFnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 01:43:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07912C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 22:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=I8R+qOv7JBIb43BqUUVOEK0P/64+HYPU2xEo1Y2YOT0=; b=YkQqLDj3EYXP32VB6hPs+NWn3k
        irqAJDtkpNc2uQBnwMFx6X+kFrLDbPegl/Cqff916CLW5PjhNqje6AvcDEtFXbfopNAcqP4uW+jdE
        AugkRICKKYNj/xsM5UJV2nIirYoosJ+Ckdi1O1wW9ndKMgd8utYzI/9PHFSy2G1azJ68qEMvcT2WD
        fl+30cU7cE8k4i44rEPxeBewUurO6PcB74lQdsnDhOKL95QM3cKKizggh+nWTBREmRN+2FgQTrGbJ
        V7bySNwbeerfH/u03k9Lwgn23ca27C0MezTQ5KAYbLJQdcsc4EwRxkkFhhnid3p9LICeG8hP20z9a
        U6enpoUg==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVSrn-002bgy-BL; Sun, 11 Apr 2021 05:42:41 +0000
Subject: Re: arch/csky/mm/tcm.c:9:2: error: #error "You should define
 ITCM_RAM_BASE"
To:     kernel test robot <lkp@intel.com>,
        Julian Braha <julianbraha@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Guo Ren <guoren@kernel.org>
References: <202104111227.ArabakLc-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3c581465-2b66-934c-28a2-a5328de4fa35@infradead.org>
Date:   Sat, 10 Apr 2021 22:42:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <202104111227.ArabakLc-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/21 9:43 PM, kernel test robot wrote:
> Hi Julian,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   52e44129fba5cfc4e351fdb5e45849afc74d9a53
> commit: 7d37cb2c912dc5c25ffac784a4f9b98c06c6bd08 lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
> date:   31 hours ago
> config: csky-randconfig-c003-20210411 (attached as .config)
> compiler: csky-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d37cb2c912dc5c25ffac784a4f9b98c06c6bd08
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7d37cb2c912dc5c25ffac784a4f9b98c06c6bd08
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=csky 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/csky/mm/tcm.c:9:2: error: #error "You should define ITCM_RAM_BASE"
>        9 | #error "You should define ITCM_RAM_BASE"
>          |  ^~~~~
>    arch/csky/mm/tcm.c:109:7: warning: no previous prototype for 'tcm_alloc' [-Wmissing-prototypes]
>      109 | void *tcm_alloc(size_t len)
>          |       ^~~~~~~~~
>    arch/csky/mm/tcm.c:124:6: warning: no previous prototype for 'tcm_free' [-Wmissing-prototypes]
>      124 | void tcm_free(void *addr, size_t len)
>          |      ^~~~~~~~
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for LOCKDEP
>    Depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && (FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>    Selected by
>    - LOCK_STAT && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
>    - DEBUG_LOCK_ALLOC && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
> 
> 
> vim +9 arch/csky/mm/tcm.c
> 
> f525bb2c9e7cf1 Guo Ren 2019-11-27   7  
> f525bb2c9e7cf1 Guo Ren 2019-11-27   8  #if (CONFIG_ITCM_RAM_BASE == 0xffffffff)
> f525bb2c9e7cf1 Guo Ren 2019-11-27  @9  #error "You should define ITCM_RAM_BASE"
> f525bb2c9e7cf1 Guo Ren 2019-11-27  10  #endif
> f525bb2c9e7cf1 Guo Ren 2019-11-27  11  
> 
> :::::: The code at line 9 was first introduced by commit
> :::::: f525bb2c9e7cf1e3c43ab57704c9e1c836d30b34 csky: Tightly-Coupled Memory or Sram support
> 
> :::::: TO: Guo Ren <guoren@linux.alibaba.com>
> :::::: CC: Guo Ren <guoren@linux.alibaba.com>


Hi ktr/lkp,

Do you have the ability to modify a (rand)config file before doing
a build?
To fix this kconfig problem, you can use:

./scripts/config --set-val ITCM_RAM_BASE 0xe0000000
or
./scripts/config --file csky-randconfig-c003-20210411 --set-val ITCM_RAM_BASE 0xe0000000
if you want to modify some file other than ".config".

(0xe000000 is an arbitrary value here -- just cannot be 0xffffffff.)

Then run "make oldconfig" and "make all" or however you normally build a kernel.

It looks like the Kconfig file's ITCM_RAM_BASE parameter is expected to be
set/modified by the user. The default value of 0xffffffff is invalid.

-- 
~Randy

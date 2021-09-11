Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D48407476
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 03:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhIKBiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 21:38:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:20148 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231864AbhIKBiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 21:38:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="221274076"
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="221274076"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 18:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="541062669"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Sep 2021 18:36:49 -0700
Date:   Sat, 11 Sep 2021 09:28:53 +0800
From:   Philip Li <philip.li@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [kbuild-all] Re: [mcgrof-next:20210908-firmware-builtin-v4 2/11]
 drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous
 prototype for function 'firmware_is_builtin'
Message-ID: <20210911012853.GA834679@pl-dbox>
References: <202109101524.pjY4q0Dy-lkp@intel.com>
 <YTv817Srt8hoySP5@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTv817Srt8hoySP5@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 05:48:23PM -0700, Luis Chamberlain wrote:
> On Fri, Sep 10, 2021 at 03:41:31PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210908-firmware-builtin-v4
> > head:   1c69d6a17750179d68bcaf6b16f9a08d2e475989
> > commit: 79e9fce20ee88ffe37542a66277628e6c53dde14 [2/11] firmware_loader: formalize built-in firmware API
> > config: hexagon-buildonly-randconfig-r004-20210910 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=79e9fce20ee88ffe37542a66277628e6c53dde14
> >         git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
> >         git fetch --no-tags mcgrof-next 20210908-firmware-builtin-v4
> >         git checkout 79e9fce20ee88ffe37542a66277628e6c53dde14
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> drivers/base/firmware_loader/builtin/main.c:36:6: error: no previous prototype for function 'firmware_is_builtin' [-Werror,-Wmissing-prototypes]
> >    bool firmware_is_builtin(const struct firmware *fw)
> 
> This is a lie though its defined on drivers/base/firmware_loader/firmware.h
> 
> >         ^
> >    drivers/base/firmware_loader/builtin/main.c:36:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >    bool firmware_is_builtin(const struct firmware *fw)
> >    ^
> >    static 
> >    1 error generated.
> 
> I get these odd errors:
> 
> Compiler will be installed in /home/mcgrof/0day
hi Luis, would you mind to download the make.cross tool again to give a try, it
was updated recently to use latest clang instead of this 12.0.0?

> cd: received redirection to
> `https://download.01.org/0day-ci/cross-package/'
> lftpget -c
> https://download.01.org/0day-ci/cross-package/./clang_hexagon/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz
> tar Jxf
> clang_hexagon/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz
> -C /home/mcgrof/0day                                                    
> make --keep-going
> HOSTCC=/home/mcgrof/0day/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang
> CC=/home/mcgrof/0day/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang
> LD=/home/mcgrof/0day/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/ld.lld
> HOSTLD=/home/mcgrof/0day/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/ld.lld
> AR=llvm-ar NM=llvm-nm STRIP=llvm-strip OBJDUMP=llvm-objdump
> OBJSIZE=llvm-size READELF=llvm-readelf HOSTCXX=clang++ HOSTAR=llvm-ar
> LLVM_IAS=1 CROSS_COMPILE=hexagon-unknown-linux-musl- --jobs=24
> ARCH=hexagon
>   SYNC    include/config/auto.conf.cmd
>     HOSTCC  scripts/basic/fixdep
>     /home/mcgrof/0day/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang:
>     error while loading shared libraries: libtinfo.so.5: cannot open
>     shared object file: No such file or directory
>     make[2]: *** [scripts/Makefile.host:95: scripts/basic/fixdep] Error
>     127
>     make[2]: Target '__build' not remade because of errors.
>     make[1]: *** [Makefile:594: scripts_basic] Error 2
>     make[1]: Target 'syncconfig' not remade because of errors.
>     make: *** [Makefile:771: include/config/auto.conf.cmd] Error 2
>     make: Failed to remake makefile 'include/config/auto.conf.cmd'.
>     make: Failed to remake makefile 'include/config/auto.conf'.
>       HOSTCC  scripts/basic/fixdep
>       /home/mcgrof/0day/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/clang:
>       error while loading shared libraries: libtinfo.so.5: cannot open
>       shared object file: No such file or directory
>       make[1]: *** [scripts/Makefile.host:95: scripts/basic/fixdep]
>       Error 127
> 
> 
> I have a feeling these issues are not correct...
> 
>   Luis
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

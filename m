Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2913E3AEC68
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFUPd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:33:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:43990 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFUPdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:33:54 -0400
IronPort-SDR: itX9XYqO2uQ7ScXxuHmR8Sb0V+HYorj5eyI2Vg17rBFrBRLYe2xRD4mUSsrzPW6SwRKtEZ4pFM
 X1nXbD/8cSfw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="206814412"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="206814412"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:31:40 -0700
IronPort-SDR: DTgTf3i3ayNQYlAoDtuzKx85PfxW/w0UIWvhREZFhbcJb9UKTuu5FG6+VdyCH/Qpi/HNax6tJZ
 hyCXQZ8rC5Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="641355337"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2021 08:31:37 -0700
Date:   Mon, 21 Jun 2021 23:24:10 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip:smp/urgent 1/1] make[2]: *** No rule to make target
 '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/cmac.ko',
 needed by '__modinst'.
Message-ID: <20210621152410.GH158568@pl-dbox>
References: <202106212054.VQpAXTHM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106212054.VQpAXTHM-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 08:57:01PM +0800, kernel test robot wrote:
> Hi Thomas,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/urgent
> head:   b22afcdf04c96ca58327784e280e10288cfd3303
> commit: b22afcdf04c96ca58327784e280e10288cfd3303 [1/1] cpu/hotplug: Cure the cpusets trainwreck
> config: x86_64-randconfig-a012-20210621 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project e1adf90826a57b674eee79b071fb46c1f5683cd0)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=b22afcdf04c96ca58327784e280e10288cfd3303
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip smp/urgent
>         git checkout b22afcdf04c96ca58327784e280e10288cfd3303
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
Sorry for the broken report, kindly ignore this, we will fix
this asap.

> 
>    arch/x86/Makefile:148: CONFIG_X86_X32 enabled but no binutils support
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/cmac.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/md5.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/crypto/sha512_generic.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/drivers/net/net_failover.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/drivers/net/virtio_net.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/fs/cifs/cifs.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/fs/nfs/nfsv4.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/lib/crypto/libarc4.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/core/failover.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/dns_resolver/dns_resolver.ko', needed by '__modinst'.
> >> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/b22afcdf04c96ca58327784e280e10288cfd3303/lib/modules/5.13.0-rc6+/kernel/net/sunrpc/auth_gss/auth_rpcgss.ko', needed by '__modinst'.
>    make[2]: Target '__modinst' not remade because of errors.
>    make[1]: *** [Makefile:1770: modules_install] Error 2
>    make: *** [Makefile:215: __sub-make] Error 2
>    make: Target 'modules_install' not remade because of errors.
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3B3CD18E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhGSJ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:26:44 -0400
Received: from foss.arm.com ([217.140.110.172]:54484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235215AbhGSJ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:26:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB9F86D;
        Mon, 19 Jul 2021 03:07:23 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E9923F73D;
        Mon, 19 Jul 2021 03:07:22 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:07:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [peterz-queue:locking/core 21/21]
 drivers/net/usb/r8152.c:7474:13: warning: stack frame size (9568) exceeds
 limit (8192) in function 'r8156b_hw_phy_cfg'
Message-ID: <20210719100719.GB12806@C02TD0UTHF1T.local>
References: <202107191712.2fNjndRF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107191712.2fNjndRF-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 05:24:25PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> head:   cf3ee3c8c29dc349b2cf52e5e72e8cb805ff5e57
> commit: cf3ee3c8c29dc349b2cf52e5e72e8cb805ff5e57 [21/21] locking/atomic: add generic arch_*() bitops
> config: riscv-randconfig-r002-20210719 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 5d5b08761f944d5b9822d582378333cc4b36a0a7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=cf3ee3c8c29dc349b2cf52e5e72e8cb805ff5e57
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue locking/core
>         git checkout cf3ee3c8c29dc349b2cf52e5e72e8cb805ff5e57
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/usb/r8152.c:7474:13: warning: stack frame size (9568) exceeds limit (8192) in function 'r8156b_hw_phy_cfg' [-Wframe-larger-than]
>    static void r8156b_hw_phy_cfg(struct r8152 *tp)
>                ^
>    1 warning generated.
> 
> 
> vim +/r8156b_hw_phy_cfg +7474 drivers/net/usb/r8152.c

> 195aae321c829d Hayes Wang 2021-04-16  7866  	rtl_green_en(tp, test_bit(GREEN_ETHERNET, &tp->flags));

From local testing, it looks like this test_bit() really confuses the
compiler and forces it to spill much more than it should otherwise need
to.

The good news is that Marco's suggestion of avoiding
instrumened-non-atomic.h (when using plain accesses) sidesteps this, so
I reckon we should go with that.

Should I send that as a fixup, or should I send a new version of the
whole series?

Thanks,
Mark.

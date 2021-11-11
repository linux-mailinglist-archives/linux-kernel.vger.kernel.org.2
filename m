Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331EC44DC04
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 20:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhKKTTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 14:19:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:51328 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhKKTTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 14:19:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="256708533"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="gz'50?scan'50,208,50";a="256708533"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 11:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="gz'50?scan'50,208,50";a="670358750"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Nov 2021 11:16:49 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mlFZ2-000Guo-Ro; Thu, 11 Nov 2021 19:16:48 +0000
Date:   Fri, 12 Nov 2021 03:16:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greentime Hu <greentime.hu@sifive.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v9 09/17] riscv: Add task switch support for vector
Message-ID: <202111120304.fBGN12iW-lkp@intel.com>
References: <d2482c426887b79ddb0e6643cf7fc1a05e7225ca.1636362169.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <d2482c426887b79ddb0e6643cf7fc1a05e7225ca.1636362169.git.greentime.hu@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greentime,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v5.15]
[cannot apply to linus/master next-20211111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Greentime-Hu/riscv-Add-vector-ISA-support/20211109-175222
base:   DEBUG invalid remote for branch v5.15 8bb7eca972ad531c9b149c0a51ab43a417385813
config: riscv-nommu_k210_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/93773de66911ee019c1fb31ae8e53a1221a540db
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Greentime-Hu/riscv-Add-vector-ISA-support/20211109-175222
        git checkout 93773de66911ee019c1fb31ae8e53a1221a540db
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/process.c:164:6: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     164 | void arch_release_task_struct(struct task_struct *tsk)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/arch_release_task_struct +164 arch/riscv/kernel/process.c

   163	
 > 164	void arch_release_task_struct(struct task_struct *tsk)
   165	{
   166		/* Free the vector context of datap. */
   167		if (has_vector())
   168			kfree(tsk->thread.vstate.datap);
   169	}
   170	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
gwAA

--Dxnq1zWXvFF0Q93v--

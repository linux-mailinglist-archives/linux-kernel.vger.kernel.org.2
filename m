Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973C345F696
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 22:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbhKZVme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 16:42:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:44111 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242915AbhKZVkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 16:40:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235958751"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="235958751"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 13:37:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="675657553"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2021 13:37:17 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqiuC-0008cn-Ek; Fri, 26 Nov 2021 21:37:16 +0000
Date:   Sat, 27 Nov 2021 05:36:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/3] staging: zynpu: Add driver support for ARM(China)
 ZHOUYI AI accelerator
Message-ID: <202111270521.Fwtu770n-lkp@intel.com>
References: <20211124084620.628-2-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124084620.628-2-caihuoqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cai,

I love your patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Cai-Huoqing/staging-zynpu-Add-driver-support-for-ARM-China-ZHOUYI-AI-accelerator/20211124-164741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 1189d2fb15a4b09b2e8dd01d60a0817d985d933d
config: arm64-buildonly-randconfig-r006-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270521.Fwtu770n-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/95965c589ea2e279e082e3c9aa18c2ddd8494d64
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cai-Huoqing/staging-zynpu-Add-driver-support-for-ARM-China-ZHOUYI-AI-accelerator/20211124-164741
        git checkout 95965c589ea2e279e082e3c9aa18c2ddd8494d64
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/iio/ drivers/irqchip/ drivers/spi/ drivers/staging/zynpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/zynpu/zynpu_session.c:747:20: warning: no previous prototype for function 'zynpu_session_get_wait_queue' [-Wmissing-prototypes]
   wait_queue_head_t *zynpu_session_get_wait_queue(struct zynpu_session *session, int uthread_id)
                      ^
   drivers/staging/zynpu/zynpu_session.c:747:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   wait_queue_head_t *zynpu_session_get_wait_queue(struct zynpu_session *session, int uthread_id)
   ^
   static 
   1 warning generated.


vim +/zynpu_session_get_wait_queue +747 drivers/staging/zynpu/zynpu_session.c

   746	
 > 747	wait_queue_head_t *zynpu_session_get_wait_queue(struct zynpu_session *session, int uthread_id)
   748	{
   749	    struct zynpu_thread_wait_queue *queue = NULL;
   750	
   751		if (!session) {
   752			pr_err("invalid input session to be null!");
   753			return NULL;
   754		}
   755	
   756		/* LOCK */
   757		spin_lock(&session->job_lock);
   758		queue = get_thread_wait_queue_no_lock(session->wait_queue_head, uthread_id);
   759		spin_unlock(&session->job_lock);
   760		/* UNLOCK */
   761	
   762		if (queue)
   763			return &queue->p_wait;
   764	
   765		return NULL;
   766	}
   767	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

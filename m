Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA04C3C2AD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhGIVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:32:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:20644 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhGIVct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:32:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="190160733"
X-IronPort-AV: E=Sophos;i="5.84,227,1620716400"; 
   d="gz'50?scan'50,208,50";a="190160733"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 14:30:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,227,1620716400"; 
   d="gz'50?scan'50,208,50";a="647193393"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jul 2021 14:30:02 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1y4Q-000F5l-3w; Fri, 09 Jul 2021 21:30:02 +0000
Date:   Sat, 10 Jul 2021 05:28:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-01 3/3] net/core/filter.c:9932:15: error:
 'bpf_prog_test_run_dequeue' undeclared here (not in a function); did you
 mean 'bpf_prog_test_run_syscall'?
Message-ID: <202107100524.oqc4vo32-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-01
head:   6b5756c44933d2b55e5e59e1196ef95894203cf7
commit: 6b5756c44933d2b55e5e59e1196ef95894203cf7 [3/3] xdp: add dequeue program type for getting packets from a PIFO
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=6b5756c44933d2b55e5e59e1196ef95894203cf7
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-01
        git checkout 6b5756c44933d2b55e5e59e1196ef95894203cf7
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/core/filter.c: In function 'xdp_do_redirect':
   net/core/filter.c:3984:10: error: implicit declaration of function 'pifo_map_enqueue'; did you mean 'cpu_map_enqueue'? [-Werror=implicit-function-declaration]
    3984 |    err = pifo_map_enqueue(map, xdp, ri->tgt_index);
         |          ^~~~~~~~~~~~~~~~
         |          cpu_map_enqueue
   net/core/filter.c: At top level:
>> net/core/filter.c:9932:15: error: 'bpf_prog_test_run_dequeue' undeclared here (not in a function); did you mean 'bpf_prog_test_run_syscall'?
    9932 |  .test_run  = bpf_prog_test_run_dequeue,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~
         |               bpf_prog_test_run_syscall
   cc1: some warnings being treated as errors


vim +9932 net/core/filter.c

  9930	
  9931	const struct bpf_prog_ops dequeue_prog_ops = {
> 9932		.test_run		= bpf_prog_test_run_dequeue,
  9933	};
  9934	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--BXVAT5kNtrzKuDFl--

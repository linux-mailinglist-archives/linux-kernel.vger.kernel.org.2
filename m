Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBAD45F333
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhKZR50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:57:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:1589 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhKZRzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:55:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="234430591"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="234430591"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 09:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="741591602"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2021 09:52:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqfOL-0008Op-Eh; Fri, 26 Nov 2021 17:52:09 +0000
Date:   Sat, 27 Nov 2021 01:51:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Tero Kristo <tero.kristo@linux.intel.com>
Subject: [t-kristo-pm:usi-5.16-rfc-v2-bpf 5/30] drivers/hid/hid-bpf.c:94:5:
 warning: no previous prototype for function 'hid_bpf_prog_detach'
Message-ID: <202111270158.8DdFxp1c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-rfc-v2-bpf
head:   241207b4769fca049dfcc4dbde0bda92e4f67027
commit: 1995666cad0e362400a48617c5486a2a04f4d158 [5/30] HID: initial BPF implementation
config: hexagon-buildonly-randconfig-r002-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270158.8DdFxp1c-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/t-kristo/linux-pm/commit/1995666cad0e362400a48617c5486a2a04f4d158
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-rfc-v2-bpf
        git checkout 1995666cad0e362400a48617c5486a2a04f4d158
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-bpf.c:94:5: warning: no previous prototype for function 'hid_bpf_prog_detach' [-Wmissing-prototypes]
   int hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog *prog)
       ^
   drivers/hid/hid-bpf.c:94:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog *prog)
   ^
   static 
   1 warning generated.


vim +/hid_bpf_prog_detach +94 drivers/hid/hid-bpf.c

    93	
  > 94	int hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog *prog)
    95	{
    96		switch(prog->expected_attach_type) {
    97		case BPF_HID_RAW_EVENT:
    98			return __hid_bpf_prog_detach(hdev, &hdev->bpf.event_progs, prog);
    99		default:
   100			return -EINVAL;
   101		}
   102	
   103		return -EINVAL;
   104	}
   105	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

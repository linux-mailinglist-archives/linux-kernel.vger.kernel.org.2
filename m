Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49BE45F1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378515AbhKZQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:35:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:53395 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234731AbhKZQdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:33:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235509134"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="235509134"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 08:30:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="607922923"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2021 08:30:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqe6x-0008Kq-6b; Fri, 26 Nov 2021 16:30:07 +0000
Date:   Sat, 27 Nov 2021 00:29:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tero Kristo <tero.kristo@linux.intel.com>
Subject: [t-kristo-pm:usi-5.16-rfc-v2-bpf 5/30] drivers/hid/hid-bpf.c:94:5:
 warning: no previous prototype for 'hid_bpf_prog_detach'
Message-ID: <202111270054.cbnfZNTH-lkp@intel.com>
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
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211127/202111270054.cbnfZNTH-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/t-kristo/linux-pm/commit/1995666cad0e362400a48617c5486a2a04f4d158
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-rfc-v2-bpf
        git checkout 1995666cad0e362400a48617c5486a2a04f4d158
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-bpf.c:94:5: warning: no previous prototype for 'hid_bpf_prog_detach' [-Wmissing-prototypes]
      94 | int hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog *prog)
         |     ^~~~~~~~~~~~~~~~~~~


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

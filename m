Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F56460C06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 02:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhK2BKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 20:10:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:53792 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376620AbhK2BIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 20:08:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="233367943"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="233367943"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 17:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="458924485"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2021 17:04:44 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrV64-000BMa-5l; Mon, 29 Nov 2021 01:04:44 +0000
Date:   Mon, 29 Nov 2021 09:04:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 37/42]
 drivers/misc/habanalabs/common/firmware_if.c:972:18: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202111290912.9nnXuUjM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   f21fb20b7d0cbd7c09fbe870be75060528aea0c5
commit: 1d21e1077cef48e54f263a75af31448f9f68ee5b [37/42] habanalabs: add power information type to POWER_GET packet
config: i386-randconfig-s002-20211128 (https://download.01.org/0day-ci/archive/20211129/202111290912.9nnXuUjM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=1d21e1077cef48e54f263a75af31448f9f68ee5b
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 1d21e1077cef48e54f263a75af31448f9f68ee5b
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/habanalabs/common/firmware_if.c:972:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] type @@     got int @@
   drivers/misc/habanalabs/common/firmware_if.c:972:18: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] type
   drivers/misc/habanalabs/common/firmware_if.c:972:18: sparse:     got int

vim +972 drivers/misc/habanalabs/common/firmware_if.c

   961	
   962	int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power)
   963	{
   964		struct cpucp_packet pkt;
   965		u64 result;
   966		int rc;
   967	
   968		memset(&pkt, 0, sizeof(pkt));
   969	
   970		pkt.ctl = cpu_to_le32(CPUCP_PACKET_POWER_GET <<
   971					CPUCP_PKT_CTL_OPCODE_SHIFT);
 > 972		pkt.type = CPUCP_POWER_INPUT;
   973	
   974		rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
   975				HL_CPUCP_INFO_TIMEOUT_USEC, &result);
   976		if (rc) {
   977			dev_err(hdev->dev, "Failed to read power, error %d\n", rc);
   978			return rc;
   979		}
   980	
   981		*power = result;
   982	
   983		return rc;
   984	}
   985	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

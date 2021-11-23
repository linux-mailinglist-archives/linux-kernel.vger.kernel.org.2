Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB68F45AF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbhKWWoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:44:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:6008 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237945AbhKWWoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:44:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="232643567"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="232643567"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 14:40:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="597269653"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 23 Nov 2021 14:40:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpeT8-0002O0-B1; Tue, 23 Nov 2021 22:40:54 +0000
Date:   Wed, 24 Nov 2021 06:40:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>
Subject: drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4327:35: sparse: sparse:
 incorrect type in argument 4 (different base types)
Message-ID: <202111240652.YtQ3WLQD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   136057256686de39cc3a07c2e39ef6bc43003ff6
commit: cd96fe600cc4924d8d0cc6e3161870219c0d2c12 scsi: hisi_sas: Add trace FIFO debugfs support
date:   10 months ago
config: ia64-randconfig-s031-20211123 (https://download.01.org/0day-ci/archive/20211124/202111240652.YtQ3WLQD-lkp@intel.com/config.gz)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd96fe600cc4924d8d0cc6e3161870219c0d2c12
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cd96fe600cc4924d8d0cc6e3161870219c0d2c12
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4327:35: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __le32 [usertype] *[assigned] ptr @@     got unsigned int * @@
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4327:35: sparse:     expected restricted __le32 [usertype] *[assigned] ptr
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4327:35: sparse:     got unsigned int *

vim +4327 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c

  4319	
  4320	static int debugfs_fifo_data_v3_hw_show(struct seq_file *s, void *p)
  4321	{
  4322		struct hisi_sas_phy *phy = s->private;
  4323	
  4324		debugfs_read_fifo_data_v3_hw(phy);
  4325	
  4326		debugfs_show_row_32_v3_hw(s, 0, HISI_SAS_FIFO_DATA_DW_SIZE * 4,
> 4327					  phy->fifo.rd_data);
  4328	
  4329		return 0;
  4330	}
  4331	DEFINE_SHOW_ATTRIBUTE(debugfs_fifo_data_v3_hw);
  4332	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

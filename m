Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DDA438C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 00:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJXWpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 18:45:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:46384 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhJXWpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 18:45:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209636905"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="209636905"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 15:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="485428225"
Received: from lkp-server02.sh.intel.com (HELO 74392981b700) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2021 15:43:29 -0700
Received: from kbuild by 74392981b700 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1memDA-00016s-Rq; Sun, 24 Oct 2021 22:43:28 +0000
Date:   Mon, 25 Oct 2021 06:43:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rmk-arm:clearfog 2/13]
 drivers/net/dsa/mv88e6xxx/mv88e6xxx_debugfs.c:739:6: warning: %d in format
 string (no. 1) requires 'int *' but the argument type is 'unsigned int *'.
 [invalidScanfArgType_int]
Message-ID: <202110250619.3cpoavKr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

First bad commit (maybe != root cause):

tree:   git://git.armlinux.org.uk/~rmk/linux-arm clearfog
head:   89b5c2c2bea4a97b0c6254f54d3719fe15c9e38e
commit: ee71c167800c79ed367a6cb8d0efb4e2cfffabf7 [2/13] net: dsa: mv88e6xxx: debugfs hacks to fix the compile
compiler: sh4-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/net/dsa/mv88e6xxx/mv88e6xxx_debugfs.c:162:8: warning: sscanf() without field width limits can crash with huge input data. [invalidscanf]
    ret = sscanf(cmd, "%s %x %x", name, &reg, &val);
          ^

vim +739 drivers/net/dsa/mv88e6xxx/mv88e6xxx_debugfs.c

3724260d6f3b5e Vivien Didelot 2015-10-22  725  
3724260d6f3b5e Vivien Didelot 2015-10-22  726  static ssize_t mv88e6xxx_pvt_write(struct file *file, const char __user *buf,
3724260d6f3b5e Vivien Didelot 2015-10-22  727  				    size_t count, loff_t *ppos)
3724260d6f3b5e Vivien Didelot 2015-10-22  728  {
3724260d6f3b5e Vivien Didelot 2015-10-22  729  	struct seq_file *s = file->private_data;
3724260d6f3b5e Vivien Didelot 2015-10-22  730  	struct mv88e6xxx_chip *chip = s->private;
3724260d6f3b5e Vivien Didelot 2015-10-22  731  	const u16 mask = (1 << mv88e6xxx_num_ports(chip)) - 1;
3724260d6f3b5e Vivien Didelot 2015-10-22  732  	char cmd[32];
3724260d6f3b5e Vivien Didelot 2015-10-22  733  	unsigned int src_dev, src_port, pvlan;
3724260d6f3b5e Vivien Didelot 2015-10-22  734  	int ret;
3724260d6f3b5e Vivien Didelot 2015-10-22  735  
3724260d6f3b5e Vivien Didelot 2015-10-22  736  	if (copy_from_user(cmd, buf, sizeof(cmd)))
3724260d6f3b5e Vivien Didelot 2015-10-22  737  		return -EFAULT;
3724260d6f3b5e Vivien Didelot 2015-10-22  738  
3724260d6f3b5e Vivien Didelot 2015-10-22 @739  	if (sscanf(cmd, "%d %d %x", &src_dev, &src_port, &pvlan) != 3)
3724260d6f3b5e Vivien Didelot 2015-10-22  740  		return -EINVAL;
3724260d6f3b5e Vivien Didelot 2015-10-22  741  
3724260d6f3b5e Vivien Didelot 2015-10-22  742  	if (src_dev >= 32 || src_port >= 16 || pvlan & ~mask)
3724260d6f3b5e Vivien Didelot 2015-10-22  743  		return -ERANGE;
3724260d6f3b5e Vivien Didelot 2015-10-22  744  
3724260d6f3b5e Vivien Didelot 2015-10-22  745  	mutex_lock(&chip->reg_lock);
3724260d6f3b5e Vivien Didelot 2015-10-22  746  	ret = _mv88e6xxx_pvt_write(chip, src_dev, src_port, pvlan);
3724260d6f3b5e Vivien Didelot 2015-10-22  747  	mutex_unlock(&chip->reg_lock);
3724260d6f3b5e Vivien Didelot 2015-10-22  748  
3724260d6f3b5e Vivien Didelot 2015-10-22  749  	return ret < 0 ? ret : count;
3724260d6f3b5e Vivien Didelot 2015-10-22  750  }
3724260d6f3b5e Vivien Didelot 2015-10-22  751  

:::::: The code at line 739 was first introduced by commit
:::::: 3724260d6f3b5e821ce7ead6410416bf02c3fff6 net: dsa: mv88e6xxx: add debugfs interface

:::::: TO: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
:::::: CC: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

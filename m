Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE945E80F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359082AbhKZGtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:49:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:14381 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352697AbhKZGrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:47:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="215644143"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="215644143"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:44:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="458085374"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2021 22:44:18 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqUy1-0007iF-Bc; Fri, 26 Nov 2021 06:44:17 +0000
Date:   Fri, 26 Nov 2021 14:44:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: drivers/hid/i2c-hid/i2c-hid-core.c:867:4: warning: format specifies
 type 'unsigned short' but the argument has type 'int'
Message-ID: <202111261447.lxHTeAhi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: c1ed18c11bdb80eced208a61d40b1988f36a014f HID: i2c-hid: Introduce goodix-i2c-hid using i2c-hid core
date:   10 months ago
config: arm64-randconfig-r034-20211116 (https://download.01.org/0day-ci/archive/20211126/202111261447.lxHTeAhi-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1ed18c11bdb80eced208a61d40b1988f36a014f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c1ed18c11bdb80eced208a61d40b1988f36a014f
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/i2c-hid/i2c-hid-core.c:867:4: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                           le16_to_cpu(hdesc->bcdVersion));
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
           _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                 ~~~     ^~~~~~~~~~~
   include/linux/byteorder/generic.h:91:21: note: expanded from macro 'le16_to_cpu'
   #define le16_to_cpu __le16_to_cpu
                       ^
   include/uapi/linux/byteorder/big_endian.h:36:26: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/i2c-hid/i2c-hid-core.c:992:18: warning: format specifies type 'unsigned short' but the argument has type '__u32' (aka 'unsigned int') [-Wformat]
                    client->name, hid->vendor, hid->product);
                                  ^~~~~~~~~~~
   drivers/hid/i2c-hid/i2c-hid-core.c:992:31: warning: format specifies type 'unsigned short' but the argument has type '__u32' (aka 'unsigned int') [-Wformat]
                    client->name, hid->vendor, hid->product);
                                               ^~~~~~~~~~~~
   3 warnings generated.


vim +867 drivers/hid/i2c-hid/i2c-hid-core.c

4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  836  
0fe763c570ad27 drivers/hid/i2c-hid/i2c-hid.c      Greg Kroah-Hartman 2012-12-21  837  static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  838  {
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  839  	struct i2c_client *client = ihid->client;
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  840  	struct i2c_hid_desc *hdesc = &ihid->hdesc;
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  841  	unsigned int dsize;
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  842  	int ret;
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  843  
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  844  	/* i2c hid fetch using a fixed descriptor size (30 bytes) */
9ee3e06610fdb8 drivers/hid/i2c-hid/i2c-hid-core.c Julian Sax         2018-09-19  845  	if (i2c_hid_get_dmi_i2c_hid_desc_override(client->name)) {
9ee3e06610fdb8 drivers/hid/i2c-hid/i2c-hid-core.c Julian Sax         2018-09-19  846  		i2c_hid_dbg(ihid, "Using a HID descriptor override\n");
9ee3e06610fdb8 drivers/hid/i2c-hid/i2c-hid-core.c Julian Sax         2018-09-19  847  		ihid->hdesc =
9ee3e06610fdb8 drivers/hid/i2c-hid/i2c-hid-core.c Julian Sax         2018-09-19  848  			*i2c_hid_get_dmi_i2c_hid_desc_override(client->name);
9ee3e06610fdb8 drivers/hid/i2c-hid/i2c-hid-core.c Julian Sax         2018-09-19  849  	} else {
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  850  		i2c_hid_dbg(ihid, "Fetching the HID descriptor\n");
9ee3e06610fdb8 drivers/hid/i2c-hid/i2c-hid-core.c Julian Sax         2018-09-19  851  		ret = i2c_hid_command(client, &hid_descr_cmd,
9ee3e06610fdb8 drivers/hid/i2c-hid/i2c-hid-core.c Julian Sax         2018-09-19  852  				      ihid->hdesc_buffer,
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  853  				      sizeof(struct i2c_hid_desc));
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  854  		if (ret) {
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  855  			dev_err(&client->dev, "hid_descr_cmd failed\n");
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  856  			return -ENODEV;
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  857  		}
9ee3e06610fdb8 drivers/hid/i2c-hid/i2c-hid-core.c Julian Sax         2018-09-19  858  	}
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  859  
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  860  	/* Validate the length of HID descriptor, the 4 first bytes:
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  861  	 * bytes 0-1 -> length
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  862  	 * bytes 2-3 -> bcdVersion (has to be 1.00) */
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  863  	/* check bcdVersion == 1.0 */
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  864  	if (le16_to_cpu(hdesc->bcdVersion) != 0x0100) {
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  865  		dev_err(&client->dev,
9972dcc29cd1fc drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-12-04  866  			"unexpected HID descriptor bcdVersion (0x%04hx)\n",
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12 @867  			le16_to_cpu(hdesc->bcdVersion));
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  868  		return -ENODEV;
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  869  	}
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  870  
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  871  	/* Descriptor length should be 30 bytes as per the specification */
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  872  	dsize = le16_to_cpu(hdesc->wHIDDescLength);
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  873  	if (dsize != sizeof(struct i2c_hid_desc)) {
f58b8487bcc898 drivers/hid/i2c-hid/i2c-hid.c      Archana Patni      2014-05-08  874  		dev_err(&client->dev, "weird size of HID descriptor (%u)\n",
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  875  			dsize);
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  876  		return -ENODEV;
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  877  	}
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  878  	i2c_hid_dbg(ihid, "HID Descriptor: %*ph\n", dsize, ihid->hdesc_buffer);
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  879  	return 0;
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  880  }
4a200c3b9a4024 drivers/hid/i2c-hid/i2c-hid.c      Benjamin Tissoires 2012-11-12  881  

:::::: The code at line 867 was first introduced by commit
:::::: 4a200c3b9a40242652b5734630bdd0bcf3aca75f HID: i2c-hid: introduce HID over i2c specification implementation

:::::: TO: Benjamin Tissoires <benjamin.tissoires@gmail.com>
:::::: CC: Jiri Kosina <jkosina@suse.cz>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

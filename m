Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AD845AFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 00:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbhKWX0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 18:26:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:48390 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbhKWX0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:26:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="321393220"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="321393220"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 15:22:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="474933600"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2021 15:22:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpf7n-0002RK-A3; Tue, 23 Nov 2021 23:22:55 +0000
Date:   Wed, 24 Nov 2021 07:22:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
Subject: drivers/usb/cdns3/cdnsp-gadget.c:1178:6: warning: variable 'temp_64'
 set but not used
Message-ID: <202111240700.v09U6VsG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   136057256686de39cc3a07c2e39ef6bc43003ff6
commit: 3d82904559f4f5a2622db1b21de3edf2eded7664 usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
date:   11 months ago
config: x86_64-buildonly-randconfig-r003-20211118 (https://download.01.org/0day-ci/archive/20211124/202111240700.v09U6VsG-lkp@intel.com/config.gz)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d82904559f4f5a2622db1b21de3edf2eded7664
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3d82904559f4f5a2622db1b21de3edf2eded7664
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/cdns3/cdnsp-gadget.c:1178:6: warning: variable 'temp_64' set but not used [-Wunused-but-set-variable]
           u64 temp_64;
               ^
   1 warning generated.


vim +/temp_64 +1178 drivers/usb/cdns3/cdnsp-gadget.c

  1173	
  1174	static int cdnsp_run(struct cdnsp_device *pdev,
  1175			     enum usb_device_speed speed)
  1176	{
  1177		u32 fs_speed = 0;
> 1178		u64 temp_64;
  1179		u32 temp;
  1180		int ret;
  1181	
  1182		temp_64 = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
  1183		temp_64 &= ~ERST_PTR_MASK;
  1184		temp = readl(&pdev->ir_set->irq_control);
  1185		temp &= ~IMOD_INTERVAL_MASK;
  1186		temp |= ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
  1187		writel(temp, &pdev->ir_set->irq_control);
  1188	
  1189		temp = readl(&pdev->port3x_regs->mode_addr);
  1190	
  1191		switch (speed) {
  1192		case USB_SPEED_SUPER_PLUS:
  1193			temp |= CFG_3XPORT_SSP_SUPPORT;
  1194			break;
  1195		case USB_SPEED_SUPER:
  1196			temp &= ~CFG_3XPORT_SSP_SUPPORT;
  1197			break;
  1198		case USB_SPEED_HIGH:
  1199			break;
  1200		case USB_SPEED_FULL:
  1201			fs_speed = PORT_REG6_FORCE_FS;
  1202			break;
  1203		default:
  1204			dev_err(pdev->dev, "invalid maximum_speed parameter %d\n",
  1205				speed);
  1206			fallthrough;
  1207		case USB_SPEED_UNKNOWN:
  1208			/* Default to superspeed. */
  1209			speed = USB_SPEED_SUPER;
  1210			break;
  1211		}
  1212	
  1213		if (speed >= USB_SPEED_SUPER) {
  1214			writel(temp, &pdev->port3x_regs->mode_addr);
  1215			cdnsp_set_link_state(pdev, &pdev->usb3_port.regs->portsc,
  1216					     XDEV_RXDETECT);
  1217		} else {
  1218			cdnsp_disable_port(pdev, &pdev->usb3_port.regs->portsc);
  1219		}
  1220	
  1221		cdnsp_set_link_state(pdev, &pdev->usb2_port.regs->portsc,
  1222				     XDEV_RXDETECT);
  1223	
  1224		cdnsp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
  1225	
  1226		writel(PORT_REG6_L1_L0_HW_EN | fs_speed, &pdev->port20_regs->port_reg6);
  1227	
  1228		ret = cdnsp_start(pdev);
  1229		if (ret) {
  1230			ret = -ENODEV;
  1231			goto err;
  1232		}
  1233	
  1234		temp = readl(&pdev->op_regs->command);
  1235		temp |= (CMD_INTE);
  1236		writel(temp, &pdev->op_regs->command);
  1237	
  1238		temp = readl(&pdev->ir_set->irq_pending);
  1239		writel(IMAN_IE_SET(temp), &pdev->ir_set->irq_pending);
  1240	
  1241		return 0;
  1242	err:
  1243		cdnsp_halt(pdev);
  1244		return ret;
  1245	}
  1246	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

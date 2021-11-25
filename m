Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0245D249
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 02:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346988AbhKYBJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 20:09:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:47931 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344909AbhKYBHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 20:07:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="234142492"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="234142492"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 17:04:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="675052176"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2021 17:04:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq3BK-0005Xp-Vj; Thu, 25 Nov 2021 01:04:10 +0000
Date:   Thu, 25 Nov 2021 09:04:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mnyman-xhci:for-usb-next 2/4] drivers/usb/host/xhci-ring.c:1236:6:
 warning: no previous prototype for
 'xhci_handle_stop_endpoint_command_timeout'
Message-ID: <202111250929.ZL55xEPm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git for-usb-next
head:   a90f619386a961d42cde656b13e4c22c133cc775
commit: a62595355b40c10d1fcc7056ddcf4c246fc72967 [2/4] xhci: use generic command timer for stop endpoint commands.
config: arc-randconfig-r043-20211123 (https://download.01.org/0day-ci/archive/20211125/202111250929.ZL55xEPm-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?id=a62595355b40c10d1fcc7056ddcf4c246fc72967
        git remote add mnyman-xhci https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git
        git fetch --no-tags mnyman-xhci for-usb-next
        git checkout a62595355b40c10d1fcc7056ddcf4c246fc72967
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/host/xhci-ring.c:1236:6: warning: no previous prototype for 'xhci_handle_stop_endpoint_command_timeout' [-Wmissing-prototypes]
    1236 | void xhci_handle_stop_endpoint_command_timeout(struct xhci_hcd *xhci, struct xhci_command *cmd)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/xhci_handle_stop_endpoint_command_timeout +1236 drivers/usb/host/xhci-ring.c

  1235	
> 1236	void xhci_handle_stop_endpoint_command_timeout(struct xhci_hcd *xhci, struct xhci_command *cmd)
  1237	{
  1238		struct xhci_virt_ep	*ep;
  1239		u32			usbsts;
  1240		u32			field3;
  1241		char			str[XHCI_MSG_MAX];
  1242	
  1243		field3 = le32_to_cpu(cmd->command_trb->generic.field[3]);
  1244		usbsts = readl(&xhci->op_regs->status);
  1245	
  1246		xhci_warn(xhci, "xHCI host not responding to stop endpoint command.\n");
  1247		xhci_warn(xhci, "USBSTS:%s\n", xhci_decode_usbsts(str, usbsts));
  1248	
  1249		ep = xhci_get_virt_ep(xhci,
  1250				      TRB_TO_SLOT_ID(field3),
  1251				      TRB_TO_EP_INDEX(field3));
  1252		if (ep)
  1253			ep->ep_state &= ~EP_STOP_CMD_PENDING;
  1254	
  1255		xhci_halt(xhci);
  1256		xhci_hc_died(xhci);
  1257	
  1258		xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb, "xHCI host controller is dead.");
  1259	}
  1260	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

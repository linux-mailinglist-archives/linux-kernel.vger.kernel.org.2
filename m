Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2145D324
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 03:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhKYCZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 21:25:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:47795 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhKYCXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 21:23:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235364437"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="235364437"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 18:16:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="554485280"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2021 18:16:14 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq4J3-0005c7-DK; Thu, 25 Nov 2021 02:16:13 +0000
Date:   Thu, 25 Nov 2021 10:15:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     kbuild-all@lists.01.org, wonchung@google.com, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/4] usb: Use notifier to link Type C ports
Message-ID: <202111251010.fxed9VtQ-lkp@intel.com>
References: <20211124231028.696982-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124231028.696982-3-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on linux/master linus/master peter-chen-usb/for-usb-next v5.16-rc2 next-20211124]
[cannot apply to balbi-usb/testing/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Prashant-Malani/usb-Use-notifier-for-linking-Type-C-ports/20211125-071439
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: i386-defconfig (https://download.01.org/0day-ci/archive/20211125/202111251010.fxed9VtQ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/d56a1c2271ef9c1877e9400fb1adc5adbb278e51
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Prashant-Malani/usb-Use-notifier-for-linking-Type-C-ports/20211125-071439
        git checkout d56a1c2271ef9c1877e9400fb1adc5adbb278e51
        # save the config file to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/usb/core/port.c:12:
>> include/linux/usb/typec.h:322:5: warning: no previous prototype for 'typec_port_registration_register_notify' [-Wmissing-prototypes]
     322 | int typec_port_registration_register_notify(struct notifier_block *nb)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/usb/typec.h:327:5: warning: no previous prototype for 'typec_port_registration_unregister_notify' [-Wmissing-prototypes]
     327 | int typec_port_registration_unregister_notify(struct notifier_block *nb)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/typec_port_registration_register_notify +322 include/linux/usb/typec.h

ed296d8d0a92758 Prashant Malani 2021-11-24  321  
ed296d8d0a92758 Prashant Malani 2021-11-24 @322  int typec_port_registration_register_notify(struct notifier_block *nb)
ed296d8d0a92758 Prashant Malani 2021-11-24  323  {
ed296d8d0a92758 Prashant Malani 2021-11-24  324  	return 0;
ed296d8d0a92758 Prashant Malani 2021-11-24  325  }
ed296d8d0a92758 Prashant Malani 2021-11-24  326  
ed296d8d0a92758 Prashant Malani 2021-11-24 @327  int typec_port_registration_unregister_notify(struct notifier_block *nb)
ed296d8d0a92758 Prashant Malani 2021-11-24  328  {
ed296d8d0a92758 Prashant Malani 2021-11-24  329  	return 0;
ed296d8d0a92758 Prashant Malani 2021-11-24  330  }
ae196ddb0d3186b Heikki Krogerus 2021-04-07  331  #endif
ae196ddb0d3186b Heikki Krogerus 2021-04-07  332  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

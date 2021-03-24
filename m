Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF434745F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhCXJRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:17:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:36267 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhCXJRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:17:35 -0400
IronPort-SDR: 5FHTzyN3wd2VBxYb9ApD1NM7YyoxJA/Ek/SuUV7OtQsYPcw5lBzgY5qSYgNvhE472C3gJCMRPF
 fmVbxTag+obg==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="210767532"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="210767532"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 02:17:34 -0700
IronPort-SDR: rgkkpogi6O4X6zsxcekCIIXoijHXVkvV7NExVJnZkQPvtZmDKtw/061aglYKffygCHZ/j70SGE
 nFtnn9lnJTdA==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="452518273"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 02:17:31 -0700
Subject: Re: [PATCH v4 2/2] usb: dwc3: Add driver for Xilinx platforms
To:     Greg KH <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     Manish Narani <manish.narani@xilinx.com>, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de,
        kbuild-all@lists.01.org, git@xilinx.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1615963949-75320-3-git-send-email-manish.narani@xilinx.com>
 <202103171704.VHPs8XOA-lkp@intel.com> <YFnVZEFr3xBsRdiX@kroah.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <8fdd5b27-fb70-df01-62a2-474df5301485@intel.com>
Date:   Wed, 24 Mar 2021 17:16:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <YFnVZEFr3xBsRdiX@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/21 7:47 PM, Greg KH wrote:
> On Wed, Mar 17, 2021 at 05:50:22PM +0800, kernel test robot wrote:
>> Hi Manish,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on usb/usb-testing]
>> [also build test WARNING on robh/for-next v5.12-rc3 next-20210316]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Manish-Narani/Add-a-separate-DWC3-OF-driver-for-Xilinx-platforms/20210317-145425
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
>> config: arm64-allyesconfig (attached as .config)
>> compiler: aarch64-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/0day-ci/linux/commit/def409fdf931cd77f4a88812570ea6f38f4053d8
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Manish-Narani/Add-a-separate-DWC3-OF-driver-for-Xilinx-platforms/20210317-145425
>>          git checkout def409fdf931cd77f4a88812570ea6f38f4053d8
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/usb/dwc3/dwc3-xilinx.c:27: warning: expecting prototype for dwc3(). Prototype was for XLNX_USB_PHY_RST_EN() instead
>>
>> vim +27 drivers/usb/dwc3/dwc3-xilinx.c
>>
>>      25	
>>      26	/* USB phy reset mask register */
>>    > 27	#define XLNX_USB_PHY_RST_EN			0x001C
>>      28	#define XLNX_PHY_RST_MASK			0x1
>>      29	
> I do not understand this warning message.  What is it trying to say?

Hi Greg,

It's a kernel-doc warning:

$ ./scripts/kernel-doc -none drivers/usb/dwc3/dwc3-xilinx.c
drivers/usb/dwc3/dwc3-xilinx.c:27: warning: expecting prototype for 
dwc3(). Prototype was for XLNX_USB_PHY_RST_EN() instead

the root cause is that there's a redundant symbol ( * ) at the beginning:

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index a59e1494b1a0..f42f4cbffab0 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -1,5 +1,5 @@
  // SPDX-License-Identifier: GPL-2.0
-/**
+/*
   * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
   *
   * Authors: Manish Narani <manish.narani@xilinx.com>

Best Regards,
Rong Chen

>
> confused,
>
> greg k-h
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27C1345D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCWLsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCWLrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:47:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 589A8619BF;
        Tue, 23 Mar 2021 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616500070;
        bh=6tOFh9a0qtxxlZRCAFGaHM+gh3jhX0LL8TQ/odb571s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PO1CrBKr3s42i4iMwW7WFMXcszIple91cJcTyTXrXjXQbB3yZGPkQI9FvQ1szS9l3
         UenM7ch7OlAEvWaJunUbZPogBwn2A3IwFxFn8sPrUReMM854ucictVxolhkiXy3m3W
         HdO2cChspr+knJLE66uNC315TbVD13lK6sm0P6iE=
Date:   Tue, 23 Mar 2021 12:47:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Manish Narani <manish.narani@xilinx.com>, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de,
        kbuild-all@lists.01.org, git@xilinx.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb: dwc3: Add driver for Xilinx platforms
Message-ID: <YFnVZEFr3xBsRdiX@kroah.com>
References: <1615963949-75320-3-git-send-email-manish.narani@xilinx.com>
 <202103171704.VHPs8XOA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103171704.VHPs8XOA-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:50:22PM +0800, kernel test robot wrote:
> Hi Manish,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on usb/usb-testing]
> [also build test WARNING on robh/for-next v5.12-rc3 next-20210316]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Manish-Narani/Add-a-separate-DWC3-OF-driver-for-Xilinx-platforms/20210317-145425
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/def409fdf931cd77f4a88812570ea6f38f4053d8
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Manish-Narani/Add-a-separate-DWC3-OF-driver-for-Xilinx-platforms/20210317-145425
>         git checkout def409fdf931cd77f4a88812570ea6f38f4053d8
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/usb/dwc3/dwc3-xilinx.c:27: warning: expecting prototype for dwc3(). Prototype was for XLNX_USB_PHY_RST_EN() instead
> 
> 
> vim +27 drivers/usb/dwc3/dwc3-xilinx.c
> 
>     25	
>     26	/* USB phy reset mask register */
>   > 27	#define XLNX_USB_PHY_RST_EN			0x001C
>     28	#define XLNX_PHY_RST_MASK			0x1
>     29	

I do not understand this warning message.  What is it trying to say?

confused,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9894372FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 09:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhJVHoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 03:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhJVHoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 03:44:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 048CB610E7;
        Fri, 22 Oct 2021 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634888508;
        bh=xZki9UTOrtpOoi97HAFGs9WTimn3Llshzh1KbxLxX3A=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=FzZaTT28sXoL8kh9czTKEqZYtae0owocwfkwvUhsTyg222ZZwbrccUXdAcJ/TEzoK
         fTY7PeWCdgtGqfrP3r8YqWfh9bgWIhHViqFBIOgLSVKPcj/9zWbnTVqOwgxPPDvrGJ
         ErQ4p4IrsIksSIQJPZbESoDeE4+sQKXYFQsONJgo=
Date:   Fri, 22 Oct 2021 09:41:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>,
        Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>
Subject: Re: [char-misc:char-misc-testing 49/54]
 include/linux/firmware/xlnx-zynqmp.h:634:71: error: expected ';' after top
 level declarator
Message-ID: <YXJrOiVJmsn5hkGg@kroah.com>
References: <202110220531.JFx7N8X4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110220531.JFx7N8X4-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 05:42:37AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-testing
> head:   0a6af10747d4dc25e9c85c7daf156459f28e0e55
> commit: 1a8eae64b30f126c0786f3807982d49ca3be8f7c [49/54] firmware: xilinx: add register notifier in zynqmp firmware
> config: hexagon-randconfig-r045-20211021 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 3cea2505fd8d99a9ba0cb625aecfe28a47c4e3f8)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=1a8eae64b30f126c0786f3807982d49ca3be8f7c
>         git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>         git fetch --no-tags char-misc char-misc-testing
>         git checkout 1a8eae64b30f126c0786f3807982d49ca3be8f7c
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/spi/spi-zynqmp-gqspi.c:13:
> >> include/linux/firmware/xlnx-zynqmp.h:634:71: error: expected ';' after top level declarator
>    static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
>                                                                          ^
>                                                                          ;
>    1 error generated.
> 
> 
> vim +634 include/linux/firmware/xlnx-zynqmp.h
> 
> 2b9fc773c31bb7 Nava kishore Manne 2021-06-26  633  
> 2b9fc773c31bb7 Nava kishore Manne 2021-06-26 @634  static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
> 1a8eae64b30f12 Abhyuday Godhasara 2021-10-21  635  static inline int zynqmp_pm_register_notifier(const u32 node, const u32 event,
> 1a8eae64b30f12 Abhyuday Godhasara 2021-10-21  636  					      const u32 wake, const u32 enable)
> 2b9fc773c31bb7 Nava kishore Manne 2021-06-26  637  {
> 2b9fc773c31bb7 Nava kishore Manne 2021-06-26  638  	return -ENODEV;
> 2b9fc773c31bb7 Nava kishore Manne 2021-06-26  639  }
> 76582671eb5d00 Rajan Vaja         2018-09-12  640  #endif
> 76582671eb5d00 Rajan Vaja         2018-09-12  641  
> 
> :::::: The code at line 634 was first introduced by commit
> :::::: 2b9fc773c31bb7cb7529757382013a8158bf7e9c drivers: firmware: Add PDI load API support
> 
> :::::: TO: Nava kishore Manne <nava.manne@xilinx.com>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


I will go drop all of these patches from my tree now.  Please fix up and
resend the whole series.

thanks,

greg k-h

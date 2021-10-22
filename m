Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82094373AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhJVId0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232054AbhJVIdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:33:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DBF26108D;
        Fri, 22 Oct 2021 08:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634891466;
        bh=ul9q1P8Rn4HPsYMrl9/sFZmmZubFGTPoYfdYy2t862s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oW07IPwrh7bABrqo5s04EiL26q07C2bhDuQRyp+K/gTtt+wuFlP0wz8PdTBPOLWWs
         R28Ri+mau7y3gglJTzLtcLRgo2pB8gZRZO1ndcTdAHiAe6Y1MH60TAV9ykzjMET255
         +WkLpb/FweD405vgymegiqi+eD5ptarTOJWiPxmY=
Date:   Fri, 22 Oct 2021 10:31:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abhyuday Godhasara <agodhasa@xilinx.com>
Cc:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc:char-misc-testing 49/54]
 include/linux/firmware/xlnx-zynqmp.h:634:71: error: expected ';' after top
 level declarator
Message-ID: <YXJ2x0OgmLEU1hmU@kroah.com>
References: <202110220531.JFx7N8X4-lkp@intel.com>
 <YXJrOiVJmsn5hkGg@kroah.com>
 <SA1PR02MB859220A53FF48190EDD60A8CA1809@SA1PR02MB8592.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR02MB859220A53FF48190EDD60A8CA1809@SA1PR02MB8592.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 08:20:18AM +0000, Abhyuday Godhasara wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Friday, October 22, 2021 1:12 PM
> > To: kernel test robot <lkp@intel.com>; Abhyuday Godhasara
> > <agodhasa@xilinx.com>; llvm@lists.linux.dev; kbuild-all@lists.01.org; linux-
> > kernel@vger.kernel.org; Tejas Patel <TEJASP@xilinx.com>
> > Subject: Re: [char-misc:char-misc-testing 49/54] include/linux/firmware/xlnx-
> > zynqmp.h:634:71: error: expected ';' after top level declarator
> > 
> > On Fri, Oct 22, 2021 at 05:42:37AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > char-misc-testing
> > > head:   0a6af10747d4dc25e9c85c7daf156459f28e0e55
> > > commit: 1a8eae64b30f126c0786f3807982d49ca3be8f7c [49/54] firmware:
> > > xilinx: add register notifier in zynqmp firmware
> > > config: hexagon-randconfig-r045-20211021 (attached as .config)
> > > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project
> > > 3cea2505fd8d99a9ba0cb625aecfe28a47c4e3f8)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-
> > tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> > misc.git/commit/?id=1a8eae64b30f126c0786f3807982d49ca3be8f7c
> > >         git remote add char-misc
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > >         git fetch --no-tags char-misc char-misc-testing
> > >         git checkout 1a8eae64b30f126c0786f3807982d49ca3be8f7c
> > >         # save the attached .config to linux build tree
> > >         mkdir build_dir
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> > W=1
> > > O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    In file included from drivers/spi/spi-zynqmp-gqspi.c:13:
> > > >> include/linux/firmware/xlnx-zynqmp.h:634:71: error: expected ';'
> > > >> after top level declarator
> > >    static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
> > >                                                                          ^
> > >                                                                          ;
> > >    1 error generated.
> [Abhyuday] Place where this error generated are not part of my patch series or changes. Please let me know if there is an any action require from my side.

Your patch is incorrect, and causes this build error.

thanks,

greg k-h

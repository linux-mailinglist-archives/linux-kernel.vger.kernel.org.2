Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE646073D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358141AbhK1Ptu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 10:49:50 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55306 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235855AbhK1Prt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 10:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=E57/ks2HGs6H7jXYSa+P6zad9x+HVZI0HOrMCTR+cpU=; b=h99b3l7eYRt/YlUZCDJb7RWI6J
        IBRQz1mguwDt0ksQUwdl51jEojLvxnm0Agkfu2SbmM21xiKaSCw2B+ahwvvJCFIHxGrIN23VI4b8Q
        KveG/q1C+QoOFuU4SDHELpcBBSAaIgBInkyLNHaMBG3TolVm20PbF9TnI2U9nQ2/ijZ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mrMLm-00EqTh-Gf; Sun, 28 Nov 2021 16:44:22 +0100
Date:   Sun, 28 Nov 2021 16:44:22 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/net/mdio/mdio-xgene.c:337:13: warning: cast to smaller
 integer type 'enum xgene_mdio_id' from 'const void *'
Message-ID: <YaOj1j4MwxmrKNbY@lunn.ch>
References: <202111280114.D7JHY3PG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111280114.D7JHY3PG-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 01:54:33AM +0800, kernel test robot wrote:
> Hi Andrew,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
> commit: a9770eac511ad82390b9f4a3c1728e078c387ac7 net: mdio: Move MDIO drivers into a new subdirectory
> date:   1 year, 3 months ago
> config: arm64-randconfig-r032-20211118 (https://download.01.org/0day-ci/archive/20211128/202111280114.D7JHY3PG-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c46becf500df2a7fb4b4fce16178a036c344315a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9770eac511ad82390b9f4a3c1728e078c387ac7
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a9770eac511ad82390b9f4a3c1728e078c387ac7
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clk/zynqmp/ drivers/gpio/ drivers/gpu/drm/ drivers/net/mdio/ drivers/net/wireless/intel/ipw2x00/ drivers/net/wireless/intel/iwlwifi/mvm/ drivers/staging/rtl8188eu/ drivers/usb/gadget/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/mdio/mdio-xgene.c:337:13: warning: cast to smaller integer type 'enum xgene_mdio_id' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>                    mdio_id = (enum xgene_mdio_id)of_id->data;
>                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.

There is no overflow in the current code. It is just an enum value of
1 or 2 in of_id->data which goes via a void * and back.

To remove the warning, a struct would need to be added, or maybe a
mask applied if the compiler can follow that.

	Andrew

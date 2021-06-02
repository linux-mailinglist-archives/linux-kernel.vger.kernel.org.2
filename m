Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A86399429
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhFBUE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 16:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhFBUE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:04:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 269EC6139A;
        Wed,  2 Jun 2021 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622664164;
        bh=/fsI+8xYtRvNMRIeYtJqfD6bAKJycNv7BMWKfSa6geA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JBEcZLW0jtEv+p1uV00PnFD0ChOa3hXqUitpq5rBPHRY5URzhOL0U154KKtH0ZO7d
         ho63PEcvyhPFbY3A2SYLK6oh/fFY5gT+jarXF7mRJixPReVmVZmpa4ytqxH4ogUGba
         XEbxXdtepn/qHIaiS5oQtswtT2oUdft7GxSO0iXUrE42JnAK/0aRR6lUUdFXVoWQZg
         3JQQjW+1ORLrmaEk0oX6UiQR9htdmAdMvj+PiM6iAmUiZFjhbrw8Rf5DjHO4oLgPmZ
         xqfinU6S/VA/9MJsibwuBYeKf3qkELBn+DqmkFXn30W1KSpx7nWgxHMYYNK8EONXjY
         8xeOquGwNRY2w==
Subject: Re: drivers/net/ethernet/micrel/ks8851_common.c:995:6: warning:
 variable 'ret' set but not used
To:     kernel test robot <lkp@intel.com>, Marek Vasut <marex@denx.de>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
References: <202106030332.tmiMOCF7-lkp@intel.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <b34e07af-4559-7707-b00b-5a36789e566d@kernel.org>
Date:   Wed, 2 Jun 2021 13:02:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <202106030332.tmiMOCF7-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/2021 12:32 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   231bc539066760aaa44d46818c85b14ca2f56d9f
> commit: 797047f875b5463719cc70ba213eb691d453c946 net: ks8851: Implement Parallel bus operations
> date:   1 year ago
> config: x86_64-randconfig-a004-20210601 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project d41cb6bb2607fa5c7a9df2b3dab361353657d225)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install x86_64 cross compiling tool for clang build
>          # apt-get install binutils-x86-64-linux-gnu
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=797047f875b5463719cc70ba213eb691d453c946
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 797047f875b5463719cc70ba213eb691d453c946
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/net/ethernet/micrel/ks8851_common.c:995:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
>             int ret = 0;
>                 ^
>     1 warning generated.

This warning is newly implemented in clang, it was not caused by the 
above commit. As you can see from the blame below, this has been an 
issue since this driver's introduction. I wonder if it was intended to 
return ret in the places that return 0?

Cheers,
Nathan

> vim +/ret +995 drivers/net/ethernet/micrel/ks8851_common.c
> 
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   985
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   986  /**
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   987   * ks8851_read_selftest - read the selftest memory info.
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   988   * @ks: The device state
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   989   *
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   990   * Read and check the TX/RX memory selftest information.
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   991   */
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   992  static int ks8851_read_selftest(struct ks8851_net *ks)
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   993  {
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   994  	unsigned both_done = MBIR_TXMBF | MBIR_RXMBF;
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  @995  	int ret = 0;
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   996  	unsigned rd;
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   997
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   998  	rd = ks8851_rdreg16(ks, KS_MBIR);
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16   999
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1000  	if ((rd & both_done) != both_done) {
> 0dc7d2b3cbfcf4 drivers/net/ks8851.c Joe Perches 2010-02-27  1001  		netdev_warn(ks->netdev, "Memory selftest not finished\n");
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1002  		return 0;
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1003  	}
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1004
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1005  	if (rd & MBIR_TXMBFA) {
> 0dc7d2b3cbfcf4 drivers/net/ks8851.c Joe Perches 2010-02-27  1006  		netdev_err(ks->netdev, "TX memory selftest fail\n");
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1007  		ret |= 1;
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1008  	}
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1009
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1010  	if (rd & MBIR_RXMBFA) {
> 0dc7d2b3cbfcf4 drivers/net/ks8851.c Joe Perches 2010-02-27  1011  		netdev_err(ks->netdev, "RX memory selftest fail\n");
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1012  		ret |= 2;
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1013  	}
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1014
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1015  	return 0;
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1016  }
> 3ba81f3ece3cfa drivers/net/ks8851.c Ben Dooks   2009-07-16  1017
> 
> :::::: The code at line 995 was first introduced by commit
> :::::: 3ba81f3ece3cfa4ffb06d21ac93b8cad7fbe6a73 net: Micrel KS8851 SPI network driver
> 
> :::::: TO: Ben Dooks <ben@simtec.co.uk>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

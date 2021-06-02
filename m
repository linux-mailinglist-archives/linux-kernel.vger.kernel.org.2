Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0155439965E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 01:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFBXbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 19:31:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42178 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhFBXbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=5OxZhY2Lx3PSsgLeIF/CGHfusFZKZ4M8VuvTPJ8fjZk=; b=qPx9Zq7Ez6DFtc8Pc1fk2eNwiN
        8cc8XJj7Zz4y1t1yADcuWFIx07QBEdxXAEWwgBSl9Wf+OOA+2LHUy9l817i7GdZHQycvll8eant8k
        KxrFQ6QrTsj2zhvWgpi07w7ZWvSthQ0UvqVs/+S+QEGCNUpUfeSWffJgYs30vPwm0Vs4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1loaIY-007XKV-Hv; Thu, 03 Jun 2021 01:29:18 +0200
Date:   Thu, 3 Jun 2021 01:29:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, Marek Vasut <marex@denx.de>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/net/ethernet/micrel/ks8851_common.c:995:6: warning:
 variable 'ret' set but not used
Message-ID: <YLgUTnam/rp2ltaU@lunn.ch>
References: <202106030332.tmiMOCF7-lkp@intel.com>
 <b34e07af-4559-7707-b00b-5a36789e566d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34e07af-4559-7707-b00b-5a36789e566d@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:02:43PM -0700, Nathan Chancellor wrote:
> On 6/2/2021 12:32 PM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   231bc539066760aaa44d46818c85b14ca2f56d9f
> > commit: 797047f875b5463719cc70ba213eb691d453c946 net: ks8851: Implement Parallel bus operations
> > date:   1 year ago
> > config: x86_64-randconfig-a004-20210601 (attached as .config)
> > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project d41cb6bb2607fa5c7a9df2b3dab361353657d225)
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # install x86_64 cross compiling tool for clang build
> >          # apt-get install binutils-x86-64-linux-gnu
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=797047f875b5463719cc70ba213eb691d453c946
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout 797047f875b5463719cc70ba213eb691d453c946
> >          # save the attached .config to linux build tree
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > > > drivers/net/ethernet/micrel/ks8851_common.c:995:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
> >             int ret = 0;
> >                 ^
> >     1 warning generated.
> 
> This warning is newly implemented in clang, it was not caused by the above
> commit. As you can see from the blame below, this has been an issue since
> this driver's introduction. I wonder if it was intended to return ret in the
> places that return 0?

The return value from s8851_read_selftest() is ignored by the
caller. Probably ret could be removed and the function made to return
void.

	Andrew

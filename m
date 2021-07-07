Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF883BE905
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhGGNw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:52:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42522 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhGGNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:52:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ED1282008E;
        Wed,  7 Jul 2021 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625665817;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3hqrp2GHOyCnrbSK1ZKKcNjEVAJHLGCnMDVMhF4+ww=;
        b=jJ5I5nA7EPgGPWHkC36kiHzL/lvqYWHLQamWpsODPg1A2GXwSnUHL5i03Xsll43HzWu5xI
        pSsDLQKs5UW+fi1NCMUbWwuN3UUOaDeAkv/tvWewiRhryeOwAmTRJcuyrwejq58mS+W7L9
        cQt0e3IEJFUboOgu2Z0DTv5FGVBNeZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625665817;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3hqrp2GHOyCnrbSK1ZKKcNjEVAJHLGCnMDVMhF4+ww=;
        b=Qs0Pf/G2xf6Nt34KVoP8INoCyvW+rqxCL99GZ+uWobnQHQE7QX4uMMOyJDZ9Dkm9nZmtbA
        4a29fNKb6CuUq9CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BD4FFA3D1F;
        Wed,  7 Jul 2021 13:50:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18908DA6FD; Wed,  7 Jul 2021 15:47:43 +0200 (CEST)
Date:   Wed, 7 Jul 2021 15:47:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: super.c:undefined reference to `__umoddi3'
Message-ID: <20210707134743.GJ2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kernel test robot <lkp@intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <202107061952.nZ61qqwh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107061952.nZ61qqwh-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 07:54:13PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   79160a603bdb51916226caf4a6616cc4e1c58a58
> commit: c49f71f60754acbff37505e1d16ca796bf8a8140 MIPS: Reinstate platform `__div64_32' handler

Is it caused by this patch? It seems to be only MIPS-related, otherwise
we'd get reports from other 32bit arches in case of the emulated 64bit
division.

> date:   3 months ago
> config: mips-randconfig-r036-20210706 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c49f71f60754acbff37505e1d16ca796bf8a8140
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout c49f71f60754acbff37505e1d16ca796bf8a8140
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    mipsel-linux-ld: fs/btrfs/super.o: in function `btrfs_statfs':
>    super.c:(.text+0xed4): undefined reference to `__udivdi3'
>    mipsel-linux-ld: super.c:(.text+0xf14): undefined reference to `__umoddi3'
>    mipsel-linux-ld: super.c:(.text+0xf6c): undefined reference to `__udivdi3'

If you'd like to get that analyzed in the sources, please post the
snippet related to the binary address .text+0xf14 or .text+0xf6c .

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B763D39BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhGWLFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:05:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:54822 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234218AbhGWLFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:05:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211582532"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="211582532"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="513271803"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jul 2021 04:46:01 -0700
Date:   Fri, 23 Jul 2021 19:46:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: {standard input}:6415: Error: pcrel offset for branch to .LS0024
 too far (0x34)
Message-ID: <20210723114600.GA18766@shbuild999.sh.intel.com>
References: <202107231818.Fz1NLEeH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107231818.Fz1NLEeH-lkp@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 06:55:25PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8baef6386baaefb776bdd09b5c7630cf057c51c6
> commit: cf536e185869d4815d506e777bcca6edd9966a6e Makefile: extend 32B aligned debug option to 64B aligned
> date:   9 weeks ago
> config: csky-randconfig-c003-20210723 (attached as .config)
> compiler: csky-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf536e185869d4815d506e777bcca6edd9966a6e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout cf536e185869d4815d506e777bcca6edd9966a6e
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    {standard input}: Assembler messages:
> >> {standard input}:6415: Error: pcrel offset for branch to .LS0024 too far (0x34)

Thanks for the report!

It was reported once when the patch was in linux-next tree, and we have
discussed it in this thread
https://www.spinics.net/lists/linux-kbuild/msg30300.html

The short summary is, we tried the build on arm64/ppc32/ppc64/arc/risv32,
which were fine, and csky-develpers are checking it. 

Thanks,
Feng

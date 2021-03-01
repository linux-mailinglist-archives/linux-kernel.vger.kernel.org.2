Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB5327767
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhCAGKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:10:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:15731 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231756AbhCAGJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:09:27 -0500
IronPort-SDR: BJBonO1s802IITkqYhkqTd4g2BEVteGrrTXGWKpH/RqTDX5IxWLcxEf8/aHKnEessO1W61qh6c
 6MXVNNuy8j+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="186421916"
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="186421916"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 22:08:26 -0800
IronPort-SDR: kQhuOOw03RsOEZ4x0hq/nMjmocHhIv2OABgnuXE7jyqCTpCT2t4yiT5xEY7G/GXwToaSaladUm
 vHWMlVrX9v2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="397575231"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.165])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2021 22:08:22 -0800
Date:   Mon, 1 Mar 2021 14:08:22 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [linux-next:master 5983/6048] h8300-linux-ld: section .data VMA
 overlaps section __kcrctab VMA
Message-ID: <20210301060822.GA21746@shbuild999.sh.intel.com>
References: <202102100211.hNoYGjub-lkp@intel.com>
 <CAHC9VhRidm6WXr9T+dGG_hZjeS+cKaVkMic_cNJMG-CRqyoSVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRidm6WXr9T+dGG_hZjeS+cKaVkMic_cNJMG-CRqyoSVA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Feb 10, 2021 at 02:21:41AM +0800, Paul Moore wrote:
> On Tue, Feb 9, 2021 at 1:09 PM kernel test robot <lkp@intel.com> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   59fa6a163ffabc1bf25c5e0e33899e268a96d3cc
> > commit: 77d8143a5290b38e3331f61f55c0b682699884bc [5983/6048] Merge remote-tracking branch 'selinux/next'
> > config: h8300-randconfig-r005-20210209 (attached as .config)
> > compiler: h8300-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=77d8143a5290b38e3331f61f55c0b682699884bc
> >         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >         git fetch --no-tags linux-next master
> >         git checkout 77d8143a5290b38e3331f61f55c0b682699884bc
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    h8300-linux-ld: section .init.text LMA [0000000000430360,00000000004479a1] overlaps section .data LMA [000000000041868c,00000000004489eb]
> > >> h8300-linux-ld: section .data VMA [0000000000400000,000000000043035f] overlaps section __kcrctab VMA [00000000003fdd74,000000000040007b]
> > >> h8300-linux-ld: section __kcrctab_gpl VMA [000000000040007c,00000000004025a7] overlaps section .data VMA [0000000000400000,000000000043035f]
> >    h8300-linux-ld: arch/h8300/kernel/entry.o: in function `resume_kernel':
> >    (.text+0x29a): undefined reference to `TI_PRE_COUNT'
> 
> This really doesn't look like something caused by SELinux ...

No, this is not related with SELinux, sorry for the false alarm.

Further check shows it is related with the kernel config and the
built-out kernel size. With the kernel config, the ROM size is 4MB
large, and when the config selects many components, its .text and
.rodata may exceeds the 4MB size limit, causes the "overlaps section"
errors.

If we trim the kernel config and enable the "CONFIG_TRIM_UNUSED_KSYMS",
then the compilation can succeed.

For testing kbuild on platforms which has special size limits, one
thought is the kernel config may need to be chosen specifically.

Thanks,
Feng

> --
> paul moore
> www.paul-moore.com
> 

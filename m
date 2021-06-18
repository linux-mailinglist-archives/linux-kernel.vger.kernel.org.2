Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD093ACF5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhFRPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:45:49 -0400
Received: from foss.arm.com ([217.140.110.172]:43384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhFRPps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:45:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFF8113A1;
        Fri, 18 Jun 2021 08:43:38 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583743F694;
        Fri, 18 Jun 2021 08:43:37 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:43:20 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        kbuild-all@lists.01.org, Rob Herring <robh@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/19] rtc: sun6i: Add support for linear day storage
Message-ID: <20210618164320.2aa0ec2d@slackpad.fritz.box>
In-Reply-To: <202106180321.yesYU6UQ-lkp@intel.com>
References: <20210615110636.23403-5-andre.przywara@arm.com>
        <202106180321.yesYU6UQ-lkp@intel.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 04:07:55 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Andre,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on sunxi/sunxi/for-next]
> [also build test ERROR on v5.13-rc6]
> [cannot apply to lee-mfd/for-mfd-next mripard/sunxi/for-next next-20210617]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Andre-Przywara/arm64-sunxi-Initial-Allwinner-H616-SoC-support/20210617-022925
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
> config: powerpc64-randconfig-c004-20210617 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/b0bd86f86f42049c6e19e25460b042fca7a7901d
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andre-Przywara/arm64-sunxi-Initial-Allwinner-H616-SoC-support/20210617-022925
>         git checkout b0bd86f86f42049c6e19e25460b042fca7a7901d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    powerpc-linux-ld: drivers/rtc/rtc-sun6i.o: in function `sun6i_rtc_settime':
> >> rtc-sun6i.c:(.text.sun6i_rtc_settime+0x218): undefined reference to `__udivdi3'  

For the records, I am using div_u64() now, which compiles fine in both
ARM and arm64.
Also found some subtle bugs with the types used in that function on the
way.

Thanks dear bot for also caring about those "lesser" architectures ;-)

Cheers,
Andre

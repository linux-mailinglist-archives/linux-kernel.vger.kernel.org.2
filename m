Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111943B5913
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhF1GZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhF1GZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:25:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EC5061466;
        Mon, 28 Jun 2021 06:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624861362;
        bh=NNc851LBqarWTBV4fgQYqEOqo/uuQsKbb2A5bngvuZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtjV6yGFDUttuvRg5k9iqUlpREPB0ITN2uOogxV6+cDbF0TqqTtVZVu/P/ObQwKIy
         all0CqY8jOv7X74TG7HgiSYECElHgQEdYTMDIdMeD5aX7P/tMO6HfjapzkZI3ihm9a
         4PZw+/7SP8eNNt2YmRp7t/CTy2cNZ5CaV3Bxi1IsrOrKYPrURYWO3jQETsabXuEufe
         yQ5bmkqgKYbfyNvK3TXNHXrU3RX3jPMgP/4bfARw353PSpwk4CTeh7ILDnDlEnN3bp
         0J8WBSOrI3QIlIOkPCBunzHVFMOWFSPIo2e0wVMli7+Nzy1DMxR8M8yG6aa31pd393
         9lJwWa9fxbfjg==
Date:   Mon, 28 Jun 2021 11:52:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: owl-s500: Add ethernet support
Message-ID: <20210628062235.GA4033@workstation>
References: <222ee0c2cb431619f558dce9726585ac92f65e00.1623401998.git.cristian.ciocaltea@gmail.com>
 <202106162101.RfHWePKS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106162101.RfHWePKS-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristi,

On Wed, Jun 16, 2021 at 09:30:13PM +0800, kernel test robot wrote:
> Hi Cristian,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v5.13-rc6 next-20210615]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Cristian-Ciocaltea/Add-Ethernet-DTS-for-Actions-Semi-Owl-S500-SoCs/20210616-121106
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm-randconfig-r025-20210615 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/87e17f86112592e0805d0a081914f7b2eeb2770d
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Cristian-Ciocaltea/Add-Ethernet-DTS-for-Actions-Semi-Owl-S500-SoCs/20210616-121106
>         git checkout 87e17f86112592e0805d0a081914f7b2eeb2770d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm/boot/dts/owl-s500.dtsi:332.19-20 syntax error
> >> FATAL ERROR: Unable to parse input tree

Did you look into this error? Looks like CLK_ETHERNET is not defined in
the s500 CMU binding.

Today I saw that the clk patches are applied but then it is later for me
to send the dts patches for v5.14. So please fix this error and
resubmit, I'll take them for v5.15.

Thanks,
Mani

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



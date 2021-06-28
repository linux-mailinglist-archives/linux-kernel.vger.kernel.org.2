Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1313B59C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhF1HeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232246AbhF1Hd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:33:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6070561582;
        Mon, 28 Jun 2021 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624865491;
        bh=xQlF2kkg5CI8fR9QA6kLrmGihAIy44Vu5eKh0i1qOfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRdGiQJuy+CZrRTOvhalGZckEedXMagwjwVKyVUxPvgUaDo9IGMmS4ZzgamAacQML
         zxFF9I+HWzNuOroMICqNtT9bP1esRSzk74CODW0FJaMsxngu0hjjPBDPgQvlI1SpFP
         Gh+9pOSZqxUysbkDRrLTJf6AvmeN+NIvMc2DdBWdSpjv/D/zt4D/9l7IzmH2s4ZaS4
         13kx+aN/R5C2vbwqkJNu4cRSxg06aW9849A2eZvwwW5Ijfg+9fuQG61KIO5SO8RYy7
         ioK/pe8ltv6AmyfArSiyQYV8N5Bbw9Hb9V/oJhAizgBo4GYfYX2TDdLQk+xrnFWsil
         V/lGCcGYNGqHQ==
Date:   Mon, 28 Jun 2021 13:01:24 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: owl-s500: Add ethernet support
Message-ID: <20210628073124.GB4033@workstation>
References: <222ee0c2cb431619f558dce9726585ac92f65e00.1623401998.git.cristian.ciocaltea@gmail.com>
 <202106162101.RfHWePKS-lkp@intel.com>
 <20210628062235.GA4033@workstation>
 <20210628070234.GA1003245@ubuntu2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628070234.GA1003245@ubuntu2004>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 10:02:34AM +0300, Cristian Ciocaltea wrote:
> Hi Mani,
> 
> On Mon, Jun 28, 2021 at 11:52:35AM +0530, Manivannan Sadhasivam wrote:
> > Hi Cristi,
> > 
> > On Wed, Jun 16, 2021 at 09:30:13PM +0800, kernel test robot wrote:
> > > Hi Cristian,
> > > 
> > > I love your patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on robh/for-next]
> > > [also build test ERROR on v5.13-rc6 next-20210615]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Cristian-Ciocaltea/Add-Ethernet-DTS-for-Actions-Semi-Owl-S500-SoCs/20210616-121106
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> > > config: arm-randconfig-r025-20210615 (attached as .config)
> > > compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://github.com/0day-ci/linux/commit/87e17f86112592e0805d0a081914f7b2eeb2770d
> > >         git remote add linux-review https://github.com/0day-ci/linux
> > >         git fetch --no-tags linux-review Cristian-Ciocaltea/Add-Ethernet-DTS-for-Actions-Semi-Owl-S500-SoCs/20210616-121106
> > >         git checkout 87e17f86112592e0805d0a081914f7b2eeb2770d
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> Error: arch/arm/boot/dts/owl-s500.dtsi:332.19-20 syntax error
> > > >> FATAL ERROR: Unable to parse input tree
> > 
> > Did you look into this error? Looks like CLK_ETHERNET is not defined in
> > the s500 CMU binding.
> 
> CLK_ETHERNET is introduced through patches 5 & 6 from the patch series:
> "[PATCH v3 0/6] Improve clock support for Actions S500 SoC"
> 
> Most probably those patches were not applied to the tested kernel tree
> and that's why the robot reported the error.
> 

Ah, okay. I didn't see it. Then I'll just push the dts changes and see
if they get applied for 5.14.

Thanks,
Mani

> Thanks,
> Cristi
> 
> > Today I saw that the clk patches are applied but then it is later for me
> > to send the dts patches for v5.14. So please fix this error and
> > resubmit, I'll take them for v5.15.
> > 
> > Thanks,
> > Mani
> > 
> > > 
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > 
> > 

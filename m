Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA7033424B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhCJP6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:58:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:36836 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233150AbhCJP6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:58:04 -0500
IronPort-SDR: +FfxI5xD6s5sMlkiNPtERAlEgJYAvAvzT9CdeRYV7lNyzF1+EV5oW5Ug54BysdNZyz/88K1ruw
 FPidQfnc7F5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186118401"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="186118401"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:58:02 -0800
IronPort-SDR: OxrBNUUtotGUNg4cNRcoXloqE/9ztnxz+sMjW7YzH8BQko16HOdRoJ2GBil3TWdOC6ro2EohgX
 IP+K7e9v9puA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="599828590"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 10 Mar 2021 07:58:00 -0800
Date:   Wed, 10 Mar 2021 23:53:14 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 2/4] mfd: intel-m10-bmc: Simplify the legacy version
  reg definition
Message-ID: <20210310155314.GA27487@yilunxu-OptiPlex-7050>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
 <1614578385-26955-3-git-send-email-yilun.xu@intel.com>
 <20210310091625.GJ4931@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210310091625.GJ4931@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 09:16:25AM +0000, Lee Jones wrote:
> On Mon, 01 Mar 2021, Xu Yilun wrote:
> 
> > The version register is the only one in the legacy I/O space to be
> > accessed, so it is not necessary to define the legacy base & version
> > register offset. A direct definition of the legacy version register
> > address would be fine.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > ---
> > v3: no change, rebased to 5.12-rc1
> > ---
> >  drivers/mfd/intel-m10-bmc.c       | 12 +++++-------
> >  include/linux/mfd/intel-m10-bmc.h |  2 +-
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > index 06c9775..0d2c03f 100644
> > --- a/drivers/mfd/intel-m10-bmc.c
> > +++ b/drivers/mfd/intel-m10-bmc.c
> > @@ -117,16 +117,14 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
> >  
> >  	/*
> >  	 * This check is to filter out the very old legacy BMC versions,
> > -	 * M10BMC_LEGACY_SYS_BASE is the offset to this old block of mmio
> > -	 * registers. In the old BMC chips, the BMC version info is stored
> > -	 * in this old version register (M10BMC_LEGACY_SYS_BASE +
> > -	 * M10BMC_BUILD_VER), so its read out value would have not been
> > -	 * LEGACY_INVALID (0xffffffff). But in new BMC chips that the
> > +	 * 0x300400 is the offset to this old block of mmio registers. In the
> 
> Not sure we want actual addresses in comments.
> 
> Please reword this to cover just the latest solution.

Will fix it in next version.

Thanks,
Yilun

> 
> > +	 * old BMC chips, the BMC version info is stored in this old version
> > +	 * register (0x300400 + 0x68), so its read out value would have not
> > +	 * been LEGACY_INVALID (0xffffffff). But in new BMC chips that the
> >  	 * driver supports, the value of this register should be
> >  	 * LEGACY_INVALID.
> >  	 */
> > -	ret = m10bmc_raw_read(ddata,
> > -			      M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER, &v);
> > +	ret = m10bmc_raw_read(ddata, M10BMC_LEGACY_BUILD_VER, &v);
> >  	if (ret)
> >  		return -ENODEV;
> >  
> > diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> > index 9b54ca1..4f1071f 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -9,7 +9,7 @@
> >  
> >  #include <linux/regmap.h>
> >  
> > -#define M10BMC_LEGACY_SYS_BASE		0x300400
> > +#define M10BMC_LEGACY_BUILD_VER		0x300468
> >  #define M10BMC_SYS_BASE			0x300800
> >  #define M10BMC_MEM_END			0x1fffffff
> >  
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

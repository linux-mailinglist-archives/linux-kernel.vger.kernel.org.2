Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9F635FA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351238AbhDNRwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:52:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:15557 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346877AbhDNRwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:52:49 -0400
IronPort-SDR: J5tqTA2H1yNMVqUxV5daem6T5t50V43x16EiGp8o7+vxjB0Ntuzx3fL7U4VdIaXy581KpmRCbg
 03w6c/doKrpA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="191511511"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="191511511"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:52:27 -0700
IronPort-SDR: fzdiGQ25Qcw0t82oJ6AL7KPIFj2V0HRkBYxcgWKMkSxq+UyrNMeJk9xGVl5bwrr4mYYiZWfnAF
 yNeN5GtNTNAg==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="461307271"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:52:26 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lWjgd-00443E-6S; Wed, 14 Apr 2021 20:52:23 +0300
Date:   Wed, 14 Apr 2021 20:52:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] mfd: intel_quark_i2c_gpio: Don't play dirty trick
 with const
Message-ID: <YHcr144krHDay72g@smile.fi.intel.com>
References: <20210326124842.2437-1-andriy.shevchenko@linux.intel.com>
 <20210326145129.GB2916463@dell>
 <20210414171319.GQ4869@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210414171319.GQ4869@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 06:13:19PM +0100, Lee Jones wrote:
> On Fri, 26 Mar 2021, Lee Jones wrote:
> 
> > On Fri, 26 Mar 2021, Andy Shevchenko wrote:
> > 
> > > As Linus rightfully noticed, the driver plays dirty trick with const,
> > > i.e. it assigns a place holder data structure to the const field
> > > in the MFD cell and then drops the const by explicit casting. This is
> > > not how it should be.
> > > 
> > > Assign local pointers of the cell and resource to the respective
> > > non-const place holders in the intel_quark_i2c_setup() and
> > > intel_quark_gpio_setup().
> > > 
> > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > v2: eliminated bar parameter (Lee)
> > >  drivers/mfd/intel_quark_i2c_gpio.c | 26 ++++++++++++--------------
> > >  1 file changed, 12 insertions(+), 14 deletions(-)
> > 
> > Neat.
> > 
> > Applied, thanks.
> 
> Am I still missing patches from you Andy?

Patches for fixes should be applied to for-next as well. I don't know why with
my patches it diverged.

I have already commented on this when kbuild bot complained.

So,

	git checkout for-mfd-next
	git merge for-mfd-fixes

or equivalent (cherry-pick) will fix that.

> I get:
> 
>  make --silent --keep-going --jobs=8 O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- 'CC=sccache x86_64-linux-gnu-gcc' 'HOSTCC=sccache gcc' allmodconfig
>  make --silent --keep-going --jobs=8 O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- 'CC=sccache x86_64-linux-gnu-gcc' 'HOSTCC=sccache gcc'
>  /builds/linux/drivers/mfd/intel_quark_i2c_gpio.c: In function 'intel_quark_i2c_setup':
>  /builds/linux/drivers/mfd/intel_quark_i2c_gpio.c:181:25: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>    struct resource *res = intel_quark_i2c_res;
>                           ^~~~~~~~~~~~~~~~~~~
>  /builds/linux/drivers/mfd/intel_quark_i2c_gpio.c: In function 'intel_quark_gpio_setup':
>  /builds/linux/drivers/mfd/intel_quark_i2c_gpio.c:203:25: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>    struct resource *res = intel_quark_gpio_res;
>                           ^~~~~~~~~~~~~~~~~~~~
> 
> Link to the build (see: build.log):
> 
>   https://builds.tuxbuild.com/1rAMovpd041jvsjfQ538kW3nvYK/
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

-- 
With Best Regards,
Andy Shevchenko



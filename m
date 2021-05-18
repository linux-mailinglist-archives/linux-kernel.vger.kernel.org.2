Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5415387480
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347625AbhERJAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:00:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:43301 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241201AbhERJAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:00:44 -0400
IronPort-SDR: 4qWFjUh3c39jPgYrgUVKPdmT8jJPewcQ3EmjqnovbhUJ2dhsCKP+16u7TSOi4ejMlHjdZr3NQN
 5QEf9dB3hmqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221712549"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="221712549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 01:59:27 -0700
IronPort-SDR: XCdarnEpSTThK2pbACDrC8TGBHOtwodR+hEEHVNmY0nuK2yV37pMmGg3jT7Gvb8SYoVKyO/Afi
 SQSH9RyoaMeQ==
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="541668909"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 01:59:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1livZS-00CuRz-Pn; Tue, 18 May 2021 11:59:22 +0300
Date:   Tue, 18 May 2021 11:59:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: platform: Remove
 platform_device_add_properties()
Message-ID: <YKOB6lRqc5DKo2GS@smile.fi.intel.com>
References: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:30:44AM +0300, Heikki Krogerus wrote:
> Hi,
> 
> It looks like there is only one place left that still uses the
> function. Converting that last user and removing the thing.
> 
> Note, I'm actually resending the patch for board-paz00.c. I'm assuming
> the original patch slipped through the cracks because it did not end
> up anywhere.

Cool!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Btw, which base have you used for this series?

> I would imagine that it's OK to everybody if Greg takes these?
> 
> thanks,
> 
> Heikki Krogerus (2):
>   ARM: tegra: paz00: Handle device properties with software node API
>   driver core: platform: Remove platform_device_add_properties()
> 
>  arch/arm/mach-tegra/board-paz00.c |  2 +-
>  drivers/base/platform.c           | 20 ++------------------
>  include/linux/platform_device.h   |  2 --
>  3 files changed, 3 insertions(+), 21 deletions(-)
> 
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko



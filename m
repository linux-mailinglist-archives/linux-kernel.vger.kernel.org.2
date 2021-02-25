Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B202F324F16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbhBYLYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:24:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:34043 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235087AbhBYLYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:24:19 -0500
IronPort-SDR: 9vxlhA1xzPmK06eGmGTXNlHj3Y+QZp6Ha7wHw4abiJ5jhzd0WHhmbr9MkHzB85VVhCQI43dzh1
 0ItD25eMZ8uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="184790913"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="184790913"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 03:22:30 -0800
IronPort-SDR: 7tPITnpAE9/TVffope+8kG9rgHzjZbcByJ6o53pZuL2vgHpXo4cpHVuTFDFFNwJQ7lDum2RRia
 e1Utm8bZVkhw==
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="442532278"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 03:22:29 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lFEiw-0080Ln-6R; Thu, 25 Feb 2021 13:22:26 +0200
Date:   Thu, 25 Feb 2021 13:22:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Christian Eggers <ceggers@arri.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v2 1/9] units: Add the HZ macros
Message-ID: <YDeIcsQeDloy5Lx3@smile.fi.intel.com>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:42:11PM +0100, Daniel Lezcano wrote:
> The macros for the unit conversion for frequency are duplicated in
> different places.
> 
> Provide these macros in the 'units' header, so they can be reused.

For the all that have not been tagged:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Christian Eggers <ceggers@arri.de>
> Reviewed-by: Andy Shevchenko <Andy.Shevchenko@gmail.com>
> ---
>  include/linux/units.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/units.h b/include/linux/units.h
> index dcc30a53fa93..218ec0d314b6 100644
> --- a/include/linux/units.h
> +++ b/include/linux/units.h
> @@ -4,6 +4,10 @@
>  
>  #include <linux/math.h>
>  
> +#define HZ_PER_KHZ		1000L
> +#define KHZ_PER_MHZ		1000L
> +#define HZ_PER_MHZ		1000000L
> +
>  #define MILLIWATT_PER_WATT	1000L
>  #define MICROWATT_PER_MILLIWATT	1000L
>  #define MICROWATT_PER_WATT	1000000L
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko



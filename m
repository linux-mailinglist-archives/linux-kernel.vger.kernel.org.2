Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0312B437A93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 18:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhJVQKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:10:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:44251 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhJVQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:10:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216244832"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216244832"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 09:02:53 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="464087112"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 09:02:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mdwzx-0009DN-OI;
        Fri, 22 Oct 2021 19:02:25 +0300
Date:   Fri, 22 Oct 2021 19:02:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Tim Crawford <tcrawford@system76.com>,
        Jeremy Soller <jeremy@system76.com>,
        Arnd Bergmann <arnd@arndb.de>, Kate Hsuan <hpa@redhat.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] platform/x86: system76_acpi: fix Kconfig dependencies
Message-ID: <YXLgkWFgSHgQLljx@smile.fi.intel.com>
References: <20211022154901.904984-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022154901.904984-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 05:48:40PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_INPUT is disabled, this driver now fails to link:
> 
> ld.lld: error: undefined symbol: devm_input_allocate_device
> >>> referenced by system76_acpi.c
> >>>               platform/x86/system76_acpi.o:(system76_add) in archive drivers/built-in.a
> 
> ld.lld: error: undefined symbol: input_set_capability
> >>> referenced by system76_acpi.c
> >>>               platform/x86/system76_acpi.o:(system76_add) in archive drivers/built-in.a
> 
> ld.lld: error: undefined symbol: devm_hwmon_device_register_with_info
> >>> referenced by system76_acpi.c
> >>>               platform/x86/system76_acpi.o:(system76_add) in archive drivers/built-in.a
> 
> ld.lld: error: undefined symbol: battery_hook_unregister
> >>> referenced by system76_acpi.c
> >>>               platform/x86/system76_acpi.o:(system76_remove) in archive drivers/built-in.a
> 
> Add Kconfig dependencies for each of these three.

Thanks! FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(See one comment below)

> Fixes: 0de30fc684b3 ("platform/x86: system76_acpi: Replace Fn+F2 function for OLED models")
> Fixes: 95563d45b5da ("platform/x86: system76_acpi: Report temperature and fan speed")
> Fixes: 76f7eba3e0a2 ("platform/x86: system76_acpi: Add battery charging thresholds")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 56bcf80da60a..c422ee785c56 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -923,6 +923,9 @@ config SONYPI_COMPAT
>  config SYSTEM76_ACPI
>  	tristate "System76 ACPI Driver"

>  	depends on ACPI
> +	depends on ACPI_BATTERY

ACPI_BATTERY depends on ACPI, do we need to keep ACPI above?

> +	depends on HWMON
> +	depends on INPUT
>  	select NEW_LEDS
>  	select LEDS_CLASS
>  	select LEDS_TRIGGERS

-- 
With Best Regards,
Andy Shevchenko



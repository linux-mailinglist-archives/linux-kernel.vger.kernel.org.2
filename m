Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2571941EAE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353568AbhJAKSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:18:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:35369 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353566AbhJAKSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:18:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225049059"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="225049059"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 03:16:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="556228865"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 03:16:23 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWFaW-007PaH-L2;
        Fri, 01 Oct 2021 13:16:20 +0300
Date:   Fri, 1 Oct 2021 13:16:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Add support for MacBookPro16,2 UART
Message-ID: <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001084905.4133-1-redecorating@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 08:51:46AM +0000, Orlando Chamberlain wrote:

Thanks for your contribution! My comments below.

> The MacBookPro16,2 has a UART controller with pci id 8086:38a8. Added

PCI ID

> this device to the intel_lpss_pci driver. This allows access to its
> Bluetooth controller.

> The name of this device is not known, however as it appears to only be
> found on the one model (MacBookPro16,2), labelling it with that
> model's name should be sufficient to identify it. (Unless some folks
> from Intel know what to call it and what its section should be called.)

No need to put this paragraph into commit message (see below).

> Records here indicate that this device is only present on the one model:
> https://linux-hardware.org/?id=pci:8086-38a8-8086-7270
> 
> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index c54d19fb184c..e02bb7026520 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -253,6 +253,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x34ea), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x34eb), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&spt_info },

> +	/* MacBookPro16,2 */

Use

	/* ICL-N */

here.

> +	{ PCI_VDEVICE(INTEL, 0x38a8), (kernel_ulong_t)&bxt_uart_info },
>  	/* TGL-H */
>  	{ PCI_VDEVICE(INTEL, 0x43a7), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x43a8), (kernel_ulong_t)&bxt_uart_info },

-- 
With Best Regards,
Andy Shevchenko



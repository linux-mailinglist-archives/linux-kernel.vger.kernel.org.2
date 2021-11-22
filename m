Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C21458D47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhKVLZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:25:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:26883 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhKVLZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:25:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="232252613"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="232252613"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 03:22:44 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="456248443"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 03:22:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mp7PC-009PlW-Pv;
        Mon, 22 Nov 2021 13:22:38 +0200
Date:   Mon, 22 Nov 2021 13:22:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss-pci: fix clock speed for 38a8 UART
Message-ID: <YZt9fpdd284FdKSh@smile.fi.intel.com>
References: <20211120083312.41230-1-redecorating@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120083312.41230-1-redecorating@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 08:34:26AM +0000, Orlando Chamberlain wrote:

Thanks, my comments below.

> This device is found in the MacBookPro16,2, and as the MacBookPro16,1 is
> from the same generation of MacBooks and has a UART with bxt_uart_info,
> it was incorrectly assumed that the MacBookPro16,2's UART would have the
> same info.
> 
> This led to the wrong clock speed being used, and the Bluetooth
> controller exposed by the UART receiving and sending random data, which
> was incorrectly assumed to be an issue with the Bluetooth stuff, not an
> error with the UART side of things.
> 
> Changing the info to spt_uart_info changes the clock speed and makes it
> send and receive data correctly.

> Fixes: ddb1ada416fd ("mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N UART")
> 
> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>

Tag block shouldn't have blank lines. Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>  drivers/mfd/intel-lpss-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index a872b4485eac..f70464ce8e3d 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -254,7 +254,7 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x34eb), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&spt_info },
>  	/* ICL-N */
> -	{ PCI_VDEVICE(INTEL, 0x38a8), (kernel_ulong_t)&bxt_uart_info },
> +	{ PCI_VDEVICE(INTEL, 0x38a8), (kernel_ulong_t)&spt_uart_info },
>  	/* TGL-H */
>  	{ PCI_VDEVICE(INTEL, 0x43a7), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x43a8), (kernel_ulong_t)&bxt_uart_info },
> -- 
> 2.34.0
> 
> 

-- 
With Best Regards,
Andy Shevchenko



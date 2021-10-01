Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0034241EB59
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353722AbhJALGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:06:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:55989 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353235AbhJALG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:06:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="247958974"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="247958974"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:04:45 -0700
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="708552234"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:04:44 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWGLJ-007QCW-Up;
        Fri, 01 Oct 2021 14:04:41 +0300
Date:   Fri, 1 Oct 2021 14:04:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mfd: intel-lpss: Add support for MacBookPro16,2 UART
Message-ID: <YVbrSXeaMUzxbWys@smile.fi.intel.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
 <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
 <20211001103845.21976-1-redecorating@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001103845.21976-1-redecorating@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 10:40:09AM +0000, Orlando Chamberlain wrote:
> Added 8086:38a8 to the intel_lpss_pci driver. It is a UART controler
> present on the MacBookPro16,2.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> ---
> v1->v2: Use "ICL-N" and shorten commit message.
>  drivers/mfd/intel-lpss-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index c54d19fb184c..a872b4485eac 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -253,6 +253,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x34ea), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x34eb), (kernel_ulong_t)&bxt_i2c_info },
>  	{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&spt_info },
> +	/* ICL-N */
> +	{ PCI_VDEVICE(INTEL, 0x38a8), (kernel_ulong_t)&bxt_uart_info },
>  	/* TGL-H */
>  	{ PCI_VDEVICE(INTEL, 0x43a7), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x43a8), (kernel_ulong_t)&bxt_uart_info },
> -- 
> 2.33.0
> 
> 

-- 
With Best Regards,
Andy Shevchenko



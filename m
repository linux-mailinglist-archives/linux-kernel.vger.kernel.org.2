Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD94E41FAFF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhJBLG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 07:06:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:30190 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232822AbhJBLG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 07:06:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="248252266"
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; 
   d="scan'208";a="248252266"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 04:04:34 -0700
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; 
   d="scan'208";a="481389250"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 04:04:33 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWcog-007hpl-Du;
        Sat, 02 Oct 2021 14:04:30 +0300
Date:   Sat, 2 Oct 2021 14:04:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N
 UART
Message-ID: <YVg8vsdU89wjC9/7@smile.fi.intel.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
 <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
 <YVdP9PwNrjmKxKac@google.com>
 <YVdR4bdpr9/E+GNf@smile.fi.intel.com>
 <20211002032810.3729-1-redecorating@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002032810.3729-1-redecorating@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2021 at 03:31:07AM +0000, Orlando Chamberlain wrote:
> Added 8086:38a8 to the intel_lpss_pci driver. It is an Intel Ice Lake
> PCH-N UART controler present on the MacBookPro16,2.

You ignoring my Reviewed-by tag. Any reason why?

Besides that you are posting patches as continuation of the thread. It may be
problematic for some tools, like `b4`, although I dunno if Lee is using such
tools.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> ---
> v2->v3: Mention "ICL-N" in commit message.
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



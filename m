Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB603F45D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhHWHdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:33:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:59466 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234861AbhHWHdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:33:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="302637138"
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="302637138"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 00:32:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="574563672"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 00:32:48 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mI4Rl-00ChFf-Pn; Mon, 23 Aug 2021 10:32:41 +0300
Date:   Mon, 23 Aug 2021 10:32:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kate Hsuan <hpa@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Dell.Client.Kernel@dell.com, Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
Subject: Re: [PATCH v5 07/20] platform/x86: pmc_atom: Move to intel
 sub-directory
Message-ID: <YSNPGRt6azqfXFKP@smile.fi.intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
 <20210820110458.73018-8-andriy.shevchenko@linux.intel.com>
 <ccae9fcb-fa2f-5c44-1241-9f107b358103@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccae9fcb-fa2f-5c44-1241-9f107b358103@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 08:18:17PM +0200, Hans de Goede wrote:
> On 8/20/21 1:04 PM, Andy Shevchenko wrote:
> > Move Intel Atom PMC driver to intel sub-directory to improve readability.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This means that pmc_atom will now not be build if X86_PLATFORM_DRIVERS_INTEL
> is not set (and PCI is enabled). Which will cause missing pmc_atom_read/_write
> symbols in drivers/acpi/acpi_lpss.c. So I have dropped this patch from the
> set, while applying the rest.
> 
> Note I'm thinking that we should just remove the whole X86_PLATFORM_DRIVERS_INTEL
> Kconfig option and in the drivers/platform/x86/Makefile replace:
> 
> obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)                += intel/
> 
> with:
> 
> obj-y                                                   += intel/
> 
> This will also allows us to fix the scu issue without needing any
> changes to drivers/mfd/Kconfig .
> 
> But this can all wait for the 2nd round of renames after 5.15-rc1.
> 
> For now I'm moving forward with this v5 series, except with this
> patch dropped.

Indeed. Thanks for the analysis.

Btw, should we convert Dell subdir to something similar in terms of Kconfig?

-- 
With Best Regards,
Andy Shevchenko



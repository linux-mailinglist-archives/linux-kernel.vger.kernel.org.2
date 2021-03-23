Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DF8345BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhCWKbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:31:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:62535 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhCWKbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:31:18 -0400
IronPort-SDR: nXJK1wsl239CczalZFdab4oHvIv9Jd7Yz0R2ZRraOffzfudAkY7IFQXZVASmmqwIPzqbeQYZH5
 xKlVCL5pFtYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190544139"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="190544139"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 03:31:17 -0700
IronPort-SDR: BqsQ0ZVCsf9IoI8Sc27lfq+vew4nrqY0C26IM78ERSY1t//Zqw1EAn1pmHr8NLXFNY6r0ZlTLx
 ZRd1xBNHdwMQ==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="408258545"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 03:31:16 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lOeJd-00EzHj-Sr; Tue, 23 Mar 2021 12:31:13 +0200
Date:   Tue, 23 Mar 2021 12:31:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] mfd: intel_quark_i2c_gpio: Reuse BAR definitions
 for MFD cell indexing
Message-ID: <YFnDccpWGjXAI3Rk@smile.fi.intel.com>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
 <20210302135620.89958-5-andriy.shevchenko@linux.intel.com>
 <20210323092057.GM2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323092057.GM2916463@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:20:57AM +0000, Lee Jones wrote:
> On Tue, 02 Mar 2021, Andy Shevchenko wrote:
> 
> > It's convenient and less error prone to use definitions to address
> > different cells in an array. For this purpose we may reuse existing
> > BAR definitions.

...

> > +	{
> > +		.id = MFD_GPIO_BAR,
> > +		.name = "gpio-dwapb",
> > +		.acpi_match = &intel_quark_acpi_match_gpio,
> > +		.num_resources = ARRAY_SIZE(intel_quark_gpio_res),
> > +		.resources = intel_quark_gpio_res,
> > +		.ignore_resource_conflicts = true,
> > +	},
> >  };
> 
> I would make this more explicit.
> 
> [MFD_I2C_BAR] = { }
> 
> If someone comes along and re-reorders these, it will break.

Agree.
Will do for v2.

-- 
With Best Regards,
Andy Shevchenko



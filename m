Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57723D26FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhGVPFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:05:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:57800 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhGVPFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:05:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="209777051"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="209777051"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 08:45:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="462813165"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 08:45:46 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m6atI-00H1uh-7d; Thu, 22 Jul 2021 18:45:40 +0300
Date:   Thu, 22 Jul 2021 18:45:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>, Dennis Giaya <dgiaya@whoi.edu>
Subject: Re: [PATCH v1 1/1] serial: max310x: Use clock-names property
 matching to recognize XTAL
Message-ID: <YPmSpNZr/yQiPqsO@smile.fi.intel.com>
References: <20210722150233.30897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722150233.30897-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 06:02:33PM +0300, Andy Shevchenko wrote:
> Dennis reported that on ACPI-based systems the clock frequency
> isn't enough to configure device properly. We have to respect
> the clock source as well. To achieve this match the clock-names
> property against "xtal" to recognize crystal connection.

Dennis, please test this.

...

> -	s->clk = devm_clk_get_optional(dev, "osc");
> +	xtal = device_property_match_string(dev, "clock-names", "xtal") >= 0;

Meanwhile I will change this (not affects the testing in your case) to actually
negative one as:

	..., "osc") < 0;

to be compatible with the original flow (in case there are two clock names, the
"osc" has a priority).


-- 
With Best Regards,
Andy Shevchenko



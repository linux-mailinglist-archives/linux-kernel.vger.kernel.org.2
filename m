Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB4F347E41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhCXQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:54:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:9472 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236257AbhCXQx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:53:29 -0400
IronPort-SDR: oZNEtzPWz50jGSiepHLJEXm8YBVyZfcwCVQdPoikWP6A1UhRSnGXqIWitEQLw31ol4o1cHCfJh
 Vt7S/fWu9MTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="210861405"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="210861405"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 09:53:28 -0700
IronPort-SDR: 4EQQIKL5mgOOctLH+vs5kn9VT13xUaS7XEjBnxIqSiZpQO9MF2ABVNGsdPDmo8WBR9GaL0gZKq
 RspZzudzyFSA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="408929906"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 09:53:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lP6l2-00FkJq-Vu; Wed, 24 Mar 2021 18:53:24 +0200
Date:   Wed, 24 Mar 2021 18:53:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <YFtuhN/+o1hxo0WD@smile.fi.intel.com>
References: <20210324151929.36844-1-andriy.shevchenko@linux.intel.com>
 <20210324152502.GQ2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324152502.GQ2916463@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 03:25:02PM +0000, Lee Jones wrote:
> On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> 
> > Allow interrupts to be MSI if supported by hardware.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v3: added a comment about magic 1s (Lee)
> > 
> >  drivers/mfd/intel_quark_i2c_gpio.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> Doesn't apply.  :(
> 
> What repo is this based on?

Sorry. I have an extra patch that messed up with this. I'll rebase and resend
soon a fixed version.

-- 
With Best Regards,
Andy Shevchenko



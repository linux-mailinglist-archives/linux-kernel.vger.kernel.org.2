Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190F3450297
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhKOKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:39:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:6031 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhKOKjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:39:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="213450968"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="213450968"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 02:36:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="671460856"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 02:36:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmZLL-0071rr-2e;
        Mon, 15 Nov 2021 12:36:07 +0200
Date:   Mon, 15 Nov 2021 12:36:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH v2 1/1] mfd: intel-lpss: Fix too early PM enablement in
 the ACPI ->probe()
Message-ID: <YZI4FnCvAws2FLDA@smile.fi.intel.com>
References: <20211101190008.86473-1-andriy.shevchenko@linux.intel.com>
 <54F23B0A-9DB9-439A-B3BA-E1141703E91D@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54F23B0A-9DB9-439A-B3BA-E1141703E91D@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 05:42:35AM +0000, Aditya Garg wrote:
> > On 02-Nov-2021, at 12:30 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > The runtime PM callback may be called as soon as the runtime PM facility
> > is enabled and activated. It means that ->suspend() may be called before
> > we finish probing the device in the ACPI case. Hence, NULL pointer
> > dereference:
> > 
> >  intel-lpss INT34BA:00: IRQ index 0 not found
> >  BUG: kernel NULL pointer dereference, address: 0000000000000030
> >  ...
> >  Workqueue: pm pm_runtime_work
> >  RIP: 0010:intel_lpss_suspend+0xb/0x40 [intel_lpss]
> > 
> > To fix this, first try to register the device and only after that enable
> > runtime PM facility.
> > 
> > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> > Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
> > Reported-by: Aditya Garg <gargaditya08@live.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Tested-by: Aditya Garg <gargaditya08@live.com>
> > ---
> > v2: added tag (Aditya), returned 0 explicitly at the end of ->probe()

> It works

Thanks for testing again!

Lee, can we have this as a fix material for v5.16-rcX?

-- 
With Best Regards,
Andy Shevchenko



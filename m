Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F959345BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhCWKcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:32:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:65353 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhCWKbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:31:32 -0400
IronPort-SDR: XLWhfbc7hpmMh5uXYyjgFI/NwVtP0qCNAh9DLrVVaaQC3bvRzcCEGl8WAqQ4R7qyJYnG3cttMn
 HAP6CacVFduQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="178013997"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="178013997"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 03:31:31 -0700
IronPort-SDR: sao+WvMsGOPTn2Hd9AC/1S3XYw2MZOrDmssNUZc3q0bPAbFWqq+8GlpN7WSDtbrmM9fVIe2GfN
 6cW4xNtqbiwQ==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="408258631"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 03:31:29 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lOeJr-00EzHw-56; Tue, 23 Mar 2021 12:31:27 +0200
Date:   Tue, 23 Mar 2021 12:31:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH v1 1/5] mfd: intel_quark_i2c_gpio: revert "Constify
 static struct resources"
Message-ID: <YFnDf9A0Vq6cFtPi@smile.fi.intel.com>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
 <20210323091453.GL2916463@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323091453.GL2916463@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:14:53AM +0000, Lee Jones wrote:
> On Tue, 02 Mar 2021, Andy Shevchenko wrote:
> 
> > The structures are used as place holders, so they are modified at run-time.
> > Obviously they may not be constants.
> > 
> >   BUG: unable to handle page fault for address: d0643220
> >   ...
> >   CPU: 0 PID: 110 Comm: modprobe Not tainted 5.11.0+ #1
> >   Hardware name: Intel Corp. QUARK/GalileoGen2, BIOS 0x01000200 01/01/2014
> >   EIP: intel_quark_mfd_probe+0x93/0x1c0 [intel_quark_i2c_gpio]
> > 
> > This partially reverts the commit c4a164f41554d2899bed94bdcc499263f41787b4.
> > 
> > While at it, add a comment to avoid similar changes in the future.
> > 
> > Fixes: c4a164f41554 ("mfd: Constify static struct resources")
> > Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/mfd/intel_quark_i2c_gpio.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Applied to -fixes for testing, thanks.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



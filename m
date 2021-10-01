Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E259641F5CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 21:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355403AbhJATiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 15:38:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:37511 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhJATiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 15:38:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="225209067"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="225209067"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 12:36:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="708908639"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 12:36:14 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWOKJ-007WjZ-IO;
        Fri, 01 Oct 2021 22:36:11 +0300
Date:   Fri, 1 Oct 2021 22:36:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: spi-nor: intel-spi: Add support for Intel
 Ice Lake-N SPI serial flash
Message-ID: <YVdjKzD/SeNkfT5d@smile.fi.intel.com>
References: <20211001171530.15283-1-andriy.shevchenko@linux.intel.com>
 <0D47CDDE-0F9E-4D5D-8524-1D911BF52CEF@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0D47CDDE-0F9E-4D5D-8524-1D911BF52CEF@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 07:21:08PM +0200, Michael Walle wrote:
> Am 1. Oktober 2021 19:15:30 MESZ schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> >Intel Ice Lake-N has the same SPI serial flash controller as Ice Lake-LP.
> >Add Ice Lake-N PCI ID to the driver list of supported devices.
> >
> >The device can be found on MacBookPro16,2 [1].
> >
> >[1]: https://linux-hardware.org/?probe=f1c5cf0c43
> >
> >Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Hi Andy, 
> 
> there is currently a rewrite of this driver (to use spi-mem)
> in progress:
> 
> https://lore.kernel.org/linux-mtd/20210930100719.2176-1-mika.westerberg@linux.intel.com/
> 
> Could you try that series with your hardware? 

It's not mine - can't test myself. I'm helping to enable Linux on it.
But okay, I postpone this till the reworked version will be applied.

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89403356832
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350203AbhDGJkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:40:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:7171 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237543AbhDGJjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:39:42 -0400
IronPort-SDR: DyBse/M1Cr5AyIJdDnV7aXag/z2okBT8ztnZEDEu1kQ7SRQ/XS75bnOM0rejQYaPIhWsqfCdHx
 lef3/6YdtqtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="193310969"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="193310969"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 02:38:44 -0700
IronPort-SDR: FxODBIASr2lF1YeruIMYHWmTcR7zUvk9LZwfr26DnZs/snKilN3T2P4/DQFrXhXpJ8aY2X9FQ+
 TE/gmQqQk2mA==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="458288146"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 02:38:41 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lU4dv-001yYn-6J; Wed, 07 Apr 2021 12:38:35 +0300
Date:   Wed, 7 Apr 2021 12:38:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v1 1/1] driver core: platform: Make
 platform_get_irq_optional() optional
Message-ID: <YG19mxfyHIdZKW/Z@smile.fi.intel.com>
References: <20210331144526.19439-1-andriy.shevchenko@linux.intel.com>
 <20210406192514.GA34677@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406192514.GA34677@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 12:25:14PM -0700, Guenter Roeck wrote:
> On Wed, Mar 31, 2021 at 05:45:26PM +0300, Andy Shevchenko wrote:
> > Currently the platform_get_irq_optional() returns an error code even
> > if IRQ resource sumply has not been found. It prevents caller to be
> > error code agnostic in their error handling.
> > 
> > Now:
> > 	ret = platform_get_irq_optional(...);
> > 	if (ret != -ENXIO)
> > 		return ret; // respect deferred probe
> > 	if (ret > 0)
> > 		...we get an IRQ...
> > 
> > After proposed change:
> > 	ret = platform_get_irq_optional(...);
> > 	if (ret < 0)
> > 		return ret;
> > 	if (ret > 0)
> > 		...we get an IRQ...
> > 
> > Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This patch causes all my "sh" emulations to stall during boot with the
> following repeated error message.
> 
> sh-sci sh-sci.1: Can't allocate rx full IRQ
> 
> Reverting this patch fixes the problem (and the message is gone).
> Bisect log is attached.

I believe it reveals some "interesting" error handling there.
I'm going to propose a solution soon.

Thanks for the report!

-- 
With Best Regards,
Andy Shevchenko



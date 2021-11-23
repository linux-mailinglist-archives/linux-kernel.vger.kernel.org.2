Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3932145A7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhKWQda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:33:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:8892 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233459AbhKWQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:33:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="295862042"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="295862042"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:30:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="571112189"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:30:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpYeK-009prJ-CL;
        Tue, 23 Nov 2021 18:28:04 +0200
Date:   Tue, 23 Nov 2021 18:28:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Subject: Re: [PATCH v2 3/3] soc: fsl: Replace kernel.h with the necessary
 inclusions
Message-ID: <YZ0WlMyS36Gj565C@smile.fi.intel.com>
References: <20211110105952.62013-1-andriy.shevchenko@linux.intel.com>
 <20211110105952.62013-3-andriy.shevchenko@linux.intel.com>
 <YZJExzxJ4j8g6jEY@smile.fi.intel.com>
 <AS8PR04MB8946B4800AE34258F7F2BA688F989@AS8PR04MB8946.eurprd04.prod.outlook.com>
 <YZN7+UlXtJi8/i1L@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZN7+UlXtJi8/i1L@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:38:01AM +0200, Andy Shevchenko wrote:
> On Mon, Nov 15, 2021 at 10:24:36PM +0000, Leo Li wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Monday, November 15, 2021 5:30 AM
> > > On Wed, Nov 10, 2021 at 12:59:52PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > > v2: updated Cc list based on previous changes to MAINTAINERS
> > > 
> > > Any comments on this, please?
> > > 
> > > I really want to decrease amount of kernel.h usage in the common headers.
> > > So others won't copy'n'paste bad example.
> > 
> > There seems to be no problem with the patch although I didn't get time to really compile with it applied.
> > 
> > Will pick them up later after build test.
> 
> Thank you!
> 
> Note, it has two fixes against MAINTAINERS which may be sent, I believe,
> sooner than later to Linus.

Any new so far?

-- 
With Best Regards,
Andy Shevchenko



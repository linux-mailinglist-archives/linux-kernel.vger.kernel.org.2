Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1BB41F4ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355782AbhJASYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:24:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:58179 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355596AbhJASYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:24:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205013879"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="205013879"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 11:22:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="565196707"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 11:22:28 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWNAv-007Vpz-HI;
        Fri, 01 Oct 2021 21:22:25 +0300
Date:   Fri, 1 Oct 2021 21:22:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Add support for MacBookPro16,2 UART
Message-ID: <YVdR4bdpr9/E+GNf@smile.fi.intel.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
 <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
 <YVdP9PwNrjmKxKac@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVdP9PwNrjmKxKac@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 07:14:12PM +0100, Lee Jones wrote:
> On Fri, 01 Oct 2021, Andy Shevchenko wrote:
> > On Fri, Oct 01, 2021 at 08:51:46AM +0000, Orlando Chamberlain wrote:

...

> > > +	/* MacBookPro16,2 */
> > 
> > Use
> > 
> > 	/* ICL-N */
> > 
> > here.
> 
> Why is that?

It's a standard way of representing PCH/SoC in the comments in this driver:
- MacBookPro16,2 is not a name of the PCH/SoC
- MacBookPro16,2 is possible not the solely hardware of this chip

Why not to mention this name in the commit message?

-- 
With Best Regards,
Andy Shevchenko



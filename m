Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18B843B824
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbhJZR3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:29:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:35456 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236432AbhJZR3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:29:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="230233392"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="230233392"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 09:33:31 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="529285751"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 09:33:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfPNu-001BJc-6r;
        Tue, 26 Oct 2021 19:33:10 +0300
Date:   Tue, 26 Oct 2021 19:33:09 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     YE Chengfeng <cyeaa@connect.ust.hk>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: suspected null-pointer-reference problem for to_swnode
Message-ID: <YXgtxXNIyJ8+G4Oy@smile.fi.intel.com>
References: <TYCP286MB11888DAE6D94FAE6A9F1CB438A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <YXbeF58NlV1o5tcG@smile.fi.intel.com>
 <YXgavSb+/NoGclFS@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXgavSb+/NoGclFS@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 06:11:57PM +0300, Sakari Ailus wrote:
> On Mon, Oct 25, 2021 at 07:40:55PM +0300, andriy.shevchenko@linux.intel.com wrote:
> > On Mon, Oct 25, 2021 at 02:03:51PM +0000, YE Chengfeng wrote:
> > > Hi, 
> > > 
> > > https://github.com/torvalds/linux/blob/master/drivers/base/swnode.c#L405
> > > 
> > > We notice that the return pointer of to_swnode is null check in some case, while in some case is not. For example, at line 416, the return pointer is null-check, but in line 405 is not. We want to know whether it would be a potential null pointer dereference problem, in the case that null-check is missing.
> > > 
> > > This problem is detected by our experimental static analysis tool, we are not familiar with the source code and it could just be a false positive. We send this email in case this is a real problem. Would you like to spare some time to have a look at it?
> > 
> > Thank you for the interest to our code!
> > 
> > Line #405 refers to software node operations and it means it won't be ever
> > called if there is no swnode behind it, means it's backed with properties.
> > If you think it will be a NULL pointer there, please describe in detail
> > (with a traceback included) when and how it happens, because such bugs are
> > serious.
> > 
> > Line #416 refers to the same stage when options are defined and we know we
> > have been called against swnode. Seems to me like a dead code brought from
> > day 1 by the commit bc0500c1e43d ("device property: Add fwnode_get_name
> > for returning the name of a node").
> > 
> > Sakari?
> 
> Yeah, the check could be removed.

I have just sent a patch.

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272253C5DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhGLOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:00:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:1072 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234125AbhGLOAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:00:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="231774443"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="231774443"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 06:57:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="502176636"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 06:57:40 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m2wRD-00CFZc-3k; Mon, 12 Jul 2021 16:57:35 +0300
Date:   Mon, 12 Jul 2021 16:57:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Gordeev <lasaine@lvk.cs.msu.su>
Cc:     linux-kernel@vger.kernel.org,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH v1 1/1] pps: generators: pps_gen_parport: Switch to use
 module_parport_driver()
Message-ID: <YOxKT9FnFPd+491W@smile.fi.intel.com>
References: <20210616143121.46059-1-andriy.shevchenko@linux.intel.com>
 <YMoOVrJ1ETVhRr4F@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMoOVrJ1ETVhRr4F@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 04:44:38PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 16, 2021 at 05:31:21PM +0300, Andy Shevchenko wrote:
> > Switch to use module_parport_driver() to reduce boilerplate code.

> > +	pr_info("hrtimer avg error is %ldns\n", hrtimer_error);
> 
> Why is this line needed?  When drivers work properly, they are quiet.
> 
> I know the existing code has it, no reason it needs to stay here, that's
> why we created these macros, to remove the ability for drivers to be
> printing junk like this that they do not need to be printing.

Seems the original authors keeps silent. What do you suggest in this case?
Remove the line and resubmit?

-- 
With Best Regards,
Andy Shevchenko



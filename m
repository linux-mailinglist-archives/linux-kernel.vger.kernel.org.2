Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02F43E6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhJ1RDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:03:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:61611 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhJ1RD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:03:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="316664366"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="316664366"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 10:01:00 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="597876341"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 10:00:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mg8lc-001oic-J9;
        Thu, 28 Oct 2021 20:00:40 +0300
Date:   Thu, 28 Oct 2021 20:00:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] delay: Replace kernel.h with the necessary
 inclusions
Message-ID: <YXrXOLgjCNOUpsPK@smile.fi.intel.com>
References: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
 <20211028153055.GA440866@roeck-us.net>
 <YXrIlT+2llnwgRpj@smile.fi.intel.com>
 <20211028162810.GB470146@roeck-us.net>
 <YXrUu8swbM3BL/4C@smile.fi.intel.com>
 <YXrVO57eLx8gkWHW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXrVO57eLx8gkWHW@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 07:52:12PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 28, 2021 at 07:50:03PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 28, 2021 at 09:28:10AM -0700, Guenter Roeck wrote:
> > > On Thu, Oct 28, 2021 at 06:58:13PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > Build results:
> > > 	total: 153 pass: 115 fail: 38
> 
> > > Qemu test results:
> > > 	total: 480 pass: 315 fail: 165
> 
> FWIW, most of them on the first glance due to something like below
> 
> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
> 7 | #include <errno.h>
>   |          ^~~~~~~~~

I have briefly looked at the logs (stdio) and potentially my patch might brake
h8300 and parisc, the rest as pointed above (have no idea if my patch anyhow
may be involved to that).

Hence, will sent only fix for what you bisected.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



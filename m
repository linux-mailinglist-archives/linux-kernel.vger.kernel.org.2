Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED72243E6A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhJ1QzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:55:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:37751 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhJ1QzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:55:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="254034844"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="254034844"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 09:52:32 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498482973"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 09:52:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mg8dQ-001oQS-6o;
        Thu, 28 Oct 2021 19:52:12 +0300
Date:   Thu, 28 Oct 2021 19:52:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] delay: Replace kernel.h with the necessary
 inclusions
Message-ID: <YXrVO57eLx8gkWHW@smile.fi.intel.com>
References: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
 <20211028153055.GA440866@roeck-us.net>
 <YXrIlT+2llnwgRpj@smile.fi.intel.com>
 <20211028162810.GB470146@roeck-us.net>
 <YXrUu8swbM3BL/4C@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXrUu8swbM3BL/4C@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 07:50:03PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 28, 2021 at 09:28:10AM -0700, Guenter Roeck wrote:
> > On Thu, Oct 28, 2021 at 06:58:13PM +0300, Andy Shevchenko wrote:

...

> > Build results:
> > 	total: 153 pass: 115 fail: 38

> > Qemu test results:
> > 	total: 480 pass: 315 fail: 165

FWIW, most of them on the first glance due to something like below

<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
7 | #include <errno.h>
  |          ^~~~~~~~~

-- 
With Best Regards,
Andy Shevchenko



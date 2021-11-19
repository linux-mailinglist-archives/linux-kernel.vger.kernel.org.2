Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC245726A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhKSQMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:12:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:31519 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232454AbhKSQMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:12:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234674970"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="234674970"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 08:07:40 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="495920662"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 08:07:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mo6QH-008aVI-6l;
        Fri, 19 Nov 2021 18:07:33 +0200
Date:   Fri, 19 Nov 2021 18:07:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
Message-ID: <YZfLxMozjQypfbsv@smile.fi.intel.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
 <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
 <YZfEHZa3f5MXeqoH@smile.fi.intel.com>
 <f1a90f53-060e-2960-3926-e30b44a1be28@gmail.com>
 <4a39bc52-53ff-ca79-8d34-4310b2894f43@gmail.com>
 <YZfHi0GXk129wmQE@smile.fi.intel.com>
 <04bd3abf-44e3-ab2d-7226-b12ff951cd26@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04bd3abf-44e3-ab2d-7226-b12ff951cd26@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 04:52:22PM +0100, Alejandro Colomar (man-pages) wrote:
> On 11/19/21 16:49, Andy Shevchenko wrote:
> >>
> >> I think the problem was in
> >> <linux/memberof.h> requiring NULL from <linux/stddef.h>
> >> <linux/stddef.h> requiring memberof() from <linux/memberof.h>
> >> or something like that.
> > 
> > There is no memberof.h in the kernel. Something is done wrongly on your series.
> 
> memberof.h was my first addition in this patch series.
> 
> Since I replaced (((T *)0)->m) by memberof(),
> and that construction is used in <linux/stddef.h>
> for example for sizeof_field(),
> I included <linux/memberof.h> from <linux/stddef.h>.

Then why you need that header to be separated? What circular dependency
it resolves? In case you are wondering about my activity in the area,
the problematic piece is that headers including headers which includes
the first headers again.

Try to inline bitmap_alloc() and you will get what I'm struggling with.
The biggest (as far as I see now) part of it is the mess called "kernel.h"
that is included by other headers. And my idea to get rid of that.

Btw, Arnd gave actually a good suggestion what to look at.

-- 
With Best Regards,
Andy Shevchenko



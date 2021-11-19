Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCE645721D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhKSPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:52:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:27637 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhKSPwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:52:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234264295"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="234264295"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 07:49:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="507943302"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 07:49:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mo68p-008aGa-Rz;
        Fri, 19 Nov 2021 17:49:31 +0200
Date:   Fri, 19 Nov 2021 17:49:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
Message-ID: <YZfHi0GXk129wmQE@smile.fi.intel.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
 <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
 <YZfEHZa3f5MXeqoH@smile.fi.intel.com>
 <f1a90f53-060e-2960-3926-e30b44a1be28@gmail.com>
 <4a39bc52-53ff-ca79-8d34-4310b2894f43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a39bc52-53ff-ca79-8d34-4310b2894f43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 04:43:04PM +0100, Alejandro Colomar (man-pages) wrote:
> On 11/19/21 16:38, Alejandro Colomar (man-pages) wrote:
> > On 11/19/21 16:34, Andy Shevchenko wrote:
> >> On Fri, Nov 19, 2021 at 04:06:27PM +0100, Alejandro Colomar (man-pages) wrote:
> >>> Yes, I would like to untangle the dependencies.
> >>>
> >>> The main reason I started doing this splitting
> >>> is because I wouldn't be able to include
> >>> <linux/stddef.h> in some headers,
> >>> because it pulled too much stuff that broke unrelated things.
> >>>
> >>> So that's why I started from there.
> >>>
> >>> I for example would like to get NULL in memberof()
> >>> without puling anything else,
> >>> so <linux/NULL.h> makes sense for that.
> >>
> >> I don't believe that the code that uses NULL won't include types.h.
> > 
> > I'm not sure about the error I got (I didn't write it down),
> > but I got a compilation error.
> > That's why I split NULL.
> 
> Now that I think about it twice,
> since I'm rewriting these changes from scratch,
> I think the error might have been
> not due to pulling too much stuff,
> but due to circular dependencies.
> 
> Having more granularity
> helps precisely define the dependencies.
> 
> I think the problem was in
> <linux/memberof.h> requiring NULL from <linux/stddef.h>
> <linux/stddef.h> requiring memberof() from <linux/memberof.h>
> or something like that.

There is no memberof.h in the kernel. Something is done wrongly on your series.

-- 
With Best Regards,
Andy Shevchenko



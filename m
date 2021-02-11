Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B3A318C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhBKNaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:30:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:43014 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhBKNGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:06:46 -0500
IronPort-SDR: 55ObIwXXP7Ce+w74u2c3hDjZHO3GcWqkMcBtUfKazDIngzn3bigOULlPiVf33d343Cd0zZqqMH
 iLmcAyNdWchw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="182369696"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="182369696"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:04:51 -0800
IronPort-SDR: xmlb9NqFgliArX/nIyV1XOP5dZrVm+iMz+ouoHhFVFin0OJO3ifO98hiQVCt3vuiEQ6czA0zcz
 eIuL75rTI65g==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="437106463"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 05:04:49 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lABeJ-004E5z-3c; Thu, 11 Feb 2021 15:04:47 +0200
Date:   Thu, 11 Feb 2021 15:04:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-test-robot <lkp@intel.com>
Subject: Re: [PATCH] platform/surface: aggregator: Fix access of unaligned
 value
Message-ID: <YCUrb+yAdBCagxvv@smile.fi.intel.com>
References: <20210210230411.1938660-1-luzmaximilian@gmail.com>
 <YCUFgF9gmyeO+796@smile.fi.intel.com>
 <b68b7547-5be4-c823-d015-febb5e7f84e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b68b7547-5be4-c823-d015-febb5e7f84e9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:58:48PM +0100, Maximilian Luz wrote:
> On 2/11/21 11:22 AM, Andy Shevchenko wrote:
> > On Thu, Feb 11, 2021 at 12:04:11AM +0100, Maximilian Luz wrote:
> > > The raw message frame length is unaligned and explicitly marked as
> > > little endian. It should not be accessed without the appropriatte
> > > accessor functions. Fix this.

...

> > Also it's possible to annotate temporary variable and use it, but it seems not
> > worth to do.
> 
> Now that you mention it, we already have the correct frame length in
> payload.len. Let me draft up a new patch with that.

Good!

> > Side question: Do you think the below is correct (& operator)?
> > 
> >          sp.len = get_unaligned_le16(&((struct ssh_frame *)sf.ptr)->len);
> > 
> > To me seems like you take an address to len member rather its value.
> 
> That's the point though, no? The signature is
> 
>         u16 get_unaligned_le16(const void *p)
> 
> so we do want a pointer to the len member. So I believe that is correct.

Indeed. I messed up with le16_to_cpu().

-- 
With Best Regards,
Andy Shevchenko



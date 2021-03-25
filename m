Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF89B349998
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCYShf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:37:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:21623 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhCYShQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:37:16 -0400
IronPort-SDR: gA/ySKX/KYJRZiyjM2SWsPWa08msIP+NSDbn2ifCZ0hrkYVjsJ6bQ/HQWvztNHdI2sXSNtM7VK
 TPugJPGSFmzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="178550463"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="178550463"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 11:37:15 -0700
IronPort-SDR: 3CgO15C7qfxZn+8LJGWfk+DO7khppUgo0Ok7fuSBLo4c5OE6Lo8vMn/EFsvuhIXxF8yWtd53sD
 /uSwhBFnJ80Q==
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="409501185"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 11:37:14 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lPUr1-00G8Ku-Bb; Thu, 25 Mar 2021 20:37:11 +0200
Date:   Thu, 25 Mar 2021 20:37:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] MFD fixes for v5.12
Message-ID: <YFzYVxZQ9WWkhfRA@smile.fi.intel.com>
References: <20210325163358.GU2916463@dell>
 <CAHk-=wjJxziChniE2zmkbFxEpizYFg=XaKyq_O_Rfh_Lr_idkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJxziChniE2zmkbFxEpizYFg=XaKyq_O_Rfh_Lr_idkw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 11:23:06AM -0700, Linus Torvalds wrote:
> On Thu, Mar 25, 2021 at 9:34 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> >    - Unconstify editable placeholder structures
> 
> Hmm. This does show a real issue with that gpio driver.
> 
> It does garbage things:
> 
>   static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
>   {
>         struct dwapb_platform_data *pdata;
>         struct resource *res = (struct resource *)cell->resources;
> 
> where that cast is exactly because "cell->resources" _is_ const, and
> the driver violates that.
> 
> This horrible mis-use of a const pointer is why the original patch
> that got reverted didn't cause build-time warnings.
> 
> Honestly, I think the right thing to do is to get rid of that cast, and do
> 
>         struct resource *res = intel_quark_mfd_cells;
> 
> instead, so that you clearly edit somethign that isn't const, and so
> that the compiler would have warned about the whole constification in
> the first place.
> 
> This broken pattern shows up for both intel_quark_i2c_setup() and
> intel_quark_gpio_setup().
> 
> I've pulled this, but I really want this kind of "take a const pointer
> and violate it" crap removed. It is *only* correct if you know exactly
> which pointer it is, and then you should just have used that original
> pointer in the first place (ie use that intel_quark_mfd_cells[]
> directly like suggested above).

Thanks for pointing this out! I'll take it in my TODO list.

Hmm... I missed the above b/c I have seen the pattern of supplying non-const
data structures via .driver_data field and thought that here is something
similar without looking into the actual approach.

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DFF38C628
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhEUMEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:04:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:33813 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhEUMEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:04:00 -0400
IronPort-SDR: X/buWrz5u4i3jCj29A2ch7GP900Z9J2JB6Nlwm6QSS84JuswF3CEB9JetDbz7Ryh4VBc2KMl8S
 LQoGBzURDG4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="181078792"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="181078792"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 05:02:15 -0700
IronPort-SDR: KV+7S5Plh5E5Qs4JvsHLaF2a4JpNQYVNUTBaLNLl557BLxepRNe+zNWuORARXlRfrW6cbbgPIz
 LauFKMTKn2xA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="474496344"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 05:02:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lk3r1-00Dhc5-6S; Fri, 21 May 2021 15:02:11 +0300
Date:   Fri, 21 May 2021 15:02:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] kernel.h: split out panic and oops helpers (ia64
 fix)
Message-ID: <YKehQyAn7rgXL9Bb@smile.fi.intel.com>
References: <20210520130557.55277-1-andriy.shevchenko@linux.intel.com>
 <f2420178-53d7-a1e4-eea7-5e1773835411@physik.fu-berlin.de>
 <YKZhcKqomWxH3eph@smile.fi.intel.com>
 <41bbace7-1b09-8464-a082-e4152f07fdb4@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41bbace7-1b09-8464-a082-e4152f07fdb4@physik.fu-berlin.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 09:24:08AM +0200, John Paul Adrian Glaubitz wrote:
> On 5/20/21 3:17 PM, Andy Shevchenko wrote:
> > On Thu, May 20, 2021 at 03:12:24PM +0200, John Paul Adrian Glaubitz wrote:
> >> On 5/20/21 3:05 PM, Andy Shevchenko wrote:
> >>> Note, this patch is untested. I have no ia64 compiler at hand.
> > 
> >> I can test it later today.
> > 
> > Appreciate it, thanks!
> > 
> > This is against Linux Next (where Andrew's patches are sitting for a while).
> 
> I just pulled linux-next and was able to build a kernel for my RX-2600 without any
> problems. Since your patch is already in the tree, I assume it's correct.
> 
> Do you want me to test anything else? I can test-boot the kernel later, but I want
> to avoid that now since I don't want to turn on the noisy server while at home :-)

Nothing is required anymore, thanks for your help with testing!

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9A03F29F0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbhHTKMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:12:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:30224 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238956AbhHTKMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:12:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216478219"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="216478219"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 03:12:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="512475401"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 03:12:09 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mH1VL-00Bmkt-8z; Fri, 20 Aug 2021 13:12:03 +0300
Date:   Fri, 20 Aug 2021 13:12:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kate Hsuan <hpa@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Dell.Client.Kernel@dell.com, Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
Subject: Re: [PATCH v4 00/21] platform/x86: Intel platform driver code
 movement
Message-ID: <YR9/83LozDtedLKZ@smile.fi.intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
 <b152a497-9cbe-83fa-e04a-f5d2a5b875f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b152a497-9cbe-83fa-e04a-f5d2a5b875f3@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 08:46:14PM +0200, Hans de Goede wrote:
> On 8/19/21 6:37 PM, Andy Shevchenko wrote:
> > This is v4 of the Intel drivers move on in the source tree.
> > v3 has been done by Kate:
> > https://lore.kernel.org/platform-driver-x86/20210819033001.20136-1-hpa@redhat.com/
> > 
> > I have taken the initial set from review-hans branch and removed Hans' SoB
> > along with Link, while leaving others' tags.
> > 
> > Changelog v4:
> > - spelled fully the driver names in the commit messages
> > - fixed SCU *.ko module names
> 
> Actually I checked this during review and
> CONFIG_INTEL_SCU_IPC, CONFIG_INTEL_SCU_PCI and CONFIG_INTEL_SCU_WDT
> are booleans, iow if enabled they are always builtin so the
> drivers/platform/x86/intel/scu/Makefile from v3 was correct.
> 
> Since the v3 Makefile is more simple I prefer that version,
> but if you prefer to keep the v4 version that is fine too.

I prefer mine, but we need to fix what kbuild bot complained about.

> > - dropped extra prefix in PMC files
> > - dropped stray changes within the series
> > - removed confusing comments in Makefile and Kconfig files
> > - embedded a few of Kconfig improvements here and there (ordering, spelling)
> > - split miscellaneous group
> > - added a patch to fix kernel doc issue in SCU IPC code
> 
> Thanks, I've not (re)reviewed things, but this all sounds good.
> 
> > So, I have noticed the report about SCU and taking into account IPS
> > header deferred move, I think those two should be excluded from the
> > series and sent after rc1, it will also eliminate trampoline move for
> > IPS header, since we may send one patch which includes DRM changes.
> > 
> > Hans, what do you think?
> 
> Fixing the SCU thing will require coordination with / an 
> ack from the MFD maintainer (Lee) so yeah dropping that for
> now and doing the SCU move next cycle is probably the best.
> 
> Dropping the IPS move for now is fine with me too.
> 
> Can you send a v5 with those 2 patches dropped ?

Yes.

> We can still fix the SCU doc, just in the old place...

And yes, definitely.

-- 
With Best Regards,
Andy Shevchenko



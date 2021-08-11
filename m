Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E670A3E939A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhHKOXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:23:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:64220 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232251AbhHKOXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:23:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="215158615"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="215158615"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:23:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="445941829"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:23:12 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mDp8L-0086Xg-AU; Wed, 11 Aug 2021 17:23:05 +0300
Date:   Wed, 11 Aug 2021 17:23:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 1/2] iommu/vt-d: Move intel_iommu_ops to header file
Message-ID: <YRPdSX8fQ+z+EehZ@smile.fi.intel.com>
References: <20210729163538.40101-1-andriy.shevchenko@linux.intel.com>
 <3c7663db-5b1e-3e00-3ff1-381c7a107ac9@linux.intel.com>
 <YQOyzka9VDJU3NhU@smile.fi.intel.com>
 <17a2b3f2-747d-2798-7fea-5846eec0b1fe@linux.intel.com>
 <YRPVfES0aTbfaHES@smile.fi.intel.com>
 <f0f98e37-2486-fe79-7950-0a117a59b303@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f98e37-2486-fe79-7950-0a117a59b303@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:02:48PM +0800, Lu Baolu wrote:
> On 2021/8/11 21:49, Andy Shevchenko wrote:
> > On Fri, Jul 30, 2021 at 09:01:41PM +0800, Lu Baolu wrote:
> > > On 2021/7/30 16:05, Andy Shevchenko wrote:
> > > > On Fri, Jul 30, 2021 at 10:20:08AM +0800, Lu Baolu wrote:
> > > > > On 7/30/21 12:35 AM, Andy Shevchenko wrote:
> > > > > > Compiler is not happy about hidden declaration of intel_iommu_ops.
> > > > > > 
> > > > > > .../drivers/iommu/intel/iommu.c:414:24: warning: symbol 'intel_iommu_ops' was not declared. Should it be static?
> > > > > > 
> > > > > > Move declaration to header file to make compiler happy.
> > > > > 
> > > > > Thanks for the cleanup. Sharing data structures between different files
> > > > > doesn't seem to be a good design. How about adding a helper so that the
> > > > > intel_iommu_ops could be a static one?
> > > > 
> > > > Whatever suits the purpose.
> > > > Can you apply patch 2 of this series, please?
> > > 
> > > Yes, I will. Thanks!
> > 
> > Gentle reminder.
> 
> Thanks. Normally I will queue the vt-d patches to Joerg in the rc6 week.

I see, but don't we need to have them in Linux Next for a few weeks for
testing? Perhaps you need to add your tree to be integrated in the Linux Next?

-- 
With Best Regards,
Andy Shevchenko



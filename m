Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C9E356D8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347432AbhDGNlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:41:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:8953 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230421AbhDGNlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:41:42 -0400
IronPort-SDR: rDruxvMfluMc+J63Ic6CPFcpC206KMQKvMvATn+mu6j89abqnx14p63hmC/roq/k2PJohbZ2wx
 1cEPMR6mkGxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="191146601"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="191146601"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 06:41:31 -0700
IronPort-SDR: Ym/WIw/u+om1BccCmDCT8mmslgfVHwobSPr5hPOR6wOXsyY499r0BNEpv8KO3Afc5cSBaDc/YX
 qjpLJOE8lTjQ==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="448254462"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 06:41:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lU8Qv-0021Qx-BN; Wed, 07 Apr 2021 16:41:25 +0300
Date:   Wed, 7 Apr 2021 16:41:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v1 1/1] drm/i915: Include only needed headers in ascii85.h
Message-ID: <YG22hduvvsEB3JcM@smile.fi.intel.com>
References: <20210407122337.77493-1-andriy.shevchenko@linux.intel.com>
 <87h7kijm8i.fsf@intel.com>
 <YG22OhNg3iQ8DFXW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG22OhNg3iQ8DFXW@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:40:10PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 07, 2021 at 03:46:37PM +0300, Jani Nikula wrote:
> > On Wed, 07 Apr 2021, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > The ascii85.h is user of exactly two headers, i.e. math.h and types.h.
> > > There is no need to carry on entire kernel.h.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > That's hardly drm/i915 specific!
> 
> It was originated from i915!
> 
> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> Thanks!
> 
> > But who's going to pick it up and, hopefully, change the subject prefix
> > to ascii85 or something?
> 
> It's drm specific. Should I leave drm and resend? Or what is the general rule
> for drm misc changes?

Since the topic comes up about drm misc, can somebody approve push access from
me to that?

https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/311

-- 
With Best Regards,
Andy Shevchenko



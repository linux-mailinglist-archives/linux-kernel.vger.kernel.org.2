Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E5B3ACB7B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhFRM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:58:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:60458 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhFRM6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:58:15 -0400
IronPort-SDR: 3MqafRiEyoXZYhdvQRByKK6N52EN57zHNwiStFky0QNst0GVQ2HHtPqElZw6ZKjs/VhbSjfII5
 1KC7pcBfJxiA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206366657"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="206366657"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 05:56:06 -0700
IronPort-SDR: 4P7byXJYLPX3xGe792LQTHviKnXOIiuP/3ACKbdB1fNDmNHQIDgBFE9AdgeL6WJF5NQz1G0S0S
 79pUnwbKl55Q==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="555568962"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 05:56:04 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1luE2T-003b6p-Ck; Fri, 18 Jun 2021 15:56:01 +0300
Date:   Fri, 18 Jun 2021 15:56:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>
Subject: Re: [PATCH v1 2/4] platform/x86: intel_skl_int3472: Fix dependencies
 (drop CLKDEV_LOOKUP)
Message-ID: <YMyX4dxscWirfsBj@smile.fi.intel.com>
References: <20210617183031.70685-1-andriy.shevchenko@linux.intel.com>
 <20210617183031.70685-2-andriy.shevchenko@linux.intel.com>
 <c3aec3b4-1ba1-6442-fbed-57a16febde68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3aec3b4-1ba1-6442-fbed-57a16febde68@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:50:36PM +0100, Daniel Scally wrote:
> Hi Andy
> 
> On 17/06/2021 19:30, Andy Shevchenko wrote:
> > Besides the fact that COMMON_CLK selects CLKDEV_LOOKUP
> 
> 
> So it does - thanks
> 
> > , the latter
> > is going to be removed from clock framework.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> 
> Reviewed-by: Daniel Scally <djrscally@gmail.com>

Thanks!
I have sent v2 with more patches added (twice bigger than this).
Would you be able to test them?

-- 
With Best Regards,
Andy Shevchenko



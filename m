Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC27F3DF574
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhHCTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:21:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:6860 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239475AbhHCTV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:21:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="200931592"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="200931592"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 12:21:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="667346964"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 12:21:44 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mAzys-004qDK-DC; Tue, 03 Aug 2021 22:21:38 +0300
Date:   Tue, 3 Aug 2021 22:21:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>
Subject: Re: [PATCH v1 1/1] platform/surface: aggregator: Ouse y instead of
 objs in Makefile
Message-ID: <YQmXQlZqoUCHhSdn@smile.fi.intel.com>
References: <20210803175000.72880-1-andriy.shevchenko@linux.intel.com>
 <d8d1837a-583b-3926-5057-755acc84a5c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8d1837a-583b-3926-5057-755acc84a5c9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 08:40:10PM +0200, Maximilian Luz wrote:
> On 8/3/21 7:50 PM, Andy Shevchenko wrote:
> > The 'objs' is for user space tools, for the kernel modules
> > we should use 'y'.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you! I was previously not aware of that distinction. Two small
> notes:
> 
>  - There is a typo in the subject line.
>  - With that change, the ifeq could be placed in-line (see note below).

Will address both.

> All in all looks good to me (assuming the typo gets fixed).
> 
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



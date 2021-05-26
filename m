Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422103911F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhEZIIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:08:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:38676 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhEZIIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:08:12 -0400
IronPort-SDR: YWOSOQ+s9sDXUdBXnXTz369IirxnrHwx5u8C8V1IuODkYlAVBRpgdw5CbemGxxyxr4PvS07sG7
 h/ZMSsprcKVA==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="266303758"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="266303758"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 01:06:39 -0700
IronPort-SDR: AKp4u7klHy2SEl3B4PXI4gf/JvN3+FpLkRBumcOrpPCnYyIC1HFrhqzphZRmydM/uWFzYICxID
 yKa4kE0cqHEQ==
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="436039144"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 01:06:37 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1lloYk-00Ekeu-Ic; Wed, 26 May 2021 11:06:34 +0300
Date:   Wed, 26 May 2021 11:06:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andy@kernel.org,
        akpm@linux-foundation.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>,
        Yiyuan Guo <yguoaz@gmail.com>
Subject: Re: [PATCH v3 1/2] lib/math/rational.c: Fix divide by zero
Message-ID: <YK4BiteKybO2qGHq@smile.fi.intel.com>
References: <20210525233519.343068-1-tpiepho@gmail.com>
 <YK4BDmPDuXfxEDn7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK4BDmPDuXfxEDn7@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 11:04:30AM +0300, Andy Shevchenko wrote:
> On Tue, May 25, 2021 at 04:35:18PM -0700, Trent Piepho wrote:
> > If the input is out of the range of the allowed values, either larger
> > than the largest value or closer to zero than the smallest non-zero
> > allowed value, then a division by zero would occur.
> > 
> > In the case of input too large, the division by zero will occur on the
> > first iteration.  The best result (largest allowed value) will be found
> > by always choosing the semi-convergent and excluding the denominator
> > based limit when finding it.
> > 
> > In the case of the input too small, the division by zero will occur on
> > the second iteration.  The numerator based semi-convergent should not be
> > calculated to avoid the division by zero.  But the semi-convergent vs
> > previous convergent test is still needed, which effectively chooses
> > between 0 (the previous convergent) vs the smallest allowed fraction
> > (best semi-convergent) as the result.
> 
> What has been changed that you haven't applied my Rb tag?

Note, the `b4` tool can easily collect them for you from previous thread.

-- 
With Best Regards,
Andy Shevchenko



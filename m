Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F33911F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhEZIHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:07:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:55602 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232918AbhEZIHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:07:17 -0400
IronPort-SDR: 1m3ymH8wRRpx/2QdtZqjK+Apxe9bZduCy1W+lx6hoPOaG1Tg8eAH90SN0cq0jZe87XWAB2eCyV
 LEAvV5udi3Aw==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="200508127"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="200508127"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 01:04:35 -0700
IronPort-SDR: RCuBtDICtBHu9bpHTRoSxBjSVwL8/TUojpYy2FvmbgZwnvxHDDbjgGyb2500tnnTH+oiMLL7gW
 /bfKygtCcI6g==
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="414370555"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 01:04:33 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1lloWk-00Ekdp-AQ; Wed, 26 May 2021 11:04:30 +0300
Date:   Wed, 26 May 2021 11:04:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Trent Piepho <tpiepho@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andy@kernel.org,
        akpm@linux-foundation.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>,
        Yiyuan Guo <yguoaz@gmail.com>
Subject: Re: [PATCH v3 1/2] lib/math/rational.c: Fix divide by zero
Message-ID: <YK4BDmPDuXfxEDn7@smile.fi.intel.com>
References: <20210525233519.343068-1-tpiepho@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525233519.343068-1-tpiepho@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 04:35:18PM -0700, Trent Piepho wrote:
> If the input is out of the range of the allowed values, either larger
> than the largest value or closer to zero than the smallest non-zero
> allowed value, then a division by zero would occur.
> 
> In the case of input too large, the division by zero will occur on the
> first iteration.  The best result (largest allowed value) will be found
> by always choosing the semi-convergent and excluding the denominator
> based limit when finding it.
> 
> In the case of the input too small, the division by zero will occur on
> the second iteration.  The numerator based semi-convergent should not be
> calculated to avoid the division by zero.  But the semi-convergent vs
> previous convergent test is still needed, which effectively chooses
> between 0 (the previous convergent) vs the smallest allowed fraction
> (best semi-convergent) as the result.

What has been changed that you haven't applied my Rb tag?

-- 
With Best Regards,
Andy Shevchenko



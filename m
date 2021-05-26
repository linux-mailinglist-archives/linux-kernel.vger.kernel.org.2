Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919233911B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhEZIDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:03:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:38736 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231211AbhEZICd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:02:33 -0400
IronPort-SDR: l/gVGa17sM5qa3ga4hhBvy0b2nCYooC8+e8k8zPk3oEP6+N5feC+DJ6XGD3KkSTs3TD9V/FZUI
 M4z+3m+PzNnQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202421709"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="202421709"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 01:00:58 -0700
IronPort-SDR: ZgaIrmckF0JcL73H8IeXBynjPAIxVQgl3TYj/R0jJtGJy0Bs0pKADSeLxmbBjwd79XD8FTKvW5
 cRKL8dm/2pJw==
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="547101047"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 01:00:55 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1lloTD-00Ekbj-ML; Wed, 26 May 2021 11:00:51 +0300
Date:   Wed, 26 May 2021 11:00:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Trent Piepho <tpiepho@gmail.com>, linux-kernel@vger.kernel.org,
        andy@kernel.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>,
        Yiyuan Guo <yguoaz@gmail.com>
Subject: Re: [PATCH v2 1/2] lib/math/rational.c: Fix divide by zero
Message-ID: <YK4AM3J6W44GTKTA@smile.fi.intel.com>
References: <20210525144250.214670-1-tpiepho@gmail.com>
 <20210525144654.e41cb942a2804d08127ad48f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525144654.e41cb942a2804d08127ad48f@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 02:46:54PM -0700, Andrew Morton wrote:
> On Tue, 25 May 2021 07:42:49 -0700 Trent Piepho <tpiepho@gmail.com> wrote:
> 
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
> Is there any known userspace workload which can trigger this?

Doubtfully.

What I can imagine (which also can be impossible) is to try on some UART
drivers that use this algorithm to ask crazy baud rates (much higher than the
clock). Sounds like a theoretical possibility is present, but practically
no one except bad hackers would do that (requires a special code to be written
in user space to select BOTHER with an arbitrary input in termios).

> IOW, should it be backported into -stable and fast-tracked into 5.13 or
> will a 5.14 merge suffice?

-- 
With Best Regards,
Andy Shevchenko



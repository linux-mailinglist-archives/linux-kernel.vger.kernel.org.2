Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328C736412C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 14:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhDSMCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 08:02:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:30078 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhDSMCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:02:06 -0400
IronPort-SDR: 37+PFCbMHU6rGzXREAmkEwuJA1VOULdSvvx8kGEjl4rJTATa7slOYAdXQFRE8bchhGYvN+7FHq
 /OL0v/1NNHzQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="175419055"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="175419055"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 05:01:36 -0700
IronPort-SDR: ++WMBT+IG89dr/8Un5PoXtGDoUc+rRZrGd7ee2yOatMloeZMsnARRHiG4d5Wo4xkj/1RgfR8kj
 tUZ70kS/gXxg==
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="534113285"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 05:01:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lYSaq-005UAg-QV; Mon, 19 Apr 2021 15:01:32 +0300
Date:   Mon, 19 Apr 2021 15:01:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] tee: optee: Provide special parameter field for
 UUID values
Message-ID: <YH1xHDbFyJ1URYYV@smile.fi.intel.com>
References: <20210415145857.34183-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44FWJiL1yzHR0jwL2VJG_4t_O6An48v47gORitcaahwmYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44FWJiL1yzHR0jwL2VJG_4t_O6An48v47gORitcaahwmYw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 01:35:51PM +0200, Jens Wiklander wrote:
> On Thu, Apr 15, 2021 at 4:58 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

Thanks for review, my answer below.

> >                 struct optee_msg_param_tmem tmem;
> >                 struct optee_msg_param_rmem rmem;
> >                 struct optee_msg_param_value value;
> > +               uuid_t uuid;
> 
> It's nice to get rid of the cast above, but I'm not that keen on the
> change in this struct. This file defines the ABI towards Secure world
> and adding dependencies on external complex types is a larger problem
> than the cast above in my opinion.

I understand.

So, the cast is simply wrong there. Can you add a comment above that cast to
explain that and make it is marked as FIXME? Because there is no guarantee that
internal Linux types can be 1:1 mapped to the ABI of something.

What you need, perhaps, is a middle layer function that will copy u64 data
to uuid_t or so. Also, u64 is not an ABI type, why the respective __uXX
variants are not in use?

-- 
With Best Regards,
Andy Shevchenko



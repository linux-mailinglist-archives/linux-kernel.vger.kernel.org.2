Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C043C68E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbhJ0Jhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:37:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:65461 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241205AbhJ0Jhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:37:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="316325577"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="316325577"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 02:35:17 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="597295484"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 02:35:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mffKi-001QZK-3E;
        Wed, 27 Oct 2021 12:34:56 +0300
Date:   Wed, 27 Oct 2021 12:34:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
Message-ID: <YXkdP/Rr+m30Hh72@smile.fi.intel.com>
References: <20211026144108.35373-1-quic_qiancai@quicinc.com>
 <YXhOEEOSG+fgEy+t@yury-ThinkPad>
 <YXhVVvG9keoVWJyK@smile.fi.intel.com>
 <397751ea-536b-af3c-752d-c4b1045e6e56@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397751ea-536b-af3c-752d-c4b1045e6e56@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 03:33:48PM -0400, Qian Cai wrote:
> On 10/26/21 3:21 PM, Andy Shevchenko wrote:
> > Can you explain to me how it is supposed to work?
> > 
> > For example,
> > 
> >     x = 0xaa55;
> >     size = 5;
> > 
> >     printf("%lu\n", find_first_bit(&x, size));
> > 
> > In the resulting code we will always have 5 as the result,
> > but is it correct one?
> 
> Sorry, my bad. GENMASK(size - 1, 0) would just become __GENMASK(size -
> 1, 0) instead of 0. Let me revisit it and run some tests first.

And we do not want to have __GENMASK() in the code.
Btw, I found one lurking around. Will fix it.

-- 
With Best Regards,
Andy Shevchenko



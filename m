Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6445B3C5D65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhGLNjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:39:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:58087 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhGLNjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:39:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="208162635"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="208162635"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 06:37:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="451389545"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 06:36:58 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m2w7B-00CF8s-1i; Mon, 12 Jul 2021 16:36:53 +0300
Date:   Mon, 12 Jul 2021 16:36:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 1/1] ARM: Drop ARCH_NR_GPIOS definition
Message-ID: <YOxFdUCVTT9mFXtk@smile.fi.intel.com>
References: <20210510114107.43006-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdb30HKOobtP++PqWc7UwM8qV4JC=UPAmUjUgFN_JANa+g@mail.gmail.com>
 <CAHp75Vc1qU0sBbLOZdTgjJ_pfN73Utg4wtRV8Ohu-OiaeJuycg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc1qU0sBbLOZdTgjJ_pfN73Utg4wtRV8Ohu-OiaeJuycg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:18:11AM +0300, Andy Shevchenko wrote:
> On Thu, May 20, 2021 at 2:26 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, May 10, 2021 at 1:40 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > The conditional by the generic header is the same,
> > > hence drop unnecessary duplication.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > I think this should go into Russell's patch tracker for convenience,
> > if you're not familiar with it I can sign it off and put it in there,
> > just tell me.
> 
> Nope, I'm not. Please do, thanks!
> 
> Since he kept silent I suppose it means an agreement on the change.
> It's quite straightforward and can be tested easily.

Any new on this, please?

It's kinda not good when the (simplest) patch is stuck like this :-(

-- 
With Best Regards,
Andy Shevchenko



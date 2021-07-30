Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2601D3DB7D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbhG3L26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:28:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:63062 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhG3L25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:28:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="200287672"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="200287672"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 04:28:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="581891449"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 04:28:50 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m9Qh2-003Mv2-6A; Fri, 30 Jul 2021 14:28:44 +0300
Date:   Fri, 30 Jul 2021 14:28:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 1/1] ARM: Drop ARCH_NR_GPIOS definition
Message-ID: <YQPibElzH2jP6OWL@smile.fi.intel.com>
References: <20210510114107.43006-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdb30HKOobtP++PqWc7UwM8qV4JC=UPAmUjUgFN_JANa+g@mail.gmail.com>
 <CAHp75Vc1qU0sBbLOZdTgjJ_pfN73Utg4wtRV8Ohu-OiaeJuycg@mail.gmail.com>
 <YOxFdUCVTT9mFXtk@smile.fi.intel.com>
 <CACRpkdZDOGrY8Ks7nne4KrV2dg4x87e3UdbB=pSZncTa7XFgUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZDOGrY8Ks7nne4KrV2dg4x87e3UdbB=pSZncTa7XFgUA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 11:44:05AM +0200, Linus Walleij wrote:
> On Mon, Jul 12, 2021 at 3:37 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Any new on this, please?
> >
> > It's kinda not good when the (simplest) patch is stuck like this :-(
> 
> Ooops, my fault. Now it is in Russell's patch tracker:
> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9103/1

Thanks!

-- 
With Best Regards,
Andy Shevchenko



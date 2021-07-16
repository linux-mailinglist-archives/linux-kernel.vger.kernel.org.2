Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8A3CB7B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbhGPNNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:13:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:63157 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238560AbhGPNM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:12:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="274553797"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="274553797"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 06:10:03 -0700
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="413974663"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 06:09:59 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m4NbE-00EEct-3X; Fri, 16 Jul 2021 16:09:52 +0300
Date:   Fri, 16 Jul 2021 16:09:52 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     kernel test robot <lkp@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kbuild-all@lists.01.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v1 1/3] clk: fractional-divider: Export approximation
 algo to the CCF users
Message-ID: <YPGFIAiRijr1OMZ2@smile.fi.intel.com>
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
 <202107152356.7gQSC0vc-lkp@intel.com>
 <CAHp75VcxP6QSoATProqjqJ_kmjXr4FfjijohCyumrw_gmj904w@mail.gmail.com>
 <9e1c1fde-fbbc-69d4-9273-192844037cd8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1c1fde-fbbc-69d4-9273-192844037cd8@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 06:58:40PM +0100, Robin Murphy wrote:
> On 2021-07-15 17:51, Andy Shevchenko wrote:
> > On Thu, Jul 15, 2021 at 7:49 PM kernel test robot <lkp@intel.com> wrote:
> > > I love your patch! Yet something to improve:
> > 
> > Definitely!
> > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > > > drivers/clk/rockchip/clk.c:27:10: fatal error: clk-fractional-divider.h: No such file or directory
> > >        27 | #include "clk-fractional-divider.h"
> > >           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > >     compilation terminated.
> > 
> > Indeed. No idea how to compile-test this on x86.
> > Let me see what I can do to avoid other issues.
> 
> Ha, the individual SoC-specific parts have COMPILE_TEST support, but the
> top-level COMMON_CLK_ROCKCHIP doesn't. That could probably be fixed.
> 
> Otherwise, you can always grab a toolchain from [1] (if your distro doesn't
> offer one already) and cross-compile - defconfig for arm64 or
> multi_v7_defconfig for arm should cover it.

With a hack patch I was able to compile-test.

-- 
With Best Regards,
Andy Shevchenko



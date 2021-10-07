Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282CB425A6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbhJGSNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:13:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:55313 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233750AbhJGSNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:13:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="289826106"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="289826106"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 11:11:36 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="560658940"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 11:11:33 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mYXrd-009d4k-SF;
        Thu, 07 Oct 2021 21:11:29 +0300
Date:   Thu, 7 Oct 2021 21:11:29 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] clk: Add write operation for clk_parent debugfs node
Message-ID: <YV84UTePn+1FaHw3@smile.fi.intel.com>
References: <20211007140904.3085-1-semen.protsenko@linaro.org>
 <CAHp75Ve1+pJ3Mqc7ErDSheLu5rEvSOf2Cq9JtSfOxSFrazNObg@mail.gmail.com>
 <CAPLW+4=3Mx9HuLdDo8YQ7tjVMi2kaTP23N1E2b5Krp_RJbO5-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPLW+4=3Mx9HuLdDo8YQ7tjVMi2kaTP23N1E2b5Krp_RJbO5-g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 08:45:11PM +0300, Sam Protsenko wrote:
> On Thu, 7 Oct 2021 at 17:39, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> Thanks for the review!

After addressing, feel free to add:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko



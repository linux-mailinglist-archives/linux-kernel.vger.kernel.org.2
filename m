Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B142ACAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhJLS5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:57:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:2108 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhJLS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:57:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="313439092"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="313439092"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:55:43 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="562785007"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:55:40 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1maMw5-0003LT-BZ;
        Tue, 12 Oct 2021 21:55:37 +0300
Date:   Tue, 12 Oct 2021 21:55:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] clk: Add write operation for clk_parent debugfs node
Message-ID: <YWXaKevf8D0kKYXo@smile.fi.intel.com>
References: <20211007182158.7490-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007182158.7490-1-semen.protsenko@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 09:21:58PM +0300, Sam Protsenko wrote:
> Useful for testing mux clocks. One can write the index of the parent to
> be set into clk_parent node, starting from 0. Example
> 
>     # cd /sys/kernel/debug/clk/mout_peri_bus
>     # cat clk_possible_parents
>       dout_shared0_div4 dout_shared1_div4
>     # cat clk_parent
>       dout_shared0_div4
>     # echo 1 > clk_parent
>     # cat clk_parent
>       dout_shared1_div4
> 
> CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
> order to use this feature.

...

> +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> +	if (core->num_parents > 1)
> +		debugfs_create_file("clk_parent", 0644, root, core,
> +				    &current_parent_rw_fops);
> +	else
> +#endif

> +	{
> +		if (core->num_parents > 0)
> +			debugfs_create_file("clk_parent", 0444, root, core,
> +					    &current_parent_fops);
> +	}

Currently there is no need to add the {} along with increased indentation
level. I.o.w. the 'else if' is valid in C.

-- 
With Best Regards,
Andy Shevchenko



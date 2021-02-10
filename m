Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D334316B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhBJQkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:40:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:53826 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232775AbhBJQgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:36:16 -0500
IronPort-SDR: KqWcc+wr7Es+q1o/mSTzl9OBEi67/isTJhFjzM+aIRfU8VyrqixnjP1POQkDQg1L5CAWW6KAeh
 tdT9yFr9XL/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="169229824"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="169229824"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:34:30 -0800
IronPort-SDR: 1+Iqsu8B9On0PFXd2+gZ52R1GgxtlUnuIkFW3ywEl7dLoedQUn6/nIrpdIKgp+y5kmWiJG64en
 DqHlMoCCV4tg==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="488798529"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:34:27 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l9sRc-003lvx-Ju; Wed, 10 Feb 2021 18:34:24 +0200
Date:   Wed, 10 Feb 2021 18:34:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 5/8] lib: bitmap: pair nbits value with region struct
Message-ID: <YCQLEHb8ga4SsngW@smile.fi.intel.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <20210209225907.78405-6-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209225907.78405-6-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:59:04PM -0500, Paul Gortmaker wrote:
> A region is a standalone entity to some degree, but it needs to
> be paired with a bitmap width in order to set context and determine
> if the region even fits into the width of the bitmap.
> 
> This will reduce parameter passing and enable using nbits as part
> of future dynamic region parameter parsing.

...

> +struct bitmap_region {
> +	struct region *r;

Why do we need it as a pointer?

> +	unsigned int nbits;
> +};

...

>  	struct region r;
> +	struct bitmap_region br;

> +	br.r = &r;
> +	br.nbits = nmaskbits;

I thought about simply

	struct bitmap_region br;

	br.nbits = nmaskbits;

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924B7304FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhA0Dfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:35:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:28539 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbhAZVm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:42:26 -0500
IronPort-SDR: MiwA8nk4u/Wx3XPWn5+t8yySlth1VoHXdW3npTD6M5Age7TA5lVL4oZqU7DwoptrrlPD4Hhylt
 M8tF0pAD7n6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180056047"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="180056047"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:40:40 -0800
IronPort-SDR: qczsz0GdS8UyERkoUgJ3RsxHff1rgU2LT/qG13+0GA4/lXFeASMXrJXhzTMIN0hHnHthCkPaH0
 dWTNxI+777dA==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="410299123"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:40:37 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l4W5j-00Ewq5-OO; Tue, 26 Jan 2021 23:41:39 +0200
Date:   Tue, 26 Jan 2021 23:41:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of
 bitmap
Message-ID: <YBCMk8ip4fyORSs3@smile.fi.intel.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-7-paul.gortmaker@windriver.com>
 <YBCLmrCSwBRkTAhT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBCLmrCSwBRkTAhT@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 11:37:30PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 26, 2021 at 12:11:39PM -0500, Paul Gortmaker wrote:

...

> > +	if (str[0] == 'N') {
> > +		*num = nbits - 1;
> > +		return str + 1;
> > +	}
> 
> But locating it here makes possible to enter a priori invalid input, like N for
> start of the region.
> 
> I think this should be separate helper which is called in places where it makes
> sense.

Okay, N is 31 on 32 core system... It is a bit counter intuitive, because it's
rather _L_ast than _N_umber of CPUs.

Changing letter?

-- 
With Best Regards,
Andy Shevchenko



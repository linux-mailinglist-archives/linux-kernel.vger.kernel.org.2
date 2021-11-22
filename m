Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01EC458D34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhKVLUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:20:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:26531 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231383AbhKVLUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:20:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="232251960"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="232251960"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 03:17:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="606378486"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 03:17:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mp7K1-009PgS-QF;
        Mon, 22 Nov 2021 13:17:17 +0200
Date:   Mon, 22 Nov 2021 13:17:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 00/20] Add memberof(), split headers, and simplify code
Message-ID: <YZt8PdBH5JcWTurH@smile.fi.intel.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 02:00:43PM +0100, Alejandro Colomar wrote:
> 
> Hi all,
> 
> I splitted some macros into separate headers,
> to be able to use them
> without pulling too many deps.
> 
> I also simplified some of themr
> to be implemented in terms of the others
> and to remove some unnecessary explicit casts.
> 
> And I added memberof(),
> which gives name to a typical construction
> to get the member of a struct
> without needing a variable of that type.
> 
> 
> The next step after this patch set
> is another one removing all redefinitions
> (at least all that are possible,
> since these headers can't be included everywhere)
> of these macros,
> by including these new tiny headers.
> Since these headers are so tiny and bring no dependencies,
> they should break anything.
> 
> It was hard for me to get this working
> because the order of includes _matters a lot_,
> and which headers you include _matters_ even outside of uapi.
> So I think this should help fix that,
> by allowing headers to pull exactly what they want,
> without all of the stuff that came with
> <linux/compiler.h>
> <linux/compiler_types.h>
> <linux/stddef.h>.
> 
> I already have much of the next patch set ready,
> and it removes hundreds of redefinitions of these macros,
> which should be a good thing.
> 
> 
> Then,
> when there are (almost) no redefinitions of these macros,
> I'll prepare a 3rd patch set that
> explicitly includes these tiny headers
> wherever these macros were already in use,
> to allow for removal of other bigger headers
> (although I won't remove anything,
> to avoid silently breaking anything).
> 
> 
> And then,
> a 4th patch set will
> attempt to find all uses of these macros
> that were not even named
> (i.e., hard-coded sizeof divisions).
> 
> 
> Hope this is clear and
> that you like these changes.

What happens to the indentation in your emails?!
It looks like a bad poem :-)

On top of that, never start a new thread inside the previous one.

-- 
With Best Regards,
Andy Shevchenko



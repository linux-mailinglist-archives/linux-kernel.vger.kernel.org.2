Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5030542EE8E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbhJOKQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:16:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:23621 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhJOKQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:16:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="208002544"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="208002544"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 03:13:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="571720531"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 03:13:55 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mbN1p-000OyW-JH;
        Fri, 15 Oct 2021 16:13:41 +0300
Date:   Fri, 15 Oct 2021 16:13:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     akpm@linux-foundation.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/container_of.h: switch to static_assert
Message-ID: <YWl+hQTa4Pd1A7zg@smile.fi.intel.com>
References: <20211015090530.2774079-1-linux@rasmusvillemoes.dk>
 <YWl95fZ69qpECxqi@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWl95fZ69qpECxqi@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 04:11:01PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 15, 2021 at 11:05:30AM +0200, Rasmus Villemoes wrote:
> > _Static_assert() is evaluated already in the compiler's frontend, and
> > gives a somehat more to-the-point error, compared to the BUILD_BUG_ON
> > macro, which only fires after the optimizer has had a chance to
> > eliminate calls to functions marked with
> > __attribute__((error)). In theory, this might make builds a tiny bit
> > faster.
> > 
> > There's also a little less gunk in the error message emitted:
> > 
> > lib/sort.c: In function ‘foo’:
> > ./include/linux/build_bug.h:78:41: error: static assertion failed: "pointer type mismatch in container_of()"
> >    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> > 
> > compared to
> > 
> > lib/sort.c: In function ‘foo’:
> > ././include/linux/compiler_types.h:322:38: error: call to ‘__compiletime_assert_2’ declared with attribute error: pointer type mismatch in container_of()
> >   322 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> > 
> > While at it, fix the copy-pasto in container_of_safe().
> 
> Thanks, Rasmus!
> Make sense to me.

Btw, shouldn't we also remove build_bug.h in the container_of.h with this?
(Or if this goes first, do we still need bug.h?)

-- 
With Best Regards,
Andy Shevchenko



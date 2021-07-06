Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7951C3BC8AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhGFJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:51:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:26474 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhGFJvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:51:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="206078173"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="206078173"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 02:49:08 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="562957823"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 02:49:06 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m0hhN-0098Je-19; Tue, 06 Jul 2021 12:49:01 +0300
Date:   Tue, 6 Jul 2021 12:49:01 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, pcc@google.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH] kasan: fix build by including kernel.h
Message-ID: <YOQnDWOJbNVSXM4i@smile.fi.intel.com>
References: <20210705072716.2125074-1-elver@google.com>
 <CAHp75VeRosmsAdCD7W7o9upb+G-de-rwhjCnPtTra2FToEmytg@mail.gmail.com>
 <CANpmjNMZTe1Vs6Xx9bC9+azeRWJc7JvT-G4O7aQAq--wAp7f=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMZTe1Vs6Xx9bC9+azeRWJc7JvT-G4O7aQAq--wAp7f=g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 11:01:44AM +0200, Marco Elver wrote:
> On Mon, 5 Jul 2021 at 10:50, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jul 5, 2021 at 10:28 AM Marco Elver <elver@google.com> wrote:
> > > The <linux/kasan.h> header relies on _RET_IP_ being defined, and had
> > > been receiving that definition via inclusion of bug.h which includes
> > > kernel.h. However, since f39650de687e that is no longer the case and get
> > > the following build error when building CONFIG_KASAN_HW_TAGS on arm64:
> > >
> > >   In file included from arch/arm64/mm/kasan_init.c:10:
> > >   ./include/linux/kasan.h: In function 'kasan_slab_free':
> > >   ./include/linux/kasan.h:230:39: error: '_RET_IP_' undeclared (first use in this function)
> > >     230 |   return __kasan_slab_free(s, object, _RET_IP_, init);
> > >
> > > Fix it by including kernel.h from kasan.h.
> >
> > ...which I would like to avoid in the long term, but for now it's
> > probably the best quick fix, otherwise it will require the real split
> > of _RET_IP or at least rethinking its location.
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.org>
> > Thanks!
> 
> Thanks!

Should be:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> > > Fixes: f39650de687e ("kernel.h: split out panic and oops helpers")
> >
> > P.S. I have tested the initial patch against full build of x86_64, and
> > it was long time available for different CIs/build bots, none
> > complained so far.
> 
> It only manifests on arm64 when using CONFIG_KASAN_HW_TAGS mode
> (requires Arm64 MTE extensions). The other 2 modes include
> <linux/pgtable.h> in kasan.h, and that seems to include kernel.h
> somewhere. The HW_TAGS mode, however, doesn't receive -next testing by
> a CI system AFAIK, so this was missed because it's not yet used by
> many (I'd expect that to change when CPUs with MTE are more
> widespread).

Got it.

-- 
With Best Regards,
Andy Shevchenko



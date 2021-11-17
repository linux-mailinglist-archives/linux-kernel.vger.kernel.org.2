Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1BF4546B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhKQM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:58:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:8054 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234855AbhKQM6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:58:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="213972000"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="213972000"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 04:55:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="494906876"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 04:55:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mnKSy-007nIj-1i;
        Wed, 17 Nov 2021 14:55:08 +0200
Date:   Wed, 17 Nov 2021 14:55:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li Wang <liwang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] radix-tree: Replace kernel.h with the necessary
 inclusions
Message-ID: <YZT7q+Eo9mudqOLF@smile.fi.intel.com>
References: <20211027150528.80003-1-andriy.shevchenko@linux.intel.com>
 <CAEemH2edgtA+XOY8WjgwFD-50qcw_MGFSgjjBjgKVi_dAwtR6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEemH2edgtA+XOY8WjgwFD-50qcw_MGFSgjjBjgKVi_dAwtR6w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 03:01:12PM +0800, Li Wang wrote:

Thanks for the report! And do not top post next time, please.

> This patch breaks the radix tree test building.

Yes and no. The dirty tricks with kernel headers that tools/ do is what has
been revealed by this patch.

> # make -C tools/testing/radix-tree/
> make: Entering directory '/root/linux-5.16-rc1/tools/testing/radix-tree'
> cc -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address
> -fsanitize=undefined   -c -o main.o main.c
> In file included from ./linux/../../../../include/linux/radix-tree.h:14,
>                  from ./linux/radix-tree.h:5,
>                  from main.c:10:
> ./linux/lockdep.h:7:38: error: unknown type name ‘spinlock_t’; did you mean
> ‘clock_t’?
>     7 | static inline void lockdep_set_class(spinlock_t *lock,
>       |                                      ^~~~~~~~~~
>       |                                      clock_t
> In file included from ./linux/radix-tree.h:5,
>                  from main.c:10:
> ./linux/../../../../include/linux/radix-tree.h:15:10: fatal error:
> linux/math.h: No such file or directory
>    15 | #include <linux/math.h>
>       |          ^~~~~~~~~~~~~~
> compilation terminated.
> make: *** [<builtin>: main.o] Error 1
> make: Leaving directory '/root/linux-5.16-rc1/tools/testing/radix-tree'

So, add that header to the bunch of others in the tools/

Something like this? (not even compile-tested)

diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index aa6abfe0749c..fa66853416d5 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -40,6 +40,7 @@ $(OFILES): Makefile *.h */*.h generated/map-shift.h \
 	../../include/asm/*.h \
 	../../../include/linux/xarray.h \
 	../../../include/linux/radix-tree.h \
+	../../../include/linux/math.h \
 	../../../include/linux/idr.h
 
 radix-tree.c: ../../../lib/radix-tree.c


-- 
With Best Regards,
Andy Shevchenko



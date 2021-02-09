Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769CC314F63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhBIMpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:45:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:15596 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhBIMnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:43:01 -0500
IronPort-SDR: wyMpPCyYtzIAvkBtLuKC1RRGYHs6TwB3gIoozCI8TPxITky6Kk7x9WlNeYz8bfjGqAWMXdAWKS
 0zepbT7RYdmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="178362269"
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; 
   d="scan'208";a="178362269"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 04:41:08 -0800
IronPort-SDR: 6KPKfSvEZSTkUrzHjcp/yuliol8zzke1i7JlRE/MWmabiN1Rfs7TsNnoJ4kMBS/hCoUtpjfX8N
 Kp/n0M/KEWgQ==
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; 
   d="scan'208";a="398768358"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 04:41:04 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l9SKD-003DWG-9k; Tue, 09 Feb 2021 14:41:01 +0200
Date:   Tue, 9 Feb 2021 14:41:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     willy@infradead.org, david@redhat.com, linmiaohe@huawei.com,
        vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] mm, vsprintf: dump full information of page flags
 in pGp
Message-ID: <YCKC3fkbOjJsem+E@smile.fi.intel.com>
References: <20210209105613.42747-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209105613.42747-1-laoar.shao@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 06:56:10PM +0800, Yafang Shao wrote:
> The existed pGp shows the names of page flags only, rather than the full
> information including section, node, zone, last cpuipid and kasan tag.
> While it is not easy to parse these information manually because there
> are so many flavors. We'd better interpret them in printf.
> 
> To be compitable with the existed format of pGp, the new introduced ones
> also use '|' as the separator, then the user tools parsing pGp won't
> need to make change, suggested by Matthew. The new added information is
> tracked onto the end of the existed one, e.g.
> [ 8838.835456] Slab 0x000000002828b78a objects=33 used=3 fp=0x00000000d04efc88 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> 
> The documentation and test cases are also updated. The result of the
> test cases as follows,
> [  501.485081] test_printf: loaded.
> [  501.485768] test_printf: all 388 tests passed
> [  501.488762] test_printf: unloaded.
> 
> This patchset also includes some code cleanup in mm/slub.c.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> v4:
> - extend %pGp instead of introducing new format, per Matthew
> 
> v3:
> - coding improvement, per Joe and Andy
> - the possible impact on debugfs and the fix of it, per Joe and Matthew
> - introduce new format instead of changing pGp, per Andy
> 
> v2:
> - various coding improvement, per Joe, Miaohe, Vlastimil and Andy
> - remove the prefix completely in patch #2, per Vlastimil
> - Update the test cases, per Andy
> 
> Yafang Shao (3):
>   mm, slub: use pGp to print page flags
>   mm, slub: don't combine pr_err with INFO
>   vsprintf: dump full information of page flags in pGp
> 
>  Documentation/core-api/printk-formats.rst |  2 +-
>  lib/test_printf.c                         | 60 +++++++++++++++++----
>  lib/vsprintf.c                            | 66 +++++++++++++++++++++--
>  mm/slub.c                                 | 13 ++---
>  4 files changed, 121 insertions(+), 20 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko



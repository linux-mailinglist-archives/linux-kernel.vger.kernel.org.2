Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED65315166
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhBIOSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:18:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:35706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhBIOR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:17:57 -0500
IronPort-SDR: nzZ3rAG4yK/agXrnAeTr7w2qu3Pf+5Qy1OKcL4dH5OKWCTP330X+ghvTm49rlnc2o44ze2YI3l
 OHWrAUVO6XwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="245953145"
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="245953145"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 06:16:09 -0800
IronPort-SDR: RkBMcTU0+fkpsIgm2O+1IjEi6UOCAJd89r6TT0BdfPkb4goL2fqES9jL99M3XdIGoyyLN77Xo+
 pIt4LRDN5aWg==
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="359189832"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 06:16:06 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l9To9-003EZG-Uw; Tue, 09 Feb 2021 16:16:01 +0200
Date:   Tue, 9 Feb 2021 16:16:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, willy@infradead.org,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com, joe@perches.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <YCKZIWMYjD33xXnr@smile.fi.intel.com>
References: <20210209105613.42747-1-laoar.shao@gmail.com>
 <20210209105613.42747-4-laoar.shao@gmail.com>
 <YCKT8WCPGU+HBY91@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCKT8WCPGU+HBY91@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:53:53PM +0100, Petr Mladek wrote:
> On Tue 2021-02-09 18:56:13, Yafang Shao wrote:

...

> I am sorry for my ignorance. I am not familiar with MM.
> But it is pretty hard to understand what call does what.
> 
> I have found the following comment in include/linux/page_flags.h:
> 
>  * The page flags field is split into two parts, the main flags area
>  * which extends from the low bits upwards, and the fields area which
>  * extends from the high bits downwards.
> 
> Sigh, I know that you already reworked this several times because
> people "nitpicked" about the code style. But it seems that it
> rather diverged instead of converged.
> 
> What about the following?

Isn't is some like v1 or v2?

> Note: It is inpired by the names "main area" and "fields area"
>       mentioned in the above comment from page_flags.h.
>       I have later realized that "page_flags_layout" actually made
>       sense as well. Feel free to rename page_flags_fileds
>       back to page_flags_layout.
> 
> Anyway, this is my proposal:

What about to create a one format_flags() function which accepts new data
structure and do something like

buf = format_flags(main_area);
buf = format_flags(fields_area);
return buf;

?

-- 
With Best Regards,
Andy Shevchenko



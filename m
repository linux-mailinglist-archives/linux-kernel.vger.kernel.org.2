Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE46357081
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353650AbhDGPhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:37:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:19364 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353625AbhDGPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:37:33 -0400
IronPort-SDR: x0NYdmZRGah87gzxd9eNXVXoj5K8ZTUHVHscavPlvwxEcy+RLpYx2y4LX+Q0uQ+inWUtlwUhLf
 eTqZzWxmka+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="191173873"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="191173873"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 08:37:21 -0700
IronPort-SDR: nLiCtEa99Zw5tXG79XYzqElccOCupiaUmbTVVZVLlrRsjjJNDArtQKBb+L6G7dm5zf1UTeNKSK
 ynbya8MY7efQ==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="379865679"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 08:37:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lUAF0-0022c8-95; Wed, 07 Apr 2021 18:37:14 +0300
Date:   Wed, 7 Apr 2021 18:37:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/12] module: Add printk format to add module build
 ID to stacktraces
Message-ID: <YG3RqtKP9K1hvT+F@smile.fi.intel.com>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-5-swboyd@chromium.org>
 <YG3J03GY+QqtKMlu@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3J03GY+QqtKMlu@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:03:47PM +0200, Petr Mladek wrote:
> On Tue 2021-03-30 20:05:12, Stephen Boyd wrote:

> Please add something like:
> 
> 	/* Keep BUILD_ID_SIZE_MAX in sync with the below used %20phN */
> 	BUILD_BUG_ON(BUILD_ID_SIZE_MAX != 20)
> 
> to make sure the the hard

Why not static assert?

-- 
With Best Regards,
Andy Shevchenko



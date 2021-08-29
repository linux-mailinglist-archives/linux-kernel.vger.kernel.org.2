Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2279C3FABF8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhH2NhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 09:37:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:23171 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235323AbhH2NhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 09:37:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="218198565"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="218198565"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 06:36:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="445465619"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 06:36:19 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mKKyr-00F2pb-RG; Sun, 29 Aug 2021 16:36:13 +0300
Date:   Sun, 29 Aug 2021 16:36:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/vsprintf: add __putchar()
Message-ID: <YSuNTVh17CxUNxtC@smile.fi.intel.com>
References: <20210827171155.700434-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827171155.700434-1-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Aug 27, 2021 at 10:11:55AM -0700, Yury Norov wrote:
> There are 26 occurrences of the code snippet like this in the file :
> 	if (buf < end)
> 	        *buf = separator;
> 	++buf;
> 
> This patch adds a helper function __putchar() to replace opencoding.
> It adds a lot to readability, and also saves 43 bytes of text on x86.

Last time I tried similar it failed the compilation.

Anyway, while you remove a lot of code I'm not sure it makes the code better
to read and understand. Also, we use the same idiom outside of this file.

I would ask Rasmus' opinion on this.

-- 
With Best Regards,
Andy Shevchenko



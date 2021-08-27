Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B93F9555
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbhH0Hte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:49:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:60552 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244460AbhH0Htd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:49:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="198155927"
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="198155927"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 00:48:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="537992129"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 00:48:39 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mJWbJ-00EFWa-A7; Fri, 27 Aug 2021 10:48:33 +0300
Date:   Fri, 27 Aug 2021 10:48:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] vsprintf/Documentation: Add X to %*ph extension to
 output upper case hex
Message-ID: <YSiY0aa+C9cyJni4@smile.fi.intel.com>
References: <cover.1630003183.git.joe@perches.com>
 <bc33e306a9064dfbf1180a35f9bfa587c6502eca.1630003183.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc33e306a9064dfbf1180a35f9bfa587c6502eca.1630003183.git.joe@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:43:01AM -0700, Joe Perches wrote:
> A few sysfs output uses of hex arrays are uppercase and are nominally ABI.
> 
> Add a mechanism to the existing vsprintf %*ph hex output extension to
> support upper case hex output.

...

> +	The preferred output is lowercase
>  	%*ph	00 01 02  ...  3f
>  	%*phC	00:01:02: ... :3f
>  	%*phD	00-01-02- ... -3f
>  	%*phN	000102 ... 3f
> +	Formats with X are uppercase, used for backwards compatibility
> +	%*phX	00 01 02  ...  3F
> +	%*phCX	00:01:02: ... :3F
> +	%*phDX	00-01-02- ... -3F
> +	%*phNX	000102 ... 3F

Why not using %*pH...?

...

> +	char locase = 0x20;	/* ASCII OR'd for lower case see: number() */

If you use h vs H, you may derive this from (fmt[...] & SMALL).

-- 
With Best Regards,
Andy Shevchenko



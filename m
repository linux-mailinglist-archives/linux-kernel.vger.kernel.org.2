Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7D4506B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhKOO1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:27:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:10935 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236330AbhKOO0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:26:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="294267137"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="294267137"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:20:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="453830422"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 06:20:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmcq8-0077BB-DE;
        Mon, 15 Nov 2021 16:20:08 +0200
Date:   Mon, 15 Nov 2021 16:20:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] printk: Remove printk.h inclusion in percpu.h
Message-ID: <YZJsmDWih2240nyr@smile.fi.intel.com>
References: <20211112140749.80042-1-andriy.shevchenko@linux.intel.com>
 <YY6vV2zUTdH5SNt5@fedora>
 <YZIs1FvxA0hKylNd@alley>
 <YZI4i5hsgD4pDjoQ@smile.fi.intel.com>
 <YZJnRyqtDzfmI0Cf@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZJnRyqtDzfmI0Cf@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 02:57:27PM +0100, Petr Mladek wrote:
> On Mon 2021-11-15 12:38:03, Andy Shevchenko wrote:
> > On Mon, Nov 15, 2021 at 10:48:04AM +0100, Petr Mladek wrote:

...

> > I assumed you take it, that's why I haven't Cc'ed Andrew in the first place,
> > but it seems you have a consensus with Dennis that Andrew is the best
> > maintainer to take this. So, I'll send v2 with tags and Cc to him.
> 
> No problem, I am going to take it, in a hour or so. I did not want to
> make chaos when Denis asked Andrew. But it is not worth resending the patch.

Thanks!

If needed something from me, just ping.

-- 
With Best Regards,
Andy Shevchenko



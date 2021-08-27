Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36563F966D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbhH0IuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:50:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:10097 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232048AbhH0IuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:50:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="197489373"
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="197489373"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 01:49:15 -0700
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="599107590"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 01:49:13 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mJXXv-00EH0t-VO; Fri, 27 Aug 2021 11:49:07 +0300
Date:   Fri, 27 Aug 2021 11:49:07 +0300
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
Message-ID: <YSinAyVMIQDxf6Fo@smile.fi.intel.com>
References: <cover.1630003183.git.joe@perches.com>
 <bc33e306a9064dfbf1180a35f9bfa587c6502eca.1630003183.git.joe@perches.com>
 <YSiY0aa+C9cyJni4@smile.fi.intel.com>
 <18d9f8d6803c8957ec091c207780c163af07e41f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18d9f8d6803c8957ec091c207780c163af07e41f.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 01:08:10AM -0700, Joe Perches wrote:
> On Fri, 2021-08-27 at 10:48 +0300, Andy Shevchenko wrote:
> > On Thu, Aug 26, 2021 at 11:43:01AM -0700, Joe Perches wrote:
> > > A few sysfs output uses of hex arrays are uppercase and are nominally ABI.
> > > 
> > > Add a mechanism to the existing vsprintf %*ph hex output extension to
> > > support upper case hex output.
> > 
> > ...
> > 
> > > +	The preferred output is lowercase
> > >  	%*ph	00 01 02  ...  3f
> > >  	%*phC	00:01:02: ... :3f
> > >  	%*phD	00-01-02- ... -3f
> > >  	%*phN	000102 ... 3f
> > > +	Formats with X are uppercase, used for backwards compatibility
> > > +	%*phX	00 01 02  ...  3F
> > > +	%*phCX	00:01:02: ... :3F
> > > +	%*phDX	00-01-02- ... -3F
> > > +	%*phNX	000102 ... 3F
> > 
> > Why not using %*pH...?
> 
> I find X more intelligible.
> 
> > > +	char locase = 0x20;	/* ASCII OR'd for lower case see: number() */
> > 
> > If you use h vs H, you may derive this from (fmt[...] & SMALL).
> 
> It's not necessary to use any more of the rather limited vsprintf
> extension namespace.

I understand your concern, but %*ph is quite widely used (I guess top 1 or 2
among all %p extensions), its performance degradation with your code may affect
a lot of other users and hence a kernel as a whole.

So, that's why my proposal stays.

Of course you may provide a benchmark (btw, where are the test cases for this?)
for yours and mine variant and we will see if it makes sense to optimize.

-- 
With Best Regards,
Andy Shevchenko



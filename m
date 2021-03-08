Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8A33163B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhCHShC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:37:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:42699 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhCHSg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:36:29 -0500
IronPort-SDR: muAB8SEFJwCTHjIjpvErdt2jnWo3LE286OdarEzIBpPyUTJJ/jh60aInEfOQ/6B8ANMurWRlfO
 YzcNJKfJ2ffw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="167996408"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="167996408"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 10:36:28 -0800
IronPort-SDR: 2aTtdn46OoZl2pQ9SbUHLlansm8jjvhnpQTN6xlmVYdUDcFsl6vcmgAniIQv7pax5i0/cGUIk4
 S2afTbWyj63w==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="509015145"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 10:36:26 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJKjv-00Asev-JV; Mon, 08 Mar 2021 20:36:23 +0200
Date:   Mon, 8 Mar 2021 20:36:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marco Elver <elver@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers
 warning
Message-ID: <YEZupyBiJD1zoLTi@smile.fi.intel.com>
References: <20210305194206.3165917-1-elver@google.com>
 <20210305194206.3165917-2-elver@google.com>
 <YEX5fyB16dF6N4Iu@alley>
 <CAMuHMdUDqcWfE67g2ah-JyL3H9-G_5nrtQLyq0A3OXTKPFXv6w@mail.gmail.com>
 <YEZdo0L8otuEJZNW@alley>
 <CANpmjNOS86kLPexXBZPwRB9=Ej6RHycJXCw_Z7cskMC+Jwb1Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOS86kLPexXBZPwRB9=Ej6RHycJXCw_Z7cskMC+Jwb1Ag@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 07:23:34PM +0100, Marco Elver wrote:
> On Mon, 8 Mar 2021 at 18:23, Petr Mladek <pmladek@suse.com> wrote:

> > -       pr_warn("**********************************************************\n");
> > -       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > -       pr_warn("**                                                      **\n");
> > -       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > -       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > -       pr_warn("** might reduce the security of your system.            **\n");
> > -       pr_warn("**                                                      **\n");
> > -       pr_warn("** If you see this message and you are not debugging    **\n");
> > -       pr_warn("** the kernel, report this immediately to your system   **\n");
> 
> While we're here: This paragraph can be shortened by saying what
> kernel/trace/trace.c says ("..., report this immediately to your
> vendor!") which avoids the "administrator! <lots of wasted spaces>".

Aren't we discussed that and the point was that kernel configuration option is
in administrator's realm?

> > -       pr_warn("** administrator!                                       **\n");
> > -       pr_warn("**                                                      **\n");
> > -       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > -       pr_warn("**********************************************************\n");

-- 
With Best Regards,
Andy Shevchenko



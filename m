Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6831B3FA345
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 04:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhH1CuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 22:50:20 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:59814 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232555AbhH1CuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 22:50:18 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5D4A02848D;
        Sat, 28 Aug 2021 02:49:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 1BEE12351F4;
        Sat, 28 Aug 2021 02:49:25 +0000 (UTC)
Message-ID: <3936164c5bbd978933720bc61e509a6b3ff16c14.camel@perches.com>
Subject: Re: [PATCH 1/5] vsprintf/Documentation: Add X to %*ph extension to
 output upper case hex
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Aug 2021 19:49:24 -0700
In-Reply-To: <YSinAyVMIQDxf6Fo@smile.fi.intel.com>
References: <cover.1630003183.git.joe@perches.com>
         <bc33e306a9064dfbf1180a35f9bfa587c6502eca.1630003183.git.joe@perches.com>
         <YSiY0aa+C9cyJni4@smile.fi.intel.com>
         <18d9f8d6803c8957ec091c207780c163af07e41f.camel@perches.com>
         <YSinAyVMIQDxf6Fo@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 6whpabbktbznf4rkq41ify5i4ywr5da5
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1BEE12351F4
X-Spam-Status: No, score=-2.37
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ALyDI1g+gQUbZZXxfQPmCgWVVQy0Z8UY=
X-HE-Tag: 1630118965-249460
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-27 at 11:49 +0300, Andy Shevchenko wrote:
> On Fri, Aug 27, 2021 at 01:08:10AM -0700, Joe Perches wrote:
> > On Fri, 2021-08-27 at 10:48 +0300, Andy Shevchenko wrote:
> > > On Thu, Aug 26, 2021 at 11:43:01AM -0700, Joe Perches wrote:
> > > > A few sysfs output uses of hex arrays are uppercase and are nominally ABI.
> > > > 
> > > > Add a mechanism to the existing vsprintf %*ph hex output extension to
> > > > support upper case hex output.
> > > 
> > > ...
> > > 
> > > > +	The preferred output is lowercase
> > > >  	%*ph	00 01 02  ...  3f
> > > >  	%*phC	00:01:02: ... :3f
> > > >  	%*phD	00-01-02- ... -3f
> > > >  	%*phN	000102 ... 3f
> > > > +	Formats with X are uppercase, used for backwards compatibility
> > > > +	%*phX	00 01 02  ...  3F
> > > > +	%*phCX	00:01:02: ... :3F
> > > > +	%*phDX	00-01-02- ... -3F
> > > > +	%*phNX	000102 ... 3F
> > > 
> > > Why not using %*pH...?
> > 
> > I find X more intelligible.
> > 
> > > > +	char locase = 0x20;	/* ASCII OR'd for lower case see: number() */
> > > 
> > > If you use h vs H, you may derive this from (fmt[...] & SMALL).
> > 
> > It's not necessary to use any more of the rather limited vsprintf
> > extension namespace.
> 
> I understand your concern, but %*ph is quite widely used (I guess top 1 or 2
> among all %p extensions),

Cumulatively 3rd after %pM and %pOF

> its performance degradation with your code may affect
> a lot of other users and hence a kernel as a whole.
> 
> So, that's why my proposal stays.

Knock yourself out.

> Of course you may provide a benchmark (btw, where are the test cases for this?)

You are welcome to provide both test cases and benchmarks.
I find the whole thing rather dull.

> for yours and mine variant and we will see if it makes sense to optimize.

It doesn't.  Anyone thinking there is a required printf/vsprintf
optimization in the kernel is decidedly barking up the wrong tree.



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503093F983E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbhH0KuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:50:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50302 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhH0Ktz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:49:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 66BCA223B4;
        Fri, 27 Aug 2021 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630061346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0Nn4BSUqolweqQNlr37cyJmiIhk4AifsG/Gg3LBx1o=;
        b=foTZeijej7U4TPCeksGJSkqBKTZRrzcrPT5hlHKjrS4/X434Wvbfq1yUrVL5n4fhqJA/l3
        12i6QdRod9wM9WjuYCWnmO9kQfFmLtqCYfLOxc0aA9TfNZeZo8oYQZ/8LAfayN4p4peyJx
        F8qn6TC4eDGLg+uxP3qYZAtiBHX2zf0=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D75C3A3B8F;
        Fri, 27 Aug 2021 10:49:05 +0000 (UTC)
Date:   Fri, 27 Aug 2021 12:49:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joe Perches <joe@perches.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] vsprintf/Documentation: Add X to %*ph extension to
 output upper case hex
Message-ID: <YSjDH1y8AJIvCstV@alley>
References: <cover.1630003183.git.joe@perches.com>
 <bc33e306a9064dfbf1180a35f9bfa587c6502eca.1630003183.git.joe@perches.com>
 <YSiY0aa+C9cyJni4@smile.fi.intel.com>
 <18d9f8d6803c8957ec091c207780c163af07e41f.camel@perches.com>
 <YSinAyVMIQDxf6Fo@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YSinAyVMIQDxf6Fo@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-08-27 11:49:07, Andy Shevchenko wrote:
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

I though about this as well.

> > I find X more intelligible.

I would slightly prefer %pH. I always have problems to parse long
sequences of modifiers. So, the shorter format the better.

Of course, it means that 'H' won't be usable for another purpose.
But it will happen one day anyway. Well, this is why I do not
have strong opinion.

I am more and more convinced that we will need another approach.
Mathew Wilcox has had an idea to add support for custom callbacks
that would be able to format the string, something like:

   vsprintf("Date: %pX(%p)\n", format_date, time_stamp);

I think that it might even be possible to do something like:

   vsprintf("Date: %pX\n", format_date(time));

, where the format_date() would be a macro that would create
a struct at stack a pass it as a pointer:

#define format_date(time)			   \
({						   \
	struct vsprintf_callback c = {		   \
		.func = vsprintf_format_date,	   \
		.arg1 = time,			   \
	}					   \
						   \
	&c;					   \
})

and vsprintf would internally do something like:

char *custom_format(char *buf, char *end, vsprintf_callback *c,
			 struct printf_spec spec, const char *fmt)
{
	return c->func(buf, end, c->arg1, spec);
}

It would allow to replace all the magic %pXYZ modifiers with
self-explanatory callbacks. While still keeping it easy to use.

Best Regards,
Petr

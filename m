Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA745A006
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhKWKY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:24:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56952 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhKWKYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:24:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 97D501FD58;
        Tue, 23 Nov 2021 10:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637662876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LT9/4SIjmaFXbf7+8x1j5ukFsUhfPd3v12li2rTpDt4=;
        b=jQxaC+kAW9UEaBDBfbIdR+mYrOZwdP2yEueG6usjhRNIDapuYK05XtJ83jfqLxshPzEy5u
        NG5iBNbGuIsz79AhMfM0C/JZkxnu08LtTBNil8elOQUyPd/jgo04WIiztr6Eb26U3gpeM4
        zYJJJR4ZgDYuSgW2eexHzObAByuyUE0=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4587BA3B89;
        Tue, 23 Nov 2021 10:21:16 +0000 (UTC)
Date:   Tue, 23 Nov 2021 11:21:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] printk/console: Split out code that enables default
 console
Message-ID: <YZzAmNUHOsrHh8su@alley>
References: <20211122132649.12737-1-pmladek@suse.com>
 <20211122132649.12737-2-pmladek@suse.com>
 <YZxNiiK3PRZnsfPG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZxNiiK3PRZnsfPG@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-11-23 11:10:18, Sergey Senozhatsky wrote:
> On (21/11/22 14:26), Petr Mladek wrote:
> > Put the code enabling a console by default into a separate function
> > called try_enable_default_console().
> > 
> > Rename try_enable_new_console() to try_enable_preferred_console() to
> > make the purpose of the different variants more clear.
> > 
> > It is a code refactoring without any functional change.
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> [..]
> > -static int try_enable_new_console(struct console *newcon, bool user_specified)
> > +static int try_enable_preferred_console(struct console *newcon,
> > +					bool user_specified)
> >  {
> >  	struct console_cmdline *c;
> >  	int i, err;
> > @@ -2909,6 +2910,23 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
> >  	return -ENOENT;
> >  }
> >  
> > +/* Try to enable the console unconditionally */
> > +static void try_enable_default_console(struct console *newcon)
> > +{
> > +	if (newcon->index < 0)
> > +		newcon->index = 0;
> > +
> > +	if (newcon->setup && newcon->setup(newcon, NULL) != 0)
> > +		return;
> > +
> > +	newcon->flags |= CON_ENABLED;
> > +
> > +	if (newcon->device) {
> > +		newcon->flags |= CON_CONSDEV;
> > +		has_preferred_console = true;
> > +	}
> > +}
> 
> try_enable_default_console() also sets preferred_console, as well as
> try_enable_preferred_console().

Yes, this is one of the confusing things that this patchset is trying to solve.

The result of this patchset is that preferred_console will be used
only for consoles that are explicitely preferred via the command line,
device tree, or SPCR.

The variable @has_preferred_console is renamed to @need_default_console
in 2nd patch and completely removed in 4th patch.

Anyway, thanks for review.

Best Regards,
Petr

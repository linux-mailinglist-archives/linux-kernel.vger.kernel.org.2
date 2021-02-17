Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF37931DCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhBQQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:10:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:35580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234020AbhBQQK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:10:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613578182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x3hBT9QaDaFA/EBlw1NkRQ4jKKS/PDh+tveWMhoehR8=;
        b=fUvXGBr7v3pLSvtoEaKwBotFOIaCOI48BXU14H7TxXg0jC6Mn+h+3dY5U+3osTVz7/h1E7
        uQ4sE8pFvajvXNygtCAQBbftt5s7e+qk0ziF1VhAGzJlRlOAaPyA8RTCLHV5cyJz3MtrgX
        3W1nuABGTJxKRqiUnDBpfrRnGw3sJCc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31464B944;
        Wed, 17 Feb 2021 16:09:42 +0000 (UTC)
Date:   Wed, 17 Feb 2021 17:09:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YC0/xQTephcfo6GL@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
 <YCwAbGoVuZJspcx5@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCwAbGoVuZJspcx5@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-16 17:27:08, Chris Down wrote:
> Petr Mladek writes:
> > > +/*
> > > + * Stores .printk_fmt section boundaries for vmlinux and all loaded modules.
> > > + * Add entries with store_printk_fmt_sec, remove entries with
> > > + * remove_printk_fmt_sec.
> > > + */
> > > +static DEFINE_HASHTABLE(printk_fmts_mod_sections, 8);
> 
> > The hash table looks like an overkill. This is slow path. There are
> > typically only tens of loaded modules. Even the module loader
> > uses plain list for iterating the list of modules.
> 
> I don't think it's overkill -- we have prod systems with hundreds. Hell,
> even my laptop has over 150 loaded. If someone needs to walk all of the
> files in debugfs, it seems unreasonable to do an O(n^2) walk when an O(n)
> one would suffice.
> 
> Unless you have a practical concern, I think this is a distinct case from
> the module loader with its own unique requirements, so I'd prefer to use the
> hash table.

OK, it is true that the module API is either called with a particular
struct module pointer. Or it has to iterate over all modules anyway,
for example, when looking for a symbol.

Well, do we need access to struct module at all?

What about storing the pointer to struct pf_object into
struct printk_fmt_sec *ps into the s->file->f_inode->i_private?
Then we would not need any global list/table at all.

> > > +
> > > +/* Protects printk_fmts_mod_sections */
> > > +static DEFINE_MUTEX(printk_fmts_mutex);
> > 
> > What is the rule for using "printk_fmts" and "printk_fmt", please?
> > I can't find the system here ;-)
> > 
> > Anyway, I would prefer to use "printk_fmt" everywhere.
> > Or maybe even "pf_".
> 
> pf_ sounds fine. :-)
> 
> > > +
> > > +static const char *ps_get_module_name(const struct printk_fmt_sec *ps);
> > > +static int debugfs_pf_open(struct inode *inode, struct file *file);
> > 
> > There are used many different:
> > 
> >   + shortcuts: fmt, fmts, ps, fmt_sec, dfs
> > 
> >   + styles/ordering: ps_get_module_name() vs.
> > 		      find_printk_fmt_sec() vs.
> > 		      printk_fmt_size() vs.
> > 		      debugfs_pf_open()
> > 
> > It might be bearable because there is not much code. But it would
> > still help a lot when we make it more consistent. Many subsystems
> > prefer using a feature-specific prefix.
> > 
> > It might be "printk_fmt_" or "pf_" [*] in this case. And we could use
> > names like:
> > 
> > 	+ struct pf_object [**]
> > 	+ pf_get_object_name()
> > 	+ pf_find_object()
> > 	+ pf_fops,
> > 	+ pf_open()
> > 	+ pf_release()
> > 	+ pf_mutex,
> > 	+ pf_add_object()
> > 	+ pf_remove_object()
> > 	+ pf_module_notify
> 
> Oh, I meant to change the name for v4 but neglected to do so. Sounds good,
> will do.

Thanks a lot. I am sorry that I ask you to do so many changes.
I talked about the style early enough to make the review easy.
Also I think that it is not ideal and annoing to do these
mass changes and refactoring when the code is already reviewed,
tested, and functional.

Best Regards,
Petr

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31B31DC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhBQPhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:37:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:38688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233818AbhBQPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:36:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613576136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y772A/eWsZaF+C4wo6knR7WNB2DOoWuGU2pB7dk5yXE=;
        b=eg1H5iBaIisy5a851DH22nhXpD8S3BMnoVsVqVAapXmXDOc5K89ApFwKQvxzHv5jn/+9Az
        WRa480r0lscdzlNklgVhj114uUPgkKQuzmANOZRvxqNhsu2wOOt2hrKyOubCVGLnwNpW82
        tdEQc0on82zPTBZ7mnL1XBlx5T6hxMI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04D35B06A;
        Wed, 17 Feb 2021 15:35:36 +0000 (UTC)
Date:   Wed, 17 Feb 2021 16:35:34 +0100
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
Subject: Re: debugfs: was: Re: [PATCH v4] printk: Userspace format
 enumeration support
Message-ID: <YC03xnsB8586agnT@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCvsGzv3qlsWU+UE@alley>
 <YCv+gpVGHTh9ZMNq@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCv+gpVGHTh9ZMNq@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-16 17:18:58, Chris Down wrote:
> Petr Mladek writes:
> > > +static size_t printk_fmt_size(const char *fmt)
> > > +{
> > > +	size_t sz = strlen(fmt) + 1;
> > > +
> > > +	/*
> > > +	 * Some printk formats don't start with KERN_SOH + level. We will add
> > > +	 * it later when rendering the output.
> > > +	 */
> > > +	if (unlikely(fmt[0] != KERN_SOH_ASCII))
> > > +		sz += 2;
> > 
> > This approach is hard to maintain. It might be pretty hard and error
> > prone to count the size if we want to provide more information.
> > 
> > There are many files in debugfs with not-well defined size.
> > They are opened by seq_open_private(). It allows to add
> > a line by line by an iterator.
> 
> Hmm, this is optional -- it was just to avoid seq_file having to realloc the
> buffer. I originally used an iterator and I'm happy to go back to it if it
> proves more convenient.

Please, go back to iterators ;-)

> > We should revert the changes when the file could not get crated.
> > It does not make sense to keep the structure when the file is not
> > there.
> 
> See the reply from gregkh on v2, who was quite insistent that we should not
> check debugfs error codes. I'm happy to do either, but I can't please you
> both :-)

I see. OK, it typically does not make any sense to handle the error.
The API is safe enough to handle ERR_PTR values. The files allow
to show something. The user will notice when they are not created.

But I believe that our case is different. We need to allocate
a structure, put it into hash table, to be able to show the content
by the debugfs interface. The only purpose of the structure is
to provide information for the debugfs file.

It does not make sense to keep the structure when the file was not
created.

Also it might make sense to print an error to inform the user
the some printk formats might be missing. Well, the error might
make sense only when format for others are shown.

That said, I do not resist on the error handling. The code will
be safe even without it.


> > I guess that remove_printk_fmt_sec() would even crash when
> > ps->file was set to an error code.
> 
> debugfs checks if its input is an error, so it shouldn't, unless that's not
> what you're referring to?

Good to know.

> > > +}
> > > +
> > > +#ifdef CONFIG_MODULES
> > > +static void remove_printk_fmt_sec(struct module *mod)
> > > +{
> > > +	struct printk_fmt_sec *ps = NULL;
> > > +
> > > +	if (WARN_ON_ONCE(!mod))
> > > +		return;
> > > +
> > > +	mutex_lock(&printk_fmts_mutex);
> > > +
> > > +	ps = find_printk_fmt_sec(mod);
> > > +	if (!ps) {
> > > +		mutex_unlock(&printk_fmts_mutex);
> > > +		return;
> > > +	}
> > > +
> > > +	hash_del(&ps->hnode);
> > > +
> > > +	mutex_unlock(&printk_fmts_mutex);
> > > +
> > > +	debugfs_remove(ps->file);
> > 
> > IMHO, we should remove the file before we remove the way how
> > to read it. This should be done in the opposite order
> > than in store_printk_fmt_sec().
> 
> There is a subtle issue with doing this as-is: debugfs_remove(ps->file)
> cannot be called under printk_fmts_mutex, because we may deadlock due to a
> pinned debugfs refcnt if debugfs_remove() and _show happen at the same time.

Do we need to call debugfs_remove(ps->file) under printk_fmts_mutex?

> Imagine we go into remove_printk_fmt_sec and grab printk_fmts_lock. On
> another CPU, we call _show for the same file, which takes a reference in
> debugfs, but it will stall waiting for printk_fmts_lock. Now we go back into
> remove_printk_fmt_sec and can't make any forward progress, because
> debugfs_remove will stall until all reference holders have finished, and
> there is a deadlock.

Sure. But this will not happen when debugfs_remove(ps->file) was
called without the mutex. It is safe. The code will wait here
until all references are released and the file is gone.

It will prevent an non-necessary error when reading file:

CPU0:					CPU1

monitor_check()
  cat debug/printk/formats/*
    open(debug/printk/formats/moduleA)
      # successfully opened the file
      # took reference count

					rmmod moduleA
					  remove_printk_fmt_sec()
					    mutex_lock(&printk_fmts_mutex);
					    hash_del(&ps->hnode);
					    mutex_unlock(&printk_fmts_mutex);

					    debugfs_remove(ps->file);

	debugfs_pf_show()
	  mutex_lock(&printk_fmts_mutex);
	  ps = find_printk_fmt_sec(mod);
	  if (unlikely(!ps)) {
		ret = -ENOENT;

RESTULT: There was no deadlock. The file was opened but the show
	 callback failed.

Best Regards,
Petr

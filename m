Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2E831E9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBRM3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:29:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:38734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhBRKp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:45:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613645111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUYdGfBovPQofBTZOwpzeDRcMqQI0Cs/F1EUZmLN1Og=;
        b=j/Q23nWy3DDqB0knZYFLM3ufccVH6Vlqjyra2RiO1s3T7UvBaB7b3ZemTGW7q68CP70eEU
        wg5LP8GGVgjojxP3IK1rSuckmoksDNdmSiTEUFU3PiM6dbdXk6O/j9UV+uZnxX2PRqeGjL
        260IOflu7cjHtraYDwFafFfcr/wtxf4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D530AE04;
        Thu, 18 Feb 2021 10:45:11 +0000 (UTC)
Date:   Thu, 18 Feb 2021 11:45:10 +0100
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
Message-ID: <YC5FNkSkQ+ez1JvT@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
 <YCwAbGoVuZJspcx5@chrisdown.name>
 <YC0/xQTephcfo6GL@alley>
 <YC1DjeZmBWmJe35c@chrisdown.name>
 <YC1FFVCNQpaJwO/N@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC1FFVCNQpaJwO/N@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-02-17 16:32:21, Chris Down wrote:
> Chris Down writes:
> > open(f);
> >  debugfs_file_get(f);
> >  fops->open();
> >    inode->private = ps;
> >  debugfs_file_put(f);
> > 
> > remove_printk_fmt_sec(); /* kfree ps */
> > 
> > read(f);
> >  debugfs_file_get(f);
> >  fops->read();
> >    ps = inode->private;  /* invalid */
> >  debugfs_file_put(f);
> 
> Er, sorry, inode->private is populated at creation time, not at open(). The
> same general concern applies though -- as far as I can tell there's some
> period where we may be able to _read() and `ps` has already been freed.

Honestly, I am a bit lost here. Also I have realized that you needed to
release the struct from the module going notifier. And there you have
only pointer to struct module.

The thing is that I do not see similar tricks anywhere else. Well, other
users are easier because they create the debugfs file for it own purpose.
In our case, we actually create the file for another module.

Anyway, we are going to use the seq_buf iterator API. IMHO, the
seq_buf iterator functions should be able to get the structure
directly via the data pointer.

I wonder if it is similar to proc_seq_open() and proc_seq_release().
It is using the seq_buf iterator as well. It is created used
by proc_create_seq_private(). This API is used, for example,
in decnet_init(). It is a module, so there must be the similar
problems. All data are gone when the module is removed.

The only remaining problem is the module going notifier. For this
purpose, we could store the pointer to struct module. There
are many other fields for similar purposes. I am pretty sure that
the module loader maintainer will agree.

The result will be using some existing patterns. It should reduce
problems with possible races. It should make the life easier for
all involved APIs.

Best Regards,
Petr

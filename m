Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB45031EB18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhBROpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:45:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:56400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233118AbhBRMj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:39:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613651863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=70e1UsXoaugeK3FBttnq9OkKk7JxPBGr+m2A3TXI9QE=;
        b=a76FU8qH4CBPtxa4C9Rpq1aLEyi5PaoDppoc9CNZTNPfKdkgJiNCP+eo+AbIvIWz8kqtN+
        CNl0fEVDLK/fx5tQwNFDnGtYR6V8PWZzKQadOiaezJERIi6U65RzK4590bL3GR1m2ZArD0
        Na0gnIE3CQjrE+uG/sANY6k4X7kq4ok=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E904ACE5;
        Thu, 18 Feb 2021 12:37:43 +0000 (UTC)
Date:   Thu, 18 Feb 2021 13:37:42 +0100
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
Subject: Re: [PATCH v4] printk: Userspace format enumeration support
Message-ID: <YC5flsiUEZnPs7qz@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YC5b4+hTjrGwG22o@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC5b4+hTjrGwG22o@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 12:21:55, Chris Down wrote:
> Thanks for all your feedback, Petr and Steven. :-)
> 
> Petr, I believe this is a comprehensive checklist of everything we discussed
> for v5 -- any chance you could double check I'm not missing anything you
> folks wanted? Thanks!
> 
> - Use seq_file iterator again instead of simple_open + size
> - Remove debugfs file first to avoid ENOENT
> - Tear down datastructures if debugfs fails
> - Human readable output format
> - Display file/line
> - Rename to CONFIG_PRINTK_INDEX, or... something
> - Move to another file, kernel/printk/debug_formats.c or similar

Just to be sure. The filename should be ideally based on the configure
option and API names, e.g. formats_index.c or so.

The printk_ prefix is not strictly necessary. The file is in printk/
directory. IMHO, we should have used ringbuffer.c but ...


> - Use `struct module *mod` instead of calling it module
> - Add documentation for printk_fmt_sec (or whatever it will be called)
> - Rename things to pf_, pi_, or something
> - See if it's safe to pass a printk_fmt_sec to seq_file instead of a module

Also it might be needed to store the pointer to struct module.

Both things together might allow to remove the global hash table and likely
even the mutex.

> - Handle cont + level
> - Don't expose level/KERN_SOH directly

I can't remember anything else. I am curious how v5 would look like.

Best Regards,
Petr

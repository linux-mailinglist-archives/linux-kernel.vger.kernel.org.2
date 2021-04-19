Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF06363E60
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbhDSJRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:17:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:50112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231637AbhDSJRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:17:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618823804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpdkNQQ+WredKipD8oC4hxSjZOXXr73EFAjOD6MN8Tc=;
        b=mXJOJdrES/8gtffa+Witrr0GPVO0jTqwXS6KVJNJ+UvaM1XrMtDXYeQw0/ERl7ZNTWHvgC
        on5VO2ie8+k/mjWUBv4NWA7XSCuz6wZzP2W7xefTfGqyv7zfZ/UGOk+oDoi0c+O7SuPZ27
        HzMwGD9mdoF3+atVtTb/5SlnpNPZbM4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 660B1AD8D;
        Mon, 19 Apr 2021 09:16:44 +0000 (UTC)
Date:   Mon, 19 Apr 2021 11:16:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YH1Kex8NOr89BJXq@alley>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name>
 <YFHAdUB4lu4mJ9Ar@alley>
 <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
 <YFMvfawY+0CncS8G@alley>
 <YHmXi303WxVZzVwI@chrisdown.name>
 <e9f74575-1ba0-0c06-b370-59d151c72ed6@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9f74575-1ba0-0c06-b370-59d151c72ed6@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-04-19 09:27:43, Rasmus Villemoes wrote:
> On 16/04/2021 15.56, Chris Down wrote:
> > Hey Petr, Rasmus,
> 
> >> This is great point! There are many other subsystem specific wrappers,
> >> e,g, ata_dev_printk(), netdev_printk(), snd_printk(), dprintk().
> >> We should make it easy to index them as well.
> > 
> > These would be nice to have, but we should agree about how we store
> > things internally.
> > 
> > For example, in printk we typically store the level inline as part of
> > the format string at compile time. However, for `dev_printk`, it's
> > passed entirely separately from the format string after preprocessing is
> > already concluded (or at least, not in a way we can easily parse it the
> > same way we do for printk()):
> > 
> >     void dev_printk(const char *level, const struct device *dev, const
> > char *fmt, ...)
> 
> Hm, yeah, for "naked" dev_printk() calls there's no easy way to grab the
> level, for dev_err and friends it's somewhat easier as you could just
> hook into the definition of the dev_err macro. I'm not saying you need
> to handle everything at once, but doing dev_err and netdev_err would get
> you a very long way

It is true that there are many messages printed using
dev_printk(). For example, these rough numbers:

$> git grep pr_err | wc -l
19885
$> git grep dev_err | wc -l
58153

> > One (ugly) way to handle this would be to have a new "level" field in
> > the printk index entry, with semantics that if it's some sentinel value,
> > look at the format itself for the format, otherwise if it's some other
> > value, the level field itself is the level.
> >
> > This will work, but it's pretty ugly. Any better suggestions? :-)

We should use the same algorithm that is used in parse_prefix() called
from vprintk_store(). parse_prefix() updates @level only when
the current value is LOGLEVEL_DEFAULT.

We should set the new field in the printk index entry to
LOGLEVEL_DEFAULT by default. It should be set to a particular level
when it is defined by an extra parameter, like in dev_printk().


> Well, that was more or less exactly what I suggested when I wrote
> 
> > One could also record the function a format is being used with - without
> > that, the display probably can't show a reasonable <level> for those
> > dev_* function.
> 
> But, I think the real question is, why are we/you interested in the
> level at all? Isn't the format string itself enough for the purpose of
> tracking which printks have come and gone? IOW, what about, on the
> display side, simply skipping over some KERN_* prefix if present?

Messages are filtered on consoles by console_loglevel. The loglevel
might be important to decide whether the message is visible or not.

Best Regards,
Petr

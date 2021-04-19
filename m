Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB99363F32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhDSJyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231888AbhDSJyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:54:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A8CA6108B;
        Mon, 19 Apr 2021 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618826020;
        bh=wH18bCtjkakJqzEPxyRBfaKqoZez+Yygk/rpozbagcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJftszcuM/3zhlgFO9ehzxouWBeXH8gy6JcJXMu8RDx1Lp8OXpf00FELhPFJovaio
         jhZ+B6sTm3nAYfJx2LaGBoI/WxPI/iG+Z1OESXSTrMJkJb8CXmH/vj33dc97F8JFvs
         C0MyXTAoJTbxPJ9YR38lG7vcORi/il7l1tTOzY/Q=
Date:   Mon, 19 Apr 2021 11:53:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YH1TIebAQyiMPuvI@kroah.com>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name>
 <YFHAdUB4lu4mJ9Ar@alley>
 <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
 <YFMvfawY+0CncS8G@alley>
 <YHmXi303WxVZzVwI@chrisdown.name>
 <e9f74575-1ba0-0c06-b370-59d151c72ed6@rasmusvillemoes.dk>
 <YH1Kex8NOr89BJXq@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YH1Kex8NOr89BJXq@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:16:43AM +0200, Petr Mladek wrote:
> On Mon 2021-04-19 09:27:43, Rasmus Villemoes wrote:
> > On 16/04/2021 15.56, Chris Down wrote:
> > > Hey Petr, Rasmus,
> > 
> > >> This is great point! There are many other subsystem specific wrappers,
> > >> e,g, ata_dev_printk(), netdev_printk(), snd_printk(), dprintk().
> > >> We should make it easy to index them as well.
> > > 
> > > These would be nice to have, but we should agree about how we store
> > > things internally.
> > > 
> > > For example, in printk we typically store the level inline as part of
> > > the format string at compile time. However, for `dev_printk`, it's
> > > passed entirely separately from the format string after preprocessing is
> > > already concluded (or at least, not in a way we can easily parse it the
> > > same way we do for printk()):
> > > 
> > >     void dev_printk(const char *level, const struct device *dev, const
> > > char *fmt, ...)
> > 
> > Hm, yeah, for "naked" dev_printk() calls there's no easy way to grab the
> > level, for dev_err and friends it's somewhat easier as you could just
> > hook into the definition of the dev_err macro. I'm not saying you need
> > to handle everything at once, but doing dev_err and netdev_err would get
> > you a very long way
> 
> It is true that there are many messages printed using
> dev_printk(). For example, these rough numbers:
> 
> $> git grep pr_err | wc -l
> 19885
> $> git grep dev_err | wc -l
> 58153

You need "-w" :)

And I bet most of those pr_err() should be turned into dev_err(), if
they live in drivers/.

Hm, 12734 of the pr_err() calls do live in drivers/, so most of those
should be dev_err().  Might be something good to throw at interns...

thanks,

greg k-h

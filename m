Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618B131DCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhBQQBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhBQQBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:01:00 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9139DC061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:00:20 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id c3so12546608qkj.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QCz5c6Vj3j++ulPRAaUvRc9melH6ifWxWMvaz0/sclE=;
        b=N1kQ17eOPAiq7GhlylmQGB2qUgmwjmAl7mo3niD0Cbg+YI8sNgLiS/0izE8v4Ju7jj
         AXYSc2ekH0/g9t0dCZzN7nJQt3yMGgpoE2E7xOqNgx9JrxJpNuSeYXK/EkgxuJrZjoJ1
         CzSbClxXg77Fh8Lg8lznnvqAyI/TKOinKuw/uTXhPREBaASB6rLyR1L6hZenEt3slMi8
         2HFQ2dm+ifXmdynt6P1NLiExhsjWgNNOSv8Q9vIdTG6gc++sCZiQbD29Zg1dJo4X2Uwt
         g2/7lzxN4ecWIMyCi7DJjZ5m54CmdmfmcTkbnyDVFatNwTY6G4LzJ+O7XQmK0uFWQ2bx
         fSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QCz5c6Vj3j++ulPRAaUvRc9melH6ifWxWMvaz0/sclE=;
        b=kAW2VZ8QYX+z52mQ4L3D7jsBMA6o0da12c7KzYVp/+Qj5/FAtr7M6nd3O3pE2XLrPF
         laOJndZnySOiSbnExYxaOpF1fUE8cGYCTiS79o7QYoYjj+n+QEdKwVwerpISo3D4Xrn+
         j6vZSRcJiYcZvK+3MSYHROcw/oeUihV/+Bbf2i7ThXRaD+VjN8jSSKERu1gL00x6E39W
         fwu+jPMSe0OfFiU8mJUgBc+w0NA1Gb5Ihyfda0hi97JdlxwSZF6fPd4bk2MnGLeDPxeh
         KrTRiRGYJ9r7HyfmXUCFHwzg+pQJS28RpB8hxpjvKCdVj/5j3BrQ5OkwVjqYAd+9olzv
         HCmg==
X-Gm-Message-State: AOAM531AFck1wl62crUtg58sgRtxdz68r+hOm9TBChcKKlNNAQUC3e+m
        LHBwftZGE+6xxv1dpUPPCe6DZYmWzyzUyA==
X-Google-Smtp-Source: ABdhPJxnS0r+o29d1+W4k+BWjkDoVfHomh9Hp0PxR51wp85CQYBISyNDlryWu8QfYjSMiDX4RSIalA==
X-Received: by 2002:a37:8a04:: with SMTP id m4mr24929995qkd.78.1613577619806;
        Wed, 17 Feb 2021 08:00:19 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 16sm1393855qtz.17.2021.02.17.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:00:19 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:00:18 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YC09kt7Lo9iqAEOp@cmpxchg.org>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
 <YCwAbGoVuZJspcx5@chrisdown.name>
 <YCwycC8hPsPD7ArU@cmpxchg.org>
 <YCwzrLTaE9PwNihj@chrisdown.name>
 <YC06LyPGmytXJ8Iu@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC06LyPGmytXJ8Iu@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 04:45:51PM +0100, Petr Mladek wrote:
> On Tue 2021-02-16 21:05:48, Chris Down wrote:
> > Johannes Weiner writes:
> > > On Tue, Feb 16, 2021 at 05:27:08PM +0000, Chris Down wrote:
> > > > Petr Mladek writes:
> > > > > I wonder if we could find a better name for the configure switch.
> > > > > I have troubles to imagine what printk enumeration might mean.
> > > > > Well, it might be because I am not a native speaker.
> > > > >
> > > > > Anyway, the word "enumeration" is used only in the configure option.
> > > > > Everything else is "printk_fmt"
> > > > >
> > > > > What about DEBUG_PRINTK_FORMATS?
> > > > 
> > > > Hmm, I don't like DEBUG_PRINTK_FMTS because it's not about debugging, it's
> > > > about enumeration, I guess :-)
> > > > 
> > > > The name should reflect that this catalogues the available printks in the
> > > > kernel -- "debugging" seems to imply something different.
> > > > 
> > > > I'm ok with a different name like "printk catalogue" or something like that
> > > > if you prefer. Personally I think "printk enumeration" is fairly clear --
> > > > it's about enumerating the available printks -- but anything that captures
> > > > that spirit is fine.
> > > 
> > > How about config PRINTK_INDEX?
> > 
> > Ah yes, I also like that. PRINTK_INDEX is fine from my perspective and is
> > more straightforward than "enumeration", thanks.
> 
> It is better than enumeration. But there is still the same
> problem. The word "index" is used neither in the code
> nor in the debugfs interface. It is like enabling cars and
> seeing apples.

I assumed code and interface would then also be changed to
printk_index, struct printk_index_section, pi_foo, ...

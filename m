Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1132A066
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245244AbhCBESA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346330AbhCAXoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:44:55 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F225C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 15:44:09 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id c19so653735pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 15:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RTezlDdWlyXLpCOLyoejuYIgRgLCTwDD8YVq+tQaJc8=;
        b=SMEGRkEBp354fEyh/GFvOWpGE747zYZKCkATBRaZTQsjtvIRubMSxLsRxc8oXqidQT
         DmmTlRBrgI2Gk4Foj+nUqGf2/taCScG356x6bZ7gG8Z24ALqmCoiGAhrtMWpI/oPbhCw
         AFAq59StlLTfhFw9M3ah/zARN6Bn6NjhEXnoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RTezlDdWlyXLpCOLyoejuYIgRgLCTwDD8YVq+tQaJc8=;
        b=M/EoKZatTNQ3+XOz2z0blNKH4qZM+IXDdcv8bWXxFlFScNQlA47Cf3jB5ciyOukpCZ
         st9WqeXXoxbE2O++MEBnf3OU/0NKT49V8TdQxWgO5Dqn42qFedBv681kmsEgo04SOuxz
         pM2dGxKmVNv+ZhN5CVp3jCeNSophP9jgJyR6hvCoBz/1rBU3OIYSe7k4u7cXDVVlvp9X
         o7Y+kxCH9kOiGxOBx8y6gK1k4it68u8NfQPII/ty7kFcV/F4l31xeWABObDv9BupJM0J
         tNKlHqFVSUOqR4K+QBjUaVlsC6wjytf+DSy/TlB7kFvB8/52gPX8qwI0D3JPG6PYkjat
         6zGg==
X-Gm-Message-State: AOAM530xtHcjkMDHhISppyrCE4iMd5CWhofL+rsyT++5xRssPLoujfZK
        ANf11BEt3Pua3RBhRbSVAmJVlw==
X-Google-Smtp-Source: ABdhPJyttvCmDvNSHruHFb4bfNVgROsrUVbaW5dCNRyWImvCjjaydTLjSrMwbUXOBijWRs1VeOnCAg==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr1333241pju.11.1614642249086;
        Mon, 01 Mar 2021 15:44:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm4412027pgq.32.2021.03.01.15.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 15:44:08 -0800 (PST)
Date:   Mon, 1 Mar 2021 15:44:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Hariharan Ananthakrishnan <hari@netflix.com>,
        Keerti Lakshminarayan <keerti@netflix.com>,
        Kyle Anderson <kylea@netflix.com>,
        Linux Containers List <containers@lists.linux-foundation.org>,
        stgraber@ubuntu.com, Andy Lutomirski <luto@amacapital.net>
Subject: Re: seccomp: Delay filter activation
Message-ID: <202103011515.3A941F6@keescook>
References: <CAMp4zn9oEb6bJJLQWjSE1AFg6TqwkF3FOvFk2VSkKd+0Kj7TCg@mail.gmail.com>
 <20210301110907.2qoxmiy55gpkgwnq@wittgenstein>
 <20210301132156.in3z53t5xxy3ity5@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301132156.in3z53t5xxy3ity5@wittgenstein>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 02:21:56PM +0100, Christian Brauner wrote:
> On Mon, Mar 01, 2021 at 12:09:09PM +0100, Christian Brauner wrote:
> > On Sat, Feb 20, 2021 at 01:31:57AM -0800, Sargun Dhillon wrote:
> > > We've run into a problem where attaching a filter can be quite messy
> > > business because the filter itself intercepts sendmsg, and other
> > > syscalls related to exfiltrating the listener FD. I believe that this
> > > problem set has been brought up before, and although there are
> > > "simpler" methods of exfiltrating the listener, like clone3 or
> > > pidfd_getfd, but these are still less than ideal.

I'm trying to make sure I understand: the target process would like to
have a filter attached that blocks sendmsg, but that would mean it has
no way to send the listener FD to its manager?

And you'd want to have listening working for sendmsg (otherwise you
could do it with two filters, I imagine)?

> > 	int fd_filter = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_DETACHED, &prog);
> > 
> > 	BARRIER_WAIT_SETUP_DONE;
> > 
> > 	int ret = seccomp(SECCOMP_ATTACH_FILTER, 0, INT_TO_PTR(fd_listener));
> 
> This obviously should've been sm like:
> 
> struct seccomp_filter_attach {
> 	union {
> 		__s32 pidfd;
> 		__s32 pid;
> 	};
> 	__u32 fd_filter;
> };
> 
> and then
> 
> int ret = seccomp(SECCOMP_ATTACH_FILTER, 0, seccomp_filter_attach);

Given the difficulty with TSYNC, I'm not excited about adding an
"apply this filter to another process" API. :)

The prior thread was here:
https://lore.kernel.org/lkml/20201029075841.GB29881@ircssh-2.c.rugged-nimbus-611.internal/

But I haven't had time to follow up. Both Andy and Sargun discuss filter
"replacement", but I'm not a fan of that, since I'd really like to keep
the "additive-only" property of seccomp.

So, I'm still back to wanting an answer to my questions at the end of
https://lore.kernel.org/lkml/202010281503.3D1FCFE0@keescook/

Namely, how to best indicate the point of execution where "delayed"
filters become applied?

If we require supporting the "2b" (launched oblivious target) case
(which I think we must), we need to signal it externally, or via an
automatic trip point.

Since synchronizing with an oblivious target is rather nasty (e.g.
involving ptrace or at least ptrace access checking), I'd rather create
a predefined trip point. Having it be "execve" limits the utility of
this feature for cooperating targets, though, so I think "apply on exec"
isn't great.

struct seccomp_filter_attach_trigger {
	u64 nr;
	unsigned char *filter;
};

seccomp(SECCOMP_ATTACH_FILTER_TRIGGER, 0, seccomp_filter_attach_trigger);

after "nr" is evaluated (but before it runs), seccomp installs the
filter.

And by "installs", I'm not sure if it needs to keep it in a queue, with
separate ref coutning, or if it should be in the main filter stack, but
have an "alive" toggle, or what.

-- 
Kees Cook

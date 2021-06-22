Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD723B0990
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhFVPzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhFVPzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:55:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD284C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:53:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id h15so18190579lfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwo/MhC5LC0KEncK3DG2C2podgit3zr1JlakISdk5lc=;
        b=EekqAlLo38I3+bma4TRfQUoU/27cGolaw5/ao3/1ym1iTDRjXSqaJK56RPEHetSNrU
         cl69eLI5kvNsYfD5bCSlk2NKM/guKT0Vxi8kFK7heezPGm1iuj8Gk/evz2SAI87Ydvuw
         WF17T260tx9+dZfHefOuNan6bAz6vuwSYjfN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwo/MhC5LC0KEncK3DG2C2podgit3zr1JlakISdk5lc=;
        b=oiO1m24wqLzUBENwFUUCDOwR/a6hb8U6/aMmPx4pf4dlaTTBlJwuTUBjWhq1KYGPfA
         TDgii4bzlnlzWJq3DKbRjHMe15Gd4B7pIBdqIMDKVD2jK3dTGSIQBIkbu4zynVlf5qZ+
         03DQBzH7DDFWmZ+sQNeLzGgvA7208nll1oTASTKmQYl2wVaRSKFYUwaLrk2Qnjp3gbO3
         dKY/OeV59FPGHSAfgnpdLjFEZuasY0/HB2ontIDU6tvH7tUzZJ3soEh/pvbn8clpoWqt
         EB1ZiMPKbaE+DHsLZs9vvK/Ll1HHedwxo+45wQdyayjLINz9c0MfhradODVDsC65iePg
         7d/A==
X-Gm-Message-State: AOAM532LUCXO2wVKmw3GaQEwSOIhbOrP6zmDWJ0S7xy3yyAQDVITk4qN
        ViX2IEhE5OBxQhEMj7/kI2UI5PnX2QAtS1cNjno=
X-Google-Smtp-Source: ABdhPJzOLcJKSC5OfSJzuOs9S1CkPTsV1AKMyu1KmhaoLIwn0ckOtf6qwOZX9y4n98DOCHJP2uh8Aw==
X-Received: by 2002:ac2:4281:: with SMTP id m1mr3332240lfh.164.1624377201993;
        Tue, 22 Jun 2021 08:53:21 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id s12sm2260944lfg.44.2021.06.22.08.53.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 08:53:21 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id z22so30795819ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:53:21 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr3838207lji.251.1624377200796;
 Tue, 22 Jun 2021 08:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <3221175.1624375240@warthog.procyon.org.uk> <CAHk-=wgM0ZMqY9fuYx0H6UninvbZjMyJeL=7Zz4=AmtO98QncA@mail.gmail.com>
In-Reply-To: <CAHk-=wgM0ZMqY9fuYx0H6UninvbZjMyJeL=7Zz4=AmtO98QncA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 08:53:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLM_W6W-gk7EJ69Yaoq54x_zj+BJs3Xxt5QRPSDaKCKg@mail.gmail.com>
Message-ID: <CAHk-=wjLM_W6W-gk7EJ69Yaoq54x_zj+BJs3Xxt5QRPSDaKCKg@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     David Howells <dhowells@redhat.com>
Cc:     "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 8:32 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But yes, it could get unmapped again before the actual copy happens
> with the lock held. But that's why the copy is using that atomic
> version, so if that happens, we'll end up repeating.

Side note: search for "iov_iter_fault_in_writeable()" on lkml for a
gfs2 patch-series that is buggy, exactly because it does *not* use the
atomic user space accesses, and just tries to do the fault-in to hide
the real bug.

So you are correct that the fault-in is something people need to be
very wary of. Without the atomic side of the access, it's pure voodoo
programming.

You have two choices:

 - don't hold any filesystem locks (*) over a user space access

 - do the user space access with the atomic versions and repeat (with
pre-faulting to make the repeat work)

There's one special case of that "no filesystem locks" case that I put
that (*) for: you could do a read-recursive lock if the filesystem
page fault path can only ever take read locks. But none of our regular
locks are read-recursive apart from the very special case of the
spinning rwlock in interrupts (see comment in
queued_read_lock_slowpath()).

That special read-recursive model "works", but I would seriously
caution against it, simply because such locks can get very unfair very
quickly. So it's a DoS magnet. It's part of why none of the normal
locking models really have that (any more - rwlocks used to all be
that way).

                     Linus

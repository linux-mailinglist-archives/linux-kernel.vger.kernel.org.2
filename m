Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE32377455
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 00:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhEHWTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 18:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhEHWTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 18:19:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2AC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 15:18:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h4so17937321lfv.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHc9UIBjTxYwQ2qdPehUPMXva9JHKCzKPwFeTF9Fa94=;
        b=heC0caQARc4D7+OqUNzmbrsEYq2uK5KdJ/cWF8iq0+1cYFFdyg+INwvRb25pkTTOsr
         7x7TQNNF36nD2Gmf+fvnO9HRiTdBVsNWjLMZ5jQJk1oktUnPxFyM43QdMrl0YfvfSk9Y
         k9cDINYHtih4EAW+qlMGno1XJVtz6+rOIKDt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHc9UIBjTxYwQ2qdPehUPMXva9JHKCzKPwFeTF9Fa94=;
        b=r06xZJVw9lfr0j2sz2F9pJWxeU+JAR+2zRRi7TUcNZqcZBLHutoggGPxGcTmpVJN7R
         rhbc4t7tAdqAyU5gzLmdhe1JtqU/XAgW7BM2Po0J/2WpcEtM0OeyGBpwv+zK66RIyrKE
         bHSTj2cgozQK4r1mWHxWLEJ0B3pAmHrzPXBgmJC6LLx6EfeAr2Y7JCrcBgYhE6QdduEr
         qXsWZbRCmgDAeEKR93dCeYMhjH271uifURVIwHKc8B8DpBw6IPCOOxFZ/8ad8ku9Mho/
         ZSSWmM2X9/bM5lF9aW8Ks5sA6rh1mZAlsDvk0PHudkemSXUhTi/taGCTgdxzPMlXn5Mh
         baBg==
X-Gm-Message-State: AOAM533i6BdNikuwRDD8e72g0xqsewai9mknhLFQD+zhcHAOcDjDzLWM
        UQtcIs0ymWiI8TnaAbaPWzG+2vU//nwn4hqfqrw=
X-Google-Smtp-Source: ABdhPJyNWRsafqoWPIudHkiSvdU12N/Kbedv4wH/6GBeoWn5Bh1ZkmOLPt5smBGpKXS8yYHiomUEdw==
X-Received: by 2002:a05:6512:3591:: with SMTP id m17mr10936374lfr.302.1620512281747;
        Sat, 08 May 2021 15:18:01 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id w16sm125514lfn.183.2021.05.08.15.18.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 15:18:01 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id h4so17937284lfv.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 15:18:00 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr10956114lfs.377.1620512280216;
 Sat, 08 May 2021 15:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
In-Reply-To: <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 15:17:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
Message-ID: <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 2:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, May 08, 2021 at 01:39:45PM -0700, Linus Torvalds wrote:
>
> > +static inline int prepend_entries(struct prepend_buffer *b, const struct path *path, const struct path *root, struct mount *mnt)
>
> If anything, s/path/dentry/, since vfsmnt here will be equal to &mnt->mnt all along.

Too subtle for me.

And is it? Because mnt is from

     mnt = real_mount(path->mnt);

earlier, while vfsmount is plain "path->mnt".

> > +                     return 2;               // detached or not attached yet
> > +                     break;
>
> ?

Leftover. Good catch.

> > +             parent = dentry->d_parent;
> > +             prefetch(parent);
> > +             error = prepend_name(b, &dentry->d_name);
> > +             if (error)
> > +                     break;
>
> return error, surely?

Surely. Bad conversion to the separate function where I missed one of
the "break" statements.

> FWIW, if we go that way, I would make that

No arguments against that - I tried to keep it with the same structure
it had when it was inside prepend_path().

Which I obviously wasn't very good at (see your fixes above ;), but it
was *meant* to be a minimal patch with no structural change.

                      Linus

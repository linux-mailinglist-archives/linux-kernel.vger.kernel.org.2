Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985D339A9C7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhFCSJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:09:35 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:45897 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhFCSJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:09:34 -0400
Received: by mail-ua1-f49.google.com with SMTP id m23so3783278uao.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llczrUowQbUDxoyW8Fe3w+wZDCFWjdjoD/4x2j+vVJg=;
        b=Xrk/o1WlRoaP8m7dFFhXj1nHF3JRF2UNcgDTxbO5PUjM5F3VtmIuL+9y81MbbHRKs6
         H8MEqgjIcYzrCEujCfLC0p3mJLbkDpBXgGbiPIPAFCjy3WwgO3PEdYvJf31nniA0Gei2
         kOooV/K6xbQuBRB86za14gz/kpVbu4MU2jKjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llczrUowQbUDxoyW8Fe3w+wZDCFWjdjoD/4x2j+vVJg=;
        b=EKYpnVioImHuFNwkxSXCvRW+W1UOceax1M5mqW3f8JEzqPGsNUyNF4+9O5qoustb7l
         4c4grf+U65bJpq2SB5ilAOrz1inYiejHCwC2OF1sqv6RUGM05JW9ECd0eHjb3m94s9NY
         in36eWGQ01vuHUpFYS2/oHrrvNEf/FhEUG4MML9TEGEMfO+Z7cFAz4vFwyOS0ca3kqsC
         JIdOP/2l7zZ9ADOFn2OV5KAk4nvEF4f5nr/6Y9ozXR0oi+1aTqrjk3glc2E2tAeh3FFc
         MKf+hcrOVX+HTb5eE1Pf3q3R1Lj+jUBy/0z/GOfv035JKICZJWMQg0e0od49okdU1UZR
         0oWQ==
X-Gm-Message-State: AOAM531oHH5cKFzCaUeu1Cs9g2CxQYrL1HsgP0oQcrSIuc4YlBNEOr0u
        p23XEEt9BP3QQHihtDatHj6Y6pPvqS+VWYoRUHmAYg==
X-Google-Smtp-Source: ABdhPJwIEosM7UwGjOOqVwRg9ztnWaeH+lJ0LVEs2YTd3Sl9IOmB5t/Z7UPzry6FVBfO8CGl+ftVPdCL9jwH75USFps=
X-Received: by 2002:a1f:32cf:: with SMTP id y198mr603626vky.23.1622743608931;
 Thu, 03 Jun 2021 11:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
 <162218364554.34379.636306635794792903.stgit@web.messagingengine.com> <87czt2q2pl.fsf@disp2133>
In-Reply-To: <87czt2q2pl.fsf@disp2133>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 3 Jun 2021 20:06:38 +0200
Message-ID: <CAJfpegsVxoL8WgQa7hFXAg4RBbA-suaeo5pZ5EE7HDpL0rT03A@mail.gmail.com>
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 at 19:26, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ian Kent <raven@themaw.net> writes:
>
> > If there are many lookups for non-existent paths these negative lookups
> > can lead to a lot of overhead during path walks.
> >
> > The VFS allows dentries to be created as negative and hashed, and caches
> > them so they can be used to reduce the fairly high overhead alloc/free
> > cycle that occurs during these lookups.
> >
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 33 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 4c69e2af82dac..5151c712f06f5 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -1037,12 +1037,33 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
> >       if (flags & LOOKUP_RCU)
> >               return -ECHILD;
> >
> > -     /* Always perform fresh lookup for negatives */
> > -     if (d_really_is_negative(dentry))
> > -             goto out_bad_unlocked;
> > +     mutex_lock(&kernfs_mutex);
> >
> >       kn = kernfs_dentry_node(dentry);
> > -     mutex_lock(&kernfs_mutex);
>
> Why bring kernfs_dentry_node inside the mutex?
>
> The inode lock of the parent should protect negative to positive
> transitions not the kernfs_mutex.  So moving the code inside
> the mutex looks unnecessary and confusing.

Except that d_revalidate() may or may not be called with parent lock held.

Thanks,
Miklos

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C883A3DE218
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhHBWJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhHBWJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:09:15 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982BCC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 15:09:04 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ba4so7442346vsb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0z2frdioc+022ZJhUgkbzYFDHR9K4cOIsQI1uc4I5g=;
        b=d+iHjggGaTAJFXKvT7ICh1fXgLTrnkxVEiEbriozUro5c/4VovjTf8Smb+XYcQyN2G
         TvuQsE9bhwo1yHKONW4HAqQ26ScH5NkJ5+Q8LBT/OZg11J3OpKVWxvI+r6DsNnni2rij
         edGYtbyNfJ6+KBGmehLSA9ouLbdJ+QW/E6cVNZ8Oj+gAdbDG+M1TbVkCWoU3DNTGRKu5
         8mZXWrKdPKjVQydLtlBiXc2LWSBI8YJ/r6dyJ8hvUyiEAPl/F09N3Ro6QMwhCnVFcq2R
         4EmNbhWT26FopKQJaEBmP3vl8hgS7ZaQZ47WzVkdswbfyYvoYmjnzhGQJRsfDu+MTBHE
         GV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0z2frdioc+022ZJhUgkbzYFDHR9K4cOIsQI1uc4I5g=;
        b=KDiqeC8Sp04XNh3VYNbIsNCjFpBQLfyBlJI5R5KUEJzBcCVk901tzAQ1WBXgg6Wq+D
         mXQ+oqRebaDRBkQ5kKsOx9hYfxX66ob7l2r6WRbk4YqN8NXX+FIDOAmHCyKI1wy41hz7
         RAuzuJthGVJm0APbj2dtur0pTL96IyMw5x/BW3lBycnyEbTr/SWBm0TRfvFowXtCUGUk
         cgdjkxZsq6qYAEAAYBVowuqFfqUgy8i20LiGpzeKgOz9i/5JuCrlUUnHC7HhIwo5obCJ
         qad00L0Tc3u+nB6bYbLmGU/6e9aiZgtnleFfNPnC4oFVUr99SDNoC7brjc0k2wp7sbCK
         NhjQ==
X-Gm-Message-State: AOAM533GU2VR2/WnSeGG/e2p5/HIxWFZKpSLBwALIfdR7G1jH1tIzh04
        plozXwWveYs3uQE8fQJFQa+YY+iOC9dMFLWvAPxWZQ==
X-Google-Smtp-Source: ABdhPJz3VJnAruU7LF/LJajnAJKnBJ5aXdpIWlUZFaE4smS8RSaZnhmg2mRIu6WMTJZ/E/+v1qijRY/Z3+iVu3VfJ7E=
X-Received: by 2002:a05:6102:21b:: with SMTP id z27mr12259102vsp.18.1627942143272;
 Mon, 02 Aug 2021 15:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210802174139.1908760-1-ramjiyani@google.com> <CAHRSSEzUcSpWxQzjhGoDsk3uTm=anFri2jHVKDoLrCXVY8i0WA@mail.gmail.com>
In-Reply-To: <CAHRSSEzUcSpWxQzjhGoDsk3uTm=anFri2jHVKDoLrCXVY8i0WA@mail.gmail.com>
From:   Ramji Jiyani <ramjiyani@google.com>
Date:   Mon, 2 Aug 2021 15:08:51 -0700
Message-ID: <CAKUd0B_Dx8E8CyuWoFYTVJLVTLoa0ay9Gtuo=92foUany8QZrg@mail.gmail.com>
Subject: Re: [PATCH] binder: Add invalid handle info in user error log
To:     Todd Kjos <tkjos@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 11:22 AM Todd Kjos <tkjos@google.com> wrote:
>
> On Mon, Aug 2, 2021 at 10:41 AM 'Ramji Jiyani' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > In case of a fail transaction to the target node; user error log currently
>
> nit: I'd rephrase this to something like  "In the case of a failed
> transaction, only the thread and process id are logged. Add the handle
> info..."

Thanks for the review. Submitted v2 with the fix.

>
> > only prints the thread and process id. Add handle info for the reference
> > to the target node in user error log to aid debugging.
> >
> > Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
>
> Acked-by: Todd Kjos <tkjos@google.com>

Thanks for the Ack.

>
> > ---
> >  drivers/android/binder.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index bcec598b89f2..d9030cb6b1e4 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -2547,8 +2547,8 @@ static void binder_transaction(struct binder_proc *proc,
> >                                                 ref->node, &target_proc,
> >                                                 &return_error);
> >                         } else {
> > -                               binder_user_error("%d:%d got transaction to invalid handle\n",
> > -                                                 proc->pid, thread->pid);
> > +                               binder_user_error("%d:%d got transaction to invalid handle, %u\n",
> > +                                                 proc->pid, thread->pid, tr->target.handle);
> >                                 return_error = BR_FAILED_REPLY;
> >                         }
> >                         binder_proc_unlock(proc);
> > --
> > 2.32.0.554.ge1b32706d8-goog
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >

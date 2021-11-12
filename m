Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2717144EBE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhKLRWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:22:03 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48916
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232231AbhKLRWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:22:02 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D66E83F19F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636737550;
        bh=gxk6VajY+mymEu0iayO1IXlVmjEZfe7/jfbVMCqwCUw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=k57hF2N9ukvYvxRGIZeoorSTgLCtAMCG/cqMbpMxOJRQcF0VQ4v6c2K+E9MYUq4pQ
         NjyIVLi3AEXZgqlKMKw1wvRhK42ScEoAFicbO0fv6WiWzORlHp3umXRbaYfYbk31Fu
         kp18gEXaI7QdNGw11Xyr2uN+tpZoHlNyX+w2PGsfqeDTvyDSc9bHgQz3Gm9hxdU9rb
         mDjkmMSZ/9TOmX6BjMhM5C8VslgjV689M8YujOLbeEj19YEoSh+h+nb15u11UW0PHb
         QxLkbFpAeHNpHrNFfrvFwq3ROIyQYoI3GFOJvFxwgG0NAxkelJwTTOxGT7pvjoA844
         dmxVaDFuK6QCg==
Received: by mail-pg1-f197.google.com with SMTP id k22-20020a635a56000000b002df9863aa74so3704527pgm.19
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:19:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxk6VajY+mymEu0iayO1IXlVmjEZfe7/jfbVMCqwCUw=;
        b=f+0R3r3Yl2lc2z+WxSx40XVnXI2Fv6WYbkBL4vx9fhBgAU8CWVq5hYRhZza4gRHIcI
         lL4nf/XqwxBNe5TZNJQ26xkQUG859rLHKP76Lmx9upDdopUYWa6kL8IOkXIaLQBo7XGc
         Cm6ruasPMyId38t7S5Q9oHCc9VlAF3WhKXRvaSniJnZPGixRguNfcQlFW9lLN72U1+pv
         MujLTaKkUW/7/jdiAdkhdv6g6yuS8TQWJy8IK4ZGf2J74s30lqkAZ/DlA6zqNxqU64+0
         fmxRLTnsuliiro8t+hQAQ/26mB5HnfmyX2jMhdEXC57cM5XY1zan8ng49Eu7kWkSsVPz
         jPng==
X-Gm-Message-State: AOAM533nW33Vt5RJQMf9i/IgwZDEhNRRqcCV+rXrAPZQNYBj9x5xscSZ
        5Ip4FO9Ri143sOZDS5scC5gkUNfku8zxxx/VHqdd/yfM6XGZSjDnWZfPIRfviKJUyuxRknVmbHl
        UEbEJjvamX5yAPV8R7isBWDJUqsB9lLaFScaIByYUW4I1E+ud5dWP2rbb+g==
X-Received: by 2002:a05:6a00:a23:b0:43d:e856:a3d4 with SMTP id p35-20020a056a000a2300b0043de856a3d4mr15426650pfh.17.1636737549155;
        Fri, 12 Nov 2021 09:19:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0hYUq4M324GdI6hCCV/M34WZh6reSCGX23+hpq8u80vT2d0h4drXPrM9cTkQifw1fNhLz71kvNLwAHKFhwWA=
X-Received: by 2002:a05:6a00:a23:b0:43d:e856:a3d4 with SMTP id
 p35-20020a056a000a2300b0043de856a3d4mr15426602pfh.17.1636737548759; Fri, 12
 Nov 2021 09:19:08 -0800 (PST)
MIME-Version: 1.0
References: <20211112165413.7747-1-ioanna-maria.alifieraki@canonical.com> <20211112170905.GI4667@minyard.net>
In-Reply-To: <20211112170905.GI4667@minyard.net>
From:   Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Date:   Fri, 12 Nov 2021 19:18:42 +0200
Message-ID: <CAOLeGd0hKQYzsrgFQEd_fB-GdqDN==hq0dZE6_ou+hLVKaohJg@mail.gmail.com>
Subject: Re: [PATCH] ipmi: Move remove_work to dedicated workqueue
To:     minyard@acm.org
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        ioanna.alifieraki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 7:09 PM Corey Minyard <minyard@acm.org> wrote:
>
> On Fri, Nov 12, 2021 at 06:54:13PM +0200, Ioanna Alifieraki wrote:
> > Currently when removing an ipmi_user the removal is deferred as a work on
> > the system's workqueue. Although this guarantees the free operation will
> > occur in non atomic context, it can race with the ipmi_msghandler module
> > removal (see [1]) . In case a remove_user work is scheduled for removal
> > and shortly after ipmi_msghandler module is removed we can end up in a
> > situation where the module is removed fist and when the work is executed
> > the system crashes with :
> > BUG: unable to handle page fault for address: ffffffffc05c3450
> > PF: supervisor instruction fetch in kernel mode
> > PF: error_code(0x0010) - not-present page
> > because the pages of the module are gone. In cleanup_ipmi() there is no
> > easy way to detect if there are any pending works to flush them before
> > removing the module. This patch creates a separate workqueue and schedules
> > the remove_work works on it. When removing the module the workqueue is
> > flushed to avoid the race.
>
> Yeah, this is an issue.  One comment below...
>
> >
> > [1] https://bugs.launchpad.net/bugs/1950666
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 3b9a907223d7 (ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier)
> > Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
> > ---
> >  drivers/char/ipmi/ipmi_msghandler.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > index deed355422f4..9e0ad2ccd3e0 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -191,6 +191,8 @@ struct ipmi_user {
> >       struct work_struct remove_work;
> >  };
> >
> > +struct workqueue_struct *remove_work_wq;
> > +
> >  static struct ipmi_user *acquire_ipmi_user(struct ipmi_user *user, int *index)
> >       __acquires(user->release_barrier)
> >  {
> > @@ -1297,7 +1299,7 @@ static void free_user(struct kref *ref)
> >       struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
> >
> >       /* SRCU cleanup must happen in task context. */
> > -     schedule_work(&user->remove_work);
> > +     queue_work(remove_work_wq, &user->remove_work);
> >  }
> >
> >  static void _ipmi_destroy_user(struct ipmi_user *user)
> > @@ -5383,6 +5385,8 @@ static int ipmi_init_msghandler(void)
> >
> >       atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
> >
> > +     remove_work_wq = create_singlethread_workqueue("ipmi-msghandler-remove-wq");
> > +
>
> Shouldn't you check the return value here?
>

Yes you're right, my bad.
I'll incorporate Christophe's feedback too and send a v2 next week.
Thanks all for the feedback!

> -corey
>
> >       initialized = true;
> >
> >  out:
> > @@ -5408,6 +5412,9 @@ static void __exit cleanup_ipmi(void)
> >       int count;
> >
> >       if (initialized) {
> > +             flush_workqueue(remove_work_wq);
> > +             destroy_workqueue(remove_work_wq);
> > +
> >               atomic_notifier_chain_unregister(&panic_notifier_list,
> >                                                &panic_block);
> >
> > --
> > 2.17.1
> >

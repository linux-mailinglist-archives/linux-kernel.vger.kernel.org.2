Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA6406776
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhIJHF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhIJHF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:05:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B47C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:04:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc21so2228990ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3H4oKYSFY56M3qiNXBl+wyXrV3Q3fK7XNGLdUGoxRYk=;
        b=XEF2dNRdTYcFZ49M5pLnNkQGCRME+D2yb6K0sa6lGGehvguZSeR4VYKb/SB8dsl55o
         MlQTLsfMEN8dRH9TY0LM2p/S2GDgMWhlby19cOyAfHiNLd7xfwmOpibfUxAIpxDDSWVk
         LfuzFhM/z4WSSobVjz8ZB+zSRJ86BWQd2cxWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3H4oKYSFY56M3qiNXBl+wyXrV3Q3fK7XNGLdUGoxRYk=;
        b=y/dOvVLcACKd4m8Pm1FBIiMGf+iNFYA0GczCT8M9y3+jsoyM0a+YIZRah9vxZH6Anu
         YMFGU9sXr+uVsm7F7OR0TryHJF6SJP8PwZHk5Ltyru6nyTtsoiKYNZD6YynaRYIy7b3A
         1Sz8gd9/gXIxyEyTr3hx5YLgfxEwIboSGs8wCsH8Oe9+tLJUku9RfMLIuXeQDtdBjjix
         QK4fPge1Gagutr1JEMD/zKcF1VHjVtf4ibK6BX9Khays9yuJRpGZMK8iiCIovRPE2cFz
         mmQyF9o3m5uxT51o76C9itt9WpSwO2wN3AN6VAI9TGBMGFCI8buzGfiW8Pn04jmq7kSi
         Bh+Q==
X-Gm-Message-State: AOAM531v0MrBo1o8AoP+BhQ6PSmxUaklWEhl2l+EsznQe9BXJBAswwJn
        BnDVmKypPXuLiLTKV+o1cMEvWytt7xieU3qnhW7l1Q==
X-Google-Smtp-Source: ABdhPJzdvpHts5YmnwO9zUbLdQPaUX6UVtZstq71FhyxXpicJP5fSXyIB9Z/lapxzFeS24WqtJwASK/He71YVJeakGo=
X-Received: by 2002:a17:906:180a:: with SMTP id v10mr8039021eje.112.1631257486397;
 Fri, 10 Sep 2021 00:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210909232141.2489691-1-dualli@chromium.org> <20210909232141.2489691-2-dualli@chromium.org>
 <20210910060251.GC7203@kadam>
In-Reply-To: <20210910060251.GC7203@kadam>
From:   Li Li <dualli@chromium.org>
Date:   Fri, 10 Sep 2021 00:04:35 -0700
Message-ID: <CANBPYPgCUgjpX38dNR+SyPVBUTF_go0saTmitO_z+Ox3AgkCdg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] binder: fix freeze race
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Li Li <dualli@google.com>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 11:03 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Sep 09, 2021 at 04:21:41PM -0700, Li Li wrote:
> > @@ -4648,6 +4647,22 @@ static int binder_ioctl_get_node_debug_info(struct binder_proc *proc,
> >       return 0;
> >  }
> >
> > +static int binder_txns_pending(struct binder_proc *proc)
> > +{
> > +     struct rb_node *n;
> > +     struct binder_thread *thread;
> > +
> > +     if (proc->outstanding_txns > 0)
> > +             return 1;
>
> Make this function bool.

Will include the change (as well as the extra ->outstanding_txns
check) in the next revision.
>
> > +
> > +     for (n = rb_first(&proc->threads); n; n = rb_next(n)) {
> > +             thread = rb_entry(n, struct binder_thread, rb_node);
> > +             if (thread->transaction_stack)
> > +                     return 1;
> > +     }
> > +     return 0;
> > +}
> > +
> >  static int binder_ioctl_freeze(struct binder_freeze_info *info,
> >                              struct binder_proc *target_proc)
> >  {
> > @@ -4682,6 +4697,14 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
> >       if (!ret && target_proc->outstanding_txns)
> >               ret = -EAGAIN;
>
> These two lines can be deleted now because binder_txns_pending() checks
> ->outstanding_txns.
>

Thanks,
Li

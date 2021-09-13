Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D19409A86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbhIMRUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhIMRUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:20:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D989FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:18:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id x11so22700182ejv.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4YV9pWz0lzIhd+YfUEnVg61Zq9n7qhIbQA2SNDsEUM=;
        b=aSiTbWmdIw42qZxE1KiBIhTgkbMfBjVrSueGpx83IEEmRKPYwwdohg4G0zgNEjiaBf
         A3N97HrRIEH2iD6tSJfHS8j5OGEK+66a511MEjXsXtNWqdezha/rvXl5wamCr7dJwxQx
         d9CeFkTGUlgcU9SxmAR/UJ8k4pcs4AJ06INUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4YV9pWz0lzIhd+YfUEnVg61Zq9n7qhIbQA2SNDsEUM=;
        b=HpLi9DlP5Tm1Q31ravwWsDV66ltvLMtWa/BvQKUokdZ6r7+lcg3yzP8b7/wd66HbEN
         6tx0dtbRn+52UAW1WRoKAM8X7E/QmDNGUzzXGxXVQUKU4i0fQuxpDSTIU6GLMLpABO9A
         FmbG88ZdTn/kZicD/ORXjG3yE4wKC3obN2u4m1r3X2YwrpHS8APgbt30ZqEqLUBT28Lt
         971WOHM3pShXntT2WkKABPzgDBcHL9POviote14veAFnI6jEkRIASCIBKGFUIHD9jbUO
         GwnOWA+noXqu9Z5Z7uxbWDXkbnkUtuRH5yayCfDVSczXC/VbpNJbKkJJLVEjTo2r1zXY
         0hzg==
X-Gm-Message-State: AOAM532vGQ8iNopEmlNFiqoQBfRQQ7UWMeclNDnbcfqK1T3qnPjuqc8Q
        ZluHwQ0Xh6Vtdk7DE32Ii2eMNLHw36ypxIBBqNdfUQ==
X-Google-Smtp-Source: ABdhPJwBy8jiqgfcAsdKhFh7QuDYJ3+JmILc5ugmtBhg0/74DjYdhgfPxLMM30DsebTSQCj+//8TUAX53O4nxwlqvFg=
X-Received: by 2002:a17:906:180a:: with SMTP id v10mr14105396eje.112.1631553528438;
 Mon, 13 Sep 2021 10:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210910035316.2873554-1-dualli@chromium.org> <20210910035316.2873554-2-dualli@chromium.org>
 <YTrvMSm2oB91IhuK@kroah.com> <CANBPYPgEbFusdyrcV1EqridahQGTH7X=s8ufUA9SMR8SefAO2g@mail.gmail.com>
 <YTsF9OC4QEMl2wp7@kroah.com>
In-Reply-To: <YTsF9OC4QEMl2wp7@kroah.com>
From:   Li Li <dualli@chromium.org>
Date:   Mon, 13 Sep 2021 10:18:37 -0700
Message-ID: <CANBPYPgxSVPxiThHsnCjrf7m+GbZJvszRUqas4fHD6LEoNiD9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] binder: fix freeze race
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Li Li <dualli@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 12:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 09, 2021 at 11:17:42PM -0700, Li Li wrote:
> > On Thu, Sep 9, 2021 at 10:38 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Sep 09, 2021 at 08:53:16PM -0700, Li Li wrote:
> > > >  struct binder_frozen_status_info {
> > > >       __u32            pid;
> > > > +
> > > > +     /* process received sync transactions since last frozen
> > > > +      * bit 0: received sync transaction after being frozen
> > > > +      * bit 1: new pending sync transaction during freezing
> > > > +      */
> > > >       __u32            sync_recv;
> > >
> > > You just changed a user/kernel api here, did you just break existing
> > > userspace applications?  If not, how did that not happen?
> > >
> >
> > That's a good question. This design does keep backward compatibility.
> >
> > The existing userspace applications call ioctl(BINDER_GET_FROZEN_INFO)
> > to check if there's sync or async binder transactions sent to a frozen
> > process.
> >
> > If the existing userspace app runs on a new kernel, a sync binder call
> > still sets bit 1 of sync_recv (as it's a bool variable) so the ioctl
> > will return the expected value (TRUE). The app just doesn't check bit
> > 1 intentionally so it doesn't have the ability to tell if there's a
> > race - this behavior is aligned with what happens on an old kernel as
> > the old kernel doesn't have bit 1 set at all.
> >
> > The bit 1 of sync_recv enables new userspace app the ability to tell
> > 1) there's a sync binder transaction happened when being frozen - same
> > as before; and 2) if that sync binder transaction happens exactly when
> > there's a race - a new information for rollback decision.
>
> Ah, can you add that to the changelog text to make it more obvious?
>
Sure, added that to V3, plus other minor improvements listed in the cover
letter. Please let me know if there's anything else I should continue
to improve.

https://lore.kernel.org/lkml/20210910164210.2282716-1-dualli@chromium.org/

BTW, I had a stress test running, repeatedly freezing and unfreezing a
couple apps every second, which at the same time initiates new binder
transactions in a loop. The overnight stress test during the past
weekend showed positive results. Without this kernel patch, the reply
transaction will fail in tens of iterations. With this kernel patch
and the corresponding user space fix (rescheduling the freeze op to
next second in case race happens), the stress test runs for 24hrs
without a single failure.

Thanks,
Li

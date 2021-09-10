Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20B406723
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 08:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhIJGTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 02:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhIJGTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:19:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCCC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 23:17:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i6so937607edu.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPswZAW7o0vaf27MkZYYDJ2cBqEgZHCY6/Z7/D3pu6Y=;
        b=OIG72E4XQRFTroK4LjVAqB9sdceeW3kBBgRmk22e5RESV1QFT1tqZTIpOXM53SNVth
         5Y69qV6WAqZ7hrRauk3WQEWhFS5h6hKeL0s7X9tIcQ8Yl1zq3E9PJLXakvfH+j8d8CCt
         dbP/q4atNyVOxNoB8cdG6eykTxR7n3JZbKWSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPswZAW7o0vaf27MkZYYDJ2cBqEgZHCY6/Z7/D3pu6Y=;
        b=4kdmdmOyzzb5r/rtqRZIVDO9/ls2el6BAso9ujs/bGm8LnF9yShGOSVAuxec5KJfaT
         zR//321OGzxbhg3rJXVGlJCMzFNGydz4Mv/V3nOLSTkmwJkRv7yCQz9JptTauYU83pmy
         7kfNzFhAtyyHWxvw19YvbyGBuMR5sfYOCiEgBOHvdtwUdguemSgMATtVM4BfqQFcJpTw
         SYp64cwOdnHPsa83jCn+mQ8Po9yBJdwipUjsSfb4xVt0BHefJgfYLfG4Yq4ykek5TwF7
         22RYNApDmR8G2cJj3qptCeM47pUrynWV95Keyw6yxDfa1TI0WIqD3a7e5sadE6jf726W
         DlfQ==
X-Gm-Message-State: AOAM532HXLi2Mv1LWYPA3JRPquXQBC91Ju3bJpYKLco0n75YN4IvUuq8
        Qgg4RJi4XrAz2CqkGkpNzlrl9z76LMr9lw4fwiFo7Q==
X-Google-Smtp-Source: ABdhPJz2hNYb7IsJ/Z8ul3E6XYe/l4+sdHrR6jy4LrPlGs8rfMGdv5WmctwUjSEI2TNaaGaZkKTfcXcMz1tOeHWCFCA=
X-Received: by 2002:a50:ed09:: with SMTP id j9mr7227355eds.164.1631254673244;
 Thu, 09 Sep 2021 23:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210910035316.2873554-1-dualli@chromium.org> <20210910035316.2873554-2-dualli@chromium.org>
 <YTrvMSm2oB91IhuK@kroah.com>
In-Reply-To: <YTrvMSm2oB91IhuK@kroah.com>
From:   Li Li <dualli@chromium.org>
Date:   Thu, 9 Sep 2021 23:17:42 -0700
Message-ID: <CANBPYPgEbFusdyrcV1EqridahQGTH7X=s8ufUA9SMR8SefAO2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] binder: fix freeze race
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Li Li <dualli@google.com>, Todd Kjos <tkjos@google.com>,
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

On Thu, Sep 9, 2021 at 10:38 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 09, 2021 at 08:53:16PM -0700, Li Li wrote:
> >  struct binder_frozen_status_info {
> >       __u32            pid;
> > +
> > +     /* process received sync transactions since last frozen
> > +      * bit 0: received sync transaction after being frozen
> > +      * bit 1: new pending sync transaction during freezing
> > +      */
> >       __u32            sync_recv;
>
> You just changed a user/kernel api here, did you just break existing
> userspace applications?  If not, how did that not happen?
>

That's a good question. This design does keep backward compatibility.

The existing userspace applications call ioctl(BINDER_GET_FROZEN_INFO)
to check if there's sync or async binder transactions sent to a frozen
process.

If the existing userspace app runs on a new kernel, a sync binder call
still sets bit 1 of sync_recv (as it's a bool variable) so the ioctl
will return the expected value (TRUE). The app just doesn't check bit
1 intentionally so it doesn't have the ability to tell if there's a
race - this behavior is aligned with what happens on an old kernel as
the old kernel doesn't have bit 1 set at all.

The bit 1 of sync_recv enables new userspace app the ability to tell
1) there's a sync binder transaction happened when being frozen - same
as before; and 2) if that sync binder transaction happens exactly when
there's a race - a new information for rollback decision.

> thanks,
>
> greg k-h

Thanks,
Li

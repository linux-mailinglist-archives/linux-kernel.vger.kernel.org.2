Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D938840678F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhIJHQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhIJHQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:16:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91624611BD;
        Fri, 10 Sep 2021 07:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631258125;
        bh=4L0BAh+DvGxazIMEC9AKtHADz64tMS4ZKALwhM1qvwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4h89+wzGw1TquKhEONUO+vjD9M/ubpOmYuU6807islJsX/RVc/TtaDrcxaFQP4le
         2GjeGCwb7uHbX1+33HEk3f9V4vfEcgB3qugUdTY92Fo75ou1NObbV+aLYzxDrMPVX7
         /WRI4NRo9tyESIgYOACbzJSmeZXYriK8jx0NpGKA=
Date:   Fri, 10 Sep 2021 09:15:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Li <dualli@chromium.org>
Cc:     Li Li <dualli@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 1/1] binder: fix freeze race
Message-ID: <YTsF9OC4QEMl2wp7@kroah.com>
References: <20210910035316.2873554-1-dualli@chromium.org>
 <20210910035316.2873554-2-dualli@chromium.org>
 <YTrvMSm2oB91IhuK@kroah.com>
 <CANBPYPgEbFusdyrcV1EqridahQGTH7X=s8ufUA9SMR8SefAO2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBPYPgEbFusdyrcV1EqridahQGTH7X=s8ufUA9SMR8SefAO2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 11:17:42PM -0700, Li Li wrote:
> On Thu, Sep 9, 2021 at 10:38 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 09, 2021 at 08:53:16PM -0700, Li Li wrote:
> > >  struct binder_frozen_status_info {
> > >       __u32            pid;
> > > +
> > > +     /* process received sync transactions since last frozen
> > > +      * bit 0: received sync transaction after being frozen
> > > +      * bit 1: new pending sync transaction during freezing
> > > +      */
> > >       __u32            sync_recv;
> >
> > You just changed a user/kernel api here, did you just break existing
> > userspace applications?  If not, how did that not happen?
> >
> 
> That's a good question. This design does keep backward compatibility.
> 
> The existing userspace applications call ioctl(BINDER_GET_FROZEN_INFO)
> to check if there's sync or async binder transactions sent to a frozen
> process.
> 
> If the existing userspace app runs on a new kernel, a sync binder call
> still sets bit 1 of sync_recv (as it's a bool variable) so the ioctl
> will return the expected value (TRUE). The app just doesn't check bit
> 1 intentionally so it doesn't have the ability to tell if there's a
> race - this behavior is aligned with what happens on an old kernel as
> the old kernel doesn't have bit 1 set at all.
> 
> The bit 1 of sync_recv enables new userspace app the ability to tell
> 1) there's a sync binder transaction happened when being frozen - same
> as before; and 2) if that sync binder transaction happens exactly when
> there's a race - a new information for rollback decision.

Ah, can you add that to the changelog text to make it more obvious?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DD6380FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhENSkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhENSko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:40:44 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72372C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:39:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i204so286408yba.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nl4h5VrkNWHTD0QE6o8pfvE3+k011rhQeeh+IZIlLww=;
        b=hNg9UuY89zbrmzgYLlDaITwKxisv6kz6gQ32GwWvHOUgwmBeX67umCGO7uyPcFh7tx
         vALrfWFR4ktZyZv+xtgOrKkHroXVKAaiPFlVT0f0k4IHHjfp7Ih57V7xlsgABOQ/Yv5i
         Qe9tW1tXxAlqQUE+dhqKXwwXzCmYI5bQB1RJ4AmYgEkiapAVevDNiUYZoYUrNWRhO+B5
         nB9v0OIuxd8SjyQUQhNrpq4D/ZT4ZKLijsdkIM2600gnop2qNCZNanf9s+WKDE6+F++f
         nQrPmF4AD/95eyOGCEjfYpHVZ2Xix3hDp4ulJVEuYDPrZoWJhBB2ib/XZOA1YAdVgV5M
         35Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nl4h5VrkNWHTD0QE6o8pfvE3+k011rhQeeh+IZIlLww=;
        b=TzP86r4WGV/5+dOfOec+M8J5QdJ6VBDOzpe0d5yTaoZkDlvh6bxPkZhYO1wUMbH5h/
         S52sqWxJPiL0jbAiDz4pcYyE7T+CM5GjWbNnXTSkmYTVmBH90Md83fXufUSHUd6tDiyk
         W7pjUgQVieZeK/yLBr81Wmz2okgSVtQa7X80F0SGBG+O4GU/cxUPDrydSXIf7qOUpNS7
         PnYM3x5jukrO3iSckgtRQX5G19/eXXq2l7vI+Fv4wmhmItnVOAuf+w6Y8KrvmAGcTbQK
         IpkZB4g8eA6O66VFvW3q/ks5J/BgxUb105o0iwXpk2pn1r8TyqcXiOfehMlV899fRT9A
         enrQ==
X-Gm-Message-State: AOAM533M5m59Xgo5cdt43jn8iHiHASOK+nu7wzrn4q8Ez9RmZo5C4nB5
        F6aNfI2+Jjtyx5q6X3+loUlXgEptzqPtmlDX+lTCQw==
X-Google-Smtp-Source: ABdhPJyWGURmH+UxwDzOuonuEVARTnJZlA/nuSy8mzBtcKF/SbfBNFOSEbAvferWaohoMqujF5efpN4ZarWMnC+x8O0=
X-Received: by 2002:a5b:8cc:: with SMTP id w12mr67435835ybq.32.1621017571357;
 Fri, 14 May 2021 11:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <11761395.O9o76ZdvQC@kreacher> <4326215.LvFx2qVVIh@kreacher>
 <CAGETcx87y-tpSaKRpugons1RZaPC-rdvdueUPuNFJHWDDyrNwQ@mail.gmail.com> <CAJZ5v0ik0GMYg9ru7G=P3-=vmg-LEQo1ZO0Sn99=DJwsPN5-uw@mail.gmail.com>
In-Reply-To: <CAJZ5v0ik0GMYg9ru7G=P3-=vmg-LEQo1ZO0Sn99=DJwsPN5-uw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 14 May 2021 11:38:55 -0700
Message-ID: <CAGETcx-uPLxsQrLK_9R=4-iXZ-ZF-FaZESPGt=O6S8ePuBCs4g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drivers: base: Reduce device link removal code duplication
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:33 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, May 14, 2021 at 6:05 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Fri, May 14, 2021 at 5:12 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Reduce device link removal code duplication between the cases when
> > > SRCU is enabled and when it is disabled by moving the only differing
> > > piece of it (which is the removal of the link from the consumer and
> > > supplier lists) into a separate wrapper function (defined differently
> > > for each of the cases in question).
> > >
> > > No intentional functional impact.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/core.c |   31 +++++++++++++------------------
> > >  1 file changed, 13 insertions(+), 18 deletions(-)
> > >
> > > Index: linux-pm/drivers/base/core.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/core.c
> > > +++ linux-pm/drivers/base/core.c
> > > @@ -198,6 +198,12 @@ static void device_link_synchronize_remo
> > >  {
> > >         synchronize_srcu(&device_links_srcu);
> > >  }
> > > +
> > > +static void device_link_remove_from_lists(struct device_link *link)
> > > +{
> > > +       list_del_rcu(&link->s_node);
> > > +       list_del_rcu(&link->c_node);
> > > +}
> > >  #else /* !CONFIG_SRCU */
> > >  static DECLARE_RWSEM(device_links_lock);
> > >
> > > @@ -232,6 +238,12 @@ int device_links_read_lock_held(void)
> > >  static inline void device_link_synchronize_removal(void)
> > >  {
> > >  }
> > > +
> > > +static void device_link_remove_from_lists(struct device_link *link)
> > > +{
> > > +       list_del(&link->s_node);
> > > +       list_del(&link->c_node);
> > > +}
> > >  #endif /* !CONFIG_SRCU */
> > >
> > >  static bool device_is_ancestor(struct device *dev, struct device *target)
> > > @@ -854,7 +866,6 @@ out:
> > >  }
> > >  EXPORT_SYMBOL_GPL(device_link_add);
> > >
> > > -#ifdef CONFIG_SRCU
> > >  static void __device_link_del(struct kref *kref)
> > >  {
> > >         struct device_link *link = container_of(kref, struct device_link, kref);
> > > @@ -864,25 +875,9 @@ static void __device_link_del(struct kre
> > >
> > >         pm_runtime_drop_link(link);
> > >
> > > -       list_del_rcu(&link->s_node);
> > > -       list_del_rcu(&link->c_node);
> > > +       device_link_remove_from_lists(link);
> >
> > Remind me again why we can't do the synchronize_srcu() here (I'm not
> > too familiar with the SRCU API semantics)? Is it because
> > synchronize_srcu() can take indefinitely long?
>
> Not indefinitely, but it may take time.

More than if we had used normal mutex around these I suppose.

>  And because it is not
> actually useful before we end up freeing the device link memory.  And
> I'd rather not do it under the device links write lock.
>
> > I just vaguely remember
> > it does some checks during CPUs going idle (which can be a long time
> > later) but I'm not sure if that's the earliest you can synchronize. If
> > it's not indefinitely long and we just need to wait for other SRCU
> > critical sections to exit, maybe we can just synchronize here and make
> > the code a lot simpler?
>
> Well, maybe not  "a lot".
>
> > This function is anyway called in a sleepable context.
>
> But I'm not sure how long this context expects to be sleeping and
> sleeping under a mutex potentially blocks others.

Ack.

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

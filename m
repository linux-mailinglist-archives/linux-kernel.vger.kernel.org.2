Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09625380FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhENSe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:34:59 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34577 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhENSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:34:58 -0400
Received: by mail-ot1-f53.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso96105ote.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6GbbFUH/VMpBMHoheQ0ldYJeT1OXV4JklGm9ik7JP4=;
        b=hV2vFjB2wLo7eIFhqYJS+GLViaVmDeQ/efCW+I8QA53cZZUp1uGwLPKF3DUZzujznu
         lcCmkcw/VLeVKuE6mK8rLx8wa9jKomkWTjDihEfjmvg2mdYmzpBwoHtpedeIZ9tzDGN7
         i56sfOiEc45rMre3z01WYRKmpSTIYILrWfqEZHgCuhe8Sh+JO1SoB18JrF7vozYylkBU
         MMjJUO2v8dhGlPMBhsOSSyvsgSKFE/V3w2oSKeY9829N5KGAMGvPoq6/PZtraLASif2Y
         prQUUYZSurbGfiZ+ziBj3aRjuqy5Vf8/GcXAUQy6S7hQlfT+YM0WCiTV8PJ5gynG1/qa
         FJuw==
X-Gm-Message-State: AOAM531dvUoN3Tw6/UpX0kQ3GRUIEqjicLpqMfA3E0dEskciLDQHKh87
        wkpvpybKiRuLhwEYMhXz2xHFdAAh5N12qJRNUlI=
X-Google-Smtp-Source: ABdhPJxbSAWd5d5gmdDdLEgVhf8RZAjBUvLvCQmpkx6a1NqsGWwgML/oVA0pBg5rl85fIc0DM+TaFqohf9bYqe4Q3qo=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr40664239otb.260.1621017224275;
 Fri, 14 May 2021 11:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <11761395.O9o76ZdvQC@kreacher> <4326215.LvFx2qVVIh@kreacher> <CAGETcx87y-tpSaKRpugons1RZaPC-rdvdueUPuNFJHWDDyrNwQ@mail.gmail.com>
In-Reply-To: <CAGETcx87y-tpSaKRpugons1RZaPC-rdvdueUPuNFJHWDDyrNwQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 May 2021 20:33:33 +0200
Message-ID: <CAJZ5v0ik0GMYg9ru7G=P3-=vmg-LEQo1ZO0Sn99=DJwsPN5-uw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drivers: base: Reduce device link removal code duplication
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 6:05 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, May 14, 2021 at 5:12 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Reduce device link removal code duplication between the cases when
> > SRCU is enabled and when it is disabled by moving the only differing
> > piece of it (which is the removal of the link from the consumer and
> > supplier lists) into a separate wrapper function (defined differently
> > for each of the cases in question).
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/core.c |   31 +++++++++++++------------------
> >  1 file changed, 13 insertions(+), 18 deletions(-)
> >
> > Index: linux-pm/drivers/base/core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/core.c
> > +++ linux-pm/drivers/base/core.c
> > @@ -198,6 +198,12 @@ static void device_link_synchronize_remo
> >  {
> >         synchronize_srcu(&device_links_srcu);
> >  }
> > +
> > +static void device_link_remove_from_lists(struct device_link *link)
> > +{
> > +       list_del_rcu(&link->s_node);
> > +       list_del_rcu(&link->c_node);
> > +}
> >  #else /* !CONFIG_SRCU */
> >  static DECLARE_RWSEM(device_links_lock);
> >
> > @@ -232,6 +238,12 @@ int device_links_read_lock_held(void)
> >  static inline void device_link_synchronize_removal(void)
> >  {
> >  }
> > +
> > +static void device_link_remove_from_lists(struct device_link *link)
> > +{
> > +       list_del(&link->s_node);
> > +       list_del(&link->c_node);
> > +}
> >  #endif /* !CONFIG_SRCU */
> >
> >  static bool device_is_ancestor(struct device *dev, struct device *target)
> > @@ -854,7 +866,6 @@ out:
> >  }
> >  EXPORT_SYMBOL_GPL(device_link_add);
> >
> > -#ifdef CONFIG_SRCU
> >  static void __device_link_del(struct kref *kref)
> >  {
> >         struct device_link *link = container_of(kref, struct device_link, kref);
> > @@ -864,25 +875,9 @@ static void __device_link_del(struct kre
> >
> >         pm_runtime_drop_link(link);
> >
> > -       list_del_rcu(&link->s_node);
> > -       list_del_rcu(&link->c_node);
> > +       device_link_remove_from_lists(link);
>
> Remind me again why we can't do the synchronize_srcu() here (I'm not
> too familiar with the SRCU API semantics)? Is it because
> synchronize_srcu() can take indefinitely long?

Not indefinitely, but it may take time.  And because it is not
actually useful before we end up freeing the device link memory.  And
I'd rather not do it under the device links write lock.

> I just vaguely remember
> it does some checks during CPUs going idle (which can be a long time
> later) but I'm not sure if that's the earliest you can synchronize. If
> it's not indefinitely long and we just need to wait for other SRCU
> critical sections to exit, maybe we can just synchronize here and make
> the code a lot simpler?

Well, maybe not  "a lot".

> This function is anyway called in a sleepable context.

But I'm not sure how long this context expects to be sleeping and
sleeping under a mutex potentially blocks others.

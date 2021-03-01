Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C455328114
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhCAOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236463AbhCAOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614609335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hz1YO9pOKdF6lCxgpCIRsUs8IE/9dpDT8udUOXk1C4A=;
        b=cJ/ppSNAuc1fa+NSgqgN7FqncoLF99jz/nLIl/Nu88eiMWcd7J9E7KL8GsREsyr8Nn4tC1
        7w8GgPVDoBiyN1X43U6+ee7nmgVroXyZ56JjHKv+E3cvnChvRozAKoSj9KpA3UToELCkC2
        aplPFgDWwrFPY/AK1kNdXsn07BqT7+g=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96--MAUeGexNq2aw69V-9s8mg-1; Mon, 01 Mar 2021 09:35:34 -0500
X-MC-Unique: -MAUeGexNq2aw69V-9s8mg-1
Received: by mail-yb1-f199.google.com with SMTP id j4so18994157ybt.23
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hz1YO9pOKdF6lCxgpCIRsUs8IE/9dpDT8udUOXk1C4A=;
        b=E/ECyXUUZ4ez1WeoKEyi6feVf2p5v1cG+zSJKjXTjT4VjTU45Kcp3kp0Wi16qqepez
         q/rdISZFWtY4YdKU65hMlOvOj8qreRumx2rnPwsJxXAtURbsk9qvSANXVr5YkfBt8jkw
         jeGUEPIwBCGM+XCYQHtjIr6MJ7jPqTLkp7C51ezkWu2z3jfMel9ZD1+Up33a+7EPbXek
         6XKEqPMVGhb+q/EMzbsHHjwfb7dNeH4oeNSi4CRi/MmWd+7iFruVtiYJnfdpl5dB8idi
         BPsZ9/6t4Qns82q5/QPpVyvZpCW9eCBVkDQlIVVStyNVy4ogMdY9PbZZQAIzzMRYkL4M
         G/3w==
X-Gm-Message-State: AOAM531Xmphy0z+S/qLe4AArJMr7KqaGEMMCFcoqIhO2/+LUnJr30ETv
        t4d0AkuKO6xPPLDNpmJdZd3B8EzJKmO1Si5eiO5gv/GngY7TTAxR2xP7Mx2FqqebGdTnvvFPB9l
        XkDwmUZTB0K1aoC1Yhq1yhnh7SxgqbCYz4wDBiV+T
X-Received: by 2002:a25:ad67:: with SMTP id l39mr24078948ybe.172.1614609333691;
        Mon, 01 Mar 2021 06:35:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqY1iRRABW+DhMsbhwQqiX2RBlXVVGL5YmYqJ9mKfrzM653kOdoIcp8z2DxW2B1DjG382/mdaWg3YJjOViiJ8=
X-Received: by 2002:a25:ad67:: with SMTP id l39mr24078917ybe.172.1614609333458;
 Mon, 01 Mar 2021 06:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
 <CAHC9VhSaU-3_fs83kEA5bxBf9xMsE29B_O5nXFpROk4=y9kgXw@mail.gmail.com>
 <20210226040542.1137-1-hdanton@sina.com> <CAFqZXNu8xyeVUcYud9MLF4yp57dSb4FDyOBDyajh+=SwwomNhQ@mail.gmail.com>
 <20210227023524.15844-1-hdanton@sina.com>
In-Reply-To: <20210227023524.15844-1-hdanton@sina.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 1 Mar 2021 15:35:21 +0100
Message-ID: <CAFqZXNvqz6_RTHDTwKH7J4=DPnngmfXBVE930=y-WQmJL+C-gg@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Hillf Danton <hdanton@sina.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 3:35 AM Hillf Danton <hdanton@sina.com> wrote:
> On Fri, 26 Feb 2021 12:19:35 +0100  Ondrej Mosnacek wrote:
> > On Fri, Feb 26, 2021 at 5:08 AM Hillf Danton <hdanton@sina.com> wrote:
> > > On Thu, 25 Feb 2021 20:06:45 -0500 Paul Moore wrote:
> > > > On Wed, Feb 24, 2021 at 4:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > After the switch to RCU, we now have:
> > > > > 1. Start live conversion of new entries.
> > > > > 2. Convert existing entries.
> > > > > 3. RCU-assign the new policy pointer to selinux_state.
> > > > > [!!! Now actually both old and new sidtab may be referenced by
> > > > > readers, since there is no synchronization barrier previously provided
> > > > > by the write lock.]
> > > > > 4. Wait for synchronize_rcu() to return.
> > > > > 5. Now only the new sidtab is visible to readers, so the old one can
> > > > > be destroyed.
> > > > >
> > > > > So the race can happen between 3. and 5., if one thread already sees
> > > > > the new sidtab and adds a new entry there, and a second thread still
> > > > > has the reference to the old sidtab and also tires to add a new entry;
> > > > > live-converting to the new sidtab, which it doesn't expect to change
> > > > > by itself. Unfortunately I failed to realize this when reviewing the
> > > > > patch :/
> > > >
> > > > It is possible I'm not fully understanding the problem and/or missing
> > > > an important detail - it is rather tricky code, and RCU can be very
> > > > hard to reason at times - but I think we may be able to solve this
> > > > with some lock fixes inside sidtab_context_to_sid().  Let me try to
> > > > explain to see if we are on the same page here ...
> > > >
> > > > The problem is when we have two (or more) threads trying to
> > > > add/convert the same context into a sid; the task with new_sidtab is
> > > > looking to add a new sidtab entry, while the task with old_sidtab is
> > > > looking to convert an entry in old_sidtab into a new entry in
> > > > new_sidtab.  Boom.
> > > >
> > > > Looking at the code in sidtab_context_to_sid(), when we have two
> > > > sidtabs that are currently active (old_sidtab->convert pointer is
> > > > valid) and a task with old_sidtab attempts to add a new entry to both
> > > > sidtabs it first adds it to the old sidtab then it also adds it to the
> > > > new sidtab.  I believe the problem is that in this case while the task
> > > > grabs the old_sidtab->lock, it never grabs the new_sidtab->lock which
> > > > allows it to race with tasks that already see only new_sidtab.  I
> > > > think adding code to sidtab_context_to_sid() which grabs the
> > > > new_sidtab->lock when adding entries to the new_sidtab *should* solve
> > > > the problem.
> > > >
> > > > Did I miss something important? ;)
> > >
> > > If the convert pointer can be derefered without lock, we can opt to
> > > convert context after building sidtab with the risk of AB BA deadlock
> > > cut. Below is the minimum change I can think of along your direction.
> >
> > We could fix this a bit more easily by just having a shared spinlock
> > for both (well, *all*) sidtabs. Yes, we'd need to have it all the way
>
> Looking forward to reading how to add another BKL,

This is not even remotely comparable to the Big Kernel Lock... 99.9%
of the time, there will be just one sidtab, otherwise there will be
just two for a short time during the policy reload, which need to be
updated in sync anyway.

>
> > up in selinux_state and pass it through to sidtab_init(), but IMHO
> > that's less bad than trying to get it right with two locks.
>
> instead of a nearly pure code churn in order to walk around deadlock.

I wish it were that simple, but it won't work this way. Consider a
scenario like this:
1. Thread A acquires the old policy pointer, encounters a new context,
adds it to the old sidtab as X, but doesn't start adding it to the new
one yet.
2. Thread B acquires the new policy pointer, encounters a different
new context and adds it to the new sidtab as X.
[Now you end up with two different contexts assigned to the same SID,
depending on the policy]
3. Now thread A continues to add the context to the new sidtab, but
since it reuses the count variable from before, it overwrites the
entry for X.
(And even if you fixed that, re-searched the new sidtab, and added the
new context to the end, you'd end up with the context having different
SIDs under the old vs. new policy, which is again a messy situation.)

You see, moving the sidtab code around can get you in trouble and
that's why I'm advocating for using a common lock - it's much easier
to prove that such change doesn't create new bugs. And as I said
above, merging the locks won't really have performance consequences,
so I still believe it to be the better choice here.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


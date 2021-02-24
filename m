Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43125323992
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhBXJhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:37:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234194AbhBXJg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614159302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xDpumoxA9uXAvbvE4QJIt1iLqbsCBPKNd/TgxemxMkY=;
        b=HND5w+ePLX1iHArWVqcP/jRxGV2AcLQMhq9ExQCxbEOpEM++jZIFog1HWp+Zp52/E36CvA
        WUdlmz1jtBwEG9LKy79zR1AuaXIJTVisZWml0Qbkey0dlf+RLXa5cIrT5zovR4rUF3KpjY
        0v7wMOosRoKUUnepmg8CqDL5bZr97YM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-5u2YJtXdPzq3ZLZEmHiVig-1; Wed, 24 Feb 2021 04:33:57 -0500
X-MC-Unique: 5u2YJtXdPzq3ZLZEmHiVig-1
Received: by mail-yb1-f200.google.com with SMTP id q77so1804147ybq.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDpumoxA9uXAvbvE4QJIt1iLqbsCBPKNd/TgxemxMkY=;
        b=Ck/PPV3GJjyo9n5B9H6XyV8iozi+DiJZ27L8HocAFVQroUcyISYT/PNtb2dG8IdNQ6
         /ZeTq6fvUIEcF7a6KKyFV8ZIH4O4cY2hzh/cg2yZhYgJJqYz6pOboDTXliiNG0QYIerp
         YHbys/VAlCMj/liDPlUiSexkbn8K7WN7fVapcmf/PKnRGZZE/kHF/fwYLsCKY6uiqaKO
         DJUP0t1imselA9Ji5xDLW1NLWN96sLPsMQ7yB2fWma1AMyHB/5LcE847VltEA9RHLGPa
         GGiHSCj/ez6i70zOEpq2+8h0A9sdNVFgBWaUJYmih+T5af/bJ0QzRnIErFovkLB3vS0Q
         j7jQ==
X-Gm-Message-State: AOAM531hmlum/ttosVXbv2ScjdUqzpKMDbUOPOQUkse6bKI/lFtoy0YA
        uxwkSRU07aRQEfNOoIXhs0KFcTzzldqHopKPtcsVnwxkGWCeetx76ZqMRpKsZQSyIebBv5v3xp6
        TRChKw/10NghuAUKURazx48kFdyTZLHAktOjCGP/7
X-Received: by 2002:a5b:ac2:: with SMTP id a2mr44758936ybr.81.1614159236717;
        Wed, 24 Feb 2021 01:33:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpYwp7rz1tdZc6MVyGEegVfNnPphVXA8W4qlR+z7XNIP7BwBVjfbStjkgQyv4w9jES9ZUs+L1LQu9g9Lts1ZU=
X-Received: by 2002:a5b:ac2:: with SMTP id a2mr44758913ybr.81.1614159236426;
 Wed, 24 Feb 2021 01:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia> <20210223223652.GD6000@sequoia>
In-Reply-To: <20210223223652.GD6000@sequoia>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 24 Feb 2021 10:33:46 +0100
Message-ID: <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:37 PM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
> On 2021-02-23 15:50:56, Tyler Hicks wrote:
> > On 2021-02-23 15:43:48, Tyler Hicks wrote:
> > > I'm seeing a race during policy load while the "regular" sidtab
> > > conversion is happening and a live conversion starts to take place in
> > > sidtab_context_to_sid().
> > >
> > > We have an initial policy that's loaded by systemd ~0.6s into boot and
> > > then another policy gets loaded ~2-3s into boot. That second policy load
> > > is what hits the race condition situation because the sidtab is only
> > > partially populated and there's a decent amount of filesystem operations
> > > happening, at the same time, which are triggering live conversions.
>
> Hmm, perhaps this is the same problem that's fixed by Ondrej's proposed
> change here:
>
>  https://lore.kernel.org/selinux/20210212185930.130477-3-omosnace@redhat.com/
>
> I'll put these changes through a validation run (the only place that I
> can seem to reproduce this crash) and see how it looks.

Hm... I think there is actually another race condition introduced by
the switch from rwlock to RCU [1]... Judging from the call trace you
may be hitting that.

Basically, before the switch the sidtab swapover worked like this:
1. Start live conversion of new entries.
2. Convert existing entries.
[Still only the old sidtab is visible to readers here.]
3. Swap sidtab under write lock.
4. Now only the new sidtab is visible to readers, so the old one can
be destroyed.

After the switch to RCU, we now have:
1. Start live conversion of new entries.
2. Convert existing entries.
3. RCU-assign the new policy pointer to selinux_state.
[!!! Now actually both old and new sidtab may be referenced by
readers, since there is no synchronization barrier previously provided
by the write lock.]
4. Wait for synchronize_rcu() to return.
5. Now only the new sidtab is visible to readers, so the old one can
be destroyed.

So the race can happen between 3. and 5., if one thread already sees
the new sidtab and adds a new entry there, and a second thread still
has the reference to the old sidtab and also tires to add a new entry;
live-converting to the new sidtab, which it doesn't expect to change
by itself. Unfortunately I failed to realize this when reviewing the
patch :/

I think the only two options to fix it are A) switching back to
read-write lock (the easy and safe way; undoing the performance
benefits of [1]), or B) implementing a safe two-way live conversion of
new sidtab entries, so that both tables are kept in sync while they
are both available (more complicated and with possible tricky
implications of different interpretations of contexts by the two
policies).

[1] 1b8b31a2e612 ("selinux: convert policy read-write lock to RCU")

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


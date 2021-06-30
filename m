Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076D13B88C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhF3SyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhF3SyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:54:17 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37650C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 11:51:48 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id s129so6685027ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoBBBmTYhX92RzZNabmusTXUOu2aNFXN3aBTat+PLK8=;
        b=daVFivh6Fo86bv1Wet55ewJd8qrwOGm5ItRJ1EZ981lvQzwAQtcVcr528OLJT0AUrZ
         uPGqoruHC6FgqMwQmnVIHpZsWdvftIcPQiJTh36OpuWLYufqvDrGcZmo1EriiSuNz4e6
         ewBX7MlZFA4irWaGblZqYZZL6XX8cP6V0WPRPIeLkHoOuXvNqH68Y1t2W+60n5UrL1q4
         Lec3YL7rigYCRThrHT1oeZV47Av1+9FbORqyDORYJ3Va82PSX3CP1/IyYPkUPB2mxynQ
         H7zh/GZIicKa7n04VUE/s7aCo9EVClCt7RAs7JZHCQdbpUCf1HZfGEyHMQ6gb2JalHzd
         t43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoBBBmTYhX92RzZNabmusTXUOu2aNFXN3aBTat+PLK8=;
        b=oIEk+vLPFpOJwsBt/5dyu3Pt9aLoqiFCLVRn9gLMORBc7kseqF1L2EdNA0DgIbUdZ0
         OI4qfQdURo7fo2sJ2DcazAm+T72ESdfVR3PnhZC5ZudddFzoXEenUcvT/wPVEslPi4mQ
         STs4A7GBY5YuL8CJHuSmQNfOXNPWX+0dkCt2wjVeE79dRDtUkssE62DWHOgtj0BrI+n4
         lW1alNdJGtnD8PWnRqPDFgq+4fnc5BoQcqJJex+fYAi5RgM57d4Qeg7LAKKmsn0h7BpA
         gOJS2fJh8GIBUkjugxLdwlekqlxA+bdcxvtwLnTr92PgFbA2xum697c/3ID09oh0nCe+
         9mZA==
X-Gm-Message-State: AOAM531tnD76/XhGCBY84ZB3lll6hOKZStDMFLetCdQ9MxpTddVHa+Wg
        HyCRKp8KOuxOhtmg39a1JQqgLsiz9lGBmQHW2asrDw==
X-Google-Smtp-Source: ABdhPJyKK+cDCxlBFy6A3X6BxKdCqBpHbAJ2DvVH7Xvrh+mJ3LBI5f4jNcPY6g5WKChTsyfqL2YzAZxR02WbxRbPTiU=
X-Received: by 2002:a25:d913:: with SMTP id q19mr48111254ybg.397.1625079107259;
 Wed, 30 Jun 2021 11:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
In-Reply-To: <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 30 Jun 2021 11:51:36 -0700
Message-ID: <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Jun 23, 2021 at 12:28 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > In modern systems it's not unusual to have a system component monitoring
> > memory conditions of the system and tasked with keeping system memory
> > pressure under control. One way to accomplish that is to kill
> > non-essential processes to free up memory for more important ones.
> > Examples of this are Facebook's OOM killer daemon called oomd and
> > Android's low memory killer daemon called lmkd.
> > For such system component it's important to be able to free memory
> > quickly and efficiently. Unfortunately the time process takes to free
> > up its memory after receiving a SIGKILL might vary based on the state
> > of the process (uninterruptible sleep), size and OPP level of the core
> > the process is running. A mechanism to free resources of the target
> > process in a more predictable way would improve system's ability to
> > control its memory pressure.
> > Introduce process_reap system call that reclaims memory of a dying process
> > from the context of the caller. This way the memory in freed in a more
> > controllable way with CPU affinity and priority of the caller. The workload
> > of freeing the memory will also be charged to the caller.
> > The operation is allowed only on a dying process.
>
> At the risk of asking a potentially silly question, should this just
> be a file in procfs?

Hmm. I guess it's doable if procfs will not disappear too soon before
memory is released... syscall also supports parameters, in this case
flags can be used in the future to support PIDs in addition to PIDFDs
for example.
Before looking more in that direction, a silly question from my side:
why procfs interface would be preferable to a syscall?

>
> Also, please consider removing all mention of the word "reap" from the
> user API.  For better or for worse, "reap" in UNIX refers to what
> happens when a dead task gets wait()ed.  I sincerely wish I could go
> back in time and gently encourage whomever invented that particular
> abomination to change their mind, but my time machine doesn't work.

I see. Thanks for the note. How about process_mem_release() and
replacing reap with release everywhere?

>
> --Andy

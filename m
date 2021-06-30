Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144B93B8868
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhF3S3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232929AbhF3S3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:29:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74543613B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625077591;
        bh=NiDKvaoHWhQWL7LZpA/F0WCrtvRRTYSJpDsh8l1Scc0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QDCDUmbgFSULOVxOXrFfEkiMtguCg7CaYaNWarqdebj6ngB5MDNNqjXNV1u0u5f6G
         fTaA30rQX1sUwWOw0++2tJRH3+SQRUgiIPRWJxBI5ae5UDPXWAYXkgvXRG4dJqbfqs
         JpGGC3wzMoUrB+/vQOiXA4nCnl+fyqv9QoYUCBRXUlM1IT+J+cjt+jJ/bzmlMIWG0J
         OsXs8xGBzEXX3ecsSJHya09bObnovQfqMdtw6QBhM80Jgw6aXvUh1kH0EeawftfBdI
         S5RCPnU1v/38EmeUBcvz/JUw5+t3PHlHy28fJnba0AP8bKlo/7ou5wFC9RnkXTpHzW
         Sninjvx+DvNZg==
Received: by mail-ej1-f45.google.com with SMTP id yy20so5831306ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 11:26:31 -0700 (PDT)
X-Gm-Message-State: AOAM531SagV2Eu4xqTOiJy7GwRZq1+cCjoxGmGSxoj4/GcwFPaZtIkZy
        iAmo0r2TEIhqNdcVNQ1kFaCsaXvxFYD0fhaBvOPXhA==
X-Google-Smtp-Source: ABdhPJyVpRp+MrbZ/NDxiBqc8BHandsXdJxtq3YXXo39g1rzU6iO0EtDXnr7P9D+TuDyBcYLS2TxQiVvxc1oSGA9+nU=
X-Received: by 2002:a17:906:cb81:: with SMTP id mf1mr37639978ejb.199.1625077589941;
 Wed, 30 Jun 2021 11:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com>
In-Reply-To: <20210623192822.3072029-1-surenb@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 30 Jun 2021 11:26:18 -0700
X-Gmail-Original-Message-ID: <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
Message-ID: <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Suren Baghdasaryan <surenb@google.com>
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

On Wed, Jun 23, 2021 at 12:28 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> In modern systems it's not unusual to have a system component monitoring
> memory conditions of the system and tasked with keeping system memory
> pressure under control. One way to accomplish that is to kill
> non-essential processes to free up memory for more important ones.
> Examples of this are Facebook's OOM killer daemon called oomd and
> Android's low memory killer daemon called lmkd.
> For such system component it's important to be able to free memory
> quickly and efficiently. Unfortunately the time process takes to free
> up its memory after receiving a SIGKILL might vary based on the state
> of the process (uninterruptible sleep), size and OPP level of the core
> the process is running. A mechanism to free resources of the target
> process in a more predictable way would improve system's ability to
> control its memory pressure.
> Introduce process_reap system call that reclaims memory of a dying process
> from the context of the caller. This way the memory in freed in a more
> controllable way with CPU affinity and priority of the caller. The workload
> of freeing the memory will also be charged to the caller.
> The operation is allowed only on a dying process.

At the risk of asking a potentially silly question, should this just
be a file in procfs?

Also, please consider removing all mention of the word "reap" from the
user API.  For better or for worse, "reap" in UNIX refers to what
happens when a dead task gets wait()ed.  I sincerely wish I could go
back in time and gently encourage whomever invented that particular
abomination to change their mind, but my time machine doesn't work.

--Andy

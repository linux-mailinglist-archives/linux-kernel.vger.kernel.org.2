Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34FA3B8B64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 02:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbhGAAra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 20:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237629AbhGAAr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 20:47:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24B3C61425
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 00:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625100300;
        bh=KzOU5etl1m1d6bSza+N7XM/HsZQCAVW9hItb7YjwLWk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vP0y52s97JHm7o5r0zUZ7tZ8hbWtss6Xiwg/vW6zq04Yhvrn1TY739q7wRQkpY3Ih
         7NS0cRRC5kLSOWvssCCLZs+venx9AQbh1X41vDVElXDHiYqZTIVJ/IRwuBatni9rN1
         o8xCWdh/kY3sF1alOTCk/3c63qFgwYNyWinW/lIkF7L/aV/NbYo3xSO4K1UenZMN7K
         fJwGc8ji5I2hznWblF0kFJiUmclM3GassBfR9Gvm/9V26dS1KPGx1meUH1aMpTpAVQ
         ijbhnveRQeKt+eGjKup2tBc8mnsCDdYY46FBHxT1Qp4Z7IbROvM9drHG5szJjlLRUp
         SMMaL2GPs2G8g==
Received: by mail-lf1-f42.google.com with SMTP id d16so8539857lfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 17:45:00 -0700 (PDT)
X-Gm-Message-State: AOAM532LhRxYLGsr8qZ11/NGC9o7YXjx8iiMtjtlnSPUD4om61vD6p7r
        nhwV3eFbd7apn01qc3n6Ni8MkVAjxrZlffV03IZs7w==
X-Google-Smtp-Source: ABdhPJzAb4C5+RtXDup6dhfGpilzWVw9K1ZS6+rN2ZPScS4npWvUVa7PsUSb5+URoJ6pBUECpl3Clp6njJO4GDxxVmc=
X-Received: by 2002:a17:907:1c98:: with SMTP id nb24mr17429770ejc.316.1625100287892;
 Wed, 30 Jun 2021 17:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com> <YNzl6XNu2vxyCJu8@cmpxchg.org>
In-Reply-To: <YNzl6XNu2vxyCJu8@cmpxchg.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 30 Jun 2021 17:44:36 -0700
X-Gmail-Original-Message-ID: <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
Message-ID: <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
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

On Wed, Jun 30, 2021 at 2:45 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Jun 30, 2021 at 11:51:36AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jun 30, 2021 at 11:26 AM Andy Lutomirski <luto@kernel.org> wrote:
> > > Also, please consider removing all mention of the word "reap" from the
> > > user API.  For better or for worse, "reap" in UNIX refers to what
> > > happens when a dead task gets wait()ed.  I sincerely wish I could go
> > > back in time and gently encourage whomever invented that particular
> > > abomination to change their mind, but my time machine doesn't work.
> >
> > I see. Thanks for the note. How about process_mem_release() and
> > replacing reap with release everywhere?
>
> I don't quite understand the objection. This syscall works on tasks
> that are at the end of their life, right? Isn't something like
> process_mreap() establishing exactly the mental link we want here?
> Release is less descriptive for what this thing is to be used for.

For better or for worse, "reap" means to make a zombie pid go away.
From the description, this new operation takes a dying process (not
necessarily a zombie yet) and aggressively frees its memory.  This is
a different optioneration.

How about "free_dying_process_memory"?

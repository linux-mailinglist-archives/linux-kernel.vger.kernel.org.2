Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191F745012A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbhKOJZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbhKOJYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:24:44 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3267FC061210
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:21:15 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id l24so29133940uak.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZRzmfr33ksKeGczCmevzip8qq4bvVpQ08XPdQssnGM=;
        b=Y84O2jZqcupp8FDVBul7yU6K8vTd5w3H9tzfxrA7LsguHQZteSZok4EkX2CPJY7dZn
         3w8nxo4AjZrg+As2RYcufNPbIGt69kE8Vljtp8OCBe5Ejr0+zQ5J+aQDF3h9zQEnl9mC
         ASWxFDzY2HScF4fbXg1VHe2h/605lZgd2tF1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZRzmfr33ksKeGczCmevzip8qq4bvVpQ08XPdQssnGM=;
        b=1Ckr/56AAjFXcTMok/PZSdUsMu4p1aYC5mw30KO4O5kxKfcAZ396IxjPch/tLee11J
         sOh10ek78aRjs1AzVUSuNWEXZ8PDrztmRehoKD3834aNLT5FvbQaSCxINRttmlJWM3ac
         +BBEkQAxxL7m02RIWVNHhJHiJaTEBTOWitx5Jnu80QDoqpt7hRmIR6qe4ERRX2pv+4Kz
         5iynPjDqN7oV7D1ZlaLEwTbVLMKzyPt+nsHtc7IaXispOwhWLsQmDic9fobH/TMmDO/1
         6SX5fR79Iwt8QfbMBQXV8Zt8b3uPKd5IMpuN3bP0igdAJfOnNZCgN+IvKHPfvj2axgi7
         95Jg==
X-Gm-Message-State: AOAM530zhomVzHaX69ogNYmBM/jYIj9BUuB7Zn7miBqGvXGcw7Ft71N9
        AKWdswBO5MqfhNOhyEzNNH7S69CeeIjvyLTh/kkbAJo1jRtgvA==
X-Google-Smtp-Source: ABdhPJz6Az5+mHWva6UQPGv4CesuEhoWD83B1tbTD9++PDTzvwyfRwLJrKTpW6bVxPpoAioKST8WlGxph+8gyAztdMA=
X-Received: by 2002:a67:ec94:: with SMTP id h20mr39959755vsp.59.1636968074344;
 Mon, 15 Nov 2021 01:21:14 -0800 (PST)
MIME-Version: 1.0
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
 <20211112003249.GL449541@dread.disaster.area> <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
 <20211114231834.GM449541@dread.disaster.area>
In-Reply-To: <20211114231834.GM449541@dread.disaster.area>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 15 Nov 2021 10:21:03 +0100
Message-ID: <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ian Kent <raven@themaw.net>, xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 at 00:18, Dave Chinner <david@fromorbit.com> wrote:
> I just can't see how this race condition is XFS specific and why
> fixing it requires XFS to sepcifically handle it while we ignore
> similar theoretical issues in other filesystems...

It is XFS specific, because all other filesystems RCU free the in-core
inode after eviction.

XFS is the only one that reuses the in-core inode object and that is
very much different from anything the other filesystems do and what
the VFS expects.

I don't see how clearing the quick link buffer in ext4_evict_inode()
could do anything bad.  The contents are irrelevant, the lookup will
be restarted anyway, the important thing is that the buffer is not
freed and that it's null terminated, and both hold for the ext4,
AFAICS.

I tend to agree with Brian and Ian at this point: return -ECHILD from
xfs_vn_get_link_inline() until xfs's inode resue vs. rcu walk
implications are fully dealt with.  No way to fix this from VFS alone.

Thanks,
Miklos

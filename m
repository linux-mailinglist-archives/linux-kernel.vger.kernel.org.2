Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F45C4344E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 08:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJTGDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 02:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhJTGDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 02:03:45 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B989C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 23:01:32 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o83so8362971oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIod1o3qhCZvdW0ahsuaYBYhDgjj8nBMGLLNc7+K8Sw=;
        b=ZssLsRHBs4knpZ/LNOGmB6tMsO7Vf8u3B+7q4N/kKhDJ+qFdXnqnTp1l0TdZ6AGLXg
         eCEIQMclebzzVTUemUlS2Nr2qEs8vKNOfmBfh+bIdPvdWQpSmAE5IRSnvJ+ZMVo27Mqz
         2sWXtztztjlj1Z+Dlt/8yNncFRd6KxlysKCaatYnrSdmdgKjjaa4LZZxRMIjG1BtmDkw
         LRxLyS+VPGvn6fQhbllcntcVt7j1ZewPEeaaUrvMRrRsv4tpoXa7fw0uqBSBNtWniPXm
         JriYxB5AwpwqKFEleoGSEZLZWw2KGeNyZBqMGUs4Ea60g3hCAo8bFlW1p3SPzuzTGzRp
         WCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIod1o3qhCZvdW0ahsuaYBYhDgjj8nBMGLLNc7+K8Sw=;
        b=UpxyfdYiSYQB8g9lkZWpnSqsitx7hFHfu0Qgi+cdL/wBG+yPDJB2zBwq2C3oOMKuJq
         fht8ZfDyXvtp6WDJYgjMGrsU3Q9NgeOZgBHDNrun0MTr8hNA6vnDbgVrMdRBBSntoZSu
         xyrCAA8xYHbgFkFhvzYAZ1Q2zhTOjYY27hRwl0lgFTKgGgTRQ4byZPQqJS1sFRMTXPA/
         pnKLLo4SrWVDIKF4DvAyvqWYb7F6hHwofX8DE/Y87a4k9XfG6HN/t1zkHgvZh/pTikxM
         XmulJK085hDxDzk/aFcMlHwNvfOPui2seV0Mk5Sml2tlUdHUYw2inby6TtsUGDjXdeau
         Yllw==
X-Gm-Message-State: AOAM531PLRTHrRRujwru9kGLs57Lxo7q5R2s+k0+z8HRed10gE4EBvjZ
        X7YyB8J8jhR6ZwsFhF6EjTCSPvKQXlLrtL0yiH6Lfw==
X-Google-Smtp-Source: ABdhPJzd5qvCHYDQgSADJn7obJ/Nig85wI9Xg4OLC0YNlR1f8iwE9Xx9T55lvywUl29R/cQIuk2QANtojG3mUeF0n6s=
X-Received: by 2002:a05:6808:191c:: with SMTP id bf28mr7691641oib.7.1634709688231;
 Tue, 19 Oct 2021 23:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <YWLwUUNuRrO7AxtM@arighi-desktop> <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
 <YWPaZSX4WyOwilW+@arighi-desktop> <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
 <YWPjZv7ClDOE66iI@arighi-desktop> <CACT4Y+b4Xmev7uLhASpHnELcteadhaXCBkkD5hO2YNP5M2451g@mail.gmail.com>
 <YWQCknwPcGlOBfUi@arighi-desktop> <YWQJe1ccZ72FZkLB@arighi-desktop>
 <CANpmjNNtCf+q21_5Dj49c4D__jznwFbBFrWE0LG5UnC__B+fKA@mail.gmail.com> <YWRNVTk9N8K0RMst@arighi-desktop>
In-Reply-To: <YWRNVTk9N8K0RMst@arighi-desktop>
From:   Marco Elver <elver@google.com>
Date:   Wed, 20 Oct 2021 08:00:00 +0200
Message-ID: <CANpmjNMXNZX5QyLhXtT87ycnAhEe1upU_cL9D3+NOGKEn-gtCw@mail.gmail.com>
Subject: Re: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 at 16:42, Andrea Righi <andrea.righi@canonical.com> wrote:
> On Mon, Oct 11, 2021 at 12:03:52PM +0200, Marco Elver wrote:
> > On Mon, 11 Oct 2021 at 11:53, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > On Mon, Oct 11, 2021 at 11:23:32AM +0200, Andrea Righi wrote:
> > > ...
> > > > > You seem to use the default 20s stall timeout. FWIW syzbot uses 160
> > > > > secs timeout for TCG emulation to avoid false positive warnings:
> > > > > https://github.com/google/syzkaller/blob/838e7e2cd9228583ca33c49a39aea4d863d3e36d/dashboard/config/linux/upstream-arm64-kasan.config#L509
> > > > > There are a number of other timeouts raised as well, some as high as
> > > > > 420 seconds.
> > > >
> > > > I see, I'll try with these settings and see if I can still hit the soft
> > > > lockup messages.
> > >
> > > Still getting soft lockup messages even with the new timeout settings:
> > >
> > > [  462.663766] watchdog: BUG: soft lockup - CPU#2 stuck for 430s! [systemd-udevd:168]
> > > [  462.755758] watchdog: BUG: soft lockup - CPU#3 stuck for 430s! [systemd-udevd:171]
> > > [  924.663765] watchdog: BUG: soft lockup - CPU#2 stuck for 861s! [systemd-udevd:168]
> > > [  924.755767] watchdog: BUG: soft lockup - CPU#3 stuck for 861s! [systemd-udevd:171]
> >
> > The lockups are expected if you're hitting the TCG bug I linked. Try
> > to pass '-enable-kvm' to the inner qemu instance (my bad if you
> > already have), assuming that's somehow easy to do.
>
> If I add '-enable-kvm' I can triggering other random panics (almost
> immediately), like this one for example:

Just FYI: https://lkml.kernel.org/r/20211019102524.2807208-2-elver@google.com

But you can already flip that switch in your config
(CONFIG_KFENCE_STATIC_KEYS=n), which we recommend as a default now.

As a side-effect it'd also make your QEMU TCG tests pass.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BFA428A78
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbhJKKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbhJKKGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:06:04 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C4CC061745
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 03:04:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so16507868ote.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 03:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTfrofmPQUPweaAMFrrpDCsxkes27wM1OdN6B7aOuF4=;
        b=gNogjTGQmS3kUoqTukTRrppUYNKgp7EnaKzm2pyIOK6rwS18CxqfhXq49S8yxdu6Z9
         PwP+UXFvcIPwxiCfGUgXqGYDMfQz5Bffn/jpxVg1zKDJXeIG6LKmch6235qPHv6Tz82M
         Idz81cY1JescUsKyXgGuvSeEBDZKfd1QI2gYwCTEviWZNFsMTRbJggihDcRSorMd9HA/
         e3FsQDtV9bIHGk5rG0Bzv6xXkNa0xSFl/g1dw/MxbqRkqrPyjcnssg2NtHcVOA0nUUSm
         ew7gKQ2R+htDc9Zm5poNxBV9pigZFxTW5yvF0tulCYduHglka31trewxx5WwMIxFJKGb
         qhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTfrofmPQUPweaAMFrrpDCsxkes27wM1OdN6B7aOuF4=;
        b=cWkjNpIlOEJWRtiHYbjMyIWN+OSO10TjF7THkDr504KVIYiLueL0/44ECQx2HKYAjy
         r2AkrNxNk+xo0X5rn4OeN51rrfMNbsokfgplrbbVWClnZnxk1kKnTj01ncNGilaveCYN
         6ALe8d8FMOY6BzRmcmprOF43jM/ws15pdZMYDIX+YYsMZlCTIaxa2mN+KYwdGD21O2i+
         Zu+9DRtlFgr707SrY1IkMZBKsCRgkaoSLuOmFOmZ0416tKGDgcWRl9bYKcYzS5UAoSfi
         eP3YB3j4CoJllxXnnu695GHk4gQ8V74q8nBdHTENwSe9IJsJ2ACLRT39lNwwgYxBAx/z
         ebkg==
X-Gm-Message-State: AOAM5305dun8GLoMrmC0KwU3JZrwDolqEpKkuiogTdDthSTSsEgUrPmt
        7mNCBF18DbdBna7EQzjcMbae3nc/794zLdixEAvFDg==
X-Google-Smtp-Source: ABdhPJzx25ngeDCE3URdwsjKxtgM4s+Jz/2JV2ZclIUGP2NWMTqMM7rlS0+gpqZV1W3QBnIfyoDuomWcyPpax9g/XU4=
X-Received: by 2002:a9d:6f04:: with SMTP id n4mr20153119otq.157.1633946643977;
 Mon, 11 Oct 2021 03:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <YWLwUUNuRrO7AxtM@arighi-desktop> <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
 <YWPaZSX4WyOwilW+@arighi-desktop> <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
 <YWPjZv7ClDOE66iI@arighi-desktop> <CACT4Y+b4Xmev7uLhASpHnELcteadhaXCBkkD5hO2YNP5M2451g@mail.gmail.com>
 <YWQCknwPcGlOBfUi@arighi-desktop> <YWQJe1ccZ72FZkLB@arighi-desktop>
In-Reply-To: <YWQJe1ccZ72FZkLB@arighi-desktop>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Oct 2021 12:03:52 +0200
Message-ID: <CANpmjNNtCf+q21_5Dj49c4D__jznwFbBFrWE0LG5UnC__B+fKA@mail.gmail.com>
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

On Mon, 11 Oct 2021 at 11:53, Andrea Righi <andrea.righi@canonical.com> wrote:
> On Mon, Oct 11, 2021 at 11:23:32AM +0200, Andrea Righi wrote:
> ...
> > > You seem to use the default 20s stall timeout. FWIW syzbot uses 160
> > > secs timeout for TCG emulation to avoid false positive warnings:
> > > https://github.com/google/syzkaller/blob/838e7e2cd9228583ca33c49a39aea4d863d3e36d/dashboard/config/linux/upstream-arm64-kasan.config#L509
> > > There are a number of other timeouts raised as well, some as high as
> > > 420 seconds.
> >
> > I see, I'll try with these settings and see if I can still hit the soft
> > lockup messages.
>
> Still getting soft lockup messages even with the new timeout settings:
>
> [  462.663766] watchdog: BUG: soft lockup - CPU#2 stuck for 430s! [systemd-udevd:168]
> [  462.755758] watchdog: BUG: soft lockup - CPU#3 stuck for 430s! [systemd-udevd:171]
> [  924.663765] watchdog: BUG: soft lockup - CPU#2 stuck for 861s! [systemd-udevd:168]
> [  924.755767] watchdog: BUG: soft lockup - CPU#3 stuck for 861s! [systemd-udevd:171]

The lockups are expected if you're hitting the TCG bug I linked. Try
to pass '-enable-kvm' to the inner qemu instance (my bad if you
already have), assuming that's somehow easy to do.

Thanks,
-- Marco

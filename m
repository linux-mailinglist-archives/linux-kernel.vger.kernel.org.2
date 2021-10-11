Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442A8428691
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhJKGDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhJKGDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:03:41 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ADDC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 23:01:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so5611132otk.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 23:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7h13AY5afsp7vOYth4Tp6m8iDZB9FmezNoNd7LDicIs=;
        b=lyUPYDShvubOAEDt7S9DgDqXjg/pLHKhHBiXEIAL/UZd4qHyG0u2JQvRBhznnZ4x35
         qNS3e4oo10kLWLPIc1XmaUqnnWcNFxG+AuHVjpIddAJhBBoIfh0KW7rRYMekjnF4KyEp
         1hb5BzmWrPWTphiVf6RtPJdGRevl/uO9NQVZQJKZM/yl0z6sGhxnvY1LpDXFjC5X1pgT
         MRs1ZGtQpwSKzuBjP0d/wlfAG6FcsQgOSUlAWkpbxwdckN00vxBU6Ge0VQsy1/p/gmHx
         lLlmy20jRLeLNq4p+nkGMo835+JVweSz4QZf927vSsRBbpLIeZC1AxgIIEXnPg3D44Yg
         M0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7h13AY5afsp7vOYth4Tp6m8iDZB9FmezNoNd7LDicIs=;
        b=sCFVi2ZEEW00hnwnrhxKZJ7Fnhg6YqAUAL7IFo2nuFHrcdw9g/+SHiz36YrYI0g4Bd
         15eOIwvt580Ktc0mns86VX/Ind5T+oWNJrvT57vntd1PuApW7AEXz/s7PFEBtP70uNAs
         ur1/jWX99UStCdKrrDyZmMg+X/WnCOyVBilUJAFjwu4ip4iPVZ6dQymNTRXpI85BT9lz
         CGlcST+yKQwAUaGlat4ob8Sgt5aIkCNK/IgfMph5fpgFB5CIgmS/FMV+TF2s4qyDWQHu
         TQ0fFJRVeC4Lyx6sb1MoO+szm8jUpnNxOIRA8VDhshO2kvxgjXVGG9J2fFh+UKEgZsjo
         FkSw==
X-Gm-Message-State: AOAM533mI8KfON3rMmZxHuORcQnhyBmMVXl1ROwY7RakRTiqcLEoe9+P
        +V/zMu0ggm50PUtdIkAXVSQZ0YLT/goeP/6rTjAp5w==
X-Google-Smtp-Source: ABdhPJz6zIDjEcRBmZaIIG+x4aD2tmmvwn24+vDfvh9lRvssH6+aecFI5E50J4ASRStv3JjDrHLbNCI/zEb5vtfp0mY=
X-Received: by 2002:a9d:3e04:: with SMTP id a4mr20242022otd.329.1633932100754;
 Sun, 10 Oct 2021 23:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <YWLwUUNuRrO7AxtM@arighi-desktop>
In-Reply-To: <YWLwUUNuRrO7AxtM@arighi-desktop>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Oct 2021 08:00:00 +0200
Message-ID: <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
Subject: Re: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2021 at 15:53, Andrea Righi <andrea.righi@canonical.com> wrote:
> I can systematically reproduce the following soft lockup w/ the latest
> 5.15-rc4 kernel (and all the 5.14, 5.13 and 5.12 kernels that I've
> tested so far).
>
> I've found this issue by running systemd autopkgtest (I'm using the
> latest systemd in Ubuntu - 248.3-1ubuntu7 - but it should happen with
> any recent version of systemd).
>
> I'm running this test inside a local KVM instance and apparently systemd
> is starting up its own KVM instances to run its tests, so the context is
> a nested KVM scenario (even if I don't think the nested KVM part really
> matters).
>
> Here's the oops:
>
> [   36.466565] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [udevadm:333]
> [   36.466565] Modules linked in: btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear psmouse floppy
> [   36.466565] CPU: 0 PID: 333 Comm: udevadm Not tainted 5.15-rc4
> [   36.466565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[...]
>
> If I disable CONFIG_KFENCE the soft lockup doesn't happen and systemd
> autotest completes just fine.
>
> We've decided to disable KFENCE in the latest Ubuntu Impish kernel
> (5.13) for now, because of this issue, but I'm still investigating
> trying to better understand the problem.
>
> Any hint / suggestion?

Can you confirm this is not a QEMU TCG instance? There's been a known
issue with it: https://bugs.launchpad.net/qemu/+bug/1920934

One thing that I've been wondering is, if we can make
CONFIG_KFENCE_STATIC_KEYS=n the default, because the static keys
approach is becoming more trouble than it's worth. It requires us to
re-benchmark the defaults. If you're thinking of turning KFENCE on by
default (i.e. CONFIG_KFENCE_SAMPLE_INTERVAL non-zero), you could make
this decision for Ubuntu with whatever sample interval you choose.
We've found that for large deployments 500ms or above is more than
adequate.

Thanks,
-- Marco

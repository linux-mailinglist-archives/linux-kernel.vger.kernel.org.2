Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BAE428705
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhJKGuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbhJKGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:50:42 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE50C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 23:48:42 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id s4-20020a4aad44000000b002b6aa5b6999so3520531oon.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rg9FMIgGuiU1OB4eISCi95IByOPH0nsu1EJ0FkL+Lgk=;
        b=egUQGdXVqcdvTub+oSmCsfECSzihqal+CKJ4uV0XKQKD8rRjjI+YKz/Ijz6+VikIyV
         6x13T+pjMBYf7jSs9J+uIgKXC/XtRkFlpEhXLe7ioLEpCBeunSL6mHh3y3ugxZmyPcoc
         P2n/DyDqR/lhKmsRYDRrkBC0Y3MUe3aZg3DZHsl4kRq/UjFi+IGq83fGaz6gJ5CTnvQr
         raKdGEKmu6Dbj8gkojy6aHws9EmheAEPxqJiaVUO1VmJBFvhqaHCHaR7LEMOToyXtY6m
         Jm2dNfLhB3WVb7gmvEL73aT9CyIKYtTMXAa/BW/IOSgtnbKY7G8AwQEcnUSqzLMcD9lc
         F2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rg9FMIgGuiU1OB4eISCi95IByOPH0nsu1EJ0FkL+Lgk=;
        b=oivFOf4x5/2fstkhOIwY1pTI7a9rwdh5PsnIob7Vi9vLhHgqhhScRlQh+HT6EuVtWa
         gjUyZ39CyKHs8JZEigF1UOgcXYn+Z1ZmkAZIPevn12+a/ENqvk35cuGjoZg7Kj442sns
         dBneuGPq79TqFzcW6SdXdVFOyPrU3fJcOhc46061UCIcf2sD1youtrc7+i7PnllKg452
         MgjqZTEAuPIXJyStDn8F8ynIZQQvo4SN8bF6wuqrdcLiT0bEod61JjOqRjdb5y/FTRe7
         OhLyAoIeTU0eLCzNDlr5Wdm2f2+QMC+KDYSAthL/1AWBBFIOS3iVRVEoqTzsk54jFPsW
         or/A==
X-Gm-Message-State: AOAM531E9dp2ewCFMpbEuCD5z5QC4oYKXmNv7a0Wui9yZZdzJNqkzEvy
        fXCYDsyi21loXZOtadbhWMl6vwTeVGxaw8rPH4N92g==
X-Google-Smtp-Source: ABdhPJxliWynHRDGre6s7TaTKGAQV1rH/vPbVCTFQL3hp8w5tYrrSWTJS9BPJ+Ui+r6KaW+dGyaXIBDRQCda/n43KW4=
X-Received: by 2002:a4a:d54c:: with SMTP id q12mr17516865oos.25.1633934921227;
 Sun, 10 Oct 2021 23:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <YWLwUUNuRrO7AxtM@arighi-desktop> <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
 <YWPaZSX4WyOwilW+@arighi-desktop>
In-Reply-To: <YWPaZSX4WyOwilW+@arighi-desktop>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Oct 2021 08:48:29 +0200
Message-ID: <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
Subject: Re: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 at 08:32, Andrea Righi <andrea.righi@canonical.com> wrote:
> On Mon, Oct 11, 2021 at 08:00:00AM +0200, Marco Elver wrote:
> > On Sun, 10 Oct 2021 at 15:53, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > I can systematically reproduce the following soft lockup w/ the latest
> > > 5.15-rc4 kernel (and all the 5.14, 5.13 and 5.12 kernels that I've
> > > tested so far).
> > >
> > > I've found this issue by running systemd autopkgtest (I'm using the
> > > latest systemd in Ubuntu - 248.3-1ubuntu7 - but it should happen with
> > > any recent version of systemd).
> > >
> > > I'm running this test inside a local KVM instance and apparently systemd
> > > is starting up its own KVM instances to run its tests, so the context is
> > > a nested KVM scenario (even if I don't think the nested KVM part really
> > > matters).
> > >
> > > Here's the oops:
> > >
> > > [   36.466565] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [udevadm:333]
> > > [   36.466565] Modules linked in: btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear psmouse floppy
> > > [   36.466565] CPU: 0 PID: 333 Comm: udevadm Not tainted 5.15-rc4
> > > [   36.466565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> > [...]
> > >
> > > If I disable CONFIG_KFENCE the soft lockup doesn't happen and systemd
> > > autotest completes just fine.
> > >
> > > We've decided to disable KFENCE in the latest Ubuntu Impish kernel
> > > (5.13) for now, because of this issue, but I'm still investigating
> > > trying to better understand the problem.
> > >
> > > Any hint / suggestion?
> >
> > Can you confirm this is not a QEMU TCG instance? There's been a known
> > issue with it: https://bugs.launchpad.net/qemu/+bug/1920934
>
> It looks like systemd is running qemu-system-x86 without any "accel"
> options, so IIUC the instance shouldn't use TCG. Is this a correct
> assumption or is there a better way to check?

AFAIK, the default is TCG if nothing else is requested. What was the
command line?

> > One thing that I've been wondering is, if we can make
> > CONFIG_KFENCE_STATIC_KEYS=n the default, because the static keys
> > approach is becoming more trouble than it's worth. It requires us to
> > re-benchmark the defaults. If you're thinking of turning KFENCE on by
> > default (i.e. CONFIG_KFENCE_SAMPLE_INTERVAL non-zero), you could make
> > this decision for Ubuntu with whatever sample interval you choose.
> > We've found that for large deployments 500ms or above is more than
> > adequate.
>
> Another thing that I forgot to mention is that with
> CONFIG_KFENCE_STATIC_KEYS=n the soft lockup doesn't seem to happen.

Thanks for confirming.

Thanks,
-- Marco

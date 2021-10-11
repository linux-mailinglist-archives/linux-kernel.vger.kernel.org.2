Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6B428773
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhJKHMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:12:35 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56458
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233790AbhJKHMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:12:33 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E148C3FFFE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633936232;
        bh=h1SUzCf91Jwpb9fhrX0NRvLQL7EyCkzdP0gPLLjD4b8=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=aWQClpvl6MpmGv9YTLKRHj5GGnXK8s2u8T7VdhdRFsL4lf0cgATAFNQrEoL/mNSqF
         dZSqBHS8N7J1UAHIKMT18lUVqy0jHk/UPvA7+XYn0BtUKRakQS3jhHDP38S3z5tJR/
         UaR80i0SutViYWZOQZXIoZ0gIFjjkCsVVyxkQleFOY1rZ7CEepHknROdCEo762lzXf
         KP8u9T7L7A8DX0LGQ5vEZhZTF0Fhh/ill2mmcP91WDMwUenWGinlMRvBoNM0aK7Ynb
         xKaVm3oOHYlI7Apf7s3v+L+/XdY2Vc595yBTG39QnyaTNCZN648cJLZmrqTUHw1+K3
         V53T2LWmy11WQ==
Received: by mail-ed1-f72.google.com with SMTP id v2-20020a50f082000000b003db24e28d59so15003809edl.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1SUzCf91Jwpb9fhrX0NRvLQL7EyCkzdP0gPLLjD4b8=;
        b=JE+cwE9zO4PVDb4jVhjz/9JtVR/O2ttbHXs9KDbyznDAlCnaOdvTY/BU4pCnm8HGNm
         9/DNV2ExXFwKI7gvPF84WXaAgXiTbYiS1zmOS1sNW8akcFyqx1kBFBR7Mlwbz6Mk9cqK
         9hwPiTHk+7LDxjosgvm6CInPj++9qZlxztXvP3qYh60Fk0N1gca6fhk5evGOlsy2wF5v
         ci8jS4/8mRpXfmwYuf4eeA/GHMSauaGYgDSQ6qWV96NHKaB5heCB17cI6zIiYqFbOoGK
         U3NjYODEr92Vg513L1MjcTutGMDumMB8Wu8O/XbGmimodXhe3x3Vjv1KFtOFocDiJKPj
         ZASw==
X-Gm-Message-State: AOAM531WquwRAvKZKX3kCgbq+wgEs/UePiyI5aJHbGBQuw8um/01Cx9y
        P3uCLPDSz4pGWfidhiiDi/hEOk2o3wW8IfKGsAFwiDK9QL667LMm9XLJgd2CbG3eIEdc9vvbvpI
        PObroDSXFOo96+IQnR4MTFlWs5zMakBlEWyXgZURwbA==
X-Received: by 2002:a17:906:c009:: with SMTP id e9mr23871356ejz.509.1633936232562;
        Mon, 11 Oct 2021 00:10:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaYokr373n9+pvypy7SyEpzzJy/337+0O1svYG2JXNNbPWvZ57+ivNRR1KCyf2hS8d9lVTrg==
X-Received: by 2002:a17:906:c009:: with SMTP id e9mr23871340ejz.509.1633936232329;
        Mon, 11 Oct 2021 00:10:32 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id y19sm2560185edd.39.2021.10.11.00.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:10:31 -0700 (PDT)
Date:   Mon, 11 Oct 2021 09:10:30 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
Message-ID: <YWPjZv7ClDOE66iI@arighi-desktop>
References: <YWLwUUNuRrO7AxtM@arighi-desktop>
 <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
 <YWPaZSX4WyOwilW+@arighi-desktop>
 <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 08:48:29AM +0200, Marco Elver wrote:
> On Mon, 11 Oct 2021 at 08:32, Andrea Righi <andrea.righi@canonical.com> wrote:
> > On Mon, Oct 11, 2021 at 08:00:00AM +0200, Marco Elver wrote:
> > > On Sun, 10 Oct 2021 at 15:53, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > I can systematically reproduce the following soft lockup w/ the latest
> > > > 5.15-rc4 kernel (and all the 5.14, 5.13 and 5.12 kernels that I've
> > > > tested so far).
> > > >
> > > > I've found this issue by running systemd autopkgtest (I'm using the
> > > > latest systemd in Ubuntu - 248.3-1ubuntu7 - but it should happen with
> > > > any recent version of systemd).
> > > >
> > > > I'm running this test inside a local KVM instance and apparently systemd
> > > > is starting up its own KVM instances to run its tests, so the context is
> > > > a nested KVM scenario (even if I don't think the nested KVM part really
> > > > matters).
> > > >
> > > > Here's the oops:
> > > >
> > > > [   36.466565] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [udevadm:333]
> > > > [   36.466565] Modules linked in: btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear psmouse floppy
> > > > [   36.466565] CPU: 0 PID: 333 Comm: udevadm Not tainted 5.15-rc4
> > > > [   36.466565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> > > [...]
> > > >
> > > > If I disable CONFIG_KFENCE the soft lockup doesn't happen and systemd
> > > > autotest completes just fine.
> > > >
> > > > We've decided to disable KFENCE in the latest Ubuntu Impish kernel
> > > > (5.13) for now, because of this issue, but I'm still investigating
> > > > trying to better understand the problem.
> > > >
> > > > Any hint / suggestion?
> > >
> > > Can you confirm this is not a QEMU TCG instance? There's been a known
> > > issue with it: https://bugs.launchpad.net/qemu/+bug/1920934
> >
> > It looks like systemd is running qemu-system-x86 without any "accel"
> > options, so IIUC the instance shouldn't use TCG. Is this a correct
> > assumption or is there a better way to check?
> 
> AFAIK, the default is TCG if nothing else is requested. What was the
> command line?

This is the full command line of what systemd is running:

  /bin/qemu-system-x86_64 -smp 4 -net none -m 512M -nographic -vga none -kernel /boot/vmlinuz-5.15-rc4 -drive format=raw,cache=unsafe,file=/var/tmp/systemd-test.sI1nrh/badid.img -initrd /boot/initrd.img-5.15-rc4 -append  root=/dev/sda1 rw raid=noautodetect rd.luks=0 loglevel=2 init=/lib/systemd/systemd console=ttyS0 selinux=0  SYSTEMD_UNIT_PATH=/usr/lib/systemd/tests/testdata/testsuite-14.units:/usr/lib/systemd/tests/testdata/units: systemd.unit=testsuite.target systemd.wants=testsuite-14.service systemd.wants=end.service

And this is running inside a KVM instance (so a nested KVM scenario).

-Andrea

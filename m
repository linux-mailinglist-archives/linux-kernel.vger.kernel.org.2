Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D311C428999
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhJKJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:26:03 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47624
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235393AbhJKJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:25:40 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 185653F044
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633944213;
        bh=XGF6U6ImX48DlfSujlkFaxlWBKpZditGsN8NI04ojEA=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=f2Bgj7okh4+CW5X2rle7bluAzzyeRcSHDVPxbZDREChzfAdamAEVqm6ZX2/LbutfB
         k8LF/KxG96ufXO74ZVH6k3Mv2rbr2lzUNBpYfslOJTvODmiJXwuMSIjhwTzxzWfxq4
         Ep6ndn7Mb18iqLAIszyCc/jLn5YFrJwhQsLAC3jw9aREEe/XytUOxeSwpkV8md45aL
         K//HJJr+yDplwDBj/UVBfNnLbE0W2lcV71zEL5vWx9izbc2tmuiyZvxp64Y73zAs3q
         2yt2DlKqUN/GXBdD/QdeczmDOWg5TwGKXqxoAHq1e1QY3G6P0Q14/7BXC9deJiIOy4
         H0PGuZYt4kpUg==
Received: by mail-ed1-f71.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso15268098edj.20
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 02:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGF6U6ImX48DlfSujlkFaxlWBKpZditGsN8NI04ojEA=;
        b=bR01pJ3RZhsSD52L+KtrnT+IV97U1i0ZZ5ofKeR/SacxH5mSNZ6dFdRg5FjTiq41eV
         xpUd9GOnnQSuHMT6DwVrz9M4XNAPpHk/nVtnib2Te9GTrgglmGkg9sn29z68saJF/Ve+
         O/PiK8FRGq3rYU3gMkpzxQzMuFjT7GJ8RwbsNDr2XoeIU4Qkbq53iKBOGKN468Hmfhdz
         +cBkFfFY3l3G8QmR++7IDZ5+xkFa1pLPbzBLwx5ZaEf1upB9c3Z6IsZO2DxoMuw9UYwF
         RBQSFvuyfD7FOhzTZGdySlfI3xUzFJGdmuhnXnG/g/iIWZI/1KhmXrkSf4bAd9e+EdrH
         DtiQ==
X-Gm-Message-State: AOAM530NQcZ+ILM8fRRfn2X5/pAeGnX0PRuzs018KYmTsdhBqdYsuPlx
        Z9M5edPs4RhZXsGSf8SOCt1cF1iCps+OqgPvxWXbiYjhNLD3LJLU6GpTinBJu43DpGNDeuw+Jl6
        6suGkdsEtc6nJDvcrwkqcCDpLvwsBqFC4EzWSgEL6ag==
X-Received: by 2002:a17:906:d937:: with SMTP id rn23mr24575968ejb.101.1633944212772;
        Mon, 11 Oct 2021 02:23:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTivXi1FDEB3sKw2zNYp6Nq32GYu8WXO4hmJP5SEwnByDRHjQoqDYoiq1PP2Zr1QXgxo5RUQ==
X-Received: by 2002:a17:906:d937:: with SMTP id rn23mr24575945ejb.101.1633944212505;
        Mon, 11 Oct 2021 02:23:32 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id g17sm3861642edv.72.2021.10.11.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 02:23:31 -0700 (PDT)
Date:   Mon, 11 Oct 2021 11:23:30 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
Message-ID: <YWQCknwPcGlOBfUi@arighi-desktop>
References: <YWLwUUNuRrO7AxtM@arighi-desktop>
 <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
 <YWPaZSX4WyOwilW+@arighi-desktop>
 <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
 <YWPjZv7ClDOE66iI@arighi-desktop>
 <CACT4Y+b4Xmev7uLhASpHnELcteadhaXCBkkD5hO2YNP5M2451g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b4Xmev7uLhASpHnELcteadhaXCBkkD5hO2YNP5M2451g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 09:19:48AM +0200, Dmitry Vyukov wrote:
> On Mon, 11 Oct 2021 at 09:10, Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 08:48:29AM +0200, Marco Elver wrote:
> > > On Mon, 11 Oct 2021 at 08:32, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > On Mon, Oct 11, 2021 at 08:00:00AM +0200, Marco Elver wrote:
> > > > > On Sun, 10 Oct 2021 at 15:53, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > I can systematically reproduce the following soft lockup w/ the latest
> > > > > > 5.15-rc4 kernel (and all the 5.14, 5.13 and 5.12 kernels that I've
> > > > > > tested so far).
> > > > > >
> > > > > > I've found this issue by running systemd autopkgtest (I'm using the
> > > > > > latest systemd in Ubuntu - 248.3-1ubuntu7 - but it should happen with
> > > > > > any recent version of systemd).
> > > > > >
> > > > > > I'm running this test inside a local KVM instance and apparently systemd
> > > > > > is starting up its own KVM instances to run its tests, so the context is
> > > > > > a nested KVM scenario (even if I don't think the nested KVM part really
> > > > > > matters).
> > > > > >
> > > > > > Here's the oops:
> > > > > >
> > > > > > [   36.466565] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [udevadm:333]
> > > > > > [   36.466565] Modules linked in: btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear psmouse floppy
> > > > > > [   36.466565] CPU: 0 PID: 333 Comm: udevadm Not tainted 5.15-rc4
> > > > > > [   36.466565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> > > > > [...]
> > > > > >
> > > > > > If I disable CONFIG_KFENCE the soft lockup doesn't happen and systemd
> > > > > > autotest completes just fine.
> > > > > >
> > > > > > We've decided to disable KFENCE in the latest Ubuntu Impish kernel
> > > > > > (5.13) for now, because of this issue, but I'm still investigating
> > > > > > trying to better understand the problem.
> > > > > >
> > > > > > Any hint / suggestion?
> > > > >
> > > > > Can you confirm this is not a QEMU TCG instance? There's been a known
> > > > > issue with it: https://bugs.launchpad.net/qemu/+bug/1920934
> > > >
> > > > It looks like systemd is running qemu-system-x86 without any "accel"
> > > > options, so IIUC the instance shouldn't use TCG. Is this a correct
> > > > assumption or is there a better way to check?
> > >
> > > AFAIK, the default is TCG if nothing else is requested. What was the
> > > command line?
> >
> > This is the full command line of what systemd is running:
> >
> >   /bin/qemu-system-x86_64 -smp 4 -net none -m 512M -nographic -vga none -kernel /boot/vmlinuz-5.15-rc4 -drive format=raw,cache=unsafe,file=/var/tmp/systemd-test.sI1nrh/badid.img -initrd /boot/initrd.img-5.15-rc4 -append  root=/dev/sda1 rw raid=noautodetect rd.luks=0 loglevel=2 init=/lib/systemd/systemd console=ttyS0 selinux=0  SYSTEMD_UNIT_PATH=/usr/lib/systemd/tests/testdata/testsuite-14.units:/usr/lib/systemd/tests/testdata/units: systemd.unit=testsuite.target systemd.wants=testsuite-14.service systemd.wants=end.service
> >
> > And this is running inside a KVM instance (so a nested KVM scenario).
> 
> Hi Andrea,
> 
> I think you need to pass -enable-kvm to make it "nested KVM scenario",
> otherwise it's TCG emulation.

So, IIUC I shouldn't hit the QEMU TCG issue mentioned by Marco, right?

> 
> You seem to use the default 20s stall timeout. FWIW syzbot uses 160
> secs timeout for TCG emulation to avoid false positive warnings:
> https://github.com/google/syzkaller/blob/838e7e2cd9228583ca33c49a39aea4d863d3e36d/dashboard/config/linux/upstream-arm64-kasan.config#L509
> There are a number of other timeouts raised as well, some as high as
> 420 seconds.

I see, I'll try with these settings and see if I can still hit the soft
lockup messages.

Thanks,
-Andrea

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F70D428790
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhJKHWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhJKHWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:22:00 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6887C061745
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:20:00 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id o4so23440339oia.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hvLHxd7M6lrg6ngmQ548ehLrcVjs8MUn2wc/QvypJI4=;
        b=Qqgyce7Vxo23qX8i28+cTzfuYBMnevWdx/tqmmhlgBixOEtsWhq0FDW2RBEiPiSXoL
         jo98vABaBaiM47Mp+uRRDpLswD5Z9d5R+pNvPCkFyK4oj9udapu36GlxvddQB472+Baz
         RucJpn8zBXTrik6i/m/Tl8MFy7QH3brx0GvLuObTnLMWHTQgQapW42Z1XVACyzw/OYd5
         9eMYq0Rb0YFvyXkVr7hgC89AdNFXC+AL6PgSlCDcYBtHKeXAebd2TJXOvjbspYAyQ8bm
         neseL7niXZPlX2HNkF1LzEORNn69t5NpujwAKgI7XjExbB+gddPo7/y0oPhSXugMs7CW
         2l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hvLHxd7M6lrg6ngmQ548ehLrcVjs8MUn2wc/QvypJI4=;
        b=oiF0SJYvmYGTH1x9rugUHx8YQKfYeRQirBIZEE8QD7FhugNNLHSlyFsvHF2C+G9Blt
         JaKWSpBb/dK+dsfBcP1UjzYZAFAKDEyMVu3y+YDhcHx+ueTsWh+PboSphpXau9Nh22x/
         /g/qqLX/M1FqXjEvkIkQDuH0T1sBe9/WYSrc2dNKR3r9DP7UPvW0/7w3ldlqWDq7HDYV
         unCo+ic3RO6AI52+svu/ouhsaEfTLckYBRUXSkrPkebvxYiXzicjh9PLUHAq59zOvtXW
         HqgN/jKp+xLMdcOPiOuDTMnuI3O6riwfMGZbn0X/JxAputhnGFqYMpODrI+RWqvasS+O
         LJgQ==
X-Gm-Message-State: AOAM530RaZuA2jFKZzlgm2kiZye39C/Q73kKEUj0bKsKNttgjtg6Y+xV
        CS4gaqTzj0/paHqssxzxHsZFGc44JN5mQmY8cYMecw==
X-Google-Smtp-Source: ABdhPJwtYyd90bqWzxWBaDCiYF7L1wudQnwl9e52EgCOG/GVAWR0Kic3luA7DhxEY9yg5A4DFtl7wOtKfBDBmsBnCxU=
X-Received: by 2002:aca:5dc5:: with SMTP id r188mr2376347oib.160.1633936799664;
 Mon, 11 Oct 2021 00:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <YWLwUUNuRrO7AxtM@arighi-desktop> <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
 <YWPaZSX4WyOwilW+@arighi-desktop> <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
 <YWPjZv7ClDOE66iI@arighi-desktop>
In-Reply-To: <YWPjZv7ClDOE66iI@arighi-desktop>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Oct 2021 09:19:48 +0200
Message-ID: <CACT4Y+b4Xmev7uLhASpHnELcteadhaXCBkkD5hO2YNP5M2451g@mail.gmail.com>
Subject: Re: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 at 09:10, Andrea Righi <andrea.righi@canonical.com> wro=
te:
>
> On Mon, Oct 11, 2021 at 08:48:29AM +0200, Marco Elver wrote:
> > On Mon, 11 Oct 2021 at 08:32, Andrea Righi <andrea.righi@canonical.com>=
 wrote:
> > > On Mon, Oct 11, 2021 at 08:00:00AM +0200, Marco Elver wrote:
> > > > On Sun, 10 Oct 2021 at 15:53, Andrea Righi <andrea.righi@canonical.=
com> wrote:
> > > > > I can systematically reproduce the following soft lockup w/ the l=
atest
> > > > > 5.15-rc4 kernel (and all the 5.14, 5.13 and 5.12 kernels that I'v=
e
> > > > > tested so far).
> > > > >
> > > > > I've found this issue by running systemd autopkgtest (I'm using t=
he
> > > > > latest systemd in Ubuntu - 248.3-1ubuntu7 - but it should happen =
with
> > > > > any recent version of systemd).
> > > > >
> > > > > I'm running this test inside a local KVM instance and apparently =
systemd
> > > > > is starting up its own KVM instances to run its tests, so the con=
text is
> > > > > a nested KVM scenario (even if I don't think the nested KVM part =
really
> > > > > matters).
> > > > >
> > > > > Here's the oops:
> > > > >
> > > > > [   36.466565] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! =
[udevadm:333]
> > > > > [   36.466565] Modules linked in: btrfs blake2b_generic zstd_comp=
ress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async=
_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear psmouse floppy
> > > > > [   36.466565] CPU: 0 PID: 333 Comm: udevadm Not tainted 5.15-rc4
> > > > > [   36.466565] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.14.0-2 04/01/2014
> > > > [...]
> > > > >
> > > > > If I disable CONFIG_KFENCE the soft lockup doesn't happen and sys=
temd
> > > > > autotest completes just fine.
> > > > >
> > > > > We've decided to disable KFENCE in the latest Ubuntu Impish kerne=
l
> > > > > (5.13) for now, because of this issue, but I'm still investigatin=
g
> > > > > trying to better understand the problem.
> > > > >
> > > > > Any hint / suggestion?
> > > >
> > > > Can you confirm this is not a QEMU TCG instance? There's been a kno=
wn
> > > > issue with it: https://bugs.launchpad.net/qemu/+bug/1920934
> > >
> > > It looks like systemd is running qemu-system-x86 without any "accel"
> > > options, so IIUC the instance shouldn't use TCG. Is this a correct
> > > assumption or is there a better way to check?
> >
> > AFAIK, the default is TCG if nothing else is requested. What was the
> > command line?
>
> This is the full command line of what systemd is running:
>
>   /bin/qemu-system-x86_64 -smp 4 -net none -m 512M -nographic -vga none -=
kernel /boot/vmlinuz-5.15-rc4 -drive format=3Draw,cache=3Dunsafe,file=3D/va=
r/tmp/systemd-test.sI1nrh/badid.img -initrd /boot/initrd.img-5.15-rc4 -appe=
nd  root=3D/dev/sda1 rw raid=3Dnoautodetect rd.luks=3D0 loglevel=3D2 init=
=3D/lib/systemd/systemd console=3DttyS0 selinux=3D0  SYSTEMD_UNIT_PATH=3D/u=
sr/lib/systemd/tests/testdata/testsuite-14.units:/usr/lib/systemd/tests/tes=
tdata/units: systemd.unit=3Dtestsuite.target systemd.wants=3Dtestsuite-14.s=
ervice systemd.wants=3Dend.service
>
> And this is running inside a KVM instance (so a nested KVM scenario).

Hi Andrea,

I think you need to pass -enable-kvm to make it "nested KVM scenario",
otherwise it's TCG emulation.

You seem to use the default 20s stall timeout. FWIW syzbot uses 160
secs timeout for TCG emulation to avoid false positive warnings:
https://github.com/google/syzkaller/blob/838e7e2cd9228583ca33c49a39aea4d863=
d3e36d/dashboard/config/linux/upstream-arm64-kasan.config#L509
There are a number of other timeouts raised as well, some as high as
420 seconds.

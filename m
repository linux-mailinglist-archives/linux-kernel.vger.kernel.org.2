Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9044FC38
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 23:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhKNWcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 17:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhKNWcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 17:32:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E157C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 14:29:14 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g14so63236634edz.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 14:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=w2CXrSSpCImdKSl1PF+HVw6gEg8tNKX42OuR+2Dham8=;
        b=DXGm01r2PX8DO1jLWLAAlUtoKRj+qu6WYQEzNX0nGiqD2Bw1AoZxmNGm/5XTU/BkKQ
         dBfagvgZCJxlRe8R5yVBCnEG3/5oJpRpY+aOascJRbChhdIXjQHrrPhax4JXqb+Gs4pV
         PUbv7BNNeTlmXRP/jMVAuvGFrf3rx3+AjE9Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w2CXrSSpCImdKSl1PF+HVw6gEg8tNKX42OuR+2Dham8=;
        b=tOAfjvy0gHv6Zf8p6sFKUOzAuJYXdjUx/aRxwZ9zYpGBXVIDjm2bYqngLyUtiynZO1
         oXDY6Y+6hdmko2CjF2fOb3WBEEiBmnjL2yt3FqVLIy4L4qc0MAFoOyGwlyW0hAMcGVBi
         Wx5wDoVMbQK7GeSY2pSwiSGXYnEGIkQqljfo6GMm4vKkUKyP0vyv+YPbJ1oPXzfMz2JK
         ncHqgcwq01dYEtzCEkPHi11RC61JJdybXx5QfaO0qO09z1iHJQmrJ6pi9r8OGKFB/IRt
         JNhVLEdlgjs5W9wwH/sRZLq8W8+CsoV9aY1NEm61DZs6r/I+RjoTOf9obaHwqxbDw0Ye
         co+g==
X-Gm-Message-State: AOAM533cOX28mr9jtLureac24mxXG1u59/r4vaAFg2xtAIYtJwaUUv0G
        eZa+uT3AUoQS0ip6dOiToCOh1A09NA6eaBdu
X-Google-Smtp-Source: ABdhPJwhKIkYR+lVy8TqSHPgJ3OUigzSOtIdFIoRet2eU58ahOF/FyC2CQeUwe34kmoskbZJplDEGQ==
X-Received: by 2002:aa7:c3c8:: with SMTP id l8mr7838496edr.278.1636928952356;
        Sun, 14 Nov 2021 14:29:12 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id v10sm1746521edc.69.2021.11.14.14.29.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 14:29:11 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id p18so2947981wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 14:29:11 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr51586190wmq.8.1636928951056;
 Sun, 14 Nov 2021 14:29:11 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 14:28:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
Message-ID: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
Subject: Linux 5.16-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been two weeks, and the merge window is thus closed.

I actually anticipated more problems during the merge window than we
hit - I was traveling with a laptop for a few days early on in the
merge window, and that's usually fairly painful. But - knock wood - it
all worked out fine. Partly thanks to a lot of people sending in their
pull requests fairly early, so that I could get a bit of a head start
before travels. But partly also because I didn't end up having any
"uhhuh, things aren't working and now I need to bisect where they
broke" events for me on any of my machines. At least yet.

So who knows? Maybe this will be one of those painless releases where
everything just works.

Sure.

Anyway, it's not a huge release, although it's also not a remarkably
small one like 5.15 was (ok, "remarkably small" is relative, when even
such small releases have 10k+ commits).. There's a bit of everything
in here, and you can look to the appended mergelog for some kind of
flavor, but I guess the folio work is worth mentioning, since it's an
unusually core thing that we don't tend to see most releases. The
intent is to have a more efficient and type-safe way to specify "head
of a group of pages", rather than the page pointers and
"compound_head()" and friends.

That said, the folio changes may be unusually core, but they certainly
aren't the bulk of the changes. Pretty small in the end, with the real
meat and potatoes being all the usual stuff. As always, most of the
changes are to drivers (gpu, networking, sound and staging stand out,
but it's all over) and architecture code. Hardware support is the bulk
of the code, it gets the bulk of the changes.  But we obviously have
all the normal other updates, with filesystem, networking, and core
kernel code. With documentation and tooling support filling the gaps.

And somewhat unusually, our library code stands out in the diffstat,
thanks to the big update to a more recent version of upstream libzstd.

Anyway, the merge window may have gone about as smoothly as I could
hope for, but let's get the whole stabilization phase started with
some serious testing, shall we?

Please?

                  Linus

---

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andreas Gruenbacher (2):
    gfs2 mmap + page fault deadlocks fixes
    gfs2 updates

Andrew Morton (3):
    misc updates
    more updates
    more updates

Arnaldo Carvalho de Melo (2):
    perf tools updates
    more perf tools updates

Arnd Bergmann (6):
    ARM SoC updates
    ARM SoC DT updates
    ARM SoC driver updates
    ARM defconfig updates
    asm-generic cleanup
    ARM SoC fixes

Bartosz Golaszewski (1):
    gpio updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (2):
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (2):
    pci updates
    PCI fixes

Borislav Petkov (14):
    EDAC updates
    EFI updates
    RAS updates
    x86 build fix
    generic confidential computing updates
    x86 cleanups
    x86 cpu updates
    misc x86 changes
    x86 SEV updates
    x86 SGX updates
    x86 core updates
    x86 fixes
    perf fixes
    scheduler fixes

Bruce Fields (1):
    nfsd updates

Casey Schaufler (1):
    smack updates

Christian Brauner (2):
    pidfd updates
    prctl updates

Christoph Hellwig (1):
    dma-mapping updates

Corey Minyard (1):
    IPMI driver updates

Damien Le Moal (2):
    libata updates
    more libata updates

Dan Williams (2):
    cxl updates
    libnvdimm update

Daniel Thompson (1):
    kgdb update

Darrick Wong (2):
    xfs updates
    xfs cleanups

Dave Airlie (2):
    drm updates
    more drm updates

David Hildenbrand (1):
    virtio-mem update

David Howells (2):
    AFS updates
    netfs, 9p, afs and ceph (partial) foliation

David Kleikamp (1):
    jfs fix

David Sterba (2):
    btrfs updates
    btrfs fix

Dmitry Torokhov (1):
    input updates

Dominique Martinet (1):
    9p updates

Eric Biederman (4):
    ucount cleanups
    per signal_struct coredumps
    exit cleanups
    vm86 fix

Eric Biggers (1):
    fscrypt updates

Gao Xiang (2):
    erofs updates
    erofs fixes

Geert Uytterhoeven (1):
    m68k updates

Greg KH (7):
    USB / Thunderbolt updates
    staging driver updates
    char/misc driver updates
    driver core updates
    tty / serial driver updates
    USB fixes
    char/misc fix

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Gustavo A (2):
    hardening fixes and cleanups
    fallthrough fixes

Hans de Goede (1):
    x86 platform driver updates

Helge Deller (3):
    parisc updates
    more parisc architecture fixes and updates
    more parisc fixes

Herbert Xu (2):
    crypto updates
    crypto fix

Ilya Dryomov (1):
    ceph updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (2):
    quota, isofs, and reiserfs updates
    fsnotify updates

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jeff Layton (1):
    file locking updates

Jens Axboe (15):
    block updates
    block driver updates
    io_uring updates
    bdev size cleanups
    SCSI multi-actuator support
    CDROM updates
    QUEUE_FLAG_SCSI_PASSTHROUGH removal
    kiocb->ki_complete() cleanup
    block inode sync updates
    io_uring fixes
    more bdev size updates
    block fixes
    more block driver updates
    io_uring fix
    block fixes

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

John Johansen (1):
    apparmor updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (1):
    xen updates

Julia Lawall (1):
    coccinelle updates

Kees Cook (4):
    thread_info update to move 'cpu' back from task_struct
    compiler hardening updates
    overflow updates
    seccomp updates

Lee Jones (2):
    MFD updates
    backlight updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (1):
    module updates

Mark Brown (3):
    regmap update
    regulator updates
    spi updates

Masahiro Yamada (1):
    Kbuild updates

Matthew Wilcox (1):
    memory folios

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    xtensa updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze update

Miguel Ojeda (2):
    compiler attributes update
    auxdisplay updates

Mike Marshall (1):
    orangefs fixes

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (2):
    fuse updates
    overlayfs updates

Mimi Zohar (1):
    integrity subsystem updates

Miquel Raynal (1):
    mtd updates

Namjae Jeon (1):
    exfat fix

Nick Terrell (1):
    zstd update

Palmer Dabbelt (1):
    RISC-V updates

Paolo Bonzini (2):
    KVM updates
    more kvm updates

Paul McKenney (2):
    RCU updates
    KCSAN updates

Paul Moore (3):
    selinux updates
    audit updates
    selinux fixes

Pavel Machek (1):
    LED updates

Petr Mladek (1):
    printk updates

Rafael Wysocki (7):
    ACPI updates
    power management updates
    thermal control updates
    PNP update
    more ACPI updates
    more power management updates
    more thermal control updates

Rich Felker (1):
    arch/sh updates

Rob Herring (2):
    devicetree updates
    devicetree fixes

Russell King (2):
    ARM updates
    ARM fixes

Sebastian Reichel (2):
    power supply and reset updates
    HSI update

Shuah Khan (2):
    Kselftest updates
    KUnit updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (2):
    clk updates
    more clk updates

Steve French (3):
    cifs updates
    ksmbd updates
    more cifs updates

Steven Rostedt (4):
    tracing updates
    more tracing updates
    tracing fixes
    tracing fixes

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    workqueue updates
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (2):
    MIPS updates
    more MIPS updates

Thomas Gleixner (11):
    irq updates
    perf updates
    locking updates
    objtool updates
    timer updates
    scheduler updates
    x86/apic update
    x86 fpu updates
    x86 static call update
    irq fixes
    timer fix

Trond Myklebust (1):
    NFS client updates

Ulf Hansson (1):
    MMC and MEMSTICK updates

Vasily Gorbik (2):
    s390 updates
    more s390 updates

Vinod Koul (1):
    dmaengine updates

Wei Liu (1):
    hyperv updates

Will Deacon (2):
    arm64 updates
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c fix
    i2c updates

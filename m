Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B397D3C3FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 00:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhGKWwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 18:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKWwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 18:52:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84115C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 15:49:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 11so16448604ljv.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 15:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=JXYb/eRULVA8USnmLM4OP4poD5ZadMMpfn5oRbLVjS4=;
        b=YXfxIQIUjOVG1EI85j/Ae1k1umqiD35V+i3IT73fad9cL0Q2q/yhX0Zh9CngtnUS1r
         nh0GWHU0TCmxW4uPI81AQ6R4GENRi4hWEC4tff7SvR3ww85f0N+QKlz8OmP0fGcSHQ16
         7NhtZiAsPiYUe5no6hfiq+iV1hLpI2kEpo6DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JXYb/eRULVA8USnmLM4OP4poD5ZadMMpfn5oRbLVjS4=;
        b=ZCLEUiNIoTUdwl1iSc/jMN0r7a9ilOBomRWi2F/cy73uDRQATkeY+BKpE57JUlVzfJ
         JQgD4ENPG7GuNfHeYxYaPw/62TULesJCcGouCpNgqfULSkEu0GFnJB8jo+N6sM8okoqZ
         5RRvIrRDH8N2Hh0NSJhnO3ctJNQOvy8NVj3NS3M9tZIyg2GswtpX0KTigpM177SOXzZp
         KaHdO8XqGTn4U9zOxwqQJ937V93L3UXZHrVua7wFRGNFU4SRcnbKHqeAyHRRqIel4sz3
         emLsZT6fTcli2/WPZ0XSOsqyEtgn8ZDtmC4NLyJFU8gHhmJMqMDfsvgz1yFMPE67Bnmi
         FT+Q==
X-Gm-Message-State: AOAM5314FfwU6SSA734+MSc+r2yD0I/suVrhXNsuDXl1pKwOOJ1C14+l
        xSLIb4oucsL+NSVvzBIN0vrlPA7tqA0VEOOG
X-Google-Smtp-Source: ABdhPJyES+CYuzha9dX8JMhvTpNqnhWJMazboqJmdx54YxCzFgsExNwjE22peav1+yVbU8AXdZ7AGg==
X-Received: by 2002:a2e:3011:: with SMTP id w17mr3967563ljw.276.1626043788098;
        Sun, 11 Jul 2021 15:49:48 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k9sm542747ljn.24.2021.07.11.15.49.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 15:49:47 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id a18so38688607lfs.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 15:49:47 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr37438100lfl.41.1626043787184;
 Sun, 11 Jul 2021 15:49:47 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Jul 2021 15:49:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
Message-ID: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
Subject: Linux 5.14-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You all know the drill by now. It's been the usual two weeks of merge
window, and not it's closed, and 5.14-rc1 is out there.

As usual, it's much too big to post the shortlog, with about 13k
commits (an another ~800 merge commits) by about 1650 developers, and
a diffstat summary of

 11859 files changed, 817707 insertions(+), 285485 deletions(-)

Appended is my mergelog which gives you an overview of what I've
pulled during the merge window, and who I pulled from. And as usual, I
want to stress how this is obviously just a very high-level summary,
and tiny part of the actual developer community - if you want the full
details of all those changes, you'll have to go to the -git tree.

On the whole, I don't think there are any huge surprises in here, and
size-wise this seems to be a pretty regular release too. Let's hope
that that translates to a nice and calm release cycle, but you never
know. Last release was big, but it was all fairly calm despite that,
so size isn't always the determining factor here..

If somebody wants to look at the actual diff for the release, I'd
encourage you to ignore - once again - another set of big AMD GPU
hardware description header files. We seem to have those fairly
regularly, and they are always these huge generated headers that end
up dwarfing everything else. Almost exactly half of the whole 5.14-rc1
patch is comprised of those GPU headers, and it skews the statistics a
lot.

Now, even if you ignore that AMD header drop, drivers account for over
two thirds of the changes when you look at the diff, and that's
perfectly normal. What's slightly less usual is how there's a lot of
line _removals_ in there, with the old IDE layer finally having met
its long-overdue demise, and all our IDE support is now based on
libata.

Of course, the fact that we removed all that legacy IDE code doesn't
mean that we had a reduction in lines over-all: a few tens of
thousands of lines of legacy code is nowhere near enough to balance
out the usual kernel growth. But it's still a nice thing to see the
cleanup.

So drivers dominate: even when ignoring the AMD header addition
there's a fair amount of gpu updates, but there's networking drivers,
rdma, sound, scsi, staging, media...

Outside of drivers, there's all the usual suspects: architecture
updates (arm, arm64, x86, powerpc, s390, with a smattering of other
architecture updates too) and various core kernel updates: networking,
filesystems, VM, scheduling etc. And the usual documentation and
tooling (perf and self-tests) updates.

Please do test, and we can get the whole calming-down period rolling
and hopefully get a timely final 5.14 release.

                  Linus

---

Al Viro (3):
    vfs d_path() updates
    iov_iter updates
    vfs name lookup updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    misc updates
    more updates
    yet more updates

Arnaldo Carvalho de Melo (2):
    perf tool updates
    more perf tool updates

Arnd Bergmann (1):
    asm/unaligned.h unification

Bartosz Golaszewski (1):
    gpio updates

Bjorn Andersson (2):
    remoteproc updates
    hwspinlock updates

Bjorn Helgaas (2):
    pci updates
    pci fix

Borislav Petkov (3):
    x86 RAS updates
    x86 cpu updates
    x86 SEV updates

Bruce Fields (1):
    nfsd updates

Casey Schaufler (1):
    smack updates

Christian Brauner (2):
    mount_setattr updates
    openat2 fixes

Christoph Hellwig (2):
    dma-mapping updates
    configfs updates

Corey Minyard (1):
    IPMI driver updates

Dan Williams (1):
    CXL (Compute Express Link) updates

Daniel Lezcano (1):
    thermal updates

Daniel Thompson (1):
    kgdb updates

Darrick Wong (1):
    xfs updates

Dave Airlie (2):
    drm updates
    drm fixes

David Kleikamp (1):
    jfs updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dennis Zhou (2):
    percpu updates
    percpu fix

Dmitry Torokhov (1):
    input updates

Eric Biederman (1):
    user namespace rlimit handling update

Eric Biggers (1):
    fscrypt updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    char / misc driver updates
    driver core changes
    staging / IIO driver updates
    tty / serial updates
    USB / Thunderbolt updates

Greg Ungerer (1):
    m68knommu update

Guenter Roeck (1):
    hwmon updates

Guo Ren (1):
    arch/csky updates

Gustavo Silva (3):
    fallthrough fixes
    array-bounds fixes
    more fallthrough fixes

Hans de Goede (1):
    x86 platform driver updates

Herbert Xu (2):
    crypto updates
    crypto fixes

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (19):
    EFI updates
    objtool fix and updates
    locking updates
    perf events updates
    scheduler udpates
    timers/nohz updates
    x86 exception handling updates
    x86 asm updates
    x86 boot update
    x86 resource control documentation fixes
    x86 cleanups
    x86 uapi fixlet
    x86 mm update
    x86 splitlock updates
    scheduler fixes
    locking fixes
    perf fixes
    scheduler fixes
    irq fixes

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (1):
    networking updates

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (1):
    misc fs updates

Jarkko Sakkinen (1):
    tpm driver updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (6):
    libata updates
    core block updates
    block driver updates
    io_uring updates
    more block updates
    io_uring fixes

Jessica Yu (1):
    module updates

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (1):
    xen updates

Julia Lawall (1):
    coccinelle updates

Kees Cook (3):
    seccomp updates
    pstore updates
    clang feature updates

Lee Jones (2):
    mfd updates
    backlight updates

Linus Walleij (1):
    pin control updates

Mark Brown (3):
    regmap updates
    regulator updates
    spi updates

Masahiro Yamada (1):
    Kbuild updates

Mauro Carvalho Chehab (1):
    media updates

Micah Morton (1):
    SafeSetID update

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio,vhost,vdpa updates

Michal Simek (1):
    microblaze updates

Mike Marshall (1):
    orangefs updates

Mike Rapoport (2):
    memblock updates
    memblock fix

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (1):
    fuse updates

Mimi Zohar (1):
    integrity subsystem updates

Namjae Jeon (1):
    exfat updates

Olof Johansson (3):
    ARM SoC updates
    ARM devicetree updates
    ARM driver updates

Palmer Dabbelt (1):
    RISC-V updates

Paolo Bonzini (1):
    kvm updates

Paul E McKenney (1):
    lkmm fixlet

Paul McKenney (2):
    KCSAN updates
    RCU updates

Paul Moore (2):
    SELinux updates
    audit updates

Pavel Machek (1):
    LED updates

Petr Mladek (1):
    printk updates

Rafael Wysocki (6):
    power management updates
    ACPI updates
    PNP updates
    device properties framework updates
    more power management updates
    more ACPI updates

Richard Weinberger (3):
    MTD updates
    UBIFS updates
    UML updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM development updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    KUnit update
    Kselftest update

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (2):
    clk updates
    more clk updates

Steve French (2):
    cifs updates
    cifs fixes

Steven Rostedt (2):
    tracing updates
    tracing fix and cleanup

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (2):
    ext4 updates
    ext4 updates

Tejun Heo (1):
    cgroup updates

Tetsuo Handa (1):
    tomoyo fix

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (2):
    MIPS updates
    MIPS fixes

Thomas Gleixner (7):
    CPU hotplug cleanup
    CPU hotplug fix
    irq updates
    timer updates
    x86 interrupt related updates
    x86 entry code related updates
    x86 fpu updates

Tony Luck (1):
    EDAC updates

Trond Myklebust (1):
    NFS client updates

Ulf Hansson (2):
    MMC and MEMSTICK updates
    MMC fixes

Vasily Gorbik (2):
    s390 updates
    more s390 updates

Vinod Koul (1):
    dmaengine updates

Wei Liu (1):
    hyperv updates

Will Deacon (1):
    arm64 updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

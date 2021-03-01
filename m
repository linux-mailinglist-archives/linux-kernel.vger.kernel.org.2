Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77635327599
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 01:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhCAAal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 19:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhCAAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 19:30:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F990C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 16:29:53 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b1so11897052lfb.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 16:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=QjQrwa6s0RuEsZkQxIVwJDl+Hro46Ll5OFgQ7B9WVxw=;
        b=bQSMbrwuohH98EIPVc9H4uT+rVVY8dV7678TTSlVKG+Ikp1Q9M3VNAw7zjyBl0OIMG
         AQpja7oHawlcXY2tTd5m5/B3ZWAFHaw8qeAxZ6lfXLzsd7s5XTp4hEb5UXxZ1cjxoZfV
         2sPBTMvL04e3qQsyoMjw9UW/fPTbmAb2zFf38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QjQrwa6s0RuEsZkQxIVwJDl+Hro46Ll5OFgQ7B9WVxw=;
        b=ZIGRWJYW3xRiG2Nsx6TzGE+jZZ3NtL7vwrZdZ38sYo8OO6HgUn/medPuMyDMzOYx/X
         l6mL5wPYgl7gRwvhz7kVWOvfxYlOFP4/YKzJAYqu8Ml31FR7k8BnjTHbU8Vbh2HIbbua
         0j86W29oF0GeLnthpciunUBQjRwHh8ZMqk6ty3oycw6Rm9s8wj8SzJz8CPxXPhFl/214
         JcW6J51FrEhSlRx5HJtxgp6e8/0ZjS8n/DwgXx/8e3E5x6o1F3ZZXTWAktf9BFD5Nc9L
         vrw5Nui5xyD9clzAVqaUErJUuzUSpTE5JkUic5iZ4/7bRDSnKqL1/a9/yV13548Hxnaj
         qqQw==
X-Gm-Message-State: AOAM533yUbQz0aGDN2r12yGM46nPmQHxBrtiMgRTg1ex7BuGK6j88++N
        /XWfmMkviCRVIAKshIM8uF/KUWoEXklJpg==
X-Google-Smtp-Source: ABdhPJzKVzeNJ4M1/VegJm97MUo38i4DJSBg4R4yUfZGZsajlp6mGEPc6dplfQ+cu+0UO/r9gsWEEA==
X-Received: by 2002:ac2:4988:: with SMTP id f8mr6843335lfl.640.1614558591130;
        Sun, 28 Feb 2021 16:29:51 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id m12sm2119165lfh.237.2021.02.28.16.29.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 16:29:50 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id m11so16527760lji.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 16:29:50 -0800 (PST)
X-Received: by 2002:a2e:a306:: with SMTP id l6mr7606198lje.251.1614558589831;
 Sun, 28 Feb 2021 16:29:49 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Feb 2021 16:29:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUzNbTuRCAv80vyD1dXEEaefdpRi23J+suSaognBoV8A@mail.gmail.com>
Message-ID: <CAHk-=wjUzNbTuRCAv80vyD1dXEEaefdpRi23J+suSaognBoV8A@mail.gmail.com>
Subject: Linux 5.12-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So two weeks have passed since the 5.11 release, and so - like
clockwork - the merge window for 5.12 has closed, and 5.12-rc1 is out
there for your perusal.

That said, we have now have two unusual merge windows in a row: first
we had the holiday season, and this time around the Portland area had
over a quarter million people without electricity because we had a
winter ice storm that took down thousands of trees, and lots of
electricity lines.

So I was actually without electricity for six days of the merge
window, and was seriously considering just extending the merge window
to get everything done.

As you can tell, I didn't do that. To a large part because people were
actually very good about sending in their pull requests, so by the
time I finally got power back, everything was nicely lined up and I
got things merged up ok.

But partly this is also because 5.12 is a smaller release than some
previous ones - and that wasn't due to the lack of electricity, that
showed independently in the statistics in the linux-next tree. Of
course, "smaller" is all relative, but instead of the 12-13+k commits
we've had the last few releases, linux-next this time only had 10+k
commits lined up. So that helped things a bit.

That said, if my delayed merging caused issues for anybody, please
holler and explain to me, and I'll be flexible during the rc2 week.
But that's _not_ a blanket "I'll take late pulls", that's very much a
"if my delayed merge caused problems for some tree, explain why, and
I'll work with you".

Anyway, on to the actual changes. Even if it was a slightly smaller
merge window than previous ones, it's still big enough that appended
is just my usual merge log, not the full list of the 10982 non-merge
commits by 1500+ people. So it's  more of a flavor of the kinds of
things that have happened rather than a deep dive.

The one thing that perhaps stands out is that this release actually
did a fair amount of historical cleanup. Yes, overall we still have
more new lines than we have removed lines, but we did have some spring
cleaning, removing the legacy OPROFILE support (the user tools have
been using the "perf" interface for years), and removing several
legacy SoC platforms and various drivers that no longer make any
sense.

So even if we more than made up for that with all the _new_ drivers
and code we added, that kind of cleanup is always nice to see.

    Linus

---

Al Viro (6):
    sendfile updates
    ELF compat updates
    namei updates
    d_name whack-a-mole
    RCU-safe common_lsm_audit()
    misc vfs updates

Alexandre Belloni (2):
    i3c update
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (2):
    misc updates
    more updates

Anna Schumaker (1):
    NFS Client Updates

Ard Biesheuvel via Borislav Petkov (1):
    EFI updates

Arnaldo Carvalho de Melo (1):
    perf tool updates

Arnd Bergmann (6):
    ARM SoC fixes
    ARM SoC platform removals
    ARM SoC updates
    ARM SoC defconfig updates
    ARM SoC devicetree updates
    ARM SoC driver updates

Bartosz Golaszewski (1):
    gpio updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (3):
    hwspinlock updates
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (1):
    PCI updates

Borislav Petkov (14):
    EDAC updates
    RAS updates
    x86 SGX fixes
    x86 SEV-ES fix
    x86 platform updates
    x86 paravirt updates
    x86 mm cleanups
    x86 misc updates
    x86 microcode cleanup
    x86 FPU updates
    x86 CPUID cleanup
    x86 resource control updates
    x86 build updates
    x86 asm updates

Casey Schaufler (1):
    smack updates

Christian Brauner (1):
    idmapped mounts

Christoph Hellwig (1):
    dma-mapping updates

Chuck Lever (2):
    nfsd updates
    more nfsd updates

Corey Minyard (1):
    IPMI update

Damien Le Moal (1):
    zonefs updates

Dan Williams (2):
    libnvdimm and device-dax updates
    initial support for CXL (Compute Express Link)

Daniel Lezcano (1):
    thermal updates

Daniel Thompson (1):
    kgdb updates

Daniel Vetter (2):
    kcmp kconfig update
    follow_pfn() updates

Darrick Wong (3):
    iomap updates
    xfs updates
    more xfs updates

Dave Airlie (2):
    drm updates
    more drm updates

David Howells (1):
    keyring updates

David Kleikamp (1):
    jfs updates

David Miller (2):
    networking updates
    sparc updates

David Sterba (2):
    AFFS fix
    btrfs updates

Dennis Zhou (1):
    percpu updates

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    pcmcia update

Eric Biederman (1):
    user namespace update

Eric Biggers (1):
    fsverity updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greentime Hu (1):
    nds32 updates

Greg KH (5):
    tty/serial driver updates
    USB and Thunderbolt updates
    staging and IIO driver updates
    driver core / debugfs update
    char/misc driver updates

Greg Ungerer (1):
    m68knommu update

Guenter Roeck (1):
    hwmon updates

Guo Ren (1):
    arch/csky updates

Hans de Goede (1):
    x86 platform driver updates

Helge Deller (1):
    parisc updates

Herbert Xu (1):
    crypto update

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (5):
    RCU updates
    locking updates
    tlb gather updates
    scheduler updates
    performance event updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (1):
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (3):
    lazytime updates
    fsnotify update
    isofs, udf, and quota updates

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jeff Layton (1):
    fcntl fix

Jens Axboe (9):
    libata updates
    core block updates
    block driver updates
    io_uring updates
    block IPI updates
    more io_uring updates
    io_uring thread rewrite
    more block updates
    ide fix

Jessica Yu (1):
    module updates

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

Jonathan Corbet (2):
    documentation updates
    documentation fixes

Juergen Gross (2):
    xen updates
    more xen updates

Kees Cook (6):
    pstore fix
    seccomp updates
    clang LTO updates
    more clang LTO updates
    clang LTO fixes
    orphan handling fix

Konrad Rzeszutek Wilk (1):
    swiotlb updates

Lee Jones (2):
    backlight updates
    MFD updates

Ley Foon Tan (1):
    arch/nios2 updates

Linus Walleij (1):
    pin control updates

Mark Brown (3):
    regmap update
    regulator updates
    spi updates

Masahiro Yamada (2):
    Kbuild updates
    Kbuild fixes

Mauro Carvalho Chehab (1):
    media updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Miguel Ojeda (1):
    auxdisplay updates

Mike Rapoport (1):
    memblock update

Mike Snitzer (1):
    device mapper updates

Mimi Zohar (1):
    IMA updates

Namjae Jeon (1):
    exfat updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Bonzini (2):
    KVM updates
    more KVM updates

Paul Moore (2):
    selinux updates
    audit updates

Pavel Machek (1):
    LED updates

Petr Mladek (2):
    printk updates
    livepatching updates

Rafael Wysocki (7):
    power management updates
    ACPI updates
    PNP updates
    more power management updates
    more ACPI updates
    Simple Firmware Interface (SFI) support removal
    more ACPI updates

Richard Weinberger (3):
    UML updates
    MTD updates
    JFFS2/UBIFS and UBI updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    power supply and reset updates
    HSI update

Shuah Khan (1):
    Kselftest updates
    KUnit updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (1):
    clk updates

Steve French (1):
    cifs updates

Steven Rostedt (2):
    tracing updates
    tracing fixes

Takashi Iwai (1):
    sound updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    cgroup updates
    qorkqueue updates

Tetsuo Handa (1):
    tomoyo updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (2):
    MIPS updates
    more MIPS updates

Thomas Gleixner (5):
    irq updates
    timer updates
    timer fixes
    objtool updates
    x86 irq entry updates

Ulf Hansson (1):
    MMC updates

Vasily Gorbik (2):
    s390 updates
    more s390 updates

Vinod Koul (1):
    dmaengine updates

Viresh Kumar (1):
    oprofile and dcookies removal

Wei Liu (1):
    Hyper-V updates

Will Deacon (2):
    arm64 updates
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    i2c fixes

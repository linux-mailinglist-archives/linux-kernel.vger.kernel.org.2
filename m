Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508F140825D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 01:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhIMAAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 20:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhIMAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 20:00:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A92C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 16:58:46 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l18so13952879lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=zT4DqGPwafS1WcrL534B9bMEC897LlbMem3sYDJMBsw=;
        b=SGussuQe+NjDzPGt3M9o61CyMI6cLAyDiZLgYjMurnD739+XrnyGyZ6iXgfOuheum7
         jfGwnYtKBb1SAwFr/ZvCgpWk8nWfeqVVJfPVm8rFNF0AqRSaVDheI+KS6aSW4DDw1uGn
         CzUfFc9C/FPL94hAn9uG3XN58nHnrNdadqXEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zT4DqGPwafS1WcrL534B9bMEC897LlbMem3sYDJMBsw=;
        b=tfVh3kAX+iExkXoIVELu662WZS371t6XX11S+JROb2MKhiVpfEkakSX84rc/2om5p4
         wZ9czu4/POeB0CJXTLMtK9unmOkEYJvbAvxwl1HTsbNpP6ii5dQJHLmRyxFfllecGtLe
         VGXAFA+s+WsgMs0TNlyXjeQZzHZW9OnYmkVul4D3l2upSg7UeeCoWX32qJN2RB27XYNc
         pYKKc8uOEByNW17QJm2zvTjXDzxVMKhTJsHITeeKv6MVB1wf+7XB3/0PYyzrU09fgVl5
         LR0NV4dBvCWb+GldOm7nWxQJC6U71l9gXOEO+XOpGpC4OwO51UXe0wBEc83GekseqhdI
         kJzA==
X-Gm-Message-State: AOAM5305DFMuMOsdocajk0enZ8lRF9MY8tF51VwAZxkGb8gpyhqcsTcl
        61b8N2OOS9/grp68mAsqyBjqFXxp0/1jg3Ukrp0=
X-Google-Smtp-Source: ABdhPJzuPq7tkeJ5uUKNUyYt4+f9QMHis6SPXYpxQ7Dx1xZX172JvLTKJ+GpZWAaY/WbBRXgrBm/Vg==
X-Received: by 2002:a2e:7c0a:: with SMTP id x10mr8170925ljc.340.1631491124326;
        Sun, 12 Sep 2021 16:58:44 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id p1sm759788ljn.130.2021.09.12.16.58.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 16:58:43 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id g1so5720832lfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 16:58:43 -0700 (PDT)
X-Received: by 2002:a05:6512:3d04:: with SMTP id d4mr6775460lfv.474.1631491123455;
 Sun, 12 Sep 2021 16:58:43 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Sep 2021 16:58:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
Message-ID: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
Subject: Linux 5.15-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So 5.15 isn't shaping up to be a particularly large release, at least
in number of commits. At only just over 10k non-merge commits, this is
in fact the smallest rc1 we have had in the 5.x series. We're usually
hovering in the 12-14k commit range.

That said, counting commits isn't necessarily the best measure, and
that might be particularly true this time around. We have a few new
subsystems, with NTFSv3 and ksmbd standing out. And as a result, when
you look at the stats on a "lines changed" basis, 5.15-rc1 ends up
looking much more middle-of-the-road. It still doesn't look like a
particularly _big_ merge window, but also not remotely the smallest
one.

And while this is not up there with some larger releases, it's
actually been one of the messier merge windows. Part of it was
self-inflicted damage from me trying to enable -Werror much more
aggressively, but I also ended up having to push back a lot more on
some of the patch series and had a number o full requests where I went
"ok, I've pulled this, but XYZ is wrong".

So we've had merge windows that went much more smoothly. In fact, I
have a pull request or two that I just didn't feel like going through
fully, and I might still pull the upcoming week, but I got a bit fed
up with how I ended up seeing new pull requests - and not for fixes -
coming in fairly late in the merge window. Yes, the merge window is
two weeks, but part of that is very literally to give _me_ time to
actually look things through, not for people to send me new requests
up until the very end of the merge window.

Anyway, I'm hoping that things calm down, and I'll take a look at a
few things still in my inbox, but on the whole you should expect that
"that's it" and send me fixes only.

And in order to get those fixes going, please go out and test this.

Appended, as always, is my "mergelog" - since even at "only" 10k+
commits, the shortlog is not really realistically readable or useful
as a summary. And as always, the mergelog credits the person I pulled
from, which is not the same as the actual author of all the changes.
There's just over a hundred people listed below that I've pulled from,
but over 1500 people with authorship credit in the git tree. So that's
where you'd need to dig for all the details.

Thanks,
            Linus

---

Al Viro (4):
    iov_iter fixes
    root filesystem type handling updates
    gfs2 setattr updates
    namei updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    misc updates
    more updates
    yet more updates and hotfixes

Anna Schumaker (1):
    NFS client updates

Arnaldo Carvalho de Melo (2):
    perf tool updates
    more perf tools updates

Arnd Bergmann (5):
    asm-generic updates
    ARM SoC updates
    ARM SoC driver updates
    ARM defconfig updates
    ARM SoC DT updates

Bartosz Golaszewski (1):
    gpio updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (1):
    remoteproc updates

Bjorn Helgaas (1):
    PCI updates

Borislav Petkov (8):
    EDAC updates
    RAS update
    x86 build updates
    x86 resource control updates
    x86 cleanups
    timer fix
    locking fixes
    scheduler fixes

Casey Schaufler (1):
    smack updates

Catalin Marinas (2):
    arm64 updates
    arm64 fixes

Christian Brauner (4):
    move_mount updates
    close_range() cleanup
    idmapping documentation updates
    set_user()  update

Christoph Hellwig (2):
    configfs updates
    dma-mapping updates

Chuck Lever (2):
    nfsd updates
    nfsd fixes

Corey Minyard (1):
    IPMI updates

Dan Williams (2):
    libnvdimm updates
    CXL (Compute Express Link) updates

Daniel Lezcano (1):
    thermal updates

Daniel Thompson (1):
    kgdb updates

Darrick Wong (3):
    project quota update
    iomap updates
    xfs updates

Dave Airlie (2):
    drm updates
    drm fixes

David Hildenbrand (1):
    MAP_DENYWRITE removal

David Howells (1):
    fscache updates

David Sterba (2):
    btrfs updates
    btrfs fixes

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Dominique Martinet (1):
    9p updates

Eric Biederman (2):
    siginfo si_trapno updates
    exit cleanups

Eric Biggers (1):
    fscrypt updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (8):
    char / misc driver updates
    driver core updates
    IIO and staging driver updates
    tty / serial updates
    USB / Thunderbolt updates
    more USB updates
    habanalabs updates
    misc driver fix

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Hans de Goede (1):
    x86 platform driver updates

Heiko Carstens (2):
    s390 updates
    more s390 updates

Helge Deller (3):
    parisc architecture updates
    parisc architecture fixes
    parisc fixes

Herbert Xu (1):
    crypto updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (4):
    scheduler updates
    x86 perf event updates
    EFI updates
    memory model updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes and stragglers

James Bottomley (1):
    SCSI updates

Jan Kara (4):
    fsnotify updates
    FIEMAP cleanups
    UDF and isofs updates
    fs hole punching vs cache filling race fixes

Jarkko Sakkinen (1):
    tpm driver updates

Jason Gunthorpe (2):
    rdma updates
    rdma fixes

Jassi Brar (1):
    mailbox updates

Jean Delvare (1):
    dmi fix

Jeff Layton (1):
    file locking updates

Jens Axboe (13):
    block updates
    block driver updates
    libata updates
    io_uring updates
    support for struct bio recycling
    io_uring mkdirat/symlinkat/linkat support
    io_uring fixes
    libata fixes
    CDROM maintainer update
    block fixes
    libata maintainer update
    block fixes
    io_uring fixes

Jessica Yu (1):
    module updates

Jiri Kosina (1):
    HID updates

Joerg Roedel (2):
    iommu updates
    iommu fixes

Jon Mason (1):
    NTB updates

Jonathan Corbet (2):
    documentation updates
    more documentation updates

Juergen Gross (1):
    xen updates

Julia Lawall (1):
    coccinelle updates

Kees Cook (1):
    hardening updates

Konrad Rzeszutek Wilk (3):
    ibft updates
    swiotlb updates
    ibft fix

Konstantin Komarov (1):
    NTFSv3 filesystem

Lee Jones (2):
    MFD updates
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

Max Filippov (1):
    Xtensa updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze update

Miguel Ojeda (2):
    auxdisplay updates
    compiler attributes updates

Mike Rapoport (1):
    memblock updates

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (2):
    overlayfs update
    fuse updates

Mimi Zohar (1):
    integrity subsystem updates

Miquel Raynal (1):
    MTD updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Bonzini (1):
    KVM updates

Paul McKenney (1):
    RCU updates

Paul Moore (2):
    selinux update
    audit updates

Pavel Machek (1):
    LED updates

Petr Mladek (2):
    printk updates
    livepatching update

Rafael Wysocki (7):
    power management updates
    ACPI updates
    device properties framework updates
    more ACPI updates
    more power management updates
    more power management updates
    more ACPI updates

Richard Weinberger (1):
    UML updates

Rob Herring (2):
    devicetree updates
    devicetree fixes

Russell King (1):
    ARM development updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    KUnit updates
    Kselftest updates

Stafford Horne (1):
    OpenRISC updates

Stefan Richter (1):
    firewire updates

Stephen Boyd (2):
    clk updates
    clk fix

Steve French (4):
    initial ksmbd implementation
    cifs client updates
    ksmbd fixes
    smbfs updates

Steven Rostedt (3):
    tracing updates
    more tracing updates
    tracing fixes

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    cgroup updates
    workqueue updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (9):
    debugobjects update
    SMP core updates
    locking and atomics updates
    irq updates
    x86 cache flush updates
    x86 PIRQ updates
    misc x86 updates
    timer updates
    CPU hotplug updates

Ulf Hansson (1):
    MMC and MEMSTICK updates

Vineet Gupta (1):
    ARC updates

Vinod Koul (1):
    dmaengine updates

Vlastimil Babka (1):
    SLUB updates

Wei Liu (1):
    hyperv updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

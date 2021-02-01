Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B130A867
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhBANO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhBANOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:14:54 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC968C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:14:13 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id a19so16107820qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 05:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m/m4iDNhXlC/4SoepFWMucxyT4bgcrx85mTDKJelr6A=;
        b=IFGNwmuuTtFzC4nyasNkq/kmGH1XxBzW3n6shA/3Aq88TjZkak+MuRj+GqbtUEax/5
         jmF/G4GG6QZL0JCK6d4mfZmN8ZlVdHteyLuw9fCY58FEcW07EEGga0Z7lUKra04nmEl3
         pqQizOLJE7GCXECY54S21BxPO2zpzg/1rjbbhbXtefFsaisv3885IzSE92YowpuSrI9y
         3z6mi72i/o0p4BnUq6CJOLwKJEy4iPAs5bj2P/9mU7XwKjv/m8/KePWuNR2tjWPM9El9
         hKEoWsUJiUwQp0BafM8MM1hIHR9k/Oj0jXbXnZ8b+2CgrsNZ3ZLTyMSnKCEurXK4/QhK
         uWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m/m4iDNhXlC/4SoepFWMucxyT4bgcrx85mTDKJelr6A=;
        b=YbgBENinE66huukH6pdOFUE3RJ8VQdAJC3m4ULBddX7PRkWe1bOuS0Vil4jWQ9xasX
         hsYEq9+uE84ie+OfvvG1Qh8qXI1WaR7NVtH9/xj7OSghu8hi1I74hTH+/yEQBCAVnysT
         B8uatOQ69cgTg3dGqz1CMHZQkQqRhPMrD32Kr3Hsh9Yl9z6o3fxfcjN5MUwxU5wGEfMX
         MGkhAVXq1gxS4aVHjpoCbq8Q5iXp3c3SMp2LN+uSKZ6T/u52GddSrRboalqdgPQSNdv3
         GR5mPPWm8wycGSH3zN/ZGGdnZ/v9HdDXAeH2dWu4+leRRpBw50P4r34BqFdwwaOD8f07
         VlMw==
X-Gm-Message-State: AOAM531OdAYpQ6Jc0esIerhNkdXh7261j9+nhpx+e+lIay6vDA5VI8Vy
        adVNb1u3xxM2RVbplF07SLE4c2M46/kXPSvd4BA=
X-Google-Smtp-Source: ABdhPJxhHhM+hyiqlTKN68abhPZ0I8LNquuVChIU64oCRP2OQGuNQYluOjMTxVjJIoyl+9xLVQ0nB3dSbM9m/mZAN5c=
X-Received: by 2002:a05:620a:5fa:: with SMTP id z26mr16004586qkg.108.1612185253097;
 Mon, 01 Feb 2021 05:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at>
In-Reply-To: <20210124232007.21639-1-richard@nod.at>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 1 Feb 2021 14:14:01 +0100
Message-ID: <CAFLxGvzQo9H8h5XpLuVDYC8uaRrPmkH444yFv3jX0LNCs_nTmg@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Richard Weinberger <richard@nod.at>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        rminnich@google.com, sven@narfation.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        "open list:FUSE: FILESYSTEM..." <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*friendly FUSE maintainer ping* :-)

On Mon, Jan 25, 2021 at 12:24 AM Richard Weinberger <richard@nod.at> wrote:
>
> I'm happy to announce the first non-RFC version of this patch set.
> Over the xmas holidays I found some time to experiment with various users=
pace
> implementations of MTDs and gave the kernel side more fine-tuning.
>
> Rationale:
> ----------
>
> When working with flash devices a common task is emulating them to run va=
rious
> tests or inspect dumps from real hardware. To achieve that we have plenty=
 of
> emulators in the MTD subsystem: mtdram, block2mtd, nandsim.
>
> Each of them implements an ad-hoc MTD and have various drawbacks.
> Over the last years some developers tried to extend them but these attemp=
ts
> often got rejected because they added just more adhoc feature instead of
> addressing overall problems.
>
> MUSE is a novel approach to address the need of advanced MTD emulators.
> Advanced means in this context supporting different (vendor specific) ima=
ge
> formats, different ways for fault injection (fuzzing) and recoding/replay=
ing
> IOs to emulate power cuts.
>
> The core goal of MUSE is having the complexity on the userspace side and
> only a small MTD driver in kernelspace.
> While playing with different approaches I realized that FUSE offers every=
thing
> we need. So MUSE is a little like CUSE except that it does not implement =
a
> bare character device but an MTD.
>
> Notes:
> ------
>
> - OOB support is currently limited. Currently MUSE has no support for pro=
cessing
>   in- and out-band in the same MTD operation. It is good enough to make J=
FFS2
>   happy. This limitation is because FUSE has no support more than one var=
iable
>   length buffer in a FUSE request.
>   At least I didn=E2=80=99t find a good way to pass more than one buffer =
to a request.
>   Maybe FUSE folks can correct me. :-)
>
> - Every MTD read/write operation maps 1:1 to a MUSE_READ/WRITE opcode.
>   Since FUSE requests are not cheap, the amount of read/written bytes in =
a MTD
>   operation as a huge impact on the performance. Especially when NOR styl=
e MTDs
>   are implemented in userspace a large writebufsize should be requested t=
o gain
>   good write performance.
>   On the other hand, MTD operations with lengths larger than writesize ar=
e *not*
>   split up into multiple MUSE_READ/WRITE requests. This means that usersp=
ace
>   has to split them manually when doing power-cut emulation.
>
> - MUSE is not super fast. On my i5 workstation nandsim is almost twice as=
 fast
>   as a NAND flash in userspace. But MUSE is still magnitudes faster than =
any
>   real world MTD out there. So it is good enough for the use cases I have=
 in
>   mind.
>
> Changelog:
> ----------
>
> Changes since v2 (RFC):
> - OOB support
> - MUSE_READ/WRITE opcodes are no longer a min IO MTD unit
> - MTD partitions support via mtdparts string
> - More code cleanup
> - Code rebased to 5.11-rc4
>
> Changes since v1 (RFC):
> - Rewrote IO path, fuse_direct_io() is no longer used.
>   Instead of cheating fuse_direct_io() use custom ops to implement
>   reading and writing. That way MUSE no longer needs a dummy file object
>   nor a fuse file object.
>   In MTD all IO is synchronous and operations on kernel buffers, this
>   makes IO processing simple for MUSE.
> - Support for bad blocks.
> - No more (ab)use of FUSE ops such as FUSE_FSYNC.
> - Major code cleanup.
>
> This series can also be found at:
> git://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git muse_v3
>
> Richard Weinberger (8):
>   fuse: Export fuse_simple_request
>   fuse: Export IO helpers
>   fuse: Make cuse_parse_one a common helper
>   mtd: Add MTD_MUSE flag
>   mtd: Allow passing a custom cmdline to cmdline line parser
>   fuse: Add MUSE specific defines FUSE interface
>   fuse: Implement MUSE - MTD in userspace
>   MAINTAINERS: Add entry for MUSE
>
>  Documentation/ABI/testing/sysfs-class-mtd |    8 +
>  MAINTAINERS                               |    7 +
>  drivers/mtd/parsers/cmdlinepart.c         |   73 +-
>  fs/fuse/Kconfig                           |   15 +
>  fs/fuse/Makefile                          |    2 +
>  fs/fuse/cuse.c                            |   58 +-
>  fs/fuse/dev.c                             |    1 +
>  fs/fuse/file.c                            |   16 +-
>  fs/fuse/fuse_i.h                          |   18 +
>  fs/fuse/helper.c                          |   70 ++
>  fs/fuse/muse.c                            | 1086 +++++++++++++++++++++
>  include/linux/mtd/partitions.h            |    2 +
>  include/uapi/linux/fuse.h                 |   76 ++
>  include/uapi/mtd/mtd-abi.h                |    1 +
>  14 files changed, 1346 insertions(+), 87 deletions(-)
>  create mode 100644 fs/fuse/helper.c
>  create mode 100644 fs/fuse/muse.c
>
> --
> 2.26.2
>


--=20
Thanks,
//richard

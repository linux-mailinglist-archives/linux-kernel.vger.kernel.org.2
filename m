Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F6D31A800
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhBLWrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:47:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhBLWfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:35:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A529F64E8E;
        Fri, 12 Feb 2021 22:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613169257;
        bh=jx3SkOo53FyBZWQ2WTsLZOKbb/JkJh7B6ZUavSTDDzY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bfYrYGKpjFoeuqMx8ouLctaZfSPcP817M5XYj3VgS6MZKaK8+MOXMhrby7uZvRrOq
         aSSqyWo4xJ69Wb1sLA8tnAijieITo/QaR4OHrtwYrl2MF/HjGxyrUWx3dq2gPf3mRt
         QZWF6B6hsHdSPUsnHC1vAX0DHQb7pcnLxcxnGFXBBCjDcLnOw/jdU40McczNAPxSjt
         Km2aSoGCZhSa7pnOc+T+owGfrWgqQlIOpdp/8QtyZ4mMuDXSnfBksrGJ7RQY9i9wbe
         40b0W3KmEf2OPwYuIAWewwy7Ab1ZwZ83ys3kq60vFX26GuojdTlFxNfwAaAA2+zsPT
         XXOPQLhV0/NCg==
Received: by mail-ej1-f44.google.com with SMTP id y26so1646019eju.13;
        Fri, 12 Feb 2021 14:34:17 -0800 (PST)
X-Gm-Message-State: AOAM532WMCBn0CNUQ/HPAPZt+AHLlqqdcBAAcLofek8hfGQa8mWCFxc8
        kOlUxsvoPwlyjG88/GW2ekvZJT2WO7M/qGUEqg==
X-Google-Smtp-Source: ABdhPJwzVjipKpkcLY2YlgHVjF8avz4tr5CX828BlvrRaiH8zZVQFzkrqJ7YjY2wDhNk6EwIO07jCPYBxRgkB58Wf9g=
X-Received: by 2002:a17:906:d1d0:: with SMTP id bs16mr5262013ejb.468.1613169256227;
 Fri, 12 Feb 2021 14:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20210212033120.GA100407@roeck-us.net> <CAL_JsqLm3mHdPg4wkdhoFXNY1JgTJ56dxi3oLqBS_NBrX=rOfw@mail.gmail.com>
 <20210212151725.GA57042@roeck-us.net> <CAL_Jsq+e+KdzanMdHYCEoGZn3ybY5_ASN60qiqbOkPWpkbQ6NQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+e+KdzanMdHYCEoGZn3ybY5_ASN60qiqbOkPWpkbQ6NQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Feb 2021 16:34:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL4suDinALfp4v96arJXpWts8pergO1-aenLv+RN9S64Q@mail.gmail.com>
Message-ID: <CAL_JsqL4suDinALfp4v96arJXpWts8pergO1-aenLv+RN9S64Q@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9
To:     Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 3:01 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Feb 12, 2021 at 9:17 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Fri, Feb 12, 2021 at 08:16:04AM -0600, Rob Herring wrote:
> > > On Thu, Feb 11, 2021 at 9:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Wed, Feb 03, 2021 at 03:26:03PM -0600, Rob Herring wrote:
> > > > > This adds the following commits from upstream:
> > > > >
> > > > > 183df9e9c2b9 gitignore: Ignore the swp files
> > > > > 0db6d09584e1 gitignore: Add cscope files
> > > > > 307afa1a7be8 Update Jon Loeliger's email
> > > > > ca16a723fa9d fdtdump: Fix gcc11 warning
> > > > > 64990a272e8f srcpos: increase MAX_SRCFILE_DEPTH
> > > > > 163f0469bf2e dtc: Allow overlays to have .dtbo extension
> > > > > 3b01518e688d Set last_comp_version correctly in new dtb and fix potential version issues in fdt_open_into
> > > > > f7e5737f26aa tests: Fix overlay_overlay_nosugar test case
> > > > > 7cd5d5fe43d5 libfdt: Tweak description of assume-aligned load helpers
> > > > > a7c404099349 libfdt: Internally perform potentially unaligned loads
> > > > > bab85e48a6f4 meson: increase default timeout for tests
> > > > > f8b46098824d meson: do not assume python is installed, skip tests
> > > > > 30a56bce4f0b meson: fix -Wall warning
> > > > > 5e735860c478 libfdt: Check for 8-byte address alignment in fdt_ro_probe_()
> > > > > 67849a327927 build-sys: add meson build
> > > > > 05874d08212d pylibfdt: allow build out of tree
> > > > > 3bc3a6b9fe0c dtc: Fix signedness comparisons warnings: Wrap (-1)
> > > > > e1147b159e92 dtc: Fix signedness comparisons warnings: change types
> > > > > 04cf1fdc0fcf convert-dtsv0: Fix signedness comparisons warning
> > > > > b30013edb878 libfdt: Fix kernel-doc comments
> > > > >
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > >
> > > > This patch causes my little-endian microblaze qemu emulations to fail
> > > > silently (no console output) in next-20210211. Reverting this patch
> > > > together with "scripts: dtc: Build fdtoverlay tool" fixes the problem.
> > >
> > > My guess would be something in libfdt. Maybe 7cd5d5fe43d5 or
> > > a7c404099349, though that should return to historical behavior.
> > >
> > > Can you give me the qemu command line and kernel cfg?
> > >
> > I copied everything you should need to build a kernel (including toolchain)
> > to http://server.roeck-us.net/qemu/microblazeel/
> >
> > [ wow, I really need to update that compiler ]
>
> I can't seem to get BE/LE nor reverted or not working. It's always
> dying in microblaze_cache_init() based on the last print. It's your
> config, but gcc 10.1.0 off of kernel.org.

It seems gcc 10.1 does not work. Seems to die before here:

pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768

> There is at least one possible problem here that the FDT may only be 4
> byte aligned. The assumption is 8 bytes to not have misaligned
> accesses (and only for 64-bit accesses if 4 byte aligned). That's an
> issue with the qemu image loading depending on the sizes and
> combination of images loaded. That doesn't explain your failure
> though. As the initrd is a multiple of 8 bytes, you should be fine.

It's the built-in dtb alignment that is the problem. I had noticed
this earlier, then discovered I had no built-in DTB and QEMU provides
a default. And changing didn't help because on broken gcc-10 it was 8
byte aligned. None of that should matter because we're not using the
built-in either, right? Wrong! The assembly entry code copies the
bootloader dtb into the built-in dtb space. I remember this now from
the last time I cleaned up the early DT code. I suppose the reason is
the bootloader dtb is not or may not be at an address mapped early.
I'd really like to get rid of that copy. Anyway, the oneliner below
fixes it. We need it either way, but I'd like some comments on the
copy.

Rob

diff --git a/arch/microblaze/kernel/vmlinux.lds.S
b/arch/microblaze/kernel/vmlinux.lds.S
index df07b3d06cd6..fb31747ec092 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -45,7 +45,7 @@ SECTIONS {
                _etext = . ;
        }

-       . = ALIGN (4) ;
+       . = ALIGN (8) ;
        __fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
                _fdt_start = . ;                /* place for fdt blob */
                *(__fdt_blob) ;                 /* Any link-placed DTB */

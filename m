Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9831A817
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhBLWx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhBLWvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:51:36 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D86C061788;
        Fri, 12 Feb 2021 14:50:52 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 100so739099otg.3;
        Fri, 12 Feb 2021 14:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gzQUxZUSdHfNgm48XxeyYVL3amdO5Aoz3t0EB56jNcE=;
        b=dfwd3oJb+mxdboDYZiz0aBgpe5QAbKD+Aj9U8PxtninPqu6cY2nexQE6j8UwPqwLFx
         FXY+UXgxMds22hMvI9AMUtHrLF2AOp7DXFldEE96/AmNIoEi3fKju9TPZfNlLdV4L4D+
         hDHvn2e6RhTE9CE8Jn9LIiU5JJpZk/o7aJf11Hcbo/HZcYpCu/41tiIzBw/wh5cC7Xxr
         enp/cnW/NKp3M3Iu3uX30Ov9rUgNaTSV2xyLybAj37goV0xKE2W3ika2M9oxHLJJUT9S
         kze5lDjlTc/A5Z0Wua2V83ES083aA2ftlMCNcNfeHOvYo36aLS/Pabt07nJTypRk7S+4
         SrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzQUxZUSdHfNgm48XxeyYVL3amdO5Aoz3t0EB56jNcE=;
        b=sQH3/uPVsCfa/oYyQxRxPSdcq+m6JErGLDm7EQMI6uSsMY6wRW350WpGD9uYhcEt5d
         KHNJ7RpPiLpzN1CtO7iAwY3a9IGDEXGgLK6pW04YMiFnAfi5nTFqHVeJE/00MqaBQOhe
         z8XgmjJ5fvoYGvQAiXghhtS9HnnoorIaB+9iuTqrWrBgL8RyNPM0iAnjqhAJSkjwwfSc
         RMjrDHCM5GsnTOOkNSRH7sHnlwtrNUn7QpQU2kkvLtC31rVnwQ+BG+VfkOAvWN0jUDuk
         Uy/v8vCSbnLg39jAj7SGicieOjpE8gdaE7jNJpjPpJfqZ/fJXccY55kf2rPCGipAVCTN
         3dYw==
X-Gm-Message-State: AOAM533/alM+nEHFjlrx9dVnLYUXzUYwFwXoabDoj4IBVJnAD0MGsVf4
        cVBGeHfMI9GsBod90kBMAkjY37PZco4=
X-Google-Smtp-Source: ABdhPJxjPsbHvY/7eZXAOodxS9Rfvz8ypbNME4A1c6AhV7OIuxCGhtTo4EPUT2vsqDVMOyHlsG6S4A==
X-Received: by 2002:a05:6830:1c6c:: with SMTP id s12mr3890064otg.125.1613170251469;
        Fri, 12 Feb 2021 14:50:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y66sm2125410oig.46.2021.02.12.14.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Feb 2021 14:50:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 Feb 2021 14:50:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] scripts/dtc: Update to upstream version
 v1.6.0-51-g183df9e9c2b9
Message-ID: <20210212225049.GC115630@roeck-us.net>
References: <20210212033120.GA100407@roeck-us.net>
 <CAL_JsqLm3mHdPg4wkdhoFXNY1JgTJ56dxi3oLqBS_NBrX=rOfw@mail.gmail.com>
 <20210212151725.GA57042@roeck-us.net>
 <CAL_Jsq+e+KdzanMdHYCEoGZn3ybY5_ASN60qiqbOkPWpkbQ6NQ@mail.gmail.com>
 <CAL_JsqL4suDinALfp4v96arJXpWts8pergO1-aenLv+RN9S64Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL4suDinALfp4v96arJXpWts8pergO1-aenLv+RN9S64Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 04:34:04PM -0600, Rob Herring wrote:
> On Fri, Feb 12, 2021 at 3:01 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Feb 12, 2021 at 9:17 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Fri, Feb 12, 2021 at 08:16:04AM -0600, Rob Herring wrote:
> > > > On Thu, Feb 11, 2021 at 9:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > On Wed, Feb 03, 2021 at 03:26:03PM -0600, Rob Herring wrote:
> > > > > > This adds the following commits from upstream:
> > > > > >
> > > > > > 183df9e9c2b9 gitignore: Ignore the swp files
> > > > > > 0db6d09584e1 gitignore: Add cscope files
> > > > > > 307afa1a7be8 Update Jon Loeliger's email
> > > > > > ca16a723fa9d fdtdump: Fix gcc11 warning
> > > > > > 64990a272e8f srcpos: increase MAX_SRCFILE_DEPTH
> > > > > > 163f0469bf2e dtc: Allow overlays to have .dtbo extension
> > > > > > 3b01518e688d Set last_comp_version correctly in new dtb and fix potential version issues in fdt_open_into
> > > > > > f7e5737f26aa tests: Fix overlay_overlay_nosugar test case
> > > > > > 7cd5d5fe43d5 libfdt: Tweak description of assume-aligned load helpers
> > > > > > a7c404099349 libfdt: Internally perform potentially unaligned loads
> > > > > > bab85e48a6f4 meson: increase default timeout for tests
> > > > > > f8b46098824d meson: do not assume python is installed, skip tests
> > > > > > 30a56bce4f0b meson: fix -Wall warning
> > > > > > 5e735860c478 libfdt: Check for 8-byte address alignment in fdt_ro_probe_()
> > > > > > 67849a327927 build-sys: add meson build
> > > > > > 05874d08212d pylibfdt: allow build out of tree
> > > > > > 3bc3a6b9fe0c dtc: Fix signedness comparisons warnings: Wrap (-1)
> > > > > > e1147b159e92 dtc: Fix signedness comparisons warnings: change types
> > > > > > 04cf1fdc0fcf convert-dtsv0: Fix signedness comparisons warning
> > > > > > b30013edb878 libfdt: Fix kernel-doc comments
> > > > > >
> > > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > >
> > > > > This patch causes my little-endian microblaze qemu emulations to fail
> > > > > silently (no console output) in next-20210211. Reverting this patch
> > > > > together with "scripts: dtc: Build fdtoverlay tool" fixes the problem.
> > > >
> > > > My guess would be something in libfdt. Maybe 7cd5d5fe43d5 or
> > > > a7c404099349, though that should return to historical behavior.
> > > >
> > > > Can you give me the qemu command line and kernel cfg?
> > > >
> > > I copied everything you should need to build a kernel (including toolchain)
> > > to http://server.roeck-us.net/qemu/microblazeel/
> > >
> > > [ wow, I really need to update that compiler ]
> >
> > I can't seem to get BE/LE nor reverted or not working. It's always
> > dying in microblaze_cache_init() based on the last print. It's your
> > config, but gcc 10.1.0 off of kernel.org.
> 
> It seems gcc 10.1 does not work. Seems to die before here:
> 
> pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> 
> > There is at least one possible problem here that the FDT may only be 4
> > byte aligned. The assumption is 8 bytes to not have misaligned
> > accesses (and only for 64-bit accesses if 4 byte aligned). That's an
> > issue with the qemu image loading depending on the sizes and
> > combination of images loaded. That doesn't explain your failure
> > though. As the initrd is a multiple of 8 bytes, you should be fine.
> 
> It's the built-in dtb alignment that is the problem. I had noticed
> this earlier, then discovered I had no built-in DTB and QEMU provides
> a default. And changing didn't help because on broken gcc-10 it was 8
> byte aligned. None of that should matter because we're not using the
> built-in either, right? Wrong! The assembly entry code copies the
> bootloader dtb into the built-in dtb space. I remember this now from
> the last time I cleaned up the early DT code. I suppose the reason is
> the bootloader dtb is not or may not be at an address mapped early.

I think the problem is here:

/* initialize device tree for usage in early_printk */
        early_init_devtree(_fdt_start);

That probably also explains why enabling earlycon doesn't help.

> I'd really like to get rid of that copy. Anyway, the oneliner below
> fixes it. We need it either way, but I'd like some comments on the
> copy.
> 

I can not comment on the copy, but the change below does indeed fix
the problem. Feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

to the patch if you send it out.

Thanks,
Guenter

> Rob
> 
> diff --git a/arch/microblaze/kernel/vmlinux.lds.S
> b/arch/microblaze/kernel/vmlinux.lds.S
> index df07b3d06cd6..fb31747ec092 100644
> --- a/arch/microblaze/kernel/vmlinux.lds.S
> +++ b/arch/microblaze/kernel/vmlinux.lds.S
> @@ -45,7 +45,7 @@ SECTIONS {
>                 _etext = . ;
>         }
> 
> -       . = ALIGN (4) ;
> +       . = ALIGN (8) ;
>         __fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
>                 _fdt_start = . ;                /* place for fdt blob */
>                 *(__fdt_blob) ;                 /* Any link-placed DTB */

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0589831A807
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 23:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhBLWsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 17:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhBLWot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:44:49 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED1BC061574;
        Fri, 12 Feb 2021 14:44:09 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id d7so704304otq.6;
        Fri, 12 Feb 2021 14:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xbNtLELg1RtFG5KjcFUY5MwAGwBpJT01ZUSEWMmRYHs=;
        b=ktkbrRhy3LgCj38onsFfpS89UiTL8Robqcs849yOWncrnJ0yIJMs30uR/0fpy1oGed
         Ofs2HfOtEIXkXz6z8Z8Gkom246Zmg2OkOyDNwgmYJjig6YMaBLoVAHpzzlIZUdFHSXa/
         DuveQeu/u+rHtHUEU2EHDU2qSBnw75eNSV1u/xAMYl/1w78Zk29wU7LvBXYVie04QLt0
         VzeWG5q63tksvXlXBr8S6L2bSbiq+zQ4X7UpwF0rkpxgEgaNtPR6cN9LIwC3yarZ1ccW
         RI2S7mdlEkyT/hz93omwejlS+l35VOadKCDOWyEYvJ3Jv5KKBZvD/jzx4wZ/QQjP+mrY
         UdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xbNtLELg1RtFG5KjcFUY5MwAGwBpJT01ZUSEWMmRYHs=;
        b=etNmsj2kvXzSIW94Io7lvP1FUxHOVT7AFiKj2qvEwJr1JNxyeIK1tURQPTn9k+b4AT
         cPdttbZvGE8W9CTZ/hO/+KO7afb+CFGN3wGUZgpIx6wEwFJSVfIkOUMw7ZNDuUjvOqQw
         2DbalK3M5o7RzD8TLYVlleI1v3VC82zkEGlZJXBDA2khsE04enzosMHElpY0PhROyPrm
         WhBSpJRP9gBbDAJJtJek+wmrX0KELfIBxDqnCfav89clWg3QZm2dOEMhHIY+lT4l1grO
         x+/vGGHgv0F1Aiy9wFw3+8ueNKwyH/wMF/OEwNsPcq90LKJ3aEm4WN+QihMt/ywGSq4D
         gfBA==
X-Gm-Message-State: AOAM533Yt9ufH2PlHzk8HIVBnOX5MMbh6B7vSFJKyx3dAoud3WiUuywJ
        7ZjD69vjjVzpOGfX4mQRpZk=
X-Google-Smtp-Source: ABdhPJygl/LHWfpGbSMmOYXjMukxoaH5L5TIqxidgD3lkdNSLK1Ta2BaKL+Cwljdtk4v6qJZMcZkeg==
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr3692163otl.369.1613169848900;
        Fri, 12 Feb 2021 14:44:08 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 18sm1934991oti.30.2021.02.12.14.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Feb 2021 14:44:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 Feb 2021 14:44:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] scripts/dtc: Update to upstream version
 v1.6.0-51-g183df9e9c2b9
Message-ID: <20210212224406.GB115630@roeck-us.net>
References: <20210212033120.GA100407@roeck-us.net>
 <CAL_JsqLm3mHdPg4wkdhoFXNY1JgTJ56dxi3oLqBS_NBrX=rOfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLm3mHdPg4wkdhoFXNY1JgTJ56dxi3oLqBS_NBrX=rOfw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 08:16:04AM -0600, Rob Herring wrote:
> On Thu, Feb 11, 2021 at 9:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Hi Rob,
> >
> > On Wed, Feb 03, 2021 at 03:26:03PM -0600, Rob Herring wrote:
> > > This adds the following commits from upstream:
> > >
> > > 183df9e9c2b9 gitignore: Ignore the swp files
> > > 0db6d09584e1 gitignore: Add cscope files
> > > 307afa1a7be8 Update Jon Loeliger's email
> > > ca16a723fa9d fdtdump: Fix gcc11 warning
> > > 64990a272e8f srcpos: increase MAX_SRCFILE_DEPTH
> > > 163f0469bf2e dtc: Allow overlays to have .dtbo extension
> > > 3b01518e688d Set last_comp_version correctly in new dtb and fix potential version issues in fdt_open_into
> > > f7e5737f26aa tests: Fix overlay_overlay_nosugar test case
> > > 7cd5d5fe43d5 libfdt: Tweak description of assume-aligned load helpers
> > > a7c404099349 libfdt: Internally perform potentially unaligned loads
> > > bab85e48a6f4 meson: increase default timeout for tests
> > > f8b46098824d meson: do not assume python is installed, skip tests
> > > 30a56bce4f0b meson: fix -Wall warning
> > > 5e735860c478 libfdt: Check for 8-byte address alignment in fdt_ro_probe_()
> > > 67849a327927 build-sys: add meson build
> > > 05874d08212d pylibfdt: allow build out of tree
> > > 3bc3a6b9fe0c dtc: Fix signedness comparisons warnings: Wrap (-1)
> > > e1147b159e92 dtc: Fix signedness comparisons warnings: change types
> > > 04cf1fdc0fcf convert-dtsv0: Fix signedness comparisons warning
> > > b30013edb878 libfdt: Fix kernel-doc comments
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > This patch causes my little-endian microblaze qemu emulations to fail
> > silently (no console output) in next-20210211. Reverting this patch
> > together with "scripts: dtc: Build fdtoverlay tool" fixes the problem.
> 
> My guess would be something in libfdt. Maybe 7cd5d5fe43d5 or
> a7c404099349, though that should return to historical behavior.
> 

7cd5d5fe43d5 is just a comment change, so that won't be it.
Reverting a7c404099349 didn't help, but reverting 5e735860c478 did the trick.
This does the trick as well:

index 3e893073da05..6ab627e52a21 100644
--- a/scripts/dtc/libfdt/fdt.c
+++ b/scripts/dtc/libfdt/fdt.c
@@ -23,8 +23,9 @@ int32_t fdt_ro_probe_(const void *fdt)
                return totalsize;

        /* The device tree must be at an 8-byte aligned address */
-       if ((uintptr_t)fdt & 7)
-               return -FDT_ERR_ALIGNMENT;
+       if ((uintptr_t)fdt & 7) {
+               // return -FDT_ERR_ALIGNMENT;
+       }

with some debugging ... aha:

Compiled-in FDT at c043f804

and in arch/microblaze/kernel/vmlinux.lds.S:

        . = ALIGN (4) ;
        __fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
                _fdt_start = . ;                /* place for fdt blob */

So the fix is to either remove the 8-byte alignment check or:

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
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

Thanks,
Guenter

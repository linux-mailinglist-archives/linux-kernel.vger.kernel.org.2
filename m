Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD631A71D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhBLVwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhBLVwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:52:32 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABBEC061756;
        Fri, 12 Feb 2021 13:51:52 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id m7so1195219oiw.12;
        Fri, 12 Feb 2021 13:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HM/0JZRBItaHHp9OzO6GXNqJ+q6r8b4HR0QehahiN7A=;
        b=D58SJjn6FuWnHE+Mm84umuh3kvT4Vsy6qqlyQaHXwbynooYajRQ+Fq1CrLCPJg/k8g
         rLYCzASJWH5+5DqaIOFgdm3M38oKM2WDjcd9LfNNX9uwhDmgugw4TWqLCfUegnRBHHvs
         nzL/Rj0+d1fGYeqlrKJN7BQSgB44P/7ckL62fRWC7830mWBTetd9ClMMbdylgLk+pPjl
         nr4BcQ1J1MG+b06VErmm3DgjXkzTqXiKE+jCyccFZHrHZ4MGZSqYajwpidSaTTEZMdVo
         dKzKLQ/FJI8PTJN5k13ow2c6qH5vDmJYx4vGnJ26RiqBEPlzh+bx/2O8QUNgFjjIs44T
         RWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HM/0JZRBItaHHp9OzO6GXNqJ+q6r8b4HR0QehahiN7A=;
        b=eDTfYlqnDXDoK3+08O5IWHZeOMg/l/T8EM5ez0CoX6lVf3qrqCDTNOD3lQazfx6d3K
         c4JS/eCKIarfWrHf4Yjx7vOrnWv+W/sm7wgWXNWKBRL8C8aXbW0ZFU/oV43Upis10uMY
         AXCk1a5jhdsXk4UzmWueqRuq9RVEo04KA3JhTJcFSpH4J012YxVesbtrOFmefPQUo5fS
         pEPI0yLs1KhwFpXCNvfHs6Zpyi6VOAHzaQ5ia10FuIgV+YJt3U6RMkdygDJpRjdEe0GF
         rpbQQK3zCVWwFt0anY7T62dK/bP/t1saKcPW/XpFqF4gchD2C0Iv2sFo33qGrTh+ReIb
         BNig==
X-Gm-Message-State: AOAM531j3zh4A+IuwJKDwvVZkJt0QKHmenOuNHciheZRQwMc6p5PjcNo
        Rw7acYTrApfPcmQLP501huw=
X-Google-Smtp-Source: ABdhPJyxQFqF39KjdVlqGiKukd2pu6+x6uv0gkaOXzotjLgojMiC0UKKi4g3JujX0zs2j3tweyoRxw==
X-Received: by 2002:a05:6808:489:: with SMTP id z9mr1105735oid.155.1613166711474;
        Fri, 12 Feb 2021 13:51:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s127sm1987386oib.33.2021.02.12.13.51.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Feb 2021 13:51:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 Feb 2021 13:51:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] scripts/dtc: Update to upstream version
 v1.6.0-51-g183df9e9c2b9
Message-ID: <20210212215149.GA115630@roeck-us.net>
References: <20210212033120.GA100407@roeck-us.net>
 <CAL_JsqLm3mHdPg4wkdhoFXNY1JgTJ56dxi3oLqBS_NBrX=rOfw@mail.gmail.com>
 <20210212151725.GA57042@roeck-us.net>
 <CAL_Jsq+e+KdzanMdHYCEoGZn3ybY5_ASN60qiqbOkPWpkbQ6NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+e+KdzanMdHYCEoGZn3ybY5_ASN60qiqbOkPWpkbQ6NQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 03:01:08PM -0600, Rob Herring wrote:
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
> 
My memory may defeat me, but if I remember correctly microblaze needs
a hand-built compiler. That is why I didn't update mine.

> There is at least one possible problem here that the FDT may only be 4
> byte aligned. The assumption is 8 bytes to not have misaligned
> accesses (and only for 64-bit accesses if 4 byte aligned). That's an
> issue with the qemu image loading depending on the sizes and
> combination of images loaded. That doesn't explain your failure
> though. As the initrd is a multiple of 8 bytes, you should be fine.
> 
Also, it worked all along up to your patch. If that was a problem,
I should have seen a problem on and off.

Guenter

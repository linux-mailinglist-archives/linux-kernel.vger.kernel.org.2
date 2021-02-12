Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178AA31A18C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhBLPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhBLPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:18:09 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D8C061574;
        Fri, 12 Feb 2021 07:17:29 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id m7so10260176oiw.12;
        Fri, 12 Feb 2021 07:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bxqBljyU1lv6KMVwcygEbOD3flDiFb8A8SwfTqDbxEs=;
        b=rJOQdjsjVSg1egyEytolPUJJ/tO9s9KN5QbiB1p1wWBvRBPlCA1+GykHh9CG90NrRJ
         t3ZHO0nBT39fogDV21qWYhjETF4FWg9i1H4nQ2YX0AqwNQsDJGwFJk1gEOICcg/j48bt
         UadqovFplxAfkDJER25LdyStnoDfQLH0qUrc/eHI0/yGVu09he686hxFb5/HnWUtWy8p
         8iuPuS3Hc26eT4c/DwPxr4qfEkBoikq52xXcH+Mh8uHxlsu8zdcu4AyYy1+U/WDjD1zp
         UHJ0sGNWchb39+zgF7qubrKqb1vBzkVFdueURXSv4dNoz+kAUzTyxTAruB0Bqi9DnxEl
         wMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bxqBljyU1lv6KMVwcygEbOD3flDiFb8A8SwfTqDbxEs=;
        b=tivQHCKJr3qTJrrquBpA6UvagGxtnvg3hDRdcNJdgtZvl5DhI+uNBzZlBfPpCHZw8F
         OLkzkQCEDXxhO1LXMrSd2T8TR2o/lzCdfSbtM/P431UrlV4o6h3ZdNp1pKNkoAFji+sy
         KozBy840FbdTYYsnujqzeFiNlx8K23HtiFof8u795cShoa6urz/4vVkjIxb9NmR5vKOv
         5Sw4SBBkWEet7XTJZD3DAognVTXt/xIrem8RTHAFB9+jd+1fXOSzzaFfNBx0No9e55IM
         mYVZyU5rS0qQAoDmvIsS57EWri2f8sqnxNaTi9KTYKvcSrjaQ49OzepPayeOAkomIfZ2
         WTJg==
X-Gm-Message-State: AOAM531DPEhRtjPCa12UrAriyJ4UWqZvCMhRas2/g0Y7yU3zUqleK8JC
        JzbQlNSORdtY4PBeRNwG/Zw=
X-Google-Smtp-Source: ABdhPJyfaA+6CT1NJjzTTw7LRq5ieI2lXXXBOdqXZJuC6kcLwHIKiV7WbUssOYDfJD/R3h7ToTa1CQ==
X-Received: by 2002:aca:3282:: with SMTP id y124mr2132765oiy.146.1613143048411;
        Fri, 12 Feb 2021 07:17:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w134sm1895494oia.56.2021.02.12.07.17.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Feb 2021 07:17:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 Feb 2021 07:17:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] scripts/dtc: Update to upstream version
 v1.6.0-51-g183df9e9c2b9
Message-ID: <20210212151725.GA57042@roeck-us.net>
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
> Can you give me the qemu command line and kernel cfg?
> 
I copied everything you should need to build a kernel (including toolchain)
to http://server.roeck-us.net/qemu/microblazeel/

[ wow, I really need to update that compiler ]

Guenter

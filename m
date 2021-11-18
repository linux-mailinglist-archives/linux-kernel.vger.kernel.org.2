Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2F456501
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 22:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhKRV0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 16:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhKRV0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:26:53 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5EEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:23:52 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso13261912otf.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UWACXBbqRdeol3CXg5rFjYspFN+GWNxgtVk6AOTQB1Y=;
        b=YQdznxljCTKZuu8S49lt0p3eYl8ryeVW22jLBlQGaQshzaVOw22E/xxGibi9GBUE3W
         rZ9J0lrXplM/5P9PeW4sYiveFTbIQfzCqokBKYXXO9Im6ytnzVfQN5g/2zCrSEVdS1x9
         PqwnmDPtTnzWX+q+AgI4ZKn5jvHGec3AVPgQ6y+zBUbm2RGrwAN3614aXB5v+nHXYNUY
         Fu9gkFRNWPXKKjVjDR5Kz6TS94eo8wIFvN+Ya6c285fJphNiG5TXKIdHN4q38n0hjF3z
         n3Qnll8tmp7qreeaY3XAkvGyoeHYBv3SEXCYtqDZavF+Dc1k9KP9ktZqe/vhuKEpDxUr
         z6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UWACXBbqRdeol3CXg5rFjYspFN+GWNxgtVk6AOTQB1Y=;
        b=tZo+EDjloLYdgujJ0j9UqPRwR+NfRMyrrGeNjafMFpDvHI4NjQjQDDTi4y442+1Zgm
         n4YrnMZ8230zpGaeNMmrRAdeWxzuBF1MYo4JLCxYRpuEW/FWtbQm2fz76fZf31o23hNz
         Tia5QjsPVOg2VVPv2g+iP27D8cqe3p7342fcqspLEbm0eswyCkShcSwn/gRpRdf0SWNP
         lO65qWcLc9o0PTfKx3qfpI3JRqwKDjSHMN0UsVy5XlxqF2/BbiNBr7khIyRCXAp0CMsi
         PyIvt/PsaQVMLwzdBT1ha7LH58WnkNCKC+s3YdWHxrOWmVLqKs6mI/GlRcQesnNDzn8T
         rsWw==
X-Gm-Message-State: AOAM531u7LHRd1TjB6S9H4hQmoSgqDdNl9WraUWUbUEZDiclMfdqEdcd
        Q9B+xAm3GJYfTcfcKGp+dRs=
X-Google-Smtp-Source: ABdhPJwWg8Wje8poBr0MOTXBSHqruwMlvAW14Sn2MrWZ6wd3sgB7FUm+A5CA3Jyg09GoFZu779Ue2A==
X-Received: by 2002:a05:6830:3113:: with SMTP id b19mr284327ots.9.1637270631904;
        Thu, 18 Nov 2021 13:23:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e28sm227315oiy.10.2021.11.18.13.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 13:23:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Nov 2021 13:23:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: Linux 5.16-rc1
Message-ID: <20211118212349.GA3424901@roeck-us.net>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
 <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
 <87a6i4miwu.fsf@mpe.ellerman.id.au>
 <CAMuHMdVrpQJKKzpxrKKCCD_2+DzAvgFW+jsjPdR9JhBYeRgvNw@mail.gmail.com>
 <8D79B547-D606-4975-A79A-AEA65684F3A0@tuxera.com>
 <CAHk-=wgvzH=BaFg+kiWk1DXGLNELSmPS2VWcgSSmW5Y6vz-v_A@mail.gmail.com>
 <E1EED1BE-A0F0-4EFA-86A6-CF721E194CDC@tuxera.com>
 <CAHk-=wjoQYuOfhsiPXUvFbUbSd5iHmmoRHMP+zv+bzHKkWqAyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoQYuOfhsiPXUvFbUbSd5iHmmoRHMP+zv+bzHKkWqAyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 05:54:06PM -0800, Linus Torvalds wrote:
> On Wed, Nov 17, 2021 at 5:26 PM Anton Altaparmakov <anton@tuxera.com> wrote:
> >
> > So is it worth doing the singly linked list to fix one file only to have compilation fail a few files later when it gets to mft.c?
> 
> Heh.
> 
> That does sound dubious.
> 
> Honestly, maybe the solution here is to just make the Kconfig depend
> on the page size not being excessive for what NTFS wants to do.
> 
> Because I'm not sure that "powerpc with 64kB pages" is all that
> relevant for NTFS to begin with.
> 
> The main problem is that the page size thing isn't some generic
> Kconfig entry, different architectures have different names for it. On
> PPC, the confic name is PPC_*K_PAGES and PPC_PAGE_SHIFT.
> 
> And arm64 has something very similar.
> 
> We have other things that do that, ie KASAN support has
> 
>         select HAVE_ARCH_KASAN  if PPC32 && PPC_PAGE_SHIFT <= 14
> 
> (and something very similar for arm64).
> 
> But those KASAN dependencies are inside the core architecture Kconfig
> files, so it can fairly naturally use that page size config variable
> as a conditional.
> 
> For something like NTFS, we don't really have a generic Kconfig
> variable to test.
> 
> It wouldn't be _hard_ to add, but it would have to be done somewhat
> sensibly and preferably in a way that doesn't require every
> architecture to change how their page size selection (or lack of
> selection) is done.
> 
> The simplest thing would probably be to add something like
>      config BIG_PAGES
>           bool
> 
> to some generic file, and then add
> 
>         select BIG_PAGES
> 
> to PPC and arm64 for the 64kB+ page size, and add a
> 
>         depends on !BIG_PAGES
> 
> to the NTFS Kconfig entry.
> 
> But that honestly looks a bit hacky to me. It would be less hacky to
> just add a PAGE_SIZE config variable, and have architectures just set
> it, and then NTFS could do
> 
>         depends on PAGE_SIZE < 65536
> 
> or whatever. I just don't know if it's worth it if this is only for NTFS.
> 

Like this ?

Guenter

---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dea74d7717c0..fd3fb2ab2350 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -767,6 +767,16 @@ config PPC_PAGE_SHIFT
        default 14 if PPC_16K_PAGES
        default 12

+config HAVE_PAGE_SIZE
+       def_bool y
+
+config PAGE_SIZE
+       int
+       default 262144 if PPC_256K_PAGES
+       default 65536 if PPC_64K_PAGES
+       default 16384 if PPC_16K_PAGES
+       default 4096
+
 config THREAD_SHIFT
        int "Thread shift" if EXPERT
        range 13 15
diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
index 1667a7e590d8..912361014bb0 100644
--- a/fs/ntfs/Kconfig
+++ b/fs/ntfs/Kconfig
@@ -1,6 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config NTFS_PAGE_SIZE_LIMIT
+       int
+       default 262144 if FRAME_WARN >= 8192
+       default 131072 if FRAME_WARN >= 4096
+       default 65536 if FRAME_WARN >= 2048
+       default 32768 if FRAME_WARN >= 1024
+       default 16384
+
 config NTFS_FS
        tristate "NTFS file system support"
+       depends on !WERROR || !HAVE_PAGE_SIZE || PAGE_SIZE < NTFS_PAGE_SIZE_LIMIT
        select NLS
        help
          NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.


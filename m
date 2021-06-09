Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7903A20F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFIXph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhFIXpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:45:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFBFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 16:43:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ei4so2539471pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESHKnVXx5Fc5j9UWmfTTcVzj6Cu69fm40TTKCmKlzpM=;
        b=OtYaidF+O9MMt70ZAz6pFlK09xZYupLT7DvfGtGNa5Se3Qi8X456lVXdzwAZEqFjbk
         CFrg1kP4gMfI+ENj/P/rfeD5EWc7IruzAAEO9PNMYkQiXQSC/dUNyUSjHRnkuTeOlOwr
         70ukuDg29EHjWH807yFaifQIVfjWy0nroOsDSqXWAT12vNzK6Nhsc85l79In/Qz+9WRT
         iHFkkAgMZV65BsSXg6kqcSMJhVNt3frVX6gjnXIa+lpMDkFkY/1WHfgepWsJIdtQ1mh+
         1tz6977hMpSe9xPPGoY/kMs2xZJmzYja7qPuOiUFXMom43t22ZlweCy2tB6Y+bEeL6T9
         q3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESHKnVXx5Fc5j9UWmfTTcVzj6Cu69fm40TTKCmKlzpM=;
        b=PwZtCLafGaoAKclKsYwVAFY6WmFVl5vluac61SSjoUndm3IL7BN8hQ/cWODId5W/26
         tR5AURjs1i+HM2yphsJPHQw0v5eMxtUeIVCgemv/yuCDwUL4PJB1q7rCbTEjgvAH/SFO
         C59nQ7dqOkHztEfz4GBTpm0Af3SBXCPI5UsM8JTvuvz7N6cA11c5+gHqJH4pYwAQ00u4
         HjQatKqJdgiGjPZAuxsnH1m0Yb3qlwhr9wvEMkORsYSkmiTouYsjcnZVg4OOBEAFhlu7
         FxhW+D3g+1bg9Q0E7ySqzpPxYvn3dAJ7hiDCv9CTQvKLoKzYg33DqjQqrb+vaHLmuuU/
         uICw==
X-Gm-Message-State: AOAM532BVZg3K2SbnQkgZRXrAds0bXJZ+Ry+XEJNyR1iJ8xTfZTqqpGB
        jhtde1Skj8KE/NjCWE0DPHoqFxEQktBzwrvaGcx8eQ==
X-Google-Smtp-Source: ABdhPJyd3FYBCnl1naLD06YZvrUztcNeChR/hMgm20O2U8My75tfp0XU00pq1d3KC4EAkhOqlZj6x/F+UwHH9gTIsV4=
X-Received: by 2002:a17:902:b497:b029:115:e287:7b55 with SMTP id
 y23-20020a170902b497b0290115e2877b55mr2151695plr.79.1623282216835; Wed, 09
 Jun 2021 16:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <202106100613.JQBEtsqj-lkp@intel.com>
In-Reply-To: <202106100613.JQBEtsqj-lkp@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Jun 2021 16:43:25 -0700
Message-ID: <CAPcyv4jAkutNExqao0Q1HYL-pQxrSbAN3F5N9Uj=09KDa_uynw@mail.gmail.com>
Subject: Re: arch/x86/lib/copy_mc.c:30:1: warning: no previous prototype for 'copy_mc_fragile_handle_tail'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 3:43 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Dan,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   368094df48e680fa51cedb68537408cfa64b788e
> commit: ec6347bb43395cb92126788a1a5b25302543f815 x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user, kernel}()
> date:   8 months ago
> config: x86_64-randconfig-r025-20210610 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ec6347bb43395cb92126788a1a5b25302543f815
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ec6347bb43395cb92126788a1a5b25302543f815
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/x86/lib/copy_mc.c:30:1: warning: no previous prototype for 'copy_mc_fragile_handle_tail' [-Wmissing-prototypes]
>       30 | copy_mc_fragile_handle_tail(char *to, char *from, unsigned len)
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~

This routine is only ever called from ASM code, so the fact that there
is no C declaration is expected.

For W=1 builds we could do something like this:

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index bad4dee4f0e4..b87f40cbc3d5 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
 lib-y := delay.o misc.o cmdline.o cpu.o
 lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
 lib-y += memcpy_$(BITS).o
+CFLAGS_copy_mc.o = -Wno-strict-prototypes
 lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc.o copy_mc_64.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o

...but I don't like it nor adding a dummy declaration.

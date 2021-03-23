Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F248346264
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhCWPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhCWPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:08:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2854C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:08:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so10255891pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/0oH/sIKlTyqEM5+DPElcup5AqdVgWb/d4FeBXrA9I=;
        b=JlfWnvhobqb7KPsB/eBSI1EH5lQE72OmGcgIdhcPCBB9eoTihO0Ax7ELCPIir4EsyQ
         x77KBOsN2HZ+al4080A85kYu7oOQCJLkDlZx6Iu5Blt96wS3mPXZVUI/HzU4mZjTI5tW
         5K1dbve4ICbWxhL/FF6s180ciZxxpFnRDcrb+tsdUDvhrywT/jK7IXZ923YzlwqflJJu
         OafLvYKnWp0bBdiVPkeMvbtKwPQdcXdOpcgpxJJg0IRdZ5/K9uImnoDsF+LWl3wq/4B1
         f0y3isYxpBBgG1pG2XBrVdnw8Zhm1zReC766Xy1Aqr64BOHrPqS4zyMZxuKl+DvItOue
         p5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/0oH/sIKlTyqEM5+DPElcup5AqdVgWb/d4FeBXrA9I=;
        b=IoPKU+IPjPWgBGYNihReYr1RMvCV1fIP9gAGGAvBdE2L0yZ4/+ob/DCbczQYT/83fW
         /U0+1h98T4lJuPp9sBxZ8Z0PW5+xIC4eWEjHlB2HWF5eGYde6GkJEQKWl7K2ZwupuA2d
         cL8cQVvboYNhK6gup7R3GrzQ89VgvHdxlvm3Mlc/E5x6id3HCAbm5wkgC7LYjllczcnc
         nTSx3Gv7Dj8cCTYjU+Xxru+Cx69qL/iXXVp8SyexZDJL68YXUgFIv+JzS4rB2h4hvP4d
         E9fgWRMcDAqK9rEesAFA0x4xpiR4PaD5I/77nVO7jhwp4WqKdREkMkMpuMKZJ4le68fs
         UohQ==
X-Gm-Message-State: AOAM530gJ3wM0BF//omvAcekUApshUuWTpzVw/JYqNV35poENAX62C8I
        BxmPSaCeiPlVBDxNTTp3x5Xjp4qVBb4uJ+Hnh0NhrA==
X-Google-Smtp-Source: ABdhPJzzFj67sX3T9XBpNK435A3EOIEqiti1D/vHK8dMXR8/msBwTres5AuDllnhMAZy3aYgHXgps+wIovevf/pyvrg=
X-Received: by 2002:a17:90a:8c08:: with SMTP id a8mr5052138pjo.136.1616512097128;
 Tue, 23 Mar 2021 08:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210315132019.33202-1-vincenzo.frascino@arm.com> <20210318185607.GD10758@arm.com>
In-Reply-To: <20210318185607.GD10758@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 23 Mar 2021 16:08:05 +0100
Message-ID: <CAAeHK+w+pHtKNwxz5Scdp9_48jmSLfeBqBGqKQT+-aFO486GzA@mail.gmail.com>
Subject: Re: [PATCH v16 0/9] arm64: ARMv8.5-A: MTE: Add async mode support
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 7:56 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Mar 15, 2021 at 01:20:10PM +0000, Vincenzo Frascino wrote:
> > This patchset implements the asynchronous mode support for ARMv8.5-A
> > Memory Tagging Extension (MTE), which is a debugging feature that allows
> > to detect with the help of the architecture the C and C++ programmatic
> > memory errors like buffer overflow, use-after-free, use-after-return, etc.
> >
> > MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> > (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> > subset of its address space that is multiple of a 16 bytes granule. MTE
> > is based on a lock-key mechanism where the lock is the tag associated to
> > the physical memory and the key is the tag associated to the virtual
> > address.
> > When MTE is enabled and tags are set for ranges of address space of a task,
> > the PE will compare the tag related to the physical memory with the tag
> > related to the virtual address (tag check operation). Access to the memory
> > is granted only if the two tags match. In case of mismatch the PE will raise
> > an exception.
> >
> > The exception can be handled synchronously or asynchronously. When the
> > asynchronous mode is enabled:
> >   - Upon fault the PE updates the TFSR_EL1 register.
> >   - The kernel detects the change during one of the following:
> >     - Context switching
> >     - Return to user/EL0
> >     - Kernel entry from EL1
> >     - Kernel exit to EL1
> >   - If the register has been updated by the PE the kernel clears it and
> >     reports the error.
> >
> > The series is based on linux-next/akpm.
>
> Andrew, could you please pick these patches up via the mm tree? They
> depend on kasan patches already queued.

Hi Andrew,

Looks like these patches have reached a stable state.

Could you please pick them up into mm targeting 5.13?

Thanks!

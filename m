Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA54340DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhCRTDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhCRTDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:03:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2986AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:03:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id dm8so8037251edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTZLK6beX9SkhbU18uwJiCTDV/7tO8mXN2d8l/pVAAY=;
        b=Bh4S37QfVMWXvsThtCgSnmi3OBmkiY5UopBSkTHwy00KuhvcHxAdIIW8KfKheWcghv
         RjbNGuhHHq0p+U/tdENs2L9NIs2LAXGFi6pmW36MOOCkgEqIsKOtSsgAAsavuM9ahEfo
         RCmZNjOWbkQKI0oTOgL8FJeSBU95TUclRgNNGjntexISmzyFT2Vd1rwpPdeFqgHjsSkJ
         QPdKlyvX4ZZa0rpdUERwgJifYRW/ECgDVgu6qzrweYcyRJ3e4V0lwxH0dLxVj/Od6Ntw
         UvMkHYXhexdzQlr24DDE/M5f1TMF5CCwIJQSS+IB1YpJl9fKJY9z8WIP0k3/vyopxc98
         Na4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTZLK6beX9SkhbU18uwJiCTDV/7tO8mXN2d8l/pVAAY=;
        b=CW5ENOFx3ufrLnK4HIHOZmkUT849Fx8By0Q1jnvq1K4a8CYfrSfg6x2s42cNfXCidK
         hZL6jHc5YWN/fBWPEmGwOOHwPEAllfAYiRW6enNjAAvGINt0ob1p0iwuMuovyDO6sOSP
         8sU1qGb4uvzZiN5mBBxi2dm3JqwEI/DRNEb0fLer+DRW34u/ChESn3GyVLKGSj0xOga6
         kyU8XwEIe1sO5YB0IC6P6h5YxTue4hkh4o40U9XhjDJTB0c656fxxiPJS4KlNbjFAFFl
         z9LCRb01Vy96uSzUmEg7eO66z4BnjJo5RGeVfN/EsgHfIiymwNH8uSXHx7i443AbfxC1
         UmUw==
X-Gm-Message-State: AOAM532sS/8RsYaQDBUcistPxpvtPc/YR9Nh3FUB641no0UedBI/jO1b
        yjr0foWjpEeOho2DYEuYHi4qsxdecdYo6LWyJw8=
X-Google-Smtp-Source: ABdhPJxVHl8myJsBAFFoqcM2phIkEhbQjE7wdoAvxyXsIMhpSdSWRQBAG/N/HRokDzbYYikNMWgSYzlYYv5zjou2nD0=
X-Received: by 2002:aa7:dbd3:: with SMTP id v19mr5437548edt.314.1616094192925;
 Thu, 18 Mar 2021 12:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210315132019.33202-1-vincenzo.frascino@arm.com> <20210318185607.GD10758@arm.com>
In-Reply-To: <20210318185607.GD10758@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 18 Mar 2021 20:03:02 +0100
Message-ID: <CA+fCnZc9ayxT_u3qJmB1MV0Wi93=8tNYxWFbZK52vK4S21U2qA@mail.gmail.com>
Subject: Re: [PATCH v16 0/9] arm64: ARMv8.5-A: MTE: Add async mode support
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
>
> Andrey, all the kasan patches have your acked-by with the google.com
> address and you've been cc'ed on that. You may want to update the
> .mailmap file in the kernel.

Good point. I was wondering if there's something like that for email
changes. Will send a patch.

Thank you, Catalin.

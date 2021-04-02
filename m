Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E4A352781
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhDBIlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:41:14 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869BC061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 01:41:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 7so4732643qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Oq6IecKAdRhb0vISLYp5X5UHBzYjzxfpkAIMVbe92U=;
        b=Fjps3LQD0JVSTFEjcIJsN/pB1IYiA7TeDmRcqH6s+eEYlwyNlSHz9uRMvQ2GLPPIiC
         l/wX05Tqh0BIrKwfFyba/hVXWtCj6dqOAdWNkCW/Jsbpo6vHVBn1fJVPSLf7SaVBhAyL
         mEKzmhe7TOP82udk5b4ri0mtvsNWubfjW6dKKg0367P4w0zSCHl+Y7M7DVaMWLfzkY/a
         PM6O9aMLLhWenH7pWtIX/J6ZWhqxcGqLP3nJB4sugvZ0wJvBVrghMZkCaxRE2nENLKJM
         w3yaZNMpHhvuDvxcikMZe78A61aD4BVCBJrQX6X7ZjdEJ2MOANUTykWjSoo68oJX8wzP
         7WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Oq6IecKAdRhb0vISLYp5X5UHBzYjzxfpkAIMVbe92U=;
        b=h3e5hYgaXI1KSw8UYtXKRa4TZ6HLxHufux7wmsUhGCqb35frIrbvy0vi14bF86GapA
         R4LoMmzq/MHwvp8WFmEWvFbCDLo4v2ySG3MdghuRBBeuW8j8RTAbY1eXmDtkut2ApIFK
         aFdvhkHVOgx44dXf6aPBbYjDz5AS72NSbqXZlY3Bj9SgEuEOKxmeV+G+Ek3+XT8In6H4
         S9ANNJUkjgXl9zVgKjJi5ts0W/MF+cNaHl9xYGVvvyrmHLoP4X9douN795AsjGJYPnQd
         UfLgKB//hOH9QprKiAZbAIt4StEFkafPG4OZbw1eTYct6yExS/uAvzQKU4ldMt/PqpSk
         7Udg==
X-Gm-Message-State: AOAM530F4qqtGSV2rFW1efWAbT82o7SiVsm5P7S+WN7dU8JGY3ucJmdH
        AAeAuYlG2LRTFlBAcqA6DezIjejaxgWonfZCtSsLDQ==
X-Google-Smtp-Source: ABdhPJwrAo1Q5aKgc8eUtKDaWI3azIH3Umeg+GTujtQJ7/TfRZUOok4RQrD42IYHB25KLC6DFD2BGY/v4Dape3KfFt4=
X-Received: by 2002:a37:a7cb:: with SMTP id q194mr12418288qke.350.1617352870441;
 Fri, 02 Apr 2021 01:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2103302221590.18977@angie.orcam.me.uk> <mhng-08e5e4fb-8a42-4f7b-8ceb-ff549784100e@palmerdabbelt-glaptop>
In-Reply-To: <mhng-08e5e4fb-8a42-4f7b-8ceb-ff549784100e@palmerdabbelt-glaptop>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 2 Apr 2021 10:40:58 +0200
Message-ID: <CACT4Y+Z0PaAuUFrOBenztWkw8OV=J-qaeD1FASPM4ufcLg5a5A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     macro@orcam.me.uk, Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 6:37 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 30 Mar 2021 13:31:45 PDT (-0700), macro@orcam.me.uk wrote:
> > On Mon, 29 Mar 2021, Palmer Dabbelt wrote:
> >
> >> > --- /dev/null
> >> > +++ b/arch/riscv/include/uapi/asm/setup.h
> >> > @@ -0,0 +1,8 @@
> >> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> >> > +
> >> > +#ifndef _UAPI_ASM_RISCV_SETUP_H
> >> > +#define _UAPI_ASM_RISCV_SETUP_H
> >> > +
> >> > +#define COMMAND_LINE_SIZE 1024
> >> > +
> >> > +#endif /* _UAPI_ASM_RISCV_SETUP_H */
> >>
> >> I put this on fixes, but it seemes like this should really be a Kconfig
> >> enttry.  Either way, ours was quite a bit smaller than most architectures and
> >> it's great that syzbot has started to find bugs, so I'd rather get this in
> >> sooner.
> >
> >  This macro is exported as a part of the user API so it must not depend on
> > Kconfig.  Also changing it (rather than say adding COMMAND_LINE_SIZE_V2 or
> > switching to an entirely new data object that has its dimension set in a
> > different way) requires careful evaluation as external binaries have and
> > will have the value it expands to compiled in, so it's a part of the ABI
> > too.
>
> Thanks, I didn't realize this was part of the user BI.  In that case we
> really can't chage it, so we'll have to sort out some other way do fix
> whatever is going on.
>
> I've dropped this from fixes.

Does increasing COMMAND_LINE_SIZE break user-space binaries? I would
expect it to work the same way as adding new enum values, or adding
fields at the end of versioned structs, etc.
I would assume the old bootloaders/etc will only support up to the
old, smaller max command line size, while the kernel will support
larger command line size, which is fine.
However, if something copies /proc/cmdline into a fixed-size buffer
and expects that to work, that will break... that's quite unfortunate
user-space code... is it what we afraid of?

Alternatively, could expose the same COMMAND_LINE_SIZE, but internally
support a larger command line?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DED3C270B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhGIPsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhGIPs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 11:48:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9FBC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 08:45:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so6283888pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xr/oo6QaKEF3yyBzroogqbeO+TEDdTjBQ/ohjUC5aco=;
        b=gNm9KR7Nl8b9kI9wKWmASc8pm+nB7atspkpJFn7eECRe/lnLCs4xSNPxz58yuIa1OK
         R/vZghjGU4MRZtmnPjYdWXKqguGp+KH3Zx9PvkHubZupsYJxxK1hWxywGPCbQsyJwaM3
         xkym/IhEZz/64BDNO0BDoiNpBDquYRtarrFQ2VI4LLDwhpkzZEtrMRK2JurOaADNG+o0
         KBm+6blpXBJT8pwmAbekJEnr0U7c1mFvv7whPja26P2EJLmbsX3mCvBkFN7JR71p6Jw7
         oaazMaMkY6Rw8uENKdeQBZ6MRuK+UHBaKg7tPQ8qGcLTrc/rmn2ropvAlqS6Al6OeEmk
         n1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xr/oo6QaKEF3yyBzroogqbeO+TEDdTjBQ/ohjUC5aco=;
        b=I1K1Cu1wBYPwwgOEAnsB5BNjmjrcmXrwkxm+cU116VhnTNdn3W5G8qNqevYaCZflDI
         5NYwF/jZlcLDJl4DVTRGpBkA4ihFrxiiHZuMctbMazx4GOlA5pp23BRpFH4jvEFGExdY
         dgYbomlB47tsDl1yDV2fMXSjnFCPX1P1o1+mYgWATHZQJkIKOi4pGJkhRiK47FHI+h7e
         cZJAScMtVfTHZ0ZJaMJgV4Z2LB6H4714R7fhiI2lyhiHUdDrluxxFCb302VmQX7dS94Z
         JXW2WaPNoRxYLX9E7av4iS0BCpauasxwOzo8TK2iM4XXPh9aWMiVZDQnLFz319ieuuTp
         M7gQ==
X-Gm-Message-State: AOAM531fwYm9cqUjIzaUh9H8GZhYNUyy/y4yoFdeXZ0HP4bg3PcD4ioc
        8s9QiOpsp0MUXdKB8CKCERiLcAyICE5u28INUECSXLvaWBjudA==
X-Google-Smtp-Source: ABdhPJzNrUv4fPbngocprXlQfxtuH19GJRjFf7mXutAxJzFikk7L3/9XR5BkuWb3UkVh+I09qpS91rNkXCt+nPshsFc=
X-Received: by 2002:a17:90b:3647:: with SMTP id nh7mr4697326pjb.228.1625845545524;
 Fri, 09 Jul 2021 08:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfKyqy+vM0XkP9Yb+znGOTVT4zYCRY3A3nQ7C3WNUVN0g@mail.gmail.com>
 <CAHp75VfUHPqccrxe81=jYmiskgWcgTpf3jBjXsPiFpox+Xuyyw@mail.gmail.com>
In-Reply-To: <CAHp75VfUHPqccrxe81=jYmiskgWcgTpf3jBjXsPiFpox+Xuyyw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Jul 2021 18:45:06 +0300
Message-ID: <CAHp75VcmiEuJ7ZfrUeV0ty=qpLEJwsHQa-DwpmyWYyf_OMwQWQ@mail.gmail.com>
Subject: Re: parallel panel display stopped working
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 5:54 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jul 9, 2021 at 5:40 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > Parallel (4 bits)  panel display stopped working.
> > I have no time right now to bisect but I have noticed there was quite
> > a pile of patches from Lars to the driver recently (yeah, it seems for
> > a few months I haven't run my tests against the AUX display driver).
> >
> > I believe the issue is there somewhere.
> >
> > Moreover on the removal I have got an oops
> >
> > [  218.825445] kernel tried to execute NX-protected page - exploit
> > attempt? (uid: 0)
> > [  218.832965] BUG: unable to handle page fault for address: ffff8f8f06559dc0
> > [  218.839863] #PF: supervisor instruction fetch in kernel mode
> > [  218.845540] #PF: error_code(0x0011) - permissions violation
> > [  218.851132] PGD e601067 P4D e601067 PUD e602067 PMD 645a063 PTE
> > 8000000006559063
> > [  218.858587] Oops: 0011 [#1] SMP PTI
> > [  218.862099] CPU: 0 PID: 7 Comm: kworker/u4:0 Tainted: G         C
> >      5.13.0+ #23
> > [  218.869870] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
> > BIOS 542 2015.01.21:18.19.48
> > [  218.878681] Workqueue: kacpi_hotplug acpi_device_del_work_fn
> > [  218.884380] RIP: 0010:0xffff8f8f06559dc0
> > [  218.888328] Code: ff ff d2 2b 21 8c ff ff ff ff 08 00 00 00 00 00
> > 00 00 78 34 fa 02 8f 8f ff ff 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 <72> 65 67 75 6c 61 74 6f 72 3a 72 65
> > 67 75 6c 61 74 6f 72 2e 30 2d
> > [  218.907138] RSP: 0000:ffffad36c0043c90 EFLAGS: 00010246
> > [  218.912387] RAX: ffff8f8f06559dc0 RBX: ffff8f8f062cbc00 RCX: ffff8f8f01239fc8
> > [  218.919542] RDX: 000000002a3cccf8 RSI: 0000000000000001 RDI: ffff8f8f06559480
> > [  218.926701] RBP: ffffffffc037e279 R08: 00000000d5832520 R09: 0000000000000001
> > [  218.933856] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8f8f062cbc00
> > [  218.941010] R13: ffffffffc038e028 R14: ffffffff8c5e0b60 R15: 00000000fffffffd
> > [  218.948166] FS:  0000000000000000(0000) GS:ffff8f8f3e200000(0000)
> > knlGS:0000000000000000
> > [  218.956286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  218.962053] CR2: ffff8f8f06559dc0 CR3: 0000000002ef4000 CR4: 00000000001006f0
> > [  218.969208] Call Trace:
> > [  218.971678]  ? hd44780_common_clear_display+0x17/0x30 [hd44780_common]
> > [  218.978252]  ? charlcd_write_char+0x21a/0x810 [charlcd]
> > [  218.983519]  ? charlcd_puts+0x30/0x60 [charlcd]
> > [  218.988083]  ? charlcd_unregister+0x24/0x70 [charlcd]
> > [  218.993167]  ? hd44780_remove+0x1e/0x30 [hd44780]
> > [  218.997901]  ? platform_remove+0x1f/0x40
> > ...
> >
> > Just for your information and with hope that somebody may test and/or
> > reproduce this and fix it. Later on I might find time to bisect the
> > other issue I mentioned above.
>
> For time being confirmed the following:
> 1. a2060f288e15 ("auxdisplay: Call charlcd_backlight in place") has a
> remove bug (above), while panel works
> 2. 66ce7d5c1e12 ("auxdisplay: Use an enum for charlcd backlight on/off
> ops") everything works as expected
>
> So, the oops introduced in between those two.

The culprit (*) is 01ec46dfa633 ("auxdisplay: Move init_display to
hd44780_common").

*) Obviously it's not. It reveals the design issue on how the modules
were split. How this had been tested if tested at all?

P.S. If we don't get a fix in time, I will ask Miguel to revert the entire pile.

-- 
With Best Regards,
Andy Shevchenko

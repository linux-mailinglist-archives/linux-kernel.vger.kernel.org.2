Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1523C261F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhGIOnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGIOnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:43:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E1DC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 07:40:47 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v7so10178485pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iNaMv+HNHxIxr6Dyhl2gmTLQROfPovPZ0MJThVct2O0=;
        b=qmLi9zCwaPUjbBbGnhZgKmeBJTxLBLZ6BTSEi8+a4ljUcrq0i8meVkJgQta7oC7YwT
         +JVIzYPwtvQS3ov6vJuYUeeAp59mCrSyjcxsE+hUGMoMf0LqQY3QK5988AYPZqr0LGcP
         nYgrllSMDxV0sOZV4+cZXkqcSTOlDLoDMZL6cG2Hhzg+IQFlCw4KaTD4Y79hc8dsq/yZ
         3WM8m218m/tj7pAKMTz3z+qfmsaPAWxF8kawj2V390+Y5kHvQiytMyEKKYKRNhg0bTIt
         zfVaTqpH8INk+ywpnzznBTg4l0f1Nwzhw5GBtxKumm8h98dU0oGWvNZkqq5Q6Jd5n6c9
         ES3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iNaMv+HNHxIxr6Dyhl2gmTLQROfPovPZ0MJThVct2O0=;
        b=G1KpXCxrxL/1TRWDxTjXmCcNBjweGLUSnH4Qr0IDYygNjttZMa36oU9DhRhyJVGqfc
         z4r3+eq4AJTSzQgsKDtDEF1Ffox153sYgTyX2N7y08vN639Zs38iCKhhPPZWY3WR04Uy
         je7gt5iXTwKSuxN/ORUUAgnKtpR6ae/+IXMo/kRSgFkKpcd/ttIKP0uRcz7bnPWwEEiK
         +FZnZul9a8tMAMLi5IsBfskBB5fyDNAv9uXpscBTH1yeSiO8qZ3M4CY/cE/CZi+4+I8E
         KppjnBwYLMXggJhh+KuISANuGGZSvOo7E29SnLM+T7EpDeHGWNuj3jjAPTBCu9rzGK9O
         pOfw==
X-Gm-Message-State: AOAM532YXp8LfyE0HmoeX9GsFlIZrwlCjh6UaD18GdBPnVIEGOvrLQEk
        VCglLDvALMkdh6ntd6qEVD0yeIJMH/GqqTtLol5+gh1d5vzRJw==
X-Google-Smtp-Source: ABdhPJygDpsoyQwVjnWLuYpsPKjX1pqTQZ+XWaZqC7x+egvVQ4Bhrz9QhuMde3MHw4g04dpnvnqqPXYb9JYJSK/BNUg=
X-Received: by 2002:a63:f609:: with SMTP id m9mr38810445pgh.74.1625841646733;
 Fri, 09 Jul 2021 07:40:46 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Jul 2021 17:40:08 +0300
Message-ID: <CAHp75VfKyqy+vM0XkP9Yb+znGOTVT4zYCRY3A3nQ7C3WNUVN0g@mail.gmail.com>
Subject: parallel panel display stopped working
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parallel (4 bits)  panel display stopped working.
I have no time right now to bisect but I have noticed there was quite
a pile of patches from Lars to the driver recently (yeah, it seems for
a few months I haven't run my tests against the AUX display driver).

I believe the issue is there somewhere.

Moreover on the removal I have got an oops

[  218.825445] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
[  218.832965] BUG: unable to handle page fault for address: ffff8f8f06559dc0
[  218.839863] #PF: supervisor instruction fetch in kernel mode
[  218.845540] #PF: error_code(0x0011) - permissions violation
[  218.851132] PGD e601067 P4D e601067 PUD e602067 PMD 645a063 PTE
8000000006559063
[  218.858587] Oops: 0011 [#1] SMP PTI
[  218.862099] CPU: 0 PID: 7 Comm: kworker/u4:0 Tainted: G         C
     5.13.0+ #23
[  218.869870] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
BIOS 542 2015.01.21:18.19.48
[  218.878681] Workqueue: kacpi_hotplug acpi_device_del_work_fn
[  218.884380] RIP: 0010:0xffff8f8f06559dc0
[  218.888328] Code: ff ff d2 2b 21 8c ff ff ff ff 08 00 00 00 00 00
00 00 78 34 fa 02 8f 8f ff ff 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 <72> 65 67 75 6c 61 74 6f 72 3a 72 65
67 75 6c 61 74 6f 72 2e 30 2d
[  218.907138] RSP: 0000:ffffad36c0043c90 EFLAGS: 00010246
[  218.912387] RAX: ffff8f8f06559dc0 RBX: ffff8f8f062cbc00 RCX: ffff8f8f01239fc8
[  218.919542] RDX: 000000002a3cccf8 RSI: 0000000000000001 RDI: ffff8f8f06559480
[  218.926701] RBP: ffffffffc037e279 R08: 00000000d5832520 R09: 0000000000000001
[  218.933856] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8f8f062cbc00
[  218.941010] R13: ffffffffc038e028 R14: ffffffff8c5e0b60 R15: 00000000fffffffd
[  218.948166] FS:  0000000000000000(0000) GS:ffff8f8f3e200000(0000)
knlGS:0000000000000000
[  218.956286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  218.962053] CR2: ffff8f8f06559dc0 CR3: 0000000002ef4000 CR4: 00000000001006f0
[  218.969208] Call Trace:
[  218.971678]  ? hd44780_common_clear_display+0x17/0x30 [hd44780_common]
[  218.978252]  ? charlcd_write_char+0x21a/0x810 [charlcd]
[  218.983519]  ? charlcd_puts+0x30/0x60 [charlcd]
[  218.988083]  ? charlcd_unregister+0x24/0x70 [charlcd]
[  218.993167]  ? hd44780_remove+0x1e/0x30 [hd44780]
[  218.997901]  ? platform_remove+0x1f/0x40
...

Just for your information and with hope that somebody may test and/or
reproduce this and fix it. Later on I might find time to bisect the
other issue I mentioned above.

-- 
With Best Regards,
Andy Shevchenko

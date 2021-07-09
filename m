Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667C63C265B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhGIO6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhGIO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:58:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BE4C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 07:55:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso6196982pjp.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2Y+pSSnUywEPTSJ2tPWcTaOWBhrih5Xt4GSOmadcn8=;
        b=Ppt37Ib0qBxgOpUgzY7k88JVJaGwS/q/5GtHxj0FMBLd36ZPWtuM3qaX7v/v7cS+oq
         q/oD0ADy2AXyu8QorB902T2rTH2n64p5zczs7oi1JKjKar2ulIAaAAn9oXgMhqFJnrrq
         KMIXSN86XmDDUhFLIQjT88iBKQIPyJAJHqywRG92zvibzvOAmDo3A0WIPlgTb3RA8cuH
         apsheeT44wjZnzZJ93xSKEc7xhjpN1Q3yhUr2rnuY74fQlNgn9I79sP9TgDTgTrLHvS1
         ywGU3iJTV6S9ZMF+V1s+kbGF9o+HCSUesWZ81npXlqB4ihvj2xS9JxaWbobQFSUyET+M
         cn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2Y+pSSnUywEPTSJ2tPWcTaOWBhrih5Xt4GSOmadcn8=;
        b=nG0oORp6rDqfB5Jd28N0/+16GnHNqQXamkJsQ6FwIb43Tg2XSFY8DJ1g2lo/U1GWo1
         xGvgpFPjciekQAD5S33SqHfYnnuLpVpxCkNAlpd9R02p2lobmgH7UYQPVgh2vimcYj4G
         FzvYIhrNqbsEkJP85/Bl7EZ5/FCa9/qKX0GHWakttlB2Xp99E2JT7HNgCHTXr6YsZssV
         HHgFSuWjoPPDx7U8YHdIji+GkpYrnVlh3GRYE3zkawZxjVtRfAw2Y57+esyohWuBlQZT
         R5QpUCHDlVP0Frn79CYAWNPs8S86rRUDcXnHDTpnpPncxvTSkjKJi4qv/hoc3dz08kry
         dvXg==
X-Gm-Message-State: AOAM5319eTKjOctK8zQaRkox4M8DfQ+e2rro62+UcRB94d1dWFERKJTA
        ls8RjQyyyuQx7XzxSwdVjsUZvFJ0y8+eMKjGTJGVowiXRrpViA==
X-Google-Smtp-Source: ABdhPJzNwyX2+lS/K58nQAPnD/YBQvC2WrKAoUz1I6RR3DURC6lzpEpzkCzPhNKLw1P+2uj3WCOWhfRoRbUOUpLRbgs=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr11501998pja.181.1625842524730;
 Fri, 09 Jul 2021 07:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfKyqy+vM0XkP9Yb+znGOTVT4zYCRY3A3nQ7C3WNUVN0g@mail.gmail.com>
In-Reply-To: <CAHp75VfKyqy+vM0XkP9Yb+znGOTVT4zYCRY3A3nQ7C3WNUVN0g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Jul 2021 17:54:46 +0300
Message-ID: <CAHp75VfUHPqccrxe81=jYmiskgWcgTpf3jBjXsPiFpox+Xuyyw@mail.gmail.com>
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

On Fri, Jul 9, 2021 at 5:40 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Parallel (4 bits)  panel display stopped working.
> I have no time right now to bisect but I have noticed there was quite
> a pile of patches from Lars to the driver recently (yeah, it seems for
> a few months I haven't run my tests against the AUX display driver).
>
> I believe the issue is there somewhere.
>
> Moreover on the removal I have got an oops
>
> [  218.825445] kernel tried to execute NX-protected page - exploit
> attempt? (uid: 0)
> [  218.832965] BUG: unable to handle page fault for address: ffff8f8f06559dc0
> [  218.839863] #PF: supervisor instruction fetch in kernel mode
> [  218.845540] #PF: error_code(0x0011) - permissions violation
> [  218.851132] PGD e601067 P4D e601067 PUD e602067 PMD 645a063 PTE
> 8000000006559063
> [  218.858587] Oops: 0011 [#1] SMP PTI
> [  218.862099] CPU: 0 PID: 7 Comm: kworker/u4:0 Tainted: G         C
>      5.13.0+ #23
> [  218.869870] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
> BIOS 542 2015.01.21:18.19.48
> [  218.878681] Workqueue: kacpi_hotplug acpi_device_del_work_fn
> [  218.884380] RIP: 0010:0xffff8f8f06559dc0
> [  218.888328] Code: ff ff d2 2b 21 8c ff ff ff ff 08 00 00 00 00 00
> 00 00 78 34 fa 02 8f 8f ff ff 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 <72> 65 67 75 6c 61 74 6f 72 3a 72 65
> 67 75 6c 61 74 6f 72 2e 30 2d
> [  218.907138] RSP: 0000:ffffad36c0043c90 EFLAGS: 00010246
> [  218.912387] RAX: ffff8f8f06559dc0 RBX: ffff8f8f062cbc00 RCX: ffff8f8f01239fc8
> [  218.919542] RDX: 000000002a3cccf8 RSI: 0000000000000001 RDI: ffff8f8f06559480
> [  218.926701] RBP: ffffffffc037e279 R08: 00000000d5832520 R09: 0000000000000001
> [  218.933856] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8f8f062cbc00
> [  218.941010] R13: ffffffffc038e028 R14: ffffffff8c5e0b60 R15: 00000000fffffffd
> [  218.948166] FS:  0000000000000000(0000) GS:ffff8f8f3e200000(0000)
> knlGS:0000000000000000
> [  218.956286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  218.962053] CR2: ffff8f8f06559dc0 CR3: 0000000002ef4000 CR4: 00000000001006f0
> [  218.969208] Call Trace:
> [  218.971678]  ? hd44780_common_clear_display+0x17/0x30 [hd44780_common]
> [  218.978252]  ? charlcd_write_char+0x21a/0x810 [charlcd]
> [  218.983519]  ? charlcd_puts+0x30/0x60 [charlcd]
> [  218.988083]  ? charlcd_unregister+0x24/0x70 [charlcd]
> [  218.993167]  ? hd44780_remove+0x1e/0x30 [hd44780]
> [  218.997901]  ? platform_remove+0x1f/0x40
> ...
>
> Just for your information and with hope that somebody may test and/or
> reproduce this and fix it. Later on I might find time to bisect the
> other issue I mentioned above.

For time being confirmed the following:
1. a2060f288e15 ("auxdisplay: Call charlcd_backlight in place") has a
remove bug (above), while panel works
2. 66ce7d5c1e12 ("auxdisplay: Use an enum for charlcd backlight on/off
ops") everything works as expected

So, the oops introduced in between those two.

-- 
With Best Regards,
Andy Shevchenko

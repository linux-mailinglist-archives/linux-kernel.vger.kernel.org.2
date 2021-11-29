Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E35460EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 07:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbhK2GnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 01:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbhK2GlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 01:41:16 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FA2C06175B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 22:37:52 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so5382425ooi.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 22:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfLJTrqi5jUZYQEwuSAUlCXF+OleODxB0oQPX3+rjPc=;
        b=lR+kUz1MsHJaIxGKsS7X03dwXi5H0fLiaTz1WtI5Cq8MTnQjk/59ohpet9YlECy1bc
         dK6Kt+G4xYfEkYvqrq7f3c6tGSlECbxWWorfrg4pbcOlF1k76yeqhSSxwkndYEjiSzPX
         KleYn2FNx1MuWdq5EgSJbwOul7w5YZ/PJMHyY2Ux8L8PrgHbJEYj6A4CDoeFTTzbeRCT
         iTmQezBKpaL4XtggzC8S2hCM8neFcBR/jLBE6oLWjaPDyZQwcHsAjZl2dmU8hst/5ZoB
         lhnhPOPk+C9qzqMJH32Dlq9L2UelZ1nkygPqX9B1EvRWITZav3ZcFFtuyk9VptJOWZjj
         VbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfLJTrqi5jUZYQEwuSAUlCXF+OleODxB0oQPX3+rjPc=;
        b=Qx/1Ae3eKVtfULmuT5RUvihtDMSKWTigfYjHiBBCKkCE+81qHhN0FYiDQ5yQ7UtreP
         7a3fXPNIhXGHeKxj1y2uf2XIJMFa/qdNLltxzwKUaH5esEp6SMV3QlJlRyqXzZNtSYQC
         UjVQq+n1bC3qnf1tm9JZ7GKgfM7SjGOmrR+OB61AGlNSP/3f11giIk9lPNR95LT9vktq
         6sdgxTgQDKVRaaCQ+4b2RxglIWtvviKasA86r/46ZWrNG1cXHpnxi5aK5DOk1RoM3pdE
         hwcRQz7veBrqyFzZZb4Ht2zl9xY75b189LYNlka3mmjJBCMzu4Mqrd4KGRdlAMyZZ6J6
         jD2w==
X-Gm-Message-State: AOAM530CDqOhUCRpJSusouzCTgierhaWQf6SzJw5F7UfTthAB18Vrm0O
        Tq6y8vcMB2BP42vGxaLSSL2M2Hj6+XE2zgznOtCosA==
X-Google-Smtp-Source: ABdhPJzEgpFjQPTzYa9cQqelLZKVmty0WeS7cwVm8zwftQcKbrHtt/7GtPNNg/22bKSQvhV66iaYI/HaBg6UPaY9EAA=
X-Received: by 2002:a4a:96f1:: with SMTP id t46mr30240912ooi.53.1638167871113;
 Sun, 28 Nov 2021 22:37:51 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72kGS0JzFkuUS9oN2_HU9f_stm1gA8v79o2pUCb7bNSe0A@mail.gmail.com>
In-Reply-To: <CANiq72kGS0JzFkuUS9oN2_HU9f_stm1gA8v79o2pUCb7bNSe0A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Nov 2021 07:37:39 +0100
Message-ID: <CACT4Y+Z7bD62SkYGQH2tXV0Zx2MFojYoZzA2R+4J-CrXa6siMw@mail.gmail.com>
Subject: Re: KASAN Arm: global-out-of-bounds in load_module
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Nov 2021 at 01:43, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi KASAN / Arm folks,
>
> I noticed in our CI that inserting and removing a module, and then
> inserting it again, e.g.:
>
>     insmod bcm2835_thermal.ko
>     rmmod bcm2835_thermal.ko
>     insmod bcm2835_thermal.ko
>
> deterministically triggers the report below in v5.16-rc2. I also tried
> it on v5.12 to see if it was a recent thing, but same story.
>
> I could find this other report from May, which may be related:
> https://lore.kernel.org/lkml/20210510202653.gjvqsxacw3hcxfvr@pengutronix.de/
>
> Cheers,
> Miguel

HI Miguel,

0xf9 is redzone for global variables:
#define KASAN_GLOBAL_REDZONE    0xF9  /* redzone for global variable */

I would assume this is caused by not clearing shadow of unloaded
modules, so that the next module loaded hits these leftover redzones.

+arm mailing list and Linus W


> BUG: KASAN: global-out-of-bounds in load_module+0x1b98/0x33b0
> Write of size 16384 at addr bf000000 by task busybox/17
>
> CPU: 0 PID: 17 Comm: busybox Not tainted 5.15.0 #7
> Hardware name: Generic DT based system
> [<c010f968>] (unwind_backtrace) from [<c010c6f8>] (show_stack+0x10/0x14)
> [<c010c6f8>] (show_stack) from [<c0210734>]
> (print_address_description+0x58/0x384)
> [<c0210734>] (print_address_description) from [<c0210cc8>]
> (kasan_report+0x168/0x1fc)
> [<c0210cc8>] (kasan_report) from [<c0211230>] (kasan_check_range+0x260/0x2a8)
> [<c0211230>] (kasan_check_range) from [<c0211c68>] (memset+0x20/0x44)
> [<c0211c68>] (memset) from [<c019d21c>] (load_module+0x1b98/0x33b0)
> [<c019d21c>] (load_module) from [<c0199f88>] (sys_init_module+0x198/0x1ac)
> [<c0199f88>] (sys_init_module) from [<c0100060>] (ret_fast_syscall+0x0/0x48)
> Exception stack(0xc113ffa8 to 0xc113fff0)
> ffa0:                   00000000 00002a98 00098038 00002a98 00081483 00093f88
> ffc0: 00000000 00002a98 00000000 00000080 00000001 b66ffef0 00081483 000815c7
> ffe0: b66ffbd8 b66ffbc8 000207f5 00011cc2
>
>
> Memory state around the buggy address:
>  bf001200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  bf001280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >bf001300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9
>                                                      ^
>  bf001380: 00 00 07 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
>  bf001400: 00 00 f9 f9 f9 f9 f9 f9 00 00 04 f9 f9 f9 f9 f9
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CANiq72kGS0JzFkuUS9oN2_HU9f_stm1gA8v79o2pUCb7bNSe0A%40mail.gmail.com.

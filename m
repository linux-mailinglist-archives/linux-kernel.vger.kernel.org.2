Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D7337B79
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCKR6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhCKR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:58:01 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BAAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:58:01 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id x10so21532753qkm.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WywUmoHmcIslZBfIAYNGcMCWLJTSJyqm2ax+ex3lZg=;
        b=hLfud36U62xFdRMVP0xJQ22zs0F3ZYICohff39RVC8U6/j3fdwTdV3rhrcta+nXsXg
         kTMA9KT93A4jRk9lqUweLLk6xHAKUjdTFbHFKK+zBOL0zZHQYzvdmeITdlKrgfx99mXg
         l2iPVHChfNZ8uJCygKlUwzz/RrHf20Dqkp/HDpmFaYY8UcQKensg9L1KoNz29je0O4cg
         6rLjfOV9+zuVOlm8Otyjf+vrSE0RIBR63PrLmPZtHTYjzzT3XnyrVQX8B7HUj4rGIal6
         07YUdh1GnA+yNXtwQQN/epEUYSRhxJYVlEgifAaCrlwxunn6q68UTP2qqnxzozD5Rzvc
         1AvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WywUmoHmcIslZBfIAYNGcMCWLJTSJyqm2ax+ex3lZg=;
        b=IjgQHCE+XxktoXUDRofFtzmI/JqK8OrAriwL1uKT4HM1LVQgUYkqkjCd4nJCEF90RB
         QKgCgoz3FCFUWl/LGACBs0/vyN2x3QPKkrpQbgTPtsHl5u407//BB1ShnZ6Q/Ql6v8Qx
         PB+BAj1F9/q9zc8sW+9newZmrtIVtrCE5bqE35r5YW4rxsBJ2N4PTcUEjVwz9KjTvFHG
         CYlekQz6jdZYMx9nAlb87VK5zfFAgUS7jqCqzcEUJFnlEGslvkr298TYwXDLx30MnozV
         /K1aS3adbm46rEkSUPZopiYiuJFUmLKdZqW7gBVOZLs06VLekZY6jz7k2k9dwfPTsjzk
         K0rQ==
X-Gm-Message-State: AOAM533FnO9bShTnqJknOpvJk47OtpFV21XdJNL3DyeGvi2T5Jhfz+AK
        /A+cAatiTSyd1lYeTQhVV70ivrjoiJjF6ATinDr8kDIwByetWw==
X-Google-Smtp-Source: ABdhPJyD9GlghfhdZvjqLVxg9NP8v10ew6ZlbJtUFHlhDFYE1EejGkagEXTncqa00e89PsD9eSJiQospzRBBB0kNlwQ=
X-Received: by 2002:a37:46cf:: with SMTP id t198mr8826556qka.265.1615485480009;
 Thu, 11 Mar 2021 09:58:00 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
In-Reply-To: <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Mar 2021 18:57:48 +0100
Message-ID: <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 2:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The instances found few arm64-specific issues that we have not
> > observed on other instances:
>
> I've had a brief look at these:
>
> > https://syzkaller.appspot.com/bug?id=1d22a2cc3521d5cf6b41bd6b825793c2015f861f
>
> This one  doesn't seem arm64 specific at all. While the KASAN report has shown
> up on arm64, the link to
> https://syzkaller.appspot.com/bug?id=aa8808729c0a3540e6a29f0d45394665caf79dca
> seems to be for x86 machines running into the same problem.
>
> Looking deeper into the log, I see that fw_load_sysfs_fallback() finds
> an existing
> list entry on the global "pending_fw_head" list, which seems to have been freed
> earlier (the allocation listed here is not for a firmware load, so presumably it
> was recycled in the meantime). The log shows that this is the second time that
> loading the regulatory database failed in that run, so my guess is that it was
> the first failed load that left the freed firmware private data on the
> list, but I
> don't see how that happened.
>
> > https://syzkaller.appspot.com/bug?id=bb2c16b0e13b4de4bbf22cf6a4b9b16fb0c20eea
>
> This one rings a bell: opening a 8250 uart on a well-known port must fail
> when no I/O ports are registered in the system, or when the PCI I/O ports
> are mapped to an invalid area.
>
> It seems to be attempting a register access at I/O port '1' (virtual
> address 0xfffffbfffe800001 is one byte into the well-known PCI_IOBASE),
> which is an unusual place for a UART, traditional PCs had it at 0x3F8.
>
> This could be either a result of qemu claiming to support a PIO based UART
> at the first available address, or the table of UARTS being uninitialized
> .bss memory.
>
> Definitely an arm64 specific bug.

I can reproduce this with just:

#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

int main(void)
{
  int fd = syscall(__NR_openat, 0xffffffffffffff9cul, "/dev/ttyS3", 0ul, 0ul);
  char ch = 0;
  syscall(__NR_ioctl, fd, 0x5412, &ch); // TIOCSTI
  return 0;
}


It does not even do any tty setup... does it point to a qemu bug?

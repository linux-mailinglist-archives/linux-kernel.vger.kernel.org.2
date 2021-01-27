Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A72306469
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhA0TrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhA0To1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:44:27 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010FDC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:43:47 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 19so2977399qkh.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pApu4eekaOY2+FBBDIiRbVGqDqZosOpz0ZePSKijd6g=;
        b=h2F2pBLLIJBKCXFf1iLiR6+8YnOR/MjA6kuobJYRqSvoXYBwKrXII6DD8JFf1szkvk
         oFaUO5hqG7OlIuWKjYDxWILzMKIz4XWlxIp5JJRu5uL+j7V+5S/7eRcOq+znfjJxmzPZ
         7WbZoTI/SG5rg71WbN+Sy0RRyf4yTsON1Zp0PE55QUzq9zk3hWfj6/HbgsH73RlOSLiW
         IwjTpHXXRQezNHDUK+P52qNPIE+5nwpAg24aVKk9DwkP9T+DyTEYwMnnuz73gYq6bzM8
         +74udPbRQqFn//0xv0WtuzyXNOFYn7dLelV0nvh2yre8g8laeUq4MZIcG/8WK3EnHTJb
         +fMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pApu4eekaOY2+FBBDIiRbVGqDqZosOpz0ZePSKijd6g=;
        b=FcC+F9bfnqSrKmP/a+bBqF+6xUY8vdMPrIoZG1qaAJkYSxQgNNzGEIhZQe6+tKpFiW
         2xo/96TJeF5MGvcpGvHJmI6nKC1rCpS8V6azeJI5GukuoPhLsdxh9xO4c3GnbglkyF/e
         PgYnoM6QP1GuG257YZbj5IFy/oUHP9+9UGVsTxiQTjGagt3DafdWZyUChqSNBrZx5QdX
         9wN10BApxQGXVnPcenZdKn+u/Rsj9Jw6EBrI/FrnoTK+A3jq62eimILTXUcdWKQ+duyJ
         jNs38NguW6GPH3TzPDlw2rFQDTOyyAdepBmYPR62bbg2Iis2gEQzxDYRGidzHkdWcyeC
         eRjg==
X-Gm-Message-State: AOAM532q4o6qeCN3Vhn7zDZLIz8NzozDioOFGFEObFNmoZYa6aqCfl0N
        x5EFKDcS39o1dRh9K5x+l8UUnHIbKSUyvJpX7LtKGg==
X-Google-Smtp-Source: ABdhPJwrVeznbJ9BcE2YZgYAOMkoHGbX2IV9NkfCI287bykr2H6QyT292PWG2EPG5x5JD6TPV5YaG9hF59F4c6I8H2c=
X-Received: by 2002:a37:2716:: with SMTP id n22mr12222087qkn.265.1611776625945;
 Wed, 27 Jan 2021 11:43:45 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009bbb7905b9e4a624@google.com> <CACT4Y+agFz7Y32pkV7nObxB3KjCcN1p335h1HE4dr94rsDvndw@mail.gmail.com>
 <20210127171453.GC358@willie-the-truck> <CACT4Y+ZtQS7wtKbYSxAL=TJTmWp9_Gq-fBi-JLtAk3mA6J7siA@mail.gmail.com>
 <CAAeHK+yWe_GRDi8j7aPZAauTrfdjgYpYoj9F_KrsG3vtHDwTsw@mail.gmail.com>
 <CACT4Y+bSUnXoB_GtaFG7Vhe3bDr5MY6ZWdvcvw=uy+4-ZD7B-A@mail.gmail.com> <CAAeHK+xx7sGZPbSmZ1k0F31=V=zCAqdsh7jd-rjWLO6wJWdV4w@mail.gmail.com>
In-Reply-To: <CAAeHK+xx7sGZPbSmZ1k0F31=V=zCAqdsh7jd-rjWLO6wJWdV4w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Jan 2021 20:43:34 +0100
Message-ID: <CACT4Y+Y=4yYf1qXxRkNdxHfZU89sRMxwT9JN8_irwGK8mTsZLw@mail.gmail.com>
Subject: Re: WARNING in __do_kernel_fault
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will@kernel.org>,
        syzbot <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 8:16 PM 'Andrey Konovalov' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Wed, Jan 27, 2021 at 7:57 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Jan 27, 2021 at 7:46 PM 'Andrey Konovalov' via syzkaller-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > On Wed, Jan 27, 2021 at 6:24 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > On Wed, Jan 27, 2021 at 6:15 PM Will Deacon <will@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jan 27, 2021 at 06:00:30PM +0100, Dmitry Vyukov wrote:
> > > > > > On Wed, Jan 27, 2021 at 5:56 PM syzbot
> > > > > > <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > syzbot found the following issue on:
> > > > > > >
> > > > > > > HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> > > > > > > git tree:       upstream
> > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15a25264d00000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=45b6fce29ff97069e2c5
> > > > > > > userspace arch: arm64
> > > > > > >
> > > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > > >
> > > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > > Reported-by: syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com
> > > > > >
> > > > > > This happens on arm64 instance with mte enabled.
> > > > > > There is a GPF in reiserfs_xattr_init on x86_64 reported:
> > > > > > https://syzkaller.appspot.com/bug?id=8abaedbdeb32c861dc5340544284167dd0e46cde
> > > > > > so I would assume it's just a plain NULL deref. Is this WARNING not
> > > > > > indicative of a kernel bug? Or there is something special about this
> > > > > > particular NULL deref?
> > > > >
> > > > > Congratulations, you're the first person to trigger this warning!
> > > > >
> > > > > This fires if we take an unexpected data abort in the kernel but when we
> > > > > get into the fault handler the page-table looks ok (according to the CPU via
> > > > > an 'AT' instruction). Are you using QEMU system emulation? Perhaps its
> > > > > handling of AT isn't quite right.
> > > >
> > > > Hi Will,
> > > >
> > > > Yes, it's qemu-system-aarch64 5.2 with -machine virt,mte=on -cpu max.
> > > > Do you see any way forward for this issue? Can somehow prove/disprove
> > > > it's qemu at fault?
> > >
> > > I've reproduced this crash (by taking [1] and changing
> > > sys_memfd_create to 279), but it manifests as a normal null-ptr-deref
> > > for me. I'm using the latest QEMU master. Which QEMU does syzbot use
> > > exactly?
> >
> > qemu-system-aarch64 5.2 from this container:
> > https://github.com/google/syzkaller/blob/master/tools/docker/syzbot/Dockerfile
> > you can get a prebuilt version with:
> > docker pull gcr.io/syzkaller/syzbot
>
> Reproduced with this QEMU, still a normal null-ptr-deref. Where do I
> find the full list of arguments that are passed to QEMU on syzbot?


I am yet to document all details of these new instances, but the
syzkaller config contains:
"qemu_args": "-machine
virt,virtualization=on,mte=on,graphics=on,usb=on -cpu max"
the rest are in vm/qemu/qemu.go

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF06830639E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhA0S5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhA0S5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:57:48 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:57:07 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id e15so2198792qte.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdl713s/21KiGyh/DTXFNyf+tvozyDwj9ae9RDlS6aw=;
        b=XzAKeNrqFOuaPBSSM/RreTfJuczOhVS0Z2FAKftgmwEsY7l6P6DLJSRNSKyBRQivDd
         UnugyZFEtIST2Llgtsh0M0YpXdh0A5yR9AST2/W3BQgJW9zsM9/5usouZLO48tTN3nkP
         d6mcEoGxOwXCKYWOwzPPFoOSZNujHIrdYrpiufb1DDwc17R4ksutz+Ne45PWf6p8QO0c
         yX4XCOBl9xM6KLna7NW8e69OaAUD2q11AxVtgEt10/BlHGbZLdsFIapasgCSX3hZ1/i/
         Ym4dtZyXSheOWjFR3HtvVEL4YxRYX15Kmh0nwtA5N5Mf/9AbGys0sTzm4qFzD5P0U1Jg
         qVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdl713s/21KiGyh/DTXFNyf+tvozyDwj9ae9RDlS6aw=;
        b=fQ0drfNAox27eTyVBeytni1AT5twehcbcyi/MYnsv1kq+92ZJfzk6L+RntAs952Ec6
         BTZHeLT5goMLB+7R9nyu3TVzVnJyR4JMVT0Oikv7MCHq2PEl/9un0YmpILQ0lF5zS0mW
         tErxDUoskVjSlWU2sUXJjRXRltVh4s5+w8hrtyTCtMNRxpeNRiPjLyWfcUtPw1rvOIC7
         Mjg3sa3rTTZ3YZHBotIKN2Oj/Qtv+EOgwdqKuelpsBuXtocIlFadB7CIL2L3OaMGPrjD
         pMVMyehbM2qJDq3TYdQ1m4Je4twgD5Do25qUTUVp+6Qyo8bPLP1wSQSR2QVdQRzGOn6o
         zCKA==
X-Gm-Message-State: AOAM533wEzJcmFanjMkAkjRBmOUcdviudv4FVawbFkYLcFjO16nBfrDO
        IpjkKsZa+AQnyA4hxYSBCLl6zK5Q9iQ7X4LgBTH+tA==
X-Google-Smtp-Source: ABdhPJzudV+I630n1SVMaDIVN8XccwXytfWIVGc1y9T7v8EfrFOLYIK7l1kvgw2YoJ5d7EorNZFaJwSFzSBQJ0XZeJc=
X-Received: by 2002:ac8:66c9:: with SMTP id m9mr422359qtp.43.1611773826679;
 Wed, 27 Jan 2021 10:57:06 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009bbb7905b9e4a624@google.com> <CACT4Y+agFz7Y32pkV7nObxB3KjCcN1p335h1HE4dr94rsDvndw@mail.gmail.com>
 <20210127171453.GC358@willie-the-truck> <CACT4Y+ZtQS7wtKbYSxAL=TJTmWp9_Gq-fBi-JLtAk3mA6J7siA@mail.gmail.com>
 <CAAeHK+yWe_GRDi8j7aPZAauTrfdjgYpYoj9F_KrsG3vtHDwTsw@mail.gmail.com>
In-Reply-To: <CAAeHK+yWe_GRDi8j7aPZAauTrfdjgYpYoj9F_KrsG3vtHDwTsw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Jan 2021 19:56:55 +0100
Message-ID: <CACT4Y+bSUnXoB_GtaFG7Vhe3bDr5MY6ZWdvcvw=uy+4-ZD7B-A@mail.gmail.com>
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

On Wed, Jan 27, 2021 at 7:46 PM 'Andrey Konovalov' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Wed, Jan 27, 2021 at 6:24 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Jan 27, 2021 at 6:15 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Wed, Jan 27, 2021 at 06:00:30PM +0100, Dmitry Vyukov wrote:
> > > > On Wed, Jan 27, 2021 at 5:56 PM syzbot
> > > > <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15a25264d00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=45b6fce29ff97069e2c5
> > > > > userspace arch: arm64
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com
> > > >
> > > > This happens on arm64 instance with mte enabled.
> > > > There is a GPF in reiserfs_xattr_init on x86_64 reported:
> > > > https://syzkaller.appspot.com/bug?id=8abaedbdeb32c861dc5340544284167dd0e46cde
> > > > so I would assume it's just a plain NULL deref. Is this WARNING not
> > > > indicative of a kernel bug? Or there is something special about this
> > > > particular NULL deref?
> > >
> > > Congratulations, you're the first person to trigger this warning!
> > >
> > > This fires if we take an unexpected data abort in the kernel but when we
> > > get into the fault handler the page-table looks ok (according to the CPU via
> > > an 'AT' instruction). Are you using QEMU system emulation? Perhaps its
> > > handling of AT isn't quite right.
> >
> > Hi Will,
> >
> > Yes, it's qemu-system-aarch64 5.2 with -machine virt,mte=on -cpu max.
> > Do you see any way forward for this issue? Can somehow prove/disprove
> > it's qemu at fault?
>
> I've reproduced this crash (by taking [1] and changing
> sys_memfd_create to 279), but it manifests as a normal null-ptr-deref
> for me. I'm using the latest QEMU master. Which QEMU does syzbot use
> exactly?

qemu-system-aarch64 5.2 from this container:
https://github.com/google/syzkaller/blob/master/tools/docker/syzbot/Dockerfile
you can get a prebuilt version with:
docker pull gcr.io/syzkaller/syzbot


> [1] https://syzkaller.appspot.com/text?tag=ReproC&x=14d3621cd00000
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAAeHK%2ByWe_GRDi8j7aPZAauTrfdjgYpYoj9F_KrsG3vtHDwTsw%40mail.gmail.com.

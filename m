Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A3330638E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhA0Srt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhA0SrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:47:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:46:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y205so1782424pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cL0l4ddi6A7SFAj7pFFotWId+MU1PmBApXTLaVMI5vc=;
        b=bDA0091w1TrTcjIjSoKqVgfPGIT1smigUfMCTkVaTUYPvwHZuDeDjwIjVqPUmdyD/r
         kITpRaK5SVQ/O5QqVwofRaLYlOokulC7940x87J2jIzdChi7IfuLpOTTWedjmyXJ03Dh
         R81WvaFHwsm/PGWLZJr0vSlcvXkYHxD37DlsqQOBxpGnjS89c92xDAxyRSQyljjba5mO
         jRj/JnlSK1y0xkC/CkaWWSDhEU56ZvVUJFDMMgRByHofZuVeX3v1TQhQeVhbGoNAFpNz
         yORUUivQC5tepBe3/iF0Pyr39Fx9PaiyN4HFbNDKJBMwbSQwSmsYeYtou7cspAAx13h0
         kJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cL0l4ddi6A7SFAj7pFFotWId+MU1PmBApXTLaVMI5vc=;
        b=tuQaDejEIX7FRwBJU7ALJlvMKxO3+rXdgh6gkV2tC0k8l7B3YiwVebzloqbBTQrP58
         o3wnCVVDFqI6A81HawejCqed7xss6bSRqYZTELPqDXE1A0XRi45Jlmya+On9O54ntCdd
         AZDScPbDksLSOxFdhWvE8BBT1M5Fk6cjKMTEP4qJ8Rj/12VRlkKbpMoRg3uBSosSdMB+
         QoayJ+hN98+G2rFKTq67GafaUmwbwoh0e9TkZLGqOuamH9pBsG3nGne6RjfntaA1aHJr
         MrATiwTawrDVC0qydFeXks7Zd7oMcLCkt+riuhKsgbmWg3P8dRBZN25kttGjzJvrr7aB
         F0SQ==
X-Gm-Message-State: AOAM532uVp/XLxjTSP6JLIRO2byjtENHQIKNNWStI2/5EuEbgY4aZfoU
        qIFAuyKK3GnP4KWdAOE005/gzVP2BUpYHBgCgEzIRQ==
X-Google-Smtp-Source: ABdhPJwTPiWMAo7wC81kkDUvIrQvIBj2fRSTcE+THMiNQYKnijwpPxy9+yQujJsFboAnsMhJTIUGN2p0qqIE0uJ6a1k=
X-Received: by 2002:a62:115:0:b029:1b4:c593:acd4 with SMTP id
 21-20020a6201150000b02901b4c593acd4mr11898383pfb.2.1611773200947; Wed, 27 Jan
 2021 10:46:40 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009bbb7905b9e4a624@google.com> <CACT4Y+agFz7Y32pkV7nObxB3KjCcN1p335h1HE4dr94rsDvndw@mail.gmail.com>
 <20210127171453.GC358@willie-the-truck> <CACT4Y+ZtQS7wtKbYSxAL=TJTmWp9_Gq-fBi-JLtAk3mA6J7siA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZtQS7wtKbYSxAL=TJTmWp9_Gq-fBi-JLtAk3mA6J7siA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 27 Jan 2021 19:46:29 +0100
Message-ID: <CAAeHK+yWe_GRDi8j7aPZAauTrfdjgYpYoj9F_KrsG3vtHDwTsw@mail.gmail.com>
Subject: Re: WARNING in __do_kernel_fault
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Wed, Jan 27, 2021 at 6:24 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 27, 2021 at 6:15 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Jan 27, 2021 at 06:00:30PM +0100, Dmitry Vyukov wrote:
> > > On Wed, Jan 27, 2021 at 5:56 PM syzbot
> > > <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15a25264d00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=45b6fce29ff97069e2c5
> > > > userspace arch: arm64
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com
> > >
> > > This happens on arm64 instance with mte enabled.
> > > There is a GPF in reiserfs_xattr_init on x86_64 reported:
> > > https://syzkaller.appspot.com/bug?id=8abaedbdeb32c861dc5340544284167dd0e46cde
> > > so I would assume it's just a plain NULL deref. Is this WARNING not
> > > indicative of a kernel bug? Or there is something special about this
> > > particular NULL deref?
> >
> > Congratulations, you're the first person to trigger this warning!
> >
> > This fires if we take an unexpected data abort in the kernel but when we
> > get into the fault handler the page-table looks ok (according to the CPU via
> > an 'AT' instruction). Are you using QEMU system emulation? Perhaps its
> > handling of AT isn't quite right.
>
> Hi Will,
>
> Yes, it's qemu-system-aarch64 5.2 with -machine virt,mte=on -cpu max.
> Do you see any way forward for this issue? Can somehow prove/disprove
> it's qemu at fault?

I've reproduced this crash (by taking [1] and changing
sys_memfd_create to 279), but it manifests as a normal null-ptr-deref
for me. I'm using the latest QEMU master. Which QEMU does syzbot use
exactly?

[1] https://syzkaller.appspot.com/text?tag=ReproC&x=14d3621cd00000

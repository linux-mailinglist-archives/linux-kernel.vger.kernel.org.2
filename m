Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE19338ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhCLK5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhCLK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:56:54 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:56:53 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c6so3386628qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znud1Nr9yE8IpPd+dyG1z1NwZbu5Vx3wnftSO/9UZHs=;
        b=PQerAUBWlANgDRrqhYafbiOLT/jF2Ixyru8fv3NOALe4M9MGDv2J3mIvJLZg0NJm1p
         +q7dUdkOGtzE5kN/MvZIfJ4ORZFMHPsM2ZeNwiw8CoGxAAOWiKyfRmApzK4v9hEfXs3o
         dL2VCoxGuAY/JHhZ41hBOzR5O8MD1uEcwVNXrylge+WxCi9m+Qdf2acDtRt4dhxn4sV/
         ptgOGPVxLDjsLORb27IomD1lAUHF90EIyaIyJjXU1eMCDeolTTdpIJbsPkujfgorUS7N
         NohNLh3Mj3iDM86dkUeELZPuTOIHNpIF9DybcE336dJMERAQRfYodtWNQSIYKYNOH8gX
         26vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znud1Nr9yE8IpPd+dyG1z1NwZbu5Vx3wnftSO/9UZHs=;
        b=Me/pUiVyrtg+VNut0oZb/AE9e6/bkg06YU84QUvEdBsI0cXWs/WVtkNUvjHEqudVQp
         oigvDEHq4l2uhFTNVmpMRQWIEs2qhZ4sjoATKcvZ9/JiO+zsWhR38TkRfIq7BBJdskiC
         EpjvzadZZD2d9rbG32E4/AsuNHKuDK/xF1TXkKWwAnuike4EjHZJHtN2rEm+81tgqC0B
         vn3+nt4A3SsXtsvy8mVyX3bi07jSoffTE0t5cYRYrzniyolvpauveKnaMrkRrMKlpKBm
         Dni9jpfoDu81VIfpJKth11CFDX/IUi1PT4mEYOv96RSVnFCaMFJPQKWMBgr+i09F7cQA
         aovg==
X-Gm-Message-State: AOAM530yYghR2E+smb0rkxGZaYG6ZEwNrF2DLr/zaEeznTDmEkS3grhz
        6W+VSunEDwbUa2bZF6hKGBckbz3oLr6MhbYnmrXOWg==
X-Google-Smtp-Source: ABdhPJxMDarcE2i1JeWPslUE/Wmeg6JlATJ14Gnwu4HazIPzwmuVDGbHrn4PncF0qHrhhNv0Rm5otRrj05pD+QrUEXo=
X-Received: by 2002:ac8:4558:: with SMTP id z24mr189382qtn.66.1615546612521;
 Fri, 12 Mar 2021 02:56:52 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009bbb7905b9e4a624@google.com> <CACT4Y+agFz7Y32pkV7nObxB3KjCcN1p335h1HE4dr94rsDvndw@mail.gmail.com>
 <20210127171453.GC358@willie-the-truck> <CACT4Y+ZtQS7wtKbYSxAL=TJTmWp9_Gq-fBi-JLtAk3mA6J7siA@mail.gmail.com>
 <20210127173446.GE358@willie-the-truck>
In-Reply-To: <20210127173446.GE358@willie-the-truck>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 11:56:40 +0100
Message-ID: <CACT4Y+auMTWM9NMHAfyBjuSc6o7+7VkCxBgp6AodHk8XUu4VWA@mail.gmail.com>
Subject: Re: WARNING in __do_kernel_fault
To:     Will Deacon <will@kernel.org>
Cc:     syzbot <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 6:34 PM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Jan 27, 2021 at 06:24:22PM +0100, Dmitry Vyukov wrote:
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
> > Yes, it's qemu-system-aarch64 5.2 with -machine virt,mte=on -cpu max.
> > Do you see any way forward for this issue? Can somehow prove/disprove
> > it's qemu at fault?
> > The instance just started running, but it seems to be the most common
> > crash so far and it seems to happen on _all_ gpf's.
> > You can see all arm64 crashes so far here:
> > https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64-mte
> > They all happen in reiserfs_security_init, but locally I got a bunch
> > of different stacks, e.g.:
>
> Your best bet is to hack is_spurious_el1_translation_fault() to dump addr,
> es and par, then we can help decipher the logs here. It could also easily be
> a bug in that code, since it hasn't been run before (well, other than
> contrived testing when I wrote it).

Should dumping of addr/es/par be included into mainline kernel code if
this WARNING is not decipherable without this info?

Also, Andrey localized this to mte=on,virtualization=on combination,
does this point towards qemu bug?

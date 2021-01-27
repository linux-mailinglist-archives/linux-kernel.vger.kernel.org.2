Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA930622A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbhA0Rgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344006AbhA0Rfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:35:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B8F664DA8;
        Wed, 27 Jan 2021 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611768892;
        bh=i6kHf86hLpvjWynPpLsneLVR/FYqJtB9g8RT/GX0Tr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCJaJjgMjSKyieVO4eEAN41pY0xDAHjHDuSNqLlL1y8IyCp4pOivok0N64T+pGuoG
         YOIwWAGMYTesWPQGD8fy4jIbOKv7Ff3DS5zx5cPNZeKF1o/UyUB7YaMdceXQKjCUIq
         HL0a5tMHZqR5Semz3f9IV5y7YKMBBZQdMRO9b+whKhLNB63Mcki+Yv9+Z+Qq8FQK8m
         IGMRZfctb0V8GL/TP2f4xvNIHkkJigJY1QYzxBZ/WRhwvsDjCDgRGGi1oqPQ7zDrID
         6dMxH9pcl+f92uoBH1Y+dop6c2AFhp73c/p1sqIMeEujgco1WvQ0YwzC5+NY9FID6D
         oAcnESnPja+rg==
Date:   Wed, 27 Jan 2021 17:34:47 +0000
From:   Will Deacon <will@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: WARNING in __do_kernel_fault
Message-ID: <20210127173446.GE358@willie-the-truck>
References: <0000000000009bbb7905b9e4a624@google.com>
 <CACT4Y+agFz7Y32pkV7nObxB3KjCcN1p335h1HE4dr94rsDvndw@mail.gmail.com>
 <20210127171453.GC358@willie-the-truck>
 <CACT4Y+ZtQS7wtKbYSxAL=TJTmWp9_Gq-fBi-JLtAk3mA6J7siA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZtQS7wtKbYSxAL=TJTmWp9_Gq-fBi-JLtAk3mA6J7siA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 06:24:22PM +0100, Dmitry Vyukov wrote:
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
> Yes, it's qemu-system-aarch64 5.2 with -machine virt,mte=on -cpu max.
> Do you see any way forward for this issue? Can somehow prove/disprove
> it's qemu at fault?
> The instance just started running, but it seems to be the most common
> crash so far and it seems to happen on _all_ gpf's.
> You can see all arm64 crashes so far here:
> https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64-mte
> They all happen in reiserfs_security_init, but locally I got a bunch
> of different stacks, e.g.:

Your best bet is to hack is_spurious_el1_translation_fault() to dump addr,
es and par, then we can help decipher the logs here. It could also easily be
a bug in that code, since it hasn't been run before (well, other than
contrived testing when I wrote it).

Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53DA3499F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCYTJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCYTIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:08:31 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3060FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:08:31 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j7so2505710qtx.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ec1Ghl9v284qk873U/eSrLFZcLMUlWNcyoNkEFduibA=;
        b=fCmE3fKr0IxsO0fFE/zbqm+hoLZo9f4CwoKJXF0MBbJ6PUi/JsRvdW45djbihwqo8z
         vqfdTk724CxYz7jL33o8y+QogIKVMrYSG5kHXBnPeBLyIJoBm8C2Mt46aLX1QlausJ6g
         lgMPqP6/b7HYz3thY01MW98G4YgJ/LoEN4dpi+6YmU6B/L53cBOBGr05VmbTcA2+WmCx
         dxG+oPKrLe3Lx23EZxj20tCnwLbrkxKVqnnAKhDP2DkMdepsHl6gqIQTxBg4Y2l7MPQ6
         y3aLNuqi3AaIzdMBStxM7M1PfWICeDlcuV6UTZ60yIiHq9kglnnvPNjUznkF7P2PUUxU
         VWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ec1Ghl9v284qk873U/eSrLFZcLMUlWNcyoNkEFduibA=;
        b=GXDEmcMhihr1FKhtDwCIsDXcs1ZYZ2KClzKu8uHvR6oTW/Geib8Q3Jls/Yzf12u9DT
         FGA/Xzehvd2EVD5yLvWyjVnWgGZZ+xxMJGr6swVjACTZAbDyYCmCfsW3X5VNzKYlFsua
         AGObtHN12Orqs7EQogUNhQFwbXCq9rwfOxM7qZFu4t3u8bEsHCHCc1G/OVArh98zAGeB
         b4uhqYwlabB8AI1M+nGM3p9bkHp/BTUFfVp6PjGRcWfDB3ZK+j3ffBlRBSEmWxMLCxzB
         x0/slGWEMfLJmv5QpMNJN43dEOcHxIJI7B76GMvyKciM87ea5FGFmS0kMOTQqrg1dlZe
         2P2Q==
X-Gm-Message-State: AOAM532I89Bd9dLHOvicU+/54wk8oSoO7cQGzmSTldeIbV0z/vyThX3O
        57noCgYf/jxj141vvIROJiQijq0ZHgRLffCfkkbAIQ==
X-Google-Smtp-Source: ABdhPJzqeFQsVl1U54s3Z9D8PraCO+VrvnkFdHB0g92+1Lp8rFK1Wrcr7dCjjsHmemGlO94kEbVGea9MmVZQnpyFOPY=
X-Received: by 2002:ac8:5212:: with SMTP id r18mr8907194qtn.290.1616699310131;
 Thu, 25 Mar 2021 12:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ce4c9505bdd4a48f@google.com> <CACT4Y+a4S-oXsjgwDh3SmERqKFF1QbapvX6NiSpn51KRtqvTiQ@mail.gmail.com>
 <20210325182046.GA15860@willie-the-truck> <CACT4Y+b833yyxekjK61PpFKLmdJq0Jb6vLUo=EBYCLKr9+ksow@mail.gmail.com>
In-Reply-To: <CACT4Y+b833yyxekjK61PpFKLmdJq0Jb6vLUo=EBYCLKr9+ksow@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Mar 2021 20:08:18 +0100
Message-ID: <CACT4Y+Zq_cqJdcNA=rHXrEPhCxymW2cemmSCDTwikTn+wemUgg@mail.gmail.com>
Subject: Re: [syzbot] BUG: soft lockup in do_wp_page (4)
To:     Will Deacon <will@kernel.org>
Cc:     syzbot <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com>,
        kernel-team@android.com, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 7:34 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Thu, Mar 18, 2021 at 08:34:16PM +0100, Dmitry Vyukov wrote:
> > > On Thu, Mar 18, 2021 at 8:31 PM syzbot
> > > <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    bf152b0b Merge tag 'for_linus' of git://git.kernel.org/pub..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=17d5264ed00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2c9917c41f0bc04b
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0b036374a865ba0efa8e
> > > > userspace arch: arm64
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com
> > > >
> > > > watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:3684]
> > >
> > > +Will, arm
> > >
> > > If I am reading this commit correctly, this is caused by:
> > >
> > > commit cae118b6acc309539b33339e846cbb19187c164c
> > > Author: Will Deacon
> > > Date:   Wed Mar 3 13:49:27 2021 +0000
> > >     arm64: Drop support for CMDLINE_EXTEND
> > >
> > > syzbot passes lots of critical things in CONFIG_CMDLINE:
> > > https://github.com/google/syzkaller/blob/c3c81c94865791469d376eba84f4a2d7763d3f71/dashboard/config/linux/upstream-arm64-kasan.config#L495
> > > but also wants the bootloader args to be appended.
> > > What is the way to do it now?
> >
> > For now, there isn't a way to do it with CONFIG_CMDLINE, so I think you can
> > either:
> >
> >   * Revert my patch for your kernels
> >   * Pass the arguments via QEMU's -append option
> >   * Take a look at one of the series which should hopefully add this
> >     functionality back (but with well-defined semantics) [1] [2]
>
> Unfortunately none of these work for syzbot (and I assume other
> testing environments).
>
> syzbot does not support custom patches by design:
> http://bit.do/syzbot#no-custom-patches
> As any testing system, it tests the official trees.
>
> It's not humans who start these VMs, so it's not as easy as changing
> the command line after typing...
> There is no support for passing args specifically to qemu, syzkaller
> support not just qemu, so these things are specifically localized in
> the config. Additionally there is an issue of communicating all these
> scattered details to developers in bug reports. Currently syzbot
> reports the kernel config and it as well captures command line.
>
> Could you revert the patch? Is there any point in removing the
> currently supported feature before the new feature lands?

FTR another instance:
https://syzkaller.appspot.com/bug?extid=b6c93d85a3f77fca7f13
https://lore.kernel.org/lkml/000000000000d7142c05be60db47@google.com/T/#u


> > Sorry for the nuisance; I did try to fix this [3] but it's a bit of a
> > mess.
> >
> > Will
> >
> > [1] https://lore.kernel.org/linux-arch/cover.1614705851.git.christophe.leroy@csgroup.eu/
> > [2] https://lore.kernel.org/linux-mips/20210308235319.2988609-2-danielwa@cisco.com/#t
> > [3] https://lore.kernel.org/r/20210225125921.13147-1-will@kernel.org

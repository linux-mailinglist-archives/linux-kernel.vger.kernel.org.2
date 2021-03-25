Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355DA34996A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCYSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhCYSUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:20:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A3B5619C7;
        Thu, 25 Mar 2021 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616696452;
        bh=ZVUJNwmRK3ITpUwMjag8eZ3lFFHOkxQLXXyTtKEeFSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mFOLm6J1bQbFjXDeGgIAs6fEy1sf13gWd0Yx/bFwn+wEBTtPcyKUR/28UM323TJ5i
         iWVIJpdUqLLoXV9aaNpohiPsZJjz1egoKcb7eNeuvD9ybJ1fuej/gPF6yBkFUtL+2Q
         3gnScU1p4qUCUO3ghlXpdrB67fUSekyWs+749xaLXIZpEmJSA/LTO/zAnuTVaBp0HG
         8C9qkLmOy17N/b9G6mRwSk5Y1oTQ/S5+t9/rF533uOHcvf4//31Wc65zie3pvMKhpU
         vrPqJyX7OEfZbUxLAXmtH0LfYEE/sNEMWM6EjV2hdf6cPdGML+21IH63otSzY+a9O0
         fDemAKcNBuiuQ==
Date:   Thu, 25 Mar 2021 18:20:47 +0000
From:   Will Deacon <will@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com>,
        kernel-team@android.com, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [syzbot] BUG: soft lockup in do_wp_page (4)
Message-ID: <20210325182046.GA15860@willie-the-truck>
References: <000000000000ce4c9505bdd4a48f@google.com>
 <CACT4Y+a4S-oXsjgwDh3SmERqKFF1QbapvX6NiSpn51KRtqvTiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a4S-oXsjgwDh3SmERqKFF1QbapvX6NiSpn51KRtqvTiQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 08:34:16PM +0100, Dmitry Vyukov wrote:
> On Thu, Mar 18, 2021 at 8:31 PM syzbot
> <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    bf152b0b Merge tag 'for_linus' of git://git.kernel.org/pub..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17d5264ed00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2c9917c41f0bc04b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0b036374a865ba0efa8e
> > userspace arch: arm64
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com
> >
> > watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:3684]
> 
> +Will, arm
> 
> If I am reading this commit correctly, this is caused by:
> 
> commit cae118b6acc309539b33339e846cbb19187c164c
> Author: Will Deacon
> Date:   Wed Mar 3 13:49:27 2021 +0000
>     arm64: Drop support for CMDLINE_EXTEND
> 
> syzbot passes lots of critical things in CONFIG_CMDLINE:
> https://github.com/google/syzkaller/blob/c3c81c94865791469d376eba84f4a2d7763d3f71/dashboard/config/linux/upstream-arm64-kasan.config#L495
> but also wants the bootloader args to be appended.
> What is the way to do it now?

For now, there isn't a way to do it with CONFIG_CMDLINE, so I think you can
either:

  * Revert my patch for your kernels
  * Pass the arguments via QEMU's -append option
  * Take a look at one of the series which should hopefully add this
    functionality back (but with well-defined semantics) [1] [2]

Sorry for the nuisance; I did try to fix this [3] but it's a bit of a
mess.

Will

[1] https://lore.kernel.org/linux-arch/cover.1614705851.git.christophe.leroy@csgroup.eu/
[2] https://lore.kernel.org/linux-mips/20210308235319.2988609-2-danielwa@cisco.com/#t
[3] https://lore.kernel.org/r/20210225125921.13147-1-will@kernel.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5FE34998F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhCYSfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhCYSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:35:07 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED8FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 11:35:07 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y5so2767942qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ktz4pNsyMmw5FFMeMEqkr+bDgHdxIyIlPDtgBMB9GQg=;
        b=pKgRRTmXHDg2rpAcH1DUv2asXxqphFmsg4s6H5CmbxfKh3Ur7x4+if6AHxQPmdW2B4
         qkJJrxV5p5SGt4y9PHR1er16MV5FZdY73ty56B9ZccI27ADVGprIUUhAVBbkuTZb+Fj0
         wJ2XL0sQwliypPwKjLj3F3Gq0QCerU3jaLcpDf1MVj/NkVCi9nkWf/FuJZAgEtUiWPQu
         ndna050C3w33jdQK1zKfLys7CVocTZcw0TSdb+jtT6j0lM/baTrTkt3VKymFni8CKUv0
         dhoGO5tnFs03UizsA/RCSvZJVA8HfUgowoZEy/iW4GEp6ogg3rfpExk1GQ4eJdmYCGUD
         UWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ktz4pNsyMmw5FFMeMEqkr+bDgHdxIyIlPDtgBMB9GQg=;
        b=It2zkAK2y4lFeyZkeOPR1Nz5Lw4UJi+M5LiO9PrsLIOUfG3MgSoVWv+y/c0YB30CsY
         iVBbWyB3k3c+5L3yM+GJPlvaDxre1vAiTDmJ3qJBtoNOYOfkg01/YCd3/E6ZeyqAiWme
         YS6XzSBiz59CFnx6qJkosnOgKskXWTW5UVRNwSliR8urkvBFF1ck6AJrkfIyF6pR5E0C
         CrSi7UD0zd0KWRZ4pFLKhmnpYeIApv5jPRQX8EVWJlzTK/veB4QZo6D9y6fxx5xv3pVR
         vBgoOrau/XSxAhHM4NUA7Vy8yQL+0s6dkuw09qZMVkKEC4EmcHkjbCxG2mn/f0D/Efir
         nj0g==
X-Gm-Message-State: AOAM5338x8HQhhdIWaraFhou8DDiQ6y/P5JNiq9jmdkWK8dMttK5y4vM
        b8Rc6qd7mxhIjpL2Bad7OHFv+GsdSqExTE++HDTpeA==
X-Google-Smtp-Source: ABdhPJy3q6VaMniItkA5pooxgheav1ONAkDpPz7IasHkdpjQn6IBCn/HffQyD/vyg6Nn2qzziG307gD6EJdIhpgqqeI=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr9138045qkx.501.1616697306371;
 Thu, 25 Mar 2021 11:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ce4c9505bdd4a48f@google.com> <CACT4Y+a4S-oXsjgwDh3SmERqKFF1QbapvX6NiSpn51KRtqvTiQ@mail.gmail.com>
 <20210325182046.GA15860@willie-the-truck>
In-Reply-To: <20210325182046.GA15860@willie-the-truck>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Mar 2021 19:34:54 +0100
Message-ID: <CACT4Y+b833yyxekjK61PpFKLmdJq0Jb6vLUo=EBYCLKr9+ksow@mail.gmail.com>
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

On Thu, Mar 25, 2021 at 7:20 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Mar 18, 2021 at 08:34:16PM +0100, Dmitry Vyukov wrote:
> > On Thu, Mar 18, 2021 at 8:31 PM syzbot
> > <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    bf152b0b Merge tag 'for_linus' of git://git.kernel.org/pub..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17d5264ed00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2c9917c41f0bc04b
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0b036374a865ba0efa8e
> > > userspace arch: arm64
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com
> > >
> > > watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:3684]
> >
> > +Will, arm
> >
> > If I am reading this commit correctly, this is caused by:
> >
> > commit cae118b6acc309539b33339e846cbb19187c164c
> > Author: Will Deacon
> > Date:   Wed Mar 3 13:49:27 2021 +0000
> >     arm64: Drop support for CMDLINE_EXTEND
> >
> > syzbot passes lots of critical things in CONFIG_CMDLINE:
> > https://github.com/google/syzkaller/blob/c3c81c94865791469d376eba84f4a2d7763d3f71/dashboard/config/linux/upstream-arm64-kasan.config#L495
> > but also wants the bootloader args to be appended.
> > What is the way to do it now?
>
> For now, there isn't a way to do it with CONFIG_CMDLINE, so I think you can
> either:
>
>   * Revert my patch for your kernels
>   * Pass the arguments via QEMU's -append option
>   * Take a look at one of the series which should hopefully add this
>     functionality back (but with well-defined semantics) [1] [2]

Unfortunately none of these work for syzbot (and I assume other
testing environments).

syzbot does not support custom patches by design:
http://bit.do/syzbot#no-custom-patches
As any testing system, it tests the official trees.

It's not humans who start these VMs, so it's not as easy as changing
the command line after typing...
There is no support for passing args specifically to qemu, syzkaller
support not just qemu, so these things are specifically localized in
the config. Additionally there is an issue of communicating all these
scattered details to developers in bug reports. Currently syzbot
reports the kernel config and it as well captures command line.

Could you revert the patch? Is there any point in removing the
currently supported feature before the new feature lands?



> Sorry for the nuisance; I did try to fix this [3] but it's a bit of a
> mess.
>
> Will
>
> [1] https://lore.kernel.org/linux-arch/cover.1614705851.git.christophe.leroy@csgroup.eu/
> [2] https://lore.kernel.org/linux-mips/20210308235319.2988609-2-danielwa@cisco.com/#t
> [3] https://lore.kernel.org/r/20210225125921.13147-1-will@kernel.org

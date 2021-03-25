Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B3D349A46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCYT35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230059AbhCYT3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:29:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB40761A26;
        Thu, 25 Mar 2021 19:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616700564;
        bh=mP2NouLDus9q94+GA0gdi+r3nEQsG5iXHcIixE8bd94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hC8YAnn8yxndfhJ9e1Cxb8w9k0Fkk54vFTDaFZ58BLD2VK2opByIRzjm/+MFra0hP
         XOKroJa5ZZNtc05/h4eJDzyhAswNHLa/+aB9k7VGeCN+OffuoaS/oJsfxlMsnYJ4cw
         ALQdfLkphsF9Oe0D/NVUVAq1ausScmmRY9DV3H9B0AhSzr2SFUuHaGYIX7aXKVINlt
         lAVaHObSdO7pHnam+GRuBiE35yFr8snAC7dnNm5L/3p1q7CzwUGmA78XErDHkEAlHE
         vDB+DyoCv2rsnM8pz+50LI3k39PbKiiVhtXyMfyyCSTnli2bC1wHygX+oFpyCiOAIJ
         IM26YWjJ/AdYg==
Date:   Thu, 25 Mar 2021 19:29:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com>,
        kernel-team@android.com, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] BUG: soft lockup in do_wp_page (4)
Message-ID: <20210325192918.GB16123@willie-the-truck>
References: <000000000000ce4c9505bdd4a48f@google.com>
 <CACT4Y+a4S-oXsjgwDh3SmERqKFF1QbapvX6NiSpn51KRtqvTiQ@mail.gmail.com>
 <20210325182046.GA15860@willie-the-truck>
 <CACT4Y+b833yyxekjK61PpFKLmdJq0Jb6vLUo=EBYCLKr9+ksow@mail.gmail.com>
 <20210325191006.GE15860@willie-the-truck>
 <CACT4Y+Y-iROPw8bvpjzpSoUfHs+6ridjKfnLbs8Hhv9ciP7dYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y-iROPw8bvpjzpSoUfHs+6ridjKfnLbs8Hhv9ciP7dYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 08:24:53PM +0100, Dmitry Vyukov wrote:
> On Thu, Mar 25, 2021 at 8:10 PM Will Deacon <will@kernel.org> wrote:
> > On Thu, Mar 25, 2021 at 07:34:54PM +0100, Dmitry Vyukov wrote:
> > > On Thu, Mar 25, 2021 at 7:20 PM Will Deacon <will@kernel.org> wrote:
> > > > On Thu, Mar 18, 2021 at 08:34:16PM +0100, Dmitry Vyukov wrote:
> > > > > On Thu, Mar 18, 2021 at 8:31 PM syzbot
> > > > > <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com> wrote:
> > > > > commit cae118b6acc309539b33339e846cbb19187c164c
> > > > > Author: Will Deacon
> > > > > Date:   Wed Mar 3 13:49:27 2021 +0000
> > > > >     arm64: Drop support for CMDLINE_EXTEND
> > > > >
> > > > > syzbot passes lots of critical things in CONFIG_CMDLINE:
> > > > > https://github.com/google/syzkaller/blob/c3c81c94865791469d376eba84f4a2d7763d3f71/dashboard/config/linux/upstream-arm64-kasan.config#L495
> > > > > but also wants the bootloader args to be appended.
> > > > > What is the way to do it now?
> > > >
> > > > For now, there isn't a way to do it with CONFIG_CMDLINE, so I think you can
> > > > either:
> > > >
> > > >   * Revert my patch for your kernels
> > > >   * Pass the arguments via QEMU's -append option
> > > >   * Take a look at one of the series which should hopefully add this
> > > >     functionality back (but with well-defined semantics) [1] [2]
> > >
> > > Unfortunately none of these work for syzbot (and I assume other
> > > testing environments).
> > >
> > > syzbot does not support custom patches by design:
> > > http://bit.do/syzbot#no-custom-patches
> > > As any testing system, it tests the official trees.
> > >
> > > It's not humans who start these VMs, so it's not as easy as changing
> > > the command line after typing...
> > > There is no support for passing args specifically to qemu, syzkaller
> > > support not just qemu, so these things are specifically localized in
> > > the config. Additionally there is an issue of communicating all these
> > > scattered details to developers in bug reports. Currently syzbot
> > > reports the kernel config and it as well captures command line.
> > >
> > > Could you revert the patch? Is there any point in removing the
> > > currently supported feature before the new feature lands?
> >
> > Well, we only just merged it (in 5.10 I think?), and the semantics of the
> > new version will be different, so I really don't see the value in supporting
> > both (even worse, Android has its own implementation which is different
> > again). The timeline was: we merged CMDLINE_EXTEND, then we noticed it was
> > broken, my fixes were rejected, so we removed the feature rather than
> > support the broken version. In the relatively small window while it was
> > merged, syzbot started using it :(
> 
> I didn't realize it was just introduced :)
> We used CMDLINE_EXTEND on x86, and I looked for a similar option for
> arm64 and found it.
> 
> > So I really think the best bet is to wait until the patches are sorted out.
> > I think Christophe is about to spin a new version, and I reviewed his last
> > copy, so I don't see this being far off,
> 
> If it's expected to be merged soon, let's wait.

Thanks, and knowing that we have a keen user helps to prioritise the review
:)

Will

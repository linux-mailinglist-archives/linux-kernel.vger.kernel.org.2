Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E57940F353
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbhIQHdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbhIQHdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:33:49 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DA3C061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:32:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w19so12805186oik.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKjjeDKy7EEm8DJZCvZYnmEyAG2ECYFeNG4kNXZi54A=;
        b=f659RD4A+ZkdvN6t2UcwfNw+CfjiGjNs2EjnmtpQB9fXfPEPrpekM71MzwdATfNISV
         pcqyo3+wQ0lyGv4xdAY30LtoQIOnFOmP2LP9n2CmaRkNph6yDPM3bMZXQTNQay8U2+3u
         7j6RTQZSe2aQhxM3if/pRfaI9WszxoIEM2rbkZ7XbmxAuuqfkhF+qRBvosEwgSk5TPva
         VzcMqRpCZiR2b1Tlm2y9IvZ5YntC5HG/cGy6a8ZcuyBWn9zLLuOjMBqfSUzGJrE8Arwj
         lgePkLyVUW4K8YcSgK9llJEMNAiV2rf9KMVy5lAXZhnH7RlVJio0sH4NqY2utwISNGKH
         be7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKjjeDKy7EEm8DJZCvZYnmEyAG2ECYFeNG4kNXZi54A=;
        b=l4bATFvPqbOn5i30JSeg2GPt9u4NBFlY1EoIR7RQpA07AxSJQ+wRpcGgFdvpm2U8sY
         XZ7M2jGNCSCZMo19tmbRQPekIY6m84E16FIYWIyEjxu0zmq+/+xdcTvdefGbnm6GTfwR
         RLLZmnmBDoa5fDCo1honEETqXOBuJm5qTXWjRjItzPTPY8Bb836HCgCbjeX/kustbnQP
         jLiUaqPG06ibUWV+PRVxF4pdm5nIJ8GJ99/RgCUKIp8EBQZ4JcM3C86yD6BtHPVqECs5
         mbytjz/eJJXcmPR4NDZdyczJEy9mQ03H7kqrId5ibnhDFXySGtV9Z1dL4aKu7qYooW/2
         DaWw==
X-Gm-Message-State: AOAM532rqdfLfUqySKe01F7yi554oWMStYTy8BVAdK2oDBeMyNnNluxz
        EYpPqp2d2I1gP7Ea0q4EpC2efZ/TyVWvIRaFudsqqw==
X-Google-Smtp-Source: ABdhPJxWpEGc0igJ5nxpQq3v5XKR2nmbMkVJXnAhHdA1OOgsfRB1QysPsx1gKf3Do+2+Myq5j/wssPQdtK7uqGvduO0=
X-Received: by 2002:aca:f189:: with SMTP id p131mr12608457oih.128.1631863946814;
 Fri, 17 Sep 2021 00:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ce4c9505bdd4a48f@google.com> <CACT4Y+a4S-oXsjgwDh3SmERqKFF1QbapvX6NiSpn51KRtqvTiQ@mail.gmail.com>
 <20210325182046.GA15860@willie-the-truck> <CACT4Y+b833yyxekjK61PpFKLmdJq0Jb6vLUo=EBYCLKr9+ksow@mail.gmail.com>
 <20210325191006.GE15860@willie-the-truck> <CACT4Y+Y-iROPw8bvpjzpSoUfHs+6ridjKfnLbs8Hhv9ciP7dYw@mail.gmail.com>
 <20210325192918.GB16123@willie-the-truck>
In-Reply-To: <20210325192918.GB16123@willie-the-truck>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 09:32:16 +0200
Message-ID: <CACT4Y+aQfAqce-cD+p+OPi-EyxQR3sCH_pstxUnfgoMjA1-ULg@mail.gmail.com>
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

On Thu, 25 Mar 2021 at 20:29, Will Deacon <will@kernel.org> wrote:
>
> On Thu, Mar 25, 2021 at 08:24:53PM +0100, Dmitry Vyukov wrote:
> > On Thu, Mar 25, 2021 at 8:10 PM Will Deacon <will@kernel.org> wrote:
> > > On Thu, Mar 25, 2021 at 07:34:54PM +0100, Dmitry Vyukov wrote:
> > > > On Thu, Mar 25, 2021 at 7:20 PM Will Deacon <will@kernel.org> wrote:
> > > > > On Thu, Mar 18, 2021 at 08:34:16PM +0100, Dmitry Vyukov wrote:
> > > > > > On Thu, Mar 18, 2021 at 8:31 PM syzbot
> > > > > > <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com> wrote:
> > > > > > commit cae118b6acc309539b33339e846cbb19187c164c
> > > > > > Author: Will Deacon
> > > > > > Date:   Wed Mar 3 13:49:27 2021 +0000
> > > > > >     arm64: Drop support for CMDLINE_EXTEND
> > > > > >
> > > > > > syzbot passes lots of critical things in CONFIG_CMDLINE:
> > > > > > https://github.com/google/syzkaller/blob/c3c81c94865791469d376eba84f4a2d7763d3f71/dashboard/config/linux/upstream-arm64-kasan.config#L495
> > > > > > but also wants the bootloader args to be appended.
> > > > > > What is the way to do it now?
> > > > >
> > > > > For now, there isn't a way to do it with CONFIG_CMDLINE, so I think you can
> > > > > either:
> > > > >
> > > > >   * Revert my patch for your kernels
> > > > >   * Pass the arguments via QEMU's -append option
> > > > >   * Take a look at one of the series which should hopefully add this
> > > > >     functionality back (but with well-defined semantics) [1] [2]
> > > >
> > > > Unfortunately none of these work for syzbot (and I assume other
> > > > testing environments).
> > > >
> > > > syzbot does not support custom patches by design:
> > > > http://bit.do/syzbot#no-custom-patches
> > > > As any testing system, it tests the official trees.
> > > >
> > > > It's not humans who start these VMs, so it's not as easy as changing
> > > > the command line after typing...
> > > > There is no support for passing args specifically to qemu, syzkaller
> > > > support not just qemu, so these things are specifically localized in
> > > > the config. Additionally there is an issue of communicating all these
> > > > scattered details to developers in bug reports. Currently syzbot
> > > > reports the kernel config and it as well captures command line.
> > > >
> > > > Could you revert the patch? Is there any point in removing the
> > > > currently supported feature before the new feature lands?
> > >
> > > Well, we only just merged it (in 5.10 I think?), and the semantics of the
> > > new version will be different, so I really don't see the value in supporting
> > > both (even worse, Android has its own implementation which is different
> > > again). The timeline was: we merged CMDLINE_EXTEND, then we noticed it was
> > > broken, my fixes were rejected, so we removed the feature rather than
> > > support the broken version. In the relatively small window while it was
> > > merged, syzbot started using it :(
> >
> > I didn't realize it was just introduced :)
> > We used CMDLINE_EXTEND on x86, and I looked for a similar option for
> > arm64 and found it.
> >
> > > So I really think the best bet is to wait until the patches are sorted out.
> > > I think Christophe is about to spin a new version, and I reviewed his last
> > > copy, so I don't see this being far off,
> >
> > If it's expected to be merged soon, let's wait.
>
> Thanks, and knowing that we have a keen user helps to prioritise the review
> :)

Any updates on proper CMDLINE support for arm64? This is still broken
for syzbot and it periodically reports false positives due to
incorrect cmdline.

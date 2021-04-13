Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F024E35D6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 07:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbhDMFOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 01:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242475AbhDMFOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:14:39 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7985C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 22:14:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o17so8270152qkl.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1MhGHptppR4JfVg5lhSU+kHwLLhNLD9eNv0NPDmNZg=;
        b=JhmAgg9Wtu/dvfyYZkLeerLWdqYkkkklywFAcaG/TgjLYIZLrtVvli+2MW15yhPyaD
         s6kf/EhhxePHiIaDal7Nd/9mLKRZbNusK7NKov4tePFr4Ced3EAqWSEd3OA+huC4nCqS
         +Gw98JOOFXWjnMCNpMfrgdqqLaEFbpc1pOxUCMImYa2uJlpO5DxExs0fG1x7ZGDJhZtq
         CoZjhcWTjDQHCwxBKhDMjNWZZ3M0f0DGMMbAATpE13bNkwpwjC3kaOUeQyH4dUhqSRlK
         netSeFHiwmD5dvXK/AMMrSXCK7wS6Crj2G/F0ifavSPNeru39F7uIiI/416bbrHcqfOr
         no8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1MhGHptppR4JfVg5lhSU+kHwLLhNLD9eNv0NPDmNZg=;
        b=A0Mw/hxDns3Eq5H1FYzztp8VgQ3FfLfF2DhFBfSvSUt3gPUd3pSv7NDHhnoJyAzz86
         /2bWj00K+kOmJrYw3wN1xC4ZIsdZcTYuvBz86sH+/2HhGABz1yHEM6tX+/+zaHGzKkxn
         H2fSeZLMlLV4rIwP8i2oCY/ufSsSGy8t27TSxcF4Uswxy8GA2XtcrRUm9cXISmrcQio9
         shkIRUm0rTucbzDaeoQKw84vTi2K8bwFDjagzMS2+M1VL8sWUtO5Yj8fTidw/hGtiyQ8
         HHCmfJcZ+a4DQkC62wtmng5OBd6XnYaMbV+/2E9RRAzn6R9IeKvFgVMtAh2rj+nU4Bd4
         ELtw==
X-Gm-Message-State: AOAM532fxUbHVUdFWDt33sE2YxrQtfvldNXO24DnuYBa90oWo4TbusSt
        Y/z5molEDIKvKYl4ryDiiIW5rO1Ep2n5KrM0Sh+BBDBDMpesKQ==
X-Google-Smtp-Source: ABdhPJxtioOCZAt2nsdSxmRzp5jWFVoslJNTaejpXYmOJC+2NLTdvqdGsNrKbR1CkUzMuNapA7Q+/6oO10Hg10SnSc4=
X-Received: by 2002:a05:620a:243:: with SMTP id q3mr11531519qkn.501.1618290858611;
 Mon, 12 Apr 2021 22:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f14c105bde08f75@google.com> <CACT4Y+bLkFSc8manYrCukj-_nzwVsV9y6xYWXmGyYFS-PoBRPQ@mail.gmail.com>
 <20210319101043.GU1463@shell.armlinux.org.uk> <20210322172241.GB80352@C02TD0UTHF1T.local>
In-Reply-To: <20210322172241.GB80352@C02TD0UTHF1T.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 07:14:07 +0200
Message-ID: <CACT4Y+ZaFKB6xd9BiPjYsE+13GJb3d_4aRTkB8xrNMaexpLaFA@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: WARNING in __context_tracking_enter
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        syzbot <syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 6:22 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Russell,
>
> On Fri, Mar 19, 2021 at 10:10:43AM +0000, Russell King - ARM Linux admin wrote:
> > On Fri, Mar 19, 2021 at 10:54:48AM +0100, Dmitry Vyukov wrote:
> > > .On Fri, Mar 19, 2021 at 10:44 AM syzbot
> > > <syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com> wrote:
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    8b12a62a Merge tag 'drm-fixes-2021-03-19' of git://anongit..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=17e815aed00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfeed364fc353c32
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=f09a12b2c77bfbbf51bd
> > > > userspace arch: arm
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com
> > >
> > >
> > > +Mark, arm
> > > It did not get far with CONFIG_CONTEXT_TRACKING_FORCE (kernel doesn't boot).
> >
> > It seems that the path:
> >
> > context_tracking_user_enter()
> > user_enter()
> > context_tracking_enter()
> > __context_tracking_enter()
> > vtime_user_enter()
> >
> > expects preemption to be disabled. It effectively is, because local
> > interrupts are disabled by context_tracking_enter().
> >
> > However, the requirement for preemption to be disabled is not
> > documented... so shrug. Maybe someone can say what the real requirements
> > are here.
>
> From dealing with this recently on arm64, theis is a bit messy. To
> handle this robustly we need to do a few things in sequence, including
> using the *_irqoff() variants of the context_tracking_user_*()
> functions.
>
> I wrote down the constraints in commit:
>
>   23529049c6842382 ("arm64: entry: fix non-NMI user<->kernel transitions")
>
> For user->kernel transitions, the arch code needs the following sequence
> before invoking arbitrary kernel C code:
>
>         lockdep_hardirqs_off(CALLER_ADDR0);
>         user_exit_irqoff();
>         trace_hardirqs_off_finish();
>
> For kernel->user transitions, the arch code needs the following sequence
> once it will no longer invoke arbitrary kernel C code, just before
> returning to userspace:
>
>         trace_hardirqs_on_prepare();
>         lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>         user_enter_irqoff();
>         lockdep_hardirqs_on(CALLER_ADDR0);

Hi Russell,

Does Mark's comment make sense to you?
lockdep_assert_preemption_disabled() also checks "&&
this_cpu_read(hardirqs_enabled)", so is it that we also need hardirq's
disabled around user_enter/exit?
This issue currently prevents ARM boot on syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22D3063ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhA0TRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhA0TR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:17:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B521DC061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:16:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id md11so1843873pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BfREwbDjxnOg026qOqckLdIw1qL/4szMI1NzGoCzkk=;
        b=bRzzhgbnWr0+bkrr1FN7Dee3/AEfgIhIhblQDQBAF9HC4JBvBmos1dwMNO7stmaGsa
         9nzspPEeuLKeUZyWzIn5pxJvWr9OgHVyy4G6LJL4+52LscCJODUL1ifrJotu1/HPxwcz
         4En9SIX8lqwF+N52TOjJy2j8v11gbIDzi6Sk3xHxIfAB9iWcP9qQkh+rXQBIUngcRUvn
         3QN3hcGNq+RZ3+BvxqICIhYW9mclrExaszQ88LyF5pyNJxaS4DZa68TUEBSl5RHyjlq2
         QSkuUBCL680LteMN2Pg+wo8sMC21z7xgyzKyiZsl00bRQEMA200IQtVQrmfr3IGn12AQ
         vu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BfREwbDjxnOg026qOqckLdIw1qL/4szMI1NzGoCzkk=;
        b=ZJxRKSYIwFcB5pHTZu7WaYx2vZtsmwKziwq1td2QbZvitgYA+sbFolpw08PuELlvUi
         LTNvCtbZriSQYsopCiYXxtlr3apYTjkyiyMra6K7wmGYnAyjewMIMEw4pvdFKQTSVbSy
         OMiteDHtY9t2SMjOhz0Eo/72Bhqp6+xXSyn0kaExiQ16f1sul7SDQCW6bJyosTpP2STg
         HfgBPUKuLbwpi2ISSA6HjFi87DnWyTcUaFq3OupZ/KucixzZDhCcDY3+5N121UiDtU6l
         OYbpEnOPmixX9AESHCSzM13yVs1cOdlLUe9X1zBjOLR/EfK+Qm5ArH6mUEfoDb1jjDYK
         1uOw==
X-Gm-Message-State: AOAM53319rJlgfm7IThpBjazNIq1i8zzcrPX4PRzKyII3pYHF/xPakmX
        NYAek148sXI/St9AexCGf9D2OTp+60IZkIrKCw9eJw==
X-Google-Smtp-Source: ABdhPJx7HiZU7Ee95suEN8+xTPmrXRDoma5XNse1qY78uUE1gLHvvO2gN08oingzRTTiHLGiPjLmsVroD+Yl3PxZh6w=
X-Received: by 2002:a17:90a:ce10:: with SMTP id f16mr7285809pju.136.1611775008133;
 Wed, 27 Jan 2021 11:16:48 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009bbb7905b9e4a624@google.com> <CACT4Y+agFz7Y32pkV7nObxB3KjCcN1p335h1HE4dr94rsDvndw@mail.gmail.com>
 <20210127171453.GC358@willie-the-truck> <CACT4Y+ZtQS7wtKbYSxAL=TJTmWp9_Gq-fBi-JLtAk3mA6J7siA@mail.gmail.com>
 <CAAeHK+yWe_GRDi8j7aPZAauTrfdjgYpYoj9F_KrsG3vtHDwTsw@mail.gmail.com> <CACT4Y+bSUnXoB_GtaFG7Vhe3bDr5MY6ZWdvcvw=uy+4-ZD7B-A@mail.gmail.com>
In-Reply-To: <CACT4Y+bSUnXoB_GtaFG7Vhe3bDr5MY6ZWdvcvw=uy+4-ZD7B-A@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 27 Jan 2021 20:16:36 +0100
Message-ID: <CAAeHK+xx7sGZPbSmZ1k0F31=V=zCAqdsh7jd-rjWLO6wJWdV4w@mail.gmail.com>
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

On Wed, Jan 27, 2021 at 7:57 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 27, 2021 at 7:46 PM 'Andrey Konovalov' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Wed, Jan 27, 2021 at 6:24 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Wed, Jan 27, 2021 at 6:15 PM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Wed, Jan 27, 2021 at 06:00:30PM +0100, Dmitry Vyukov wrote:
> > > > > On Wed, Jan 27, 2021 at 5:56 PM syzbot
> > > > > <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15a25264d00000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=45b6fce29ff97069e2c5
> > > > > > userspace arch: arm64
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com
> > > > >
> > > > > This happens on arm64 instance with mte enabled.
> > > > > There is a GPF in reiserfs_xattr_init on x86_64 reported:
> > > > > https://syzkaller.appspot.com/bug?id=8abaedbdeb32c861dc5340544284167dd0e46cde
> > > > > so I would assume it's just a plain NULL deref. Is this WARNING not
> > > > > indicative of a kernel bug? Or there is something special about this
> > > > > particular NULL deref?
> > > >
> > > > Congratulations, you're the first person to trigger this warning!
> > > >
> > > > This fires if we take an unexpected data abort in the kernel but when we
> > > > get into the fault handler the page-table looks ok (according to the CPU via
> > > > an 'AT' instruction). Are you using QEMU system emulation? Perhaps its
> > > > handling of AT isn't quite right.
> > >
> > > Hi Will,
> > >
> > > Yes, it's qemu-system-aarch64 5.2 with -machine virt,mte=on -cpu max.
> > > Do you see any way forward for this issue? Can somehow prove/disprove
> > > it's qemu at fault?
> >
> > I've reproduced this crash (by taking [1] and changing
> > sys_memfd_create to 279), but it manifests as a normal null-ptr-deref
> > for me. I'm using the latest QEMU master. Which QEMU does syzbot use
> > exactly?
>
> qemu-system-aarch64 5.2 from this container:
> https://github.com/google/syzkaller/blob/master/tools/docker/syzbot/Dockerfile
> you can get a prebuilt version with:
> docker pull gcr.io/syzkaller/syzbot

Reproduced with this QEMU, still a normal null-ptr-deref. Where do I
find the full list of arguments that are passed to QEMU on syzbot?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9050A446948
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhKETqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhKETqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:46:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8767961053;
        Fri,  5 Nov 2021 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636141444;
        bh=KZI84csA0pXe4MpppkTQjETD5MBmZg+UKyN3th6aoP4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bU51s/1MhKdRxepJ8pgb+HHOMzmlroDKiUZQ0qvFFjNMQ7BNBOhXwZ/+ENQMlxzzC
         TBgBIr8zPTq2AuQ2tJBHH8ugKE15CdCCiDWBdVbAz8ISSVA4dO5mNW4O06AHqjS6TU
         t4PP+vDbwMqp6iHpuG9IMEp4m/DvOCu+Ot35+gVAtI3AzYXmIVnWO6W+f5BNVnn8Te
         Cy7ft9fyb3tGbBJ8ujfmQrDSAE4leYiVpbc5AP1ZxT91G34aZmo4zRNQo+YuDOdpvS
         KsgNs/NTf+ithAbFIDg9EVTZWXHa4ccpU9h7DpdvC0kp08QV2702QpPLrpNWFms+vI
         BV7HWlXMidDlg==
Received: by mail-ot1-f41.google.com with SMTP id c26-20020a9d615a000000b0055bf6efab46so6375978otk.6;
        Fri, 05 Nov 2021 12:44:04 -0700 (PDT)
X-Gm-Message-State: AOAM531kh1tKOk+XqlOieYlXhX1rwkwCNwVr5uN6wGL/CcPf55yjrbUk
        NI7Ts9Cahh0zsIOsjlQfEn5FO/q/aIUEYKd2aUE=
X-Google-Smtp-Source: ABdhPJwfWYqautGL8MNIxQPm+PAD0jP0F9lJNrB3iTbIUnha/V9yn45aRRyRrLPVu+uRrpm4Lfx10Uy86qkW8M6LPgc=
X-Received: by 2002:a9d:830:: with SMTP id 45mr20816312oty.112.1636141443855;
 Fri, 05 Nov 2021 12:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211104031554.GA34798@roeck-us.net> <CAHk-=wjvWORtC5vwgavJxpBtV3-q9GGidezS_2NjtUFvqg7H5Q@mail.gmail.com>
 <77dc70f4-879a-eb5c-2dd6-682b4c7cfd03@roeck-us.net> <CAHk-=wjZo3yj46FwVi0BNKfy5fZ4-UeWkeQ6nhcAbbnKS7K=dQ@mail.gmail.com>
 <202111051242.86E9DBF@keescook>
In-Reply-To: <202111051242.86E9DBF@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 5 Nov 2021 20:43:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGhHGD047BzXC3m9afW+9x_UBj1jgDdC+i2GLqHbrj-Fg@mail.gmail.com>
Message-ID: <CAMj1kXGhHGD047BzXC3m9afW+9x_UBj1jgDdC+i2GLqHbrj-Fg@mail.gmail.com>
Subject: Re: parisc build failures in mainline kernel
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        linux-parisc <linux-parisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2021 at 20:43, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Nov 03, 2021 at 09:45:47PM -0700, Linus Torvalds wrote:
> > On Wed, Nov 3, 2021 at 9:30 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Unfortunately not. With that patch it complains about task_struct.
> >
> > Gaah. You'll need something like this too
> >
> > -       DEFINE(TASK_CPU, offsetof(struct task_struct, cpu));
> > +       DEFINE(TASK_CPU, offsetof(struct task_struct, thread_info.cpu));
> >
> > in arch/parisc/kernel/asm-offsets.c.
> >
> > And really, it should probably be renamed as TASK_TI_CPU, but then you
> > have to rename all the uses too.
> >
> > There might be other details like that lurking.
>
> I'll check this out too if Ard doesn't beat me to it. Thanks for the
> investigation and sorry for the breakage!
>

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a2e8202c7a16a85a881ad2b6e32ccbebdc01dda

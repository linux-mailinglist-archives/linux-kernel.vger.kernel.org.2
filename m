Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8D35191B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhDARvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbhDARkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05553C0225B3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 08:39:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w28so3489485lfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4Yc9Fo8nH3qAbpV51g94tw6HmT4cWz0oodkJat7vyU=;
        b=PnRMEbvuuxIgoHz2A8hVDovCixxBMZDtl8IbeTG0bOFd0hithGVS/NKIT9zCRfigpP
         ZhaeGVhzMokB2fSjhktb5RZcFYv+z5OzyTdLl2flYiWVb2dGSZk5ZzfNTNxgshBcrMzG
         aSaYYF0nnY0xEBSzCpbpl5LJz4L72gcFX1rt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4Yc9Fo8nH3qAbpV51g94tw6HmT4cWz0oodkJat7vyU=;
        b=cBoZVhUKtGc8R/X+ofuBEnYwkrtBtxdgIzQ1Cw5pJzkYvDF91Xt4vMldcaLqhN3lrw
         wNtbFWiyWNJ3qo/Wk7Wu97RPnB4TXGc9KcULRZQfqxrT+s8eGmw2dMP7gyDcE3aW7WZ4
         09VoWabB4fLZOTiTzJcc+Ejpk341uvpHzEZL2Kekzdk/0L8NEXQaz+o1q2xXTkh6oQvz
         NxbST/tMh7M6jHbBvTmhxHgnbjejmUBmQKo7xgW04V+cFnGcildPUrL9y02zNyjx1FGL
         YL1xJ+3DgsEeuKwEDKglVFD1fn9TSjK1zFPQk8CgilXY6reylpwO7Q9+Is1vva2Pfpff
         T/Gw==
X-Gm-Message-State: AOAM531XXcAzIU6OY4/xdFp6QsWX7xhvaUZVleank9IWcosc60ZafhS6
        cIMDg9bSZBpTiwFy90g8Tk6y7oY29maYE3vK
X-Google-Smtp-Source: ABdhPJxtNQTSw5lzP1WJ5t05mDpi8pYC1RF6gVWXrg9BG7Ww5EH4CyQRyLv3/nt9vDXhCOZ35a7bxg==
X-Received: by 2002:a19:c309:: with SMTP id t9mr5676476lff.348.1617291583157;
        Thu, 01 Apr 2021 08:39:43 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id f23sm650824lja.43.2021.04.01.08.39.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 08:39:42 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id d12so3458610lfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:39:41 -0700 (PDT)
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr5648326lfd.487.1617291581178;
 Thu, 01 Apr 2021 08:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210326003928.978750-1-axboe@kernel.dk> <e6de934a-a794-f173-088d-a140d0645188@samba.org>
 <f2c93b75-a18b-fc2c-7941-9208c19869c1@kernel.dk> <8efd9977-003b-be65-8ae2-4b04d8dd1224@samba.org>
 <358c5225-c23f-de08-65cb-ca3349793c0e@samba.org> <5bb47c3a-2990-e4c4-69c6-1b5d1749a241@samba.org>
In-Reply-To: <5bb47c3a-2990-e4c4-69c6-1b5d1749a241@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Apr 2021 08:39:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEObPkZBe4766DmR46-=5QTUiatWbSOaD468eTgYc1tg@mail.gmail.com>
Message-ID: <CAHk-=whEObPkZBe4766DmR46-=5QTUiatWbSOaD468eTgYc1tg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Allow signals for IO threads
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 7:58 AM Stefan Metzmacher <metze@samba.org> wrote:
>
> >
> > Ok, the following makes gdb happy again:
> >
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -163,6 +163,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
> >         /* Kernel thread ? */
> >         if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> >                 memset(childregs, 0, sizeof(struct pt_regs));
> > +               if (p->flags & PF_IO_WORKER)
> > +                       childregs->cs = current_pt_regs()->cs;
> >                 kthread_frame_init(frame, sp, arg);
> >                 return 0;
> >         }
>
> Would it be possible to fix this remaining problem before 5.12 final?

Please not that way.

But doing something like

        childregs->cs = __USER_CS;
        childregs->ss = __USER_DS;
        childregs->ds = __USER_DS;
        childregs->es = __USER_DS;

might make sense (just do it unconditionally, rather than making it
special to PF_IO_WORKER).

Does that make gdb happy too?

           Linus

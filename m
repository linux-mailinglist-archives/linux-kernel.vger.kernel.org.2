Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F72316543
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhBJLcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhBJL2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:28:30 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C79C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:27:50 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id h8so1228882qkk.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8fQSnzcQwTA0SHfnRGdOf4ssZ1bU3rdts7dlVxtfE0=;
        b=aLYpseP9NsvPdQaYDvrNPZTVC9hlJ+C+ttPslOZd9TaM5TxRN22WJVVXDLMAUOiB9d
         meBPE84MUJztLkYfNHDNcIiqtDY5WytQvr+/bC6HPD4zXWRylrohxS4ehhsi/R8hKbAP
         0WlaJ+gIzlyKKAEFuJAu8/Db+LtaCzhdfSBCIbzEM23eA8e1oPjFqmBJ9ZRyy0bQ8WoE
         0bxGGroBlait5IlEBWR5+sx6W4vktuiy9L5YYUKZB2wtuLOkjYFeTLUYoImLB5si5dp2
         jBJZRsQi8IDjqeZvCMd/gMRFt+wBEd8u8c+FUlN1ZsUahRpPINIFNONXFxXc38R5dL8a
         LvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8fQSnzcQwTA0SHfnRGdOf4ssZ1bU3rdts7dlVxtfE0=;
        b=qBOhTwcv8FoXjjAoeeX7icPHym4QKGWnjdKAxoh/PUD7i8jtGJJO4ap0UoqbhWCuLy
         YBfpk+PNceeu6eRJhK1UqObUbxosostNNNLm6rWtRFnhAivItiYSSbeH4/NmxarA/CHW
         qVGmHAweTBSHgJIUqgNLeSrNulBfabcYPBbMVcOIZjQGDsnsMGkEJd6sXhN3+pVSNv/m
         h+apx+OZjYDLHw4C1ccvZUPYqAOlJlJbZk0OwSkVcUFjw/tRvThtRS3VcgEVn10kcl13
         C8YfGot9CtYhsn1X9yyykqkJ7/Ufxeai5G3QIO2CiZTokyUf6Z0Wb/yMio80Zn/7wKd/
         7T4w==
X-Gm-Message-State: AOAM532YRvlu2zctkG22Z7u6yA7+UvOONdTiTlfLa/xWs0b6Q4umhxjC
        ZpzJcko1YFMG+SYN+wx+reK4sFGoDBU8o3Khgawo0Q==
X-Google-Smtp-Source: ABdhPJx4XLDj1UXheZEZKKL4C38GrPPKljJFhYfpklk+CTxWgrzxBD1WVVzkL/ge9Gm34phV6ACuvYeY2KZxMh69oNY=
X-Received: by 2002:a05:620a:918:: with SMTP id v24mr2840941qkv.350.1612956469638;
 Wed, 10 Feb 2021 03:27:49 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YytChe9Tv5etacBL4snEDu+A2fNzF4zKiKtfmH0C0roQ@mail.gmail.com>
 <20210203160543.GA19512@duo.ucw.cz> <20210203172834.GA3943@mipc>
 <CACT4Y+bkQOAwAwEnRoZVwKM2sDpHW3bzeWdga4MhxhERvZKT+Q@mail.gmail.com> <20210203192453.GA21047@amd>
In-Reply-To: <20210203192453.GA21047@amd>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Feb 2021 12:27:38 +0100
Message-ID: <CACT4Y+ZrnDTCE0umuE0i2Sb+=Acszgc9k_hXopMX_kCkE4YQrQ@mail.gmail.com>
Subject: Re: syzbot reporting less duplicates
To:     Pavel Machek <pavel@ucw.cz>
Cc:     bobwxc <bobwxc@email.cn>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 8:24 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> On Wed 2021-02-03 19:22:34, Dmitry Vyukov wrote:
> > On Wed, Feb 3, 2021 at 6:39 PM bobwxc <bobwxc@email.cn> wrote:
> > >
> > > On Wed, Feb 03, 2021 at 05:05:43PM +0100, Pavel Machek wrote:
> > > > On Mon 2021-02-01 11:52:12, Dmitry Vyukov wrote:
> > > > Could we please get common prefix (like syzbot: KASAN:....) so that
> > > > the bulk of emails is easier to remove?
> > > There are several bots testing on the kernel, maybe we should give a prefix
> > > format for all bot.
> > > Also we can use mail-address to fliter email, but it's still a little
> > > inconvenient.
> >
> > Hi Pavel, bobwxc,
> >
> > Yes, I was wondering if syzbot in From/To/CC can be used for
> > filtering? I assume email clients that can filter based on subject can
> > also filter based on From/To/CC.
> > Does anybody filter syzbot emails? Maybe you can share what works
> > best?
>
> From does not really work. So... syzbot reports for subsystems I don't
> maintain are uninteresting, and so is the resulting discussion.
>
> While filtering on "From:" is easy for initial report, it does not
> make it easy to remove follow up discussion.n


I've filed https://github.com/google/syzkaller/issues/2435 to track
the subject feature request.
I thought that maybe filtering based on From/To/CC should work right
away, it should capture follow up discussions as well.



> > I am not sure a common prefix for all bots is useful because it
> > supports only all or nothing. There are also some bots that
> > maintainers use now that seem to be fundamental to the process, if one
> > is ignoring them, then they are effectively ignoring what the
> > maintainer is saying.
>
> I'm pretty sure common prefix for all bots is useful.
>
> Best regards,
>                                                         Pavel
> --
> http://www.livejournal.com/~pavelmachek

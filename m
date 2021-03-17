Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94BC33F53C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhCQQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhCQQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:14:57 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180CCC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:14:57 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id a15so1355028vsi.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/ySiK/kXiDv/1yzNm6ETSoZGVeV4Z5Jhp9IeBQRtMU=;
        b=rmphkjWvS05OSX8TLY4j1Tb0QWgwPh4idfVLJL+HBECp4WCQZ0t9SaNsd6wNjhGDg6
         2aVFmPr12a7pfdZ20DUI/rn1DMDWpXbPpiSpit8LWCjKuvF0kUjflDUPvmmJo6p4JXVH
         q/VHVdUlLJNii5OngIlKX9wTLYWo5rIJXB+cBCSJ2dw4ib4czhvy8eeZGfLmLbYPnhkl
         QiAJkaW065S4vXX8erUUYdzPe9A6eUEJP85h3DnLB7EjYQ4QOZdKLOd8CqvaFuEKWO9f
         baoeQQLR5bCceex07dwUGMc6cqDSf4OgwMbk0BkmGVlQsBk/wHJLXlyk7WN2kfM3YhFM
         zPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/ySiK/kXiDv/1yzNm6ETSoZGVeV4Z5Jhp9IeBQRtMU=;
        b=E1Z5d+u8qBmNj9c0VvgLB4mrsLIo6eb5imAX3Dl6ZwjPHVMltouAmCboeJjjWYyPLO
         4o3mqK1q49VmuW3Wg3/5RQk0Ir9Vkzk6eShuspceHwTVSl6FUN68qZUJdFZEZueDt+jW
         TVfoiRWIo7nEl0cJ7CzxQ4Z2SjrVMC1EKxWhJWp/JJxfRmiYccnaYOqbXG3a6G8x5vDI
         +KljBVQ5vslH4rDmb2q/pregRRZNHYHzijSqZWSCTgIsdaJ7wg43CwoyjPe/MAk7/Y4w
         VB3vpJCd+lGegD87gLNvwGr/bMhnC1/W83XssJoLGJfjjd9A+7og28nNUB2OQXdA/1ir
         0e6A==
X-Gm-Message-State: AOAM532Ss9MzR7UpeDJT5uhLsHqlt8/mYtinv49fGYkJ3/Ka2HdvD5JW
        x6BApHAyRw9PVIZt3lGHpCOQH5iO2frxvgmZTwA+7TfiWto=
X-Google-Smtp-Source: ABdhPJyA8nLlpSh/yt7nKBYDCcsZV8UZeFswNKf5xLX+5ClbFlRjGjVlm8FkDv3sy/sl6iRlOmFK85adta1OPjAqQfw=
X-Received: by 2002:a67:641:: with SMTP id 62mr3589999vsg.23.1615993704503;
 Wed, 17 Mar 2021 08:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210312171613.533405394@infradead.org> <20210312171653.710872453@infradead.org>
 <alpine.LSU.2.21.2103171444570.23081@pobox.suse.cz> <YFIOl/3NcnnV0jDa@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.2103171539270.23081@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2103171539270.23081@pobox.suse.cz>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 17 Mar 2021 08:08:12 -0700
Message-ID: <CABCJKue8=dvshNP=evGvSb1DEzAGd5ofzGiVS+zmDrmfdCtpRg@mail.gmail.com>
Subject: Re: [PATCH 6/9] objtool: Add elf_create_undef_symbol()
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jgross@suse.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 7:40 AM Miroslav Benes <mbenes@suse.cz> wrote:
>
> On Wed, 17 Mar 2021, Peter Zijlstra wrote:
>
> > On Wed, Mar 17, 2021 at 02:52:23PM +0100, Miroslav Benes wrote:
> >
> > > > + if (!elf_symbol_add(elf, sym, SHN_XINDEX)) {
> > > > +         WARN("elf_symbol_add");
> > > > +         return NULL;
> > > > + }
> > >
> > > SHN_XINDEX means that the extended section index is used. Above you seem
> > > to use it in the opposite sense too (assigning to shndx when shndx_data is
> > > NULL). While it makes the code easier to handle, it is a bit confusing
> > > (and maybe I am just confused now). Could you add a comment about that,
> > > please? elf_symbol_add() seems like a good place.
> >
> > Yes, that was a horrible thing to do :/ And you understood it right.
> >
> > Looking at it again, I'm not sure it is actually correct tho; shouldn't
> > elf_create_undef_symbol() also look at gelf_getsymshndx() of symtab ?
>
> Probably yes.
>
> > What toolchain generates these extended sections and how? That is, how
> > do I test this crud..
>
> Sami might know.

Clang generates these with LTO for vmlinux.o, but I'm guessing gcc
will do the same with -ffunction-sections -fdata-sections.

Sami

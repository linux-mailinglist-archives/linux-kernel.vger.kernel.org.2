Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D9366257
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 00:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhDTW7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 18:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhDTW7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:59:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DC4C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:58:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j18so63990290lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOGjcz7X/da2vlQcucDwkjw91MaUbIfF1kNjU6kRW7s=;
        b=XMVQ7EZXR/inCJQxuKY4F8FByHUlpnVPZ7gnRyiLNWQWaSYDyemG1ZI5sJqPhIkMJ/
         UbRYezePvtv65k4Jwg2X9j+UEAfUIsdB6ON8/fg8ZDc4EraaQfU0kxv60z0fmz46pmkA
         rVFcCZSGx6xSEIeqfWz9AacxIxPIcw+cdNXwE+ZXvDRe24V8OV/DgHbFO9XiMQvQVTTq
         NAh9DMs6ZsqXJsbw6ZTp3ywkd7Yrdk8WtXm9E7gDc++fqd1zCgi7uEGBt6mWlrKy6IWB
         DLX6F+uIfUfnTHubx7nKB9LGjGBZkgPw3tsY0lvsjlE0J0j0JobjVViWu50Ja1SASKQs
         C+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOGjcz7X/da2vlQcucDwkjw91MaUbIfF1kNjU6kRW7s=;
        b=ASpFLYoDaqUz6TzF0VqPgyQxBtZYLVAFVY3JS5qOC5USwEC4snnqKpaKw3k3U8ZoUx
         wtHqejRuWSJmyLPgcKNMOKUP6Y9+WPkM88XTkTAxGv/wGDuAUdbvRsNrIExuM5DbNO4h
         Eso7OBdisqJiI/Zu3bPB6/eB+HwVEZCVkbim4WEl4SfOHUK/MKyP14qCGfBWDJKZpui4
         b2bsDrTFUOb12sgM35sbP5XpUF5bv8hB+i7VFu+NgbJyKHwqpzdvW9j3ukyq2NlOaViY
         szfO7wzJMP+QwZMGGhEobNLuq+Ipz8R9UGEW82LNGePUzPVgEcNQM8TJFhNlQjhXLlxK
         OBhA==
X-Gm-Message-State: AOAM531a7V8vqNgNmEYLyubLOhknxirHX+hainuKEZZIWdNkfjA5tqY2
        XFvgDi7h90P2jGokjdOx+Ym0bfnb1j08vc4Snetf4g==
X-Google-Smtp-Source: ABdhPJzyIqxuOrpCPCAuRllbeq5EJmrg8df1lczPWk9fUaVvpChL43l8Gx1IVciMLG057dXa3AZB8bkI6kBjR0XbEuk=
X-Received: by 2002:a05:6512:985:: with SMTP id w5mr17201660lft.122.1618959527235;
 Tue, 20 Apr 2021 15:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-2-samitolvanen@google.com> <20210420181412.3g5dsyhggxnvif7k@treble>
 <CABCJKudO9Ovuih3ieQ70w8y744Cg3tPnciVBhCuuBPuhq4i3Xg@mail.gmail.com> <20210420225550.szbmrpwv6awd7tp5@treble>
In-Reply-To: <20210420225550.szbmrpwv6awd7tp5@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 20 Apr 2021 15:58:35 -0700
Message-ID: <CAKwvOdkOu4RSw9fwr_qdh7VLHjGD4nLjMZMZxzvpJUqjsWFBww@mail.gmail.com>
Subject: Re: [PATCH 01/15] objtool: Find a destination for jumps beyond the
 section end
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 3:57 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Apr 20, 2021 at 01:25:43PM -0700, Sami Tolvanen wrote:
> > On Tue, Apr 20, 2021 at 11:14 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Fri, Apr 16, 2021 at 01:38:30PM -0700, Sami Tolvanen wrote:
> > > > With -ffunction-sections, Clang can generate a jump beyond the end of
> > > > a section when the section ends in an unreachable instruction.
> > >
> > > Why?  Can you show an example?
> >
> > Here's the warning I'm seeing when building allyesconfig + CFI:
> >
> > vmlinux.o: warning: objtool:
> > rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c()+0x149:
> > can't find jump dest instruction at
> > .text.rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c+0x7dc
> >
> > $ objdump -d -r -j
> > .text.rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c
> > vmlinux.o
> > 0000000000000000 <rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c>:
> >   ...
> >  149:   0f 85 8d 06 00 00       jne    7dc <.compoundliteral.4>
> >   ...
> >  7d7:   e8 00 00 00 00          callq  7dc <.compoundliteral.4>
> >                         7d8: R_X86_64_PLT32     __stack_chk_fail-0x4
>
> Instead of silencing the warning by faking the jump destination, I'd
> rather improve the warning to something like
>
>   "warning: rockchip_spi_transfer_one() falls through to the next function"
>
> which is what we normally do in this type of situation.
>
> It may be caused by UB, or a compiler bug, but either way we should
> figure out the root cause.

We probably want to creduce or cvise this.  IIRC we still have
outstanding issues with switch statements with user-annotated
unreachable branches not getting eliminated.
-- 
Thanks,
~Nick Desaulniers

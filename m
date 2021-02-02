Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45530CD3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhBBUoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:44:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhBBUo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:44:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24C8C64F63
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 20:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612298628;
        bh=C758amp0xx3sY5RjoNv3le/Ko06xDS7qmJebQl2RiNk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W300S55LNj+RJLZgoqx0RWXZxCutGak1+C99RR18/6hvCgLO5GOm6Zzi4/JbWQgT/
         nEurxnvwOMppfL9Lpyj/wHis2LhZOWBDR7al64BpkVY0GXUKDfEPcUxXw8mZz6RaF3
         MyKBNazE25KODOvvLyup/yOojHwg7nvJMmzUg7tRuo+ip0hnT9xyTIP9YVfwS+S4Ck
         VN92PsNLontujd7tdWVl8zJLTUjtshKRaUna88U6RhlSzpwvGBfnQVpf3VSwK/2oLg
         qmq5AY2rY6RBgRvaY45SODACMGMu7BRN0fs0G5SiWlz7L7rRQgLRmI5+bx3mQYykS9
         Lj7pAr2DiOitQ==
Received: by mail-oi1-f181.google.com with SMTP id h192so24291086oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 12:43:48 -0800 (PST)
X-Gm-Message-State: AOAM5308YBW/HntK4ey3oUGif15+18lylQTuyIWhWOIKMYID0l6eEGAT
        sUknD3smbf0K8G8Bjf4chaXUw5pV5Tk5UgyJ+Pc=
X-Google-Smtp-Source: ABdhPJxfwhc6Pjqrs1N5mvKP75S8F56Z+dEzlWMrb+8Vl4HNeMN4b5XWdYrfo4ESObRr6ztE3iCcUWuFdiBVnZypyVs=
X-Received: by 2002:aca:e103:: with SMTP id y3mr3960496oig.11.1612298627404;
 Tue, 02 Feb 2021 12:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20210202022441.1451389-1-nathan@kernel.org> <CAK8P3a2864oSVkhaYynoadyYMcYDh0LvDDFSJ2D8OTHSszuSQA@mail.gmail.com>
 <20210202195133.GA1481999@localhost>
In-Reply-To: <20210202195133.GA1481999@localhost>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 2 Feb 2021 21:43:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a19W2ejs8mtHrf6Nd6BVG8u5fM4BZB+neVEWdOmGCbLbw@mail.gmail.com>
Message-ID: <CAK8P3a19W2ejs8mtHrf6Nd6BVG8u5fM4BZB+neVEWdOmGCbLbw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Make CPU_BIG_ENDIAN depend on !LD_IS_LLD
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Smith <Peter.Smith@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 8:51 PM Nathan Chancellor <nathan@kernel.org> wrote:
> On Tue, Feb 02, 2021 at 09:04:34AM +0100, Arnd Bergmann wrote:
> > On Tue, Feb 2, 2021 at 3:25 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Similar to commit 28187dc8ebd9 ("ARM: 9025/1: Kconfig: CPU_BIG_ENDIAN
> > > depends on !LD_IS_LLD"), ld.lld does not support aarch64 big endian,
> > > leading to the following build error when CONFIG_CPU_BIG_ENDIAN is
> > > selected:
> > >
> > > ld.lld: error: unknown emulation: aarch64linuxb
> >
> > While this is the original error message I reported, I think it would be
> > better to explain that lld actually does support linking big-endian
> > kernels but they don't boot, for unknown reasons.
>
> That statement seems to contradict what Peter Smith says:
>
> https://github.com/ClangBuiltLinux/linux/issues/1288#issuecomment-770693582
>
> https://reviews.llvm.org/D58655#1410282

Right, adding Peter to Cc for clarification. Peter, what I can tell from
experiments is that lld behaves just you describe it should, and (aside from
the command like flag handling) like ld.bfd, so I'm not sure if there are
any known deficiencies or just minor bugs when dealing with the kernel.

FWIW, I have now built a big-endian musl C library and a helloworld
binary, which I linked with ld.lld and successfully tested using
qemu-aarch64_be-static

      Arnd

> > I can send a patch to address the build error and mark big-endian
> > as "depends on !LD_IS_LLD || COMPILE_TEST" to reflect that
> > and help with randconfig testing.
>
> I have no strong opinion on handling this though.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7F142451D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbhJFRrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhJFRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:47:45 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD04C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:45:53 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id s4so7243088ybs.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymHLGH0Raq7ZmGFbhtXmAYW4w7KWD4EjLyVclCp4QNk=;
        b=FDtgJKC2yf2w+mH0oA+D57k3nx54eAv/j4VPf/geQ25vy2h5bs5gGf0Yl1iswCf1br
         twAlku9c9HaQSksJSdqaGILpkNO3VsxHP9T1pKiFZm1xd81utR7KiW1+TbdnVFM9dzpv
         8MoBpvwGcgoktnH8xTxKJKbmy6W3EpmN8/refTKp/q1c/VYBmgAmlELHwB6dYPrGl42f
         EK8d99G65Tdvk9Jmz13SG4Pw3nOYOepqAVXVBjNnwjzcGQfYX7qjEKWCQW1sl81JGpj/
         wPwKz8QCcOlukoAR89S4zRJYHYvhB8UdTQ37d5TO0bIL21axXkguID2Igqxbg/MNVIs/
         eROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymHLGH0Raq7ZmGFbhtXmAYW4w7KWD4EjLyVclCp4QNk=;
        b=LHNTOU6kw0Y7YLqtRpsSjgwBGwgWajHQNRwuf3XgppUYaYPCEEKPCDBcH4GMQ3cRZy
         DI9QDyiOnexZwunVrDEzM6kKyxm8Pmx9hBjwi5dDlLz6cREuaZqQlzLILlHg6Bb5TJK9
         sNj2jPn5tUyU8Wi19gcLfEVOehcZIafJuOT65QDTKHsJFSOq3Zl7Uo1rmqOmSr1XFD/d
         eGhowmtmiMhcvlUI2zjaCt/4x8kEZmckXHMaiBD8IvF0RkNqPQS/MhgT4z2N/bAzBxb4
         G7F7wsE6MhyuLRM5wtbIktyy02A7zxBkag3Fm5M6UtN5T/YDc+4Lk0Q2EEHUfBBr2b0K
         4sFw==
X-Gm-Message-State: AOAM532UCqH41M9lVUIdZQgRRnZARHL+MKUk8zcQbjyBRCgTGk+zUadG
        XDbipqAt1i8G2GHNY1LdRMeQ6viV0HHSIoXJfWkKWQ==
X-Google-Smtp-Source: ABdhPJx/PRDppXa0Kq84b+6Rsz/D47+Ohg3rhbB34IFTWREHPFR3I/tnnF4mNhbpL2vllEq5+bhlJ18BTkRVcOXB5SQ=
X-Received: by 2002:a5b:286:: with SMTP id x6mr30426375ybl.59.1633542352526;
 Wed, 06 Oct 2021 10:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com> <20211006032945.axlqh3vehgar6adr@treble>
 <20211006090249.248c65b0@gandalf.local.home> <CABCJKueL4Ebaan=JBUyO3oewq7RTHHXWUQpixgf2AfC_r5T3uA@mail.gmail.com>
 <20211006125809.5389b2a3@gandalf.local.home>
In-Reply-To: <20211006125809.5389b2a3@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 6 Oct 2021 10:45:41 -0700
Message-ID: <CABCJKudTuheEd5jyhXmfJHup7iYzOz3_OcO92hFnpRK1MapJSg@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 9:58 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 6 Oct 2021 09:31:04 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > > > On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> > > > > With CONFIG_CFI_CLANG, the compiler changes function references to point
> > > > > to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> > > > > are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.
> > >
> > > "not called from C" is a bit confusing.
> >
> > Any thoughts on how to make this less confusing?
>
>  "Not called by C code, but injected by the compiler."
>
> ?

Sure, sounds good to me. I'll update this in v5.

Sami

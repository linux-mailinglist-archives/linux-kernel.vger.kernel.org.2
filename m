Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84793A382B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFKABu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:01:50 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:39754 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhFKABt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:01:49 -0400
Received: by mail-lf1-f50.google.com with SMTP id p17so5867527lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdzmpvxIHQS1W3CohDEjykDRb5EPbprGAP1bkcs3yG0=;
        b=gEehPI7l2bdPrZJbd0I3pKQCTqAScA4Fwf8tuzbYqi7cRQAgbKbDCByEj7mitLP3LK
         QGoCxjEQhGw/iHvVKe7eYOrSLWW/Gt0tm+m+IfmwiIUSDDix3BPxQsd5zWCDSqls5kBv
         6QDU5ovM/UfPQSvnYn97RH4LHMwQXsP28+x1fIP63pgW2Jv8sRcLTNfGIjXVyDmTAyv/
         7OyInTYc+9Iq+hWhmxXbg/qr5sPVjWypv/x18ot7yHX6e3AVsS5/TF5r5Zbh6Paarh+T
         zbNvGz5vLMwfrKxTv3UiyW3D7w234VEnoI3Xtr3gOSkcewodwAN+T37yjoceQePEkZde
         aliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdzmpvxIHQS1W3CohDEjykDRb5EPbprGAP1bkcs3yG0=;
        b=fTMey17TXmliqLPguwrMVKDBb5QePVgt0ha4qzDYZLgtB35VlYAGdmIq3/kEwash0C
         OoCaCIQeYsO4xaWznmzuf1Ld2CLreEMqn/zKxgZ4Rp+5fgC9/RHAji46GS4UB5X2ZWW8
         rAABjFC0qjIIHgIQMogx5OXAZhfjQQVjC0ZeadwEWJIYLli4n4+MUSXxyXrILk0hvw5z
         53Et9njs20Zim9/SLRcITIuKNCM3EpYi6riHILwqm5N3xCmbSS0KkWXk/CY2I3vI1HAU
         edB6kT/6DxSyXkzF4/bhdCaOYyd8tyLj/0qS2WBWwckcVQt1a1VtCOl79gQouYPeCjPf
         YO7w==
X-Gm-Message-State: AOAM530XYYv3Q8b0RPe8+QRC9lPaMvI45cFGeQ8c0hXFJjyy9WgLn3Qq
        tHCFCHpLyfEGWZpbdTNz2LdARiQz5Pe5sv45352NlQ==
X-Google-Smtp-Source: ABdhPJyWQzBImOPb3uiVTuLa/7Wvl03W1dSo3MeJvR63xVQQGwa0uuXqweTwSV4F1qWSG96FpAo+h0N7zJlHb9NSh5U=
X-Received: by 2002:a19:f706:: with SMTP id z6mr806137lfe.122.1623369515416;
 Thu, 10 Jun 2021 16:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <f2c018ee-5999-741e-58d4-e482d5246067@mailbox.org>
 <162336538453.1311648.12615336165738957417.b4-ty@chromium.org>
 <CAKwvOdmYVH-YpEVqdoBfvgNfcbzx71jU_27cuhuzTJ6_Emzi-g@mail.gmail.com> <202106101601.248F797@keescook>
In-Reply-To: <202106101601.248F797@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Jun 2021 16:58:24 -0700
Message-ID: <CAKwvOdntX7iKNZWr1gfnR-N=11sg0CH7+EjzyaQg5t+Erc6qrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/Makefile: make -stack-alignment conditional on
 LLD < 13.0.0
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Tor Vic <torvic9@mailbox.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 4:47 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 10, 2021 at 03:58:57PM -0700, Nick Desaulniers wrote:
> > On Thu, Jun 10, 2021 at 3:50 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, 10 Jun 2021 20:58:06 +0000, Tor Vic wrote:
> > > > Since LLVM commit 3787ee4, the '-stack-alignment' flag has been dropped
> > > > [1], leading to the following error message when building a LTO kernel
> > > > with Clang-13 and LLD-13:
> > > >
> > > >     ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument
> > > >     '-stack-alignment=8'.  Try 'ld.lld --help'
> > > >     ld.lld: Did you mean '--stackrealign=8'?
> > > >
> > > > [...]
> > >
> > > Applied to for-next/clang/features, thanks!
> > >
> > > [1/1] x86/Makefile: make -stack-alignment conditional on LLD < 13.0.0
> > >       https://git.kernel.org/kees/c/e6c00f0b33ad
> >
> > Can we get this into 5.13?
>
> What's the ETA on LLVM 13.0? I was going to put this in -next, marked
> for stable, but we're about 3 weeks from 5.14 merge window.

Not soon; CI is red over this currently:
mainline:
https://github.com/ClangBuiltLinux/continuous-integration2/runs/2796736763?check_suite_focus=true
https://github.com/ClangBuiltLinux/continuous-integration2/runs/2796736978?check_suite_focus=true
linux-next:
https://github.com/ClangBuiltLinux/continuous-integration2/runs/2791754316?check_suite_focus=true
https://github.com/ClangBuiltLinux/continuous-integration2/runs/2791754426?check_suite_focus=true
https://github.com/ClangBuiltLinux/continuous-integration2/runs/2792796551?check_suite_focus=true
etc
-- 
Thanks,
~Nick Desaulniers

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3822A3A4891
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhFKSZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFKSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:25:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:23:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g4so6177623pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gPvk2gIqJbRWWZhdwlS/o0WDDqwCDh7fOG8Z0IBiq2E=;
        b=BVIc2jhVwfPS9kXJvh9Q7fQm96emAN+Q8IDjOJ3wUZVR+9RbQElnvDtZ4wJbRQegJH
         BaG1f+Cf7mlFkp0r9wJrNqup8GHmSMPrqHar81JPm/O38Oz75RBMx9fYhZUuFQ8WRpCY
         CVkX2yUv9qXUs+JreoHzSHeRRxt4vae3qjhPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gPvk2gIqJbRWWZhdwlS/o0WDDqwCDh7fOG8Z0IBiq2E=;
        b=QR0yxAj31O4kLnnVVGzL61HhbMzW8x5GD9xPTtGnwg4LsviYh4Tfu05NbVa8en5EVm
         /YXVhPhvaJ0nl2boTvrHr8xdRj9zwgPy6BlKD9Rghg0jhHsXIuFBGoX6iDu5AGECF9Yj
         w51fGbmQz+IiEIZEZupye3LFqbGC2GD5dn5q5zaT1B+r5bZ39SlbpN9QpaaO6PVZ7dX/
         a15YyQBg6AbCZWNQej+itYCW+tE6cg/p7fZw8WZIWuCyXcyS8wtpvjxpTEN9DtKZA4ON
         sUdG1yF45ENoCSHNwPF9oyd8SGy+rEGEc771o/rLi7mVLwWx3eRbDnYrnQDaFON3aFLE
         8TfQ==
X-Gm-Message-State: AOAM533fsTe8K5XrK561HU/F2SpgCDj6BSF9w1VOCJVfvMy9ER5JwrkN
        9OuozkI1PqTH/Tyt/dEY3mhiQw==
X-Google-Smtp-Source: ABdhPJzjHciLkVRda4986rGAso68livpiNfbdSmKZ4lk0aYBkMhv9RQ1CVHUJZPivaevTm7KjYVZqQ==
X-Received: by 2002:a17:902:8a98:b029:f9:36dc:37cd with SMTP id p24-20020a1709028a98b02900f936dc37cdmr4980036plo.68.1623435796718;
        Fri, 11 Jun 2021 11:23:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h12sm5739488pfh.9.2021.06.11.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:23:16 -0700 (PDT)
Date:   Fri, 11 Jun 2021 11:23:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Tor Vic <torvic9@mailbox.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2 1/1] x86/Makefile: make -stack-alignment conditional
 on LLD < 13.0.0
Message-ID: <202106111123.20036BB@keescook>
References: <f2c018ee-5999-741e-58d4-e482d5246067@mailbox.org>
 <162336538453.1311648.12615336165738957417.b4-ty@chromium.org>
 <CAKwvOdmYVH-YpEVqdoBfvgNfcbzx71jU_27cuhuzTJ6_Emzi-g@mail.gmail.com>
 <202106101601.248F797@keescook>
 <CAKwvOdntX7iKNZWr1gfnR-N=11sg0CH7+EjzyaQg5t+Erc6qrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdntX7iKNZWr1gfnR-N=11sg0CH7+EjzyaQg5t+Erc6qrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 04:58:24PM -0700, Nick Desaulniers wrote:
> On Thu, Jun 10, 2021 at 4:47 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jun 10, 2021 at 03:58:57PM -0700, Nick Desaulniers wrote:
> > > On Thu, Jun 10, 2021 at 3:50 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Thu, 10 Jun 2021 20:58:06 +0000, Tor Vic wrote:
> > > > > Since LLVM commit 3787ee4, the '-stack-alignment' flag has been dropped
> > > > > [1], leading to the following error message when building a LTO kernel
> > > > > with Clang-13 and LLD-13:
> > > > >
> > > > >     ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument
> > > > >     '-stack-alignment=8'.  Try 'ld.lld --help'
> > > > >     ld.lld: Did you mean '--stackrealign=8'?
> > > > >
> > > > > [...]
> > > >
> > > > Applied to for-next/clang/features, thanks!
> > > >
> > > > [1/1] x86/Makefile: make -stack-alignment conditional on LLD < 13.0.0
> > > >       https://git.kernel.org/kees/c/e6c00f0b33ad
> > >
> > > Can we get this into 5.13?
> >
> > What's the ETA on LLVM 13.0? I was going to put this in -next, marked
> > for stable, but we're about 3 weeks from 5.14 merge window.
> 
> Not soon; CI is red over this currently:
> mainline:
> https://github.com/ClangBuiltLinux/continuous-integration2/runs/2796736763?check_suite_focus=true
> https://github.com/ClangBuiltLinux/continuous-integration2/runs/2796736978?check_suite_focus=true
> linux-next:
> https://github.com/ClangBuiltLinux/continuous-integration2/runs/2791754316?check_suite_focus=true
> https://github.com/ClangBuiltLinux/continuous-integration2/runs/2791754426?check_suite_focus=true
> https://github.com/ClangBuiltLinux/continuous-integration2/runs/2792796551?check_suite_focus=true
> etc

Fair enough. Pull request sent to Linus...

-- 
Kees Cook

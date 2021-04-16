Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC46C362AED
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhDPWRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbhDPWRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:17:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D531C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:16:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y32so20099291pga.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HqXM3kMLEn96G3/nALKZvPIkVzBlUz9VyGBmJqc5JzE=;
        b=lcOphGXHxVCzzELzDBN2FJM2bizris3iFcQmVQ2GqUkS1yorPWLL0S4SG4QBEsW18l
         eSOeuRXOZFGM9Z9QTHb3Uae3bi6Mr8u73uIPz8YeDbYhragANRApSsFT9csLi05M26wd
         jwZqdXOVrcpkGtBg3WTqwQ7lM3gMoKb/q6rp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HqXM3kMLEn96G3/nALKZvPIkVzBlUz9VyGBmJqc5JzE=;
        b=LMO3mwVPluqeEpmu8Vh1a9d3nFewkwO3zVSlE2hU+mh216uLmVVFh+SUWMCl+RPqaS
         xwO82DnR7QsYe71twc4VrJs67Yc18UDVLUyFlowHLKqBPPFT9oEzoHtsGKVJ1Y0C9Xmo
         1C1WotR56TcFwXsXKbbWDbgSNJ86aBYXFd7yNyvZ2OjWPctb/NfcVG+hfAHpffl3KJ8s
         CDb1JaEV9TKby3f/ON6qfD5TbWuot9djOJzOo+UFJg0Eb/DNszF0BslpCvP1IUVVtdPv
         biCmf02ZvfPWLwrS6/lAm53MK0Tx288FOdQhywP9ngkGQrM9uoSxLQGelPh9Nzke+6k1
         2aKQ==
X-Gm-Message-State: AOAM5314IJppP/gCIwkp48Gljnd4X8nDVjCdDhKmWFHzUW/wLGg88ZL1
        aJ9QHB9QUtt4J7JDLcsC8hAQ2w==
X-Google-Smtp-Source: ABdhPJyTF6kQ8JbHU2sTJfChuDMV2VYbOvwyfQkZHaqve9IUtoTyWH+s35e1EgMlgafiLbYbMJaGOg==
X-Received: by 2002:aa7:8d44:0:b029:244:a363:dd57 with SMTP id s4-20020aa78d440000b0290244a363dd57mr9504822pfe.8.1618611401923;
        Fri, 16 Apr 2021 15:16:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s6sm5697805pfw.96.2021.04.16.15.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:16:41 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:16:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
Message-ID: <202104161510.246509CE@keescook>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
 <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416220251.GE22348@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 12:02:51AM +0200, Borislav Petkov wrote:
> On Fri, Apr 16, 2021 at 02:49:23PM -0700, Sami Tolvanen wrote:
> > __nocfi only disables CFI checking in a function, the compiler still
> > changes function addresses to point to the CFI jump table, which is
> > why we need function_nocfi().
> 
> So call it __func_addr() or get_function_addr() or so, so that at least
> it is clear what this does.

FWIW, it's been renamed already. I'll CC Mark back into the thread.
https://lore.kernel.org/lkml/20210325101655.GB36570@C02TD0UTHF1T.local/

> Also, am I going to get a steady stream of patches adding that wrapper
> to function names or is this it? IOW, have you built an allyesconfig to
> see how many locations need touching?

Nooo. Much like __nocfi, this should be extremely rare and is only used in
places that must not be doing CFI nor working on the jump tables (e.g. the
syscall MSR). There list for arm64 in -next, for example, is short:


429d9a552e81 arm64: ftrace: use function_nocfi for ftrace_call
fbcdf27674bc arm64: add __nocfi to __apply_alternatives
f2324191e959 arm64: add __nocfi to functions that jump to a physical address
c4a384170f17 arm64: use function_nocfi with __pa_symbol
5198a15901d2 psci: use function_nocfi for cpu_resume
8e284f3ebed2 bpf: disable CFI in dispatcher functions


-- 
Kees Cook

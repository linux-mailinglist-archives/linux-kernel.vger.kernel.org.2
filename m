Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62A930D9C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhBCMZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhBCMZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:25:44 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E6C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:25:04 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id s24so13419890iob.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+ecq5c6sKY7cd84EJlpB3NzNUMYGSZy8yjUqdXmsGQc=;
        b=p75PQK9GGEOh4pW2G5B8+7Rk73r0cBe+dKp/NlAR0yz+En355JUs6gZeiAUaDuPJTd
         DLdNmuox9J5vejEw5kPW4KAcPYsve+la1y0mdyQM6OQatSeZtcwDXIB5hZcEJueVI9bK
         95ngQXKL/TsJmFuWpoEAUNIycEdcBjObrOwswKjTcwFEKhwpBOsBX52GtAu+kZuuO+Ir
         9vNC/M3mPhPt0e1/kEtI+IMQtSdbX93SdfIWBG+F0FJMbYBs8tjiyF7iV762+A2cuMTJ
         UOu8nTibErvnC19tmrE6bhR1EpdE0lbIrE8K30ZPMYzSJIHaIMWQz4a8S7lcoQp57FpT
         /EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+ecq5c6sKY7cd84EJlpB3NzNUMYGSZy8yjUqdXmsGQc=;
        b=RuIelr7VbQhjuhDgfND4KPA0JiNAi7/C7UhHF781Lh1ChVOHQ2AC4FVHNkTxFMZ0Sy
         BgiWIXj66jIPvTiN15P9W1tEUFo1kX7MLtBr2thTqnxfGF3GSntgQChcwwtirniXbk3e
         T3zm/caElKOdUvBJJWlqRDwNaakmAxpu3fp1a1GhcCrU3ak0iuuqmk8Us5teBjQFJydH
         C3xNyiNgZYSaytRKgpMytO8P5wHophrKApmhQMw0VhNaZrv0rRyESsbZLZ6Cp03iztGX
         barB7LISv/09CdYICONGyBSKo8XOawFV4XIzWhOaI8mUejPV4suVPb9I1f9wY/3D5YhZ
         Npag==
X-Gm-Message-State: AOAM533Fmwcyd6b3+VNMtXrml/OepL7z+SKZCpvYHBuakBCJtN2yFTnD
        8IW8krOT4ISdQatyTyv6291LXLFR9v/oZBnw/Mg=
X-Google-Smtp-Source: ABdhPJwLhGiz5yl1IexB3HlY0MlbVG9S2IOjl4sESkSNa24OHvCaSDuKmN63cDto4FrAYeLA7+aGjeJEtr3MlJmRfqE=
X-Received: by 2002:a05:6602:1541:: with SMTP id h1mr2108852iow.171.1612355103342;
 Wed, 03 Feb 2021 04:25:03 -0800 (PST)
MIME-Version: 1.0
References: <cceb074c-861c-d716-5e19-834a8492f245@gmail.com>
 <37DE7046-5096-4C0C-A96D-FD168A849DFD@zytor.com> <20201226075347.GA1977841@ubuntu-m3-large-x86>
 <3b793c42-8983-4502-1f9e-729cc0ebec47@gmail.com> <20210203121934.GC13819@zn.tnic>
In-Reply-To: <20210203121934.GC13819@zn.tnic>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 3 Feb 2021 13:24:51 +0100
Message-ID: <CA+icZUVgRa__hFCGr8P1Q_EKREDg6hd2K3gDWwJsbO7h0KZYBA@mail.gmail.com>
Subject: Re: [PATCH v2] arch/x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
To:     Borislav Petkov <bp@alien8.de>
Cc:     John Millikin <jmillikin@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        John Millikin <john@john-millikin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 1:19 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Dec 26, 2020 at 05:41:25PM +0900, John Millikin wrote:
> > When cross-compiling with Clang, the `$(CLANG_FLAGS)' variable
> > contains additional flags needed to build C and assembly sources
> > for the target platform. Normally this variable is automatically
> > included in `$(KBUILD_CFLAGS)' by via the top-level Makefile.
> >
> > The x86 real-mode makefile builds `$(REALMODE_CFLAGS)' from a
> > plain assignment and therefore drops the Clang flags. This causes
> > Clang to not recognize x86-specific assembler directives:
> >
> >   arch/x86/realmode/rm/header.S:36:1: error: unknown directive
> >   .type real_mode_header STT_OBJECT ; .size real_mode_header, .-real_mode_header
> >   ^
> >
> > Explicit propagation of `$(CLANG_FLAGS)' to `$(REALMODE_CFLAGS)',
> > which is inherited by real-mode make rules, fixes cross-compilation
> > with Clang for x86 targets.
> >
> > Relevant flags:
> >
> > * `--target' sets the target architecture when cross-compiling. This
> >   flag must be set for both compilation and assembly (`KBUILD_AFLAGS')
> >   to support architecture-specific assembler directives.
> >
> > * `-no-integrated-as' tells clang to assemble with GNU Assembler
> >   instead of its built-in LLVM assembler. This flag is set by default
> >   unless `LLVM_IAS=1' is set, because the LLVM assembler can't yet
> >   parse certain GNU extensions.
> >
> > Signed-off-by: John Millikin <john@john-millikin.com>
> > ---
> > Changes in v2:
> >   - Reworded the commit message to highlight that this is for
> >     cross-compilation.
> >   - Removed the `ifdef CONFIG_CC_IS_CLANG' guard.
> >
> >  arch/x86/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 7116da3980be..412b849063ec 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -33,6 +33,7 @@ REALMODE_CFLAGS += -ffreestanding
> >  REALMODE_CFLAGS += -fno-stack-protector
>
> This one too:
>
> checking file arch/x86/Makefile
> patch: **** malformed patch at line 62:  REALMODE_CFLAGS += -fno-stack-protector
>

I needed to touch this as it was "malformed" and did not apply cleanly.

If it is not too late, feel free to add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

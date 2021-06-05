Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1D39C78E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 12:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFEKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 06:53:34 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:34712 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhFEKxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 06:53:33 -0400
Received: by mail-qt1-f175.google.com with SMTP id u20so744177qtx.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 03:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version:date
         :message-id;
        bh=AAjK4RnrixesQdsO5w2Wdh9utWEzsYLWg7tqEzuFSmY=;
        b=N/Slh0TetcKjwO2WeBYGTZdg0GBXeo6pGPJZPy2nTmvBK96Ir8hF7Ydujt8g5woTtf
         4pk4ZoCuWtZdEC06Q3J/V0UYF91j8mdLc1KELc2/DI0mMUDEzBT3v2z2VtbMs9NWDsTz
         wCj+4SWWZ3SSSo6hqGUcU2HgrQdY/kvuc7tUacf9uBesC3w0tVv53iPNW5sx05cohC82
         FyBNQXVSXTqn9I1EKb89Sus1v2Q/asFhrNbKwgXAIh4IkqsuaReXXK9v5fpnDahYSzu5
         OI64yZN045dOB/fFXfBea/mGklbYPRo7qy6WagAOrS9MoQa+fuxxx7TNazoih+Ji3a1c
         XcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=AAjK4RnrixesQdsO5w2Wdh9utWEzsYLWg7tqEzuFSmY=;
        b=tIjKdv5Tc0Vv2eB05lVRdAHDWdU1K3TCVu8nlQzfM8sSshKXUv6yWnVvsMMDvRTVuE
         vHpnLYri612H4m5B57UGUTvP1qdN5B9UKYukZXslVXdsJ6Cq803/w5+jndkOlxLNgZdo
         9Zz8dn+jSpq1mv5Bl9aAe4H4WpZnExv4M7kGWa0MICuGlylNCQC1cwKo3MkQZtuK8b/+
         AgLYQeQtTrUQ7m/c5i0343k1G5U/rjIwa3BytCJ8TLEIlTRwfLzqffcRfOb0KtXPGzog
         QpA7FNqXInGNtU/qaty9iAd6fwQyAQO0m3gDwypeLnTauBt9rz49qBPknZ8jWpl2sWDt
         O91Q==
X-Gm-Message-State: AOAM533byHVHDATrDs2trnRgmiwMhDwwro4u0Hztb+TMkbGsWHV4w+K4
        3lGfo8FdSVEZ2G8I469o9mzTVA==
X-Google-Smtp-Source: ABdhPJw7ITgbKAZiX/Yjx/Q+n4jSnFEYrSMa7CyvmsZRWFonxJG330U5aJTmqGC5O6F9VXYjBwtsvQ==
X-Received: by 2002:a05:622a:588:: with SMTP id c8mr8325520qtb.49.1622890245288;
        Sat, 05 Jun 2021 03:50:45 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id j197sm5599108qke.73.2021.06.05.03.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 03:50:44 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Masahiro Yamada <masahiroy@kernel.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: x86 - weird cross-compile build problem with try-run next-20210602
In-reply-to: <CAK7LNATbWnduSfqehJ7yMjxCbkrM87aojDCdQ79J+kXiTaZ-fQ@mail.gmail.com>
References: <454425.1622838810@turing-police>
 <CAK7LNATbWnduSfqehJ7yMjxCbkrM87aojDCdQ79J+kXiTaZ-fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 05 Jun 2021 06:50:43 -0400
Message-ID: <602426.1622890243@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jun 2021 17:19:30 +0900, Masahiro Yamada said:

> > Anybody have a clue why $(x32_ld_ok)  is null rather than 'y' or 'n'?
>
>
> What command did you run?
>
> I see this warning message for 'make install' for example.
>
> $ make install
> arch/x86/Makefile:148: CONFIG_X86_X32 enabled but no binutils support

> Please add one more debug line:
>   $(warning need-compiler is +$(need-compiler)+)
> and what will you get?
>
Bingo.

arch/x86/Makefile:143: need-compiler is ++ x32_ld_ok is ++ with CC=(.... same as before)

And it was hitting on a 'make kernelrelease'

805b2e1d427aa (Masahiro Yamada          2021-02-28 15:10:28 +0900  275) # is an exception where build artifacts may be updated. This must be fixed.
805b2e1d427aa (Masahiro Yamada          2021-02-28 15:10:28 +0900  276) no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
805b2e1d427aa (Masahiro Yamada          2021-02-28 15:10:28 +0900  277)                         headers_install modules_install kernelrelease image_name
993bdde945478 (Masahiro Yamada          2021-02-28 15:10:25 +0900  278) no-sync-config-targets := $(no-dot-config-targets) %install kernelrelease \

I suspect it's this:

 # Include this also for config targets because some architectures need
 # cc-cross-prefix to determine CROSS_COMPILE.
+ifdef need-compiler
 include $(srctree)/scripts/Makefile.compiler
+endif

and as a result, try-run isn't defined when we get into the ifdef CONFIG_X86_32
chunk in arch/x86/Makefile, which silently fails and returns a null.   I added
more debugging to double-check...

ifdef CONFIG_X86_X32
        x32_ld_ok := $(call try-run,\
                        /bin/echo -e '1: .quad 1b' | \ 
                        $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" - && \
                        $(OBJCOPY) -O elf32-x86-64 "$$TMP" "$$TMP.o" && \
                        $(LD) -m elf32_x86_64 "$$TMP.o" -o "$$TMP",y,n)
 $(warning need-compiler is +$(need-compiler)+ x32_ld_ok is +$(x32_ld_ok)+ with CC=$(CC) $(KBUILD_AFLAGS) OBJ=$(OBJCOPY) LD=$(LD) )
 foo := $(call wombats-r-us )
 $(warning foo is +$(foo)+ )
        ifeq ($(x32_ld_ok),y)

and that gets:

/usr/src/linux-next/arch/x86/Makefile:143: need-compiler is ++ x32_ld_ok is ++ with CC=x86_64-unknown-linux-gnu-gcc -D__ASSEMBLY__ -fno-PIE -m64 OBJ=x86_64-unknown-linux-gnu-objcopy LD=x86_64-unknown-linux-gnu-ld 
/usr/src/linux-next/arch/x86/Makefile:145: foo is ++ 
/usr/src/linux-next/arch/x86/Makefile:151: CONFIG_X86_X32 enabled but no binutils support

So the call to the undefined 'wombats-r-us' fails silently and returns a null..
and try-run is also failing silently the same way because it's not defined either.

There's only a few uses of try-run outside Makefile.compiler, and it looks like
x32_ld_ok is the only place where Makefile logic changes based on what try-run
returns (the rest just change compiler flags).

Havings said that, I'm not sure what the proper fix is. Move try-run out of Makefile.compiler?

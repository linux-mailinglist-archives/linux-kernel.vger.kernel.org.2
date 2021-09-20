Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7015A410ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 05:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhITD10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 23:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhITD1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 23:27:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3586CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 20:25:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v5so55103619edc.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 20:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UyH5g5gkFhjfVaHvBZg29/bQ5+iZMioda5dgko5wWww=;
        b=ABbKko9j85x/YUs90ogi9RG63IqPMr8E+uMYqkFJ+13BuBWvIswedX7TV9bIXF6u9w
         OugSTSE8hxhXSlbEkTwG0BCKPnCmxfWEnVPq4zLBTJC8Dg7Oq2OG2XGWd/pnGDRCEeuS
         CBTpuoFFJm7qIlDQSPp5rwByYnpWMQeA/0fegw/2cAW8/p+vapn9fTE5mT8+g4OCsNDG
         gM41/9KSUQ+rcFG/OHRYfUzo/fc9+3uSgPi2XJnox2OI69M1Cylozniq7EoGSbRnJJOd
         cG0jyj6hTRuGwKfqEn0JgS75zUJY2lL/hQXYZ7AvQbLjRO7LKxwatWyUySc0lcbPez9c
         KMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UyH5g5gkFhjfVaHvBZg29/bQ5+iZMioda5dgko5wWww=;
        b=NWpnhLu/cU2PCdw/ZuYNfFL9RN84DvbLTJK1tJqH3olQ9LOk5+Dlmr9Hdy12vTaln3
         BGnCnOhzHqdu+w5sxwn8BoCebAiJAoL2hzkN5qLhTjpEb+nxlD6Hw/WaW3DTnrR7Xuhr
         bJ9W5ioTBqN05SxI8puIhNE2PGPJ85PGP9X4V+7Y4K5xmzmr2SA2m/hNZd/dkSOAb228
         eI0chdqE07tfFyFWykrMYj9QpU1ihB/cM3r3GcSngUn9FZzR0I8Ipo+BGEJDmelb4Ee8
         qtXH1PoaezcxsV4XwMBFBrlFnce08HyDfoAqmkm7fp1L+ylQreyJdIYQMn6Q6hI6R6XI
         wmmQ==
X-Gm-Message-State: AOAM533JVkzad3sjZTzPKjgl17IxtJqCv+rTAda18tjQlY6VPOiR8v0K
        Lu9Hj7sF7GmiYjBBAjVIGzMxvtB9A6RUZ+8X8RQaOw==
X-Google-Smtp-Source: ABdhPJyV03HiHdna6mVQxB3htHHWLBXXOZpWYcO4xTiGH+mgCEtdbNzQbvv7/VYXRDIejFDY+MK5FsiwgHkVW/qzTI0=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr25835157ejc.69.1632108357657;
 Sun, 19 Sep 2021 20:25:57 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 20 Sep 2021 08:55:46 +0530
Message-ID: <CA+G9fYvoyDqbCnmcVMHCO3Zxn9=FGTjyTH9u=7FT7rCz-dh6JA@mail.gmail.com>
Subject: x86_64: clang-10: <instantiation>:2:2: error: unknown use of
 instruction mnemonic without a size suffix
To:     clang-built-linux <clang-built-linux@googlegroups.com>,
        llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please ignore this email if it is already reported ]

Following build warnings/ errors noticed while building linux mainline
master branch
with clang-10 for x86_64 architecture.
But clang-11, clang-12 and clang-13 build pass.

<instantiation>:2:2: error: unknown use of instruction mnemonic
without a size suffix
 lsl %rax, %rax
 ^
<instantiation>:1:1: note: while in macro instantiation
LOAD_CPU_AND_NODE_SEG_LIMIT %rax
^
<instantiation>:2:2: note: while in macro instantiation
 GET_PERCPU_BASE %rax
 ^
/builds/linux/arch/x86/entry/entry_64.S:887:2: note: while in macro
instantiation
 SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
 ^
make[3]: *** [/builds/linux/scripts/Makefile.build:379:
arch/x86/entry/entry_64.o] Error 1
arch/x86/entry/entry_64_compat.o: warning: objtool: .entry.text+0x215:
can't find jump dest instruction at .entry.text+0x21a
make[3]: Target '__build' not remade because of errors.
make[2]: *** [/builds/linux/scripts/Makefile.build:540: arch/x86/entry] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:1868: arch/x86] Error 2


Build config:
https://builds.tuxbuild.com/1yNlOcqNwVJJje4WbGjSV4ZeBh6/config

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git_describe: v5.15-rc2
    git_ref:
    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    git_sha: e4e737bb5c170df6135a127739a9e6148ee3da82
    git_short_log: e4e737bb5c17 (\"Linux 5.15-rc2\")
    kconfig: [
        defconfig
    ],
    target_arch: x86_64
    toolchain: clang-10

steps to reproduce:
tuxmake --runtime podman --target-arch x86_64 --toolchain clang-10
--kconfig defconfig

https://builds.tuxbuild.com/1yNlOcqNwVJJje4WbGjSV4ZeBh6/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org

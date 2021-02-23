Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7677D3233EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhBWWtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhBWWdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:33:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A687FC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:32:25 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d2so2975168pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=J4NLUiRDvgyRP+Whra3ilFZ7BfX/2bWEMRphlN0RD9Q=;
        b=bvhNjopFJKIkgr+vpxnuUp3EGQ/jXgimYFPDviOd/4K2sKhG3fGfsYH+Vy9L2z+Lxp
         gL5BVGru31XlSLwNWUboizua2J99gdCnuj2mB0/hZwKAoTcevc/inrvzj8j7uxidinLN
         p3eStytmq3Ixy63YgxSgIs0+jpvIMImnFaJfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=J4NLUiRDvgyRP+Whra3ilFZ7BfX/2bWEMRphlN0RD9Q=;
        b=Jj/WduLap8qzqHlVO6jTb3ko7v7MXwtT6TbTSlUGWbPkGG8qIqZoJMOq7yok4GZL6M
         ehvPG0+gWlaobTx0KPpOt2iIMWkypL/y0ipDtDh6w2TxAE0bybMMyP9I/LJYUjpS3m3q
         TntChs11h55kV99g5Zys2DGVJURHxTNtaFu2hQA4GYT/VXdDuEJYgumO2z35G3S5HM6e
         PT1fkMQY8vzt28W9MlMu949upJURqrys9GuJhGFFex4lBZM3ZCQLPZdVgE04tnBqqEkd
         8jKWnwawWdkP6aST5D01Gptq5CSrK9xPYbt76Md9qTakpz4PAKe98FzRcjZeuYRp13rd
         3kLQ==
X-Gm-Message-State: AOAM532HrKG1LwDIe8wiRN/P1HRQ+xSjt25+CNeeO8r0C5pI5rDeQgBj
        bN1P85imzi5tPBGtDqb9jACglg==
X-Google-Smtp-Source: ABdhPJxf/LtUbjZJOToh7aIEjKWnGeY4QGqQssouAEhSTCUBFPha0mq2UZZl1dcieTveVAGXo7JbLQ==
X-Received: by 2002:a17:90a:db11:: with SMTP id g17mr1000547pjv.114.1614119545272;
        Tue, 23 Feb 2021 14:32:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c11sm172767pfd.218.2021.02.23.14.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 14:32:24 -0800 (PST)
Date:   Tue, 23 Feb 2021 14:32:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] clang-lto (part 2) for v5.12-rc1
Message-ID: <202102231416.F35628E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this Clang LTO x86 enablement series for v5.12-rc1. Full
disclosure: while this has _not_ been in linux-next (since it initially
looked like the objtool dependencies weren't going to make v5.12), it
has been under daily build and runtime testing by Sami for quite some
time. These x86 portions have been discussed[1] on lkml, with Peter,
Josh, and others helping nail things down[2].

The bulk of the changes are to get objtool working happily. The rest of
the x86 enablement is very small.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20201013003203.4168817-26-samitolvanen@google.com/
[2] https://lore.kernel.org/lkml/cover.1611263461.git.jpoimboe@redhat.com/

The following changes since commit 2b8689520520175075ca97bc4eaf51ff3f7253aa:

  kbuild: prevent CC_FLAGS_LTO self-bloating on recursive rebuilds (2021-02-17 10:10:37 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1-part2

for you to fetch changes up to 5e95325fbbbdea96de91e7bdb05fe95a3031e37d:

  kbuild: lto: force rebuilds when switching CONFIG_LTO (2021-02-23 14:10:44 -0800)

----------------------------------------------------------------
clang-lto for v5.12-rc1 (part2)

- Generate __mcount_loc in objtool (Peter Zijlstra)
- Support running objtool against vmlinux.o (Sami Tolvanen)
- Clang LTO enablement for x86 (Sami Tolvanen)

----------------------------------------------------------------
Peter Zijlstra (1):
      objtool: Add a pass for generating __mcount_loc

Sami Tolvanen (10):
      objtool: Fix __mcount_loc generation with Clang's assembler
      objtool: Don't autodetect vmlinux.o
      tracing: add support for objtool mcount
      x86, build: use objtool mcount
      objtool: Split noinstr validation from --vmlinux
      kbuild: lto: postpone objtool
      x86, vdso: disable LTO only for vDSO
      x86, cpu: disable LTO for cpu.c
      x86, build: allow LTO to be selected
      kbuild: lto: force rebuilds when switching CONFIG_LTO

 Makefile                      | 10 ++++-
 arch/x86/Kconfig              |  3 ++
 arch/x86/Makefile             |  5 +++
 arch/x86/entry/vdso/Makefile  |  3 +-
 arch/x86/power/Makefile       |  4 ++
 kernel/trace/Kconfig          | 13 ++++++
 scripts/Makefile.build        | 19 +--------
 scripts/Makefile.lib          | 12 ++++++
 scripts/Makefile.modfinal     | 19 +++++++--
 scripts/link-vmlinux.sh       | 28 +++++++++++--
 tools/objtool/builtin-check.c | 10 ++---
 tools/objtool/builtin.h       |  2 +-
 tools/objtool/check.c         | 97 ++++++++++++++++++++++++++++++++++++++++++-
 tools/objtool/check.h         |  1 +
 tools/objtool/objtool.c       |  1 +
 tools/objtool/objtool.h       |  1 +
 16 files changed, 195 insertions(+), 33 deletions(-)

-- 
Kees Cook

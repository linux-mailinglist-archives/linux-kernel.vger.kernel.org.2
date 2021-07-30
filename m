Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C723DC096
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 23:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhG3V5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhG3V5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 17:57:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A14DC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:57:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y125-20020a2532830000b029058328f1b02eso11728142yby.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OuQ5TmLpp058PbGqh8D13Jsu8FS4m2xyhutHftN2hx0=;
        b=YiYCv9hGm6Qdi2iSGPtKfAfUUNTpaVdgeclTsVwvikuOLPvv9GEIDfyumGrj+7Vo/6
         lRQdRZjvXHHwSUEcXV6QoT7qwgfOh25RRGXqKWOrLwhW8jtKNNcrsd9ymj7Hr6YpMEmZ
         oyBWvT2DAs/pjsj17ylFUS9e141LF6C/5BDRrUHkjyCS1BarRB86jsLzW9gDnkyeJXES
         nnA+yRsD9e2ieENz4w61xjvBQ/SVZlJsPy6TORaZ/OwQCE1yfe2Gq6yQaBD0QM8leFH0
         rdGCSbmyp1MDoe5l/9RPVaTtbnrWQQubcmrv9vRt90YSG4eyuDbp5gTazoCtCKM7vIdz
         DrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OuQ5TmLpp058PbGqh8D13Jsu8FS4m2xyhutHftN2hx0=;
        b=m0KG9YRbXqcTOvK4BZuieZsfkVCSbWrgV8rlB+rxulGtLZXBVkjU+VRDmq7qzFThhI
         9ayI/l2DjlQzKOmDKW2lU0rL3DXtgdvkaJjIJtmCe1aRhqnnRNKHONinPo8W5e7mlNpH
         zxqo5eIxXqoP43s96D3oGel4/zLIL6p8AfonzlAEBz7j+1cU0s01dnKi2iXHaMVgE0y+
         GUZ1F/q2FC1iJMzT3SSolo23MksokVynV2hHc5mycIYjoDFEjlz0w1rgoLPqrKBkNWHY
         ikEc4qwRM9xjZ2vFrk90Ahki0E+RATiZQJj57838wLOqVLyHncrL8x3tC3KP2Y9LpsG3
         NJHw==
X-Gm-Message-State: AOAM532HnV1P0E+ZXizU4Cdy8ZfMjarMCqpFBTre09L/l8u68ySV+6cR
        WO2BeDmhWS692FAs7zZHfuv+4wn/5nsOhYogCRs=
X-Google-Smtp-Source: ABdhPJz+ssWMLL8qBVkJ8BK6giC5iUL2NzTfXDMUofWj6IfHNSqW9NWWnI/ea1sm47YgisqIAON5T/KXlf94W7RGdlg=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:ca8b:b433:7c1d:90d])
 (user=ndesaulniers job=sendgmr) by 2002:a25:1ac2:: with SMTP id
 a185mr6286643yba.350.1627682232434; Fri, 30 Jul 2021 14:57:12 -0700 (PDT)
Date:   Fri, 30 Jul 2021 14:57:05 -0700
Message-Id: <20210730215708.276437-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v5 0/3] infer --target from SRCARCH for CC=clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get constant feedback that the command line invocation of make is too
long. CROSS_COMPILE is helpful when a toolchain has a prefix of the
target triple, or is an absolute path outside of $PATH, but it's mostly
redundant for a given ARCH.

Instead, let's infer it from SRCARCH, and move some flag handling into a
new file included from the top level Makefile.

Changes v4 -> v5:
* Include previously missing first patch!

Changes v3 -> v4:
* Remove the requirement that LLVM_IAS=1 be set, as per Masahiro.
* Remove the Documentation/ change from patch 2, as per Masahiro and
  Nathan.
* Add Documentation/ change as patch 3, from Masahiro.
* Reword commit message of patch 2, as per Nathan.
* Change patch 2 oneline to refer to --target and CC=clang (not
  CROSS_COMPILE).
* Carry Arnd's and Nathan's AB/RB/TB tags, confirmed ok on IRC+discord.

Changes v2 -> v3:
* Remove requirement that LLVM=1 be set. Instead, if building with just
  CC=clang LLVM_IAS=1 instead of LLVM=1 LLVM_IAS=1, you should use
  LD=ld.lld explicitly, or LD=aarch64-linux-gnu-ld. (As per Masahiro)
  Example:

  $ ARCH=arm64 make CC=clang LLVM_IAS=1 LD=ld.lld OBJCOPY=llvm-objcopy \
    STRIP=llvm-strip -j72 defconfig all

  (It's still preferable to use LLVM=1 IMO, but this is maximally
  flexible.)
* Change oneliner from LLVM=1 to CC=clang.
* Update Docs slightly.

Changes v1 -> v2:
* patch 1/2 untouched.
* Fix typos in commit message as per Geert and Masahiro.
* Use SRCARCH instead of ARCH, simplifying x86 handling, as per
  Masahiro. Add his sugguested by tag.
* change commit oneline from 'drop' to 'infer.'
* Add detail about explicit host --target and relationship of ARCH to
  SRCARCH, as per Masahiro.

Nick Desaulniers (3):
  Makefile: move initial clang flag handling into scripts/Makefile.clang
  Makefile: infer --target from ARCH for CC=clang
  Documentation/llvm: update CROSS_COMPILE inferencing

 Documentation/kbuild/llvm.rst | 17 +++++++++++++++
 MAINTAINERS                   |  1 +
 Makefile                      | 15 +------------
 scripts/Makefile.clang        | 40 +++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 14 deletions(-)
 create mode 100644 scripts/Makefile.clang


base-commit: 27932b6a2088eac7a5afa5471963b926cfbb4de7
-- 
2.32.0.554.ge1b32706d8-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8463DA96A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhG2Qut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhG2Qus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:50:48 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28BC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:50:44 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id f9-20020a05622a1a09b02902615523e725so2978510qtb.21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MJP1t72bFvITlNOtlr8RusQlm4nGOAfcjgK9C55asO0=;
        b=p8sWn2dbfPOWOBjQc4eyjx4hSnj6xXIeQa6Rn1r20g6fteWVNgIfxcKTXkay2tj5ao
         8cpNYJ/3FwZJ+uW7vZJS1cHZjtofBZmvSZub8kyvQ/moI8wW9mTgKIA/Vtwst+S+ITBT
         rKOJsv4KWg3qTbMYo/rAA0yvKurM7uXkTL844v1QGTWCxBztnKAE9ETVIx/eOfrSD8vx
         jlfPPCPBDwHrlY0gmEbu0tf/fdx2S038Hzzs9TMee1rNbRkOOezKm7TM2jRlZvRgNlnp
         Z1EkN7iM01DojaUZz1q8hhNF0hEhtwApG+oiLcpVQDX/zISNY65glCstjGU30dOqj2hB
         uPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MJP1t72bFvITlNOtlr8RusQlm4nGOAfcjgK9C55asO0=;
        b=COBuV9M6GZ9d2SrQgyrVb2fhhSQ3U55aSc5K7rGi4nO+mmldORC9G7GwDY3rFA3Eqb
         YB8Lv6dMiwGgv3VmJqj2PLgsWVP06WPEIrMOze3QlPct306oXg3c/jPs399u77GfiSSe
         cCND0y//ow86xtDRGLsSwH47VWSa9FKAlnE4u2nqzNfWd9P10Gbmo5fybtuqIFmuPM4+
         ErRDImhYK5Ojl7vUIJyWFS/e5j73OkMqOAlnEi3AJAtjvJ7Mso7kJBJ6SQoMugel9Efx
         icJvNaGVfcPV2QJx3/pOVzdRzrEkGOO+GKBc2Rf8r2ijqW0JYiDCYD2eF2Nw6XJ30QLm
         kXsw==
X-Gm-Message-State: AOAM532to1qOa146F6uTwngIb3IxPhNqXzcyQW+Zafkw9YNLej+rbioy
        1VEXujSNR4QWR2Iiuj83GSXMBIniXX/A3zpksFg=
X-Google-Smtp-Source: ABdhPJwWD7T0W4TmwEn8mJADZPusDQqnLnyY+kZpkLqDOJPPRdSOLO6lu686aMxImY3NMENP7lV0kqpRQYZQA1ZIlA4=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:8132:32f4:cf29:1268])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:1362:: with SMTP id
 c2mr6400031qvw.9.1627577444006; Thu, 29 Jul 2021 09:50:44 -0700 (PDT)
Date:   Thu, 29 Jul 2021 09:50:37 -0700
Message-Id: <20210729165039.23896-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 0/2] infer CROSS_COMPILE from SRCARCH for CC=clang LLVM_IAS=1
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

Nick Desaulniers (2):
  Makefile: move initial clang flag handling into scripts/Makefile.clang
  Makefile: infer CROSS_COMPILE from SRCARCH for CC=clang LLVM_IAS=1

 Documentation/kbuild/llvm.rst |  6 +++++
 MAINTAINERS                   |  1 +
 Makefile                      | 15 +------------
 scripts/Makefile.clang        | 42 +++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 14 deletions(-)
 create mode 100644 scripts/Makefile.clang


base-commit: 27932b6a2088eac7a5afa5471963b926cfbb4de7
-- 
2.32.0.432.gabb21c7263-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445A43BF22D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 00:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhGGWp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 18:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhGGWpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 18:45:55 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1259CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 15:43:15 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id g11-20020a0562140acbb02902c77e759580so2676552qvi.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7PF5MF/PppYWlL0Lvh8CWn/Qemla6arexCWKEtWK8TA=;
        b=XNtbehT3q4pZdHdPbbXBIh7v/SKLG3UApl2MCXXFmUxbkDXWvfRfsL08zW2gclLMco
         EP5J4SuUAUzM5RCCRNSAC4atbhgYRYwJxjA/Dscu2kTKkUsBQj0ZHnPEz4tVO8DcJIIf
         4RlKyZ/Z0DbS3npAs7N3k/5TJg4k2BSA+jFU53ZgtNsfz2c2KGBeY5qMPkZ6AFHczxIB
         VvrHGBIVsUjAjhqwh0b7DolzQ0bS21KocKS7EoruhgWER+mDzXZQU/K/j3SCIrqKBx0W
         +tVNfZ+vCLHpEZeZPYqpEaH00T4eaQ7W9eB314FbQnoXOkacb/5jjNJEO7C12NYOmnb3
         Robw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7PF5MF/PppYWlL0Lvh8CWn/Qemla6arexCWKEtWK8TA=;
        b=WEIDgKubMtrD92X3s7PLbAuXYJuoKG6yCxtbKlnHchGLtZmMPAW9Rj1QdWlIe6C3YL
         CXb5JUpOCZZwsUSpr4g35jVs3/lcZlhYrBcBNp9jTTNDvD/2veNKqIapHqKOP9TV/JrX
         tfWwfjCZSZ5O3Zn1Hz8JpzjUNyyG+dwPwdAKpSfppOya+FaEcNRLOIyDANxpXP02zwMo
         G3vOFhFZfDJzNTDq8to4fNAJLN+hR3xP+uBLVegen+/AO01Qac5wmu/Tc2838yVh9jYG
         PqIcYThWttpjtQoNtx+xM+DMIuJtagwxmBIXAIU47E57cRLplqNs4KQk5EfxwRgnaMlU
         Werg==
X-Gm-Message-State: AOAM531PMU04MqBG9ZAu9Mc5Cs1L0Su6bwWSqeA5A5+iiv8M0caPXryg
        PXP8R1NXoYZpPshaWIB1Rs4PT83E/Ufd5iwRF9g=
X-Google-Smtp-Source: ABdhPJyR2IYCNrFl/gSLnix/vfqbJaGYtBN0xeQunRqSdq+ildius84+CDJN7M4tTBufaXF6FSk/VatJd2JaLksbiqA=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:d417:6e24:4a54:1792])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:1d23:: with SMTP id
 f3mr26515764qvd.10.1625697793911; Wed, 07 Jul 2021 15:43:13 -0700 (PDT)
Date:   Wed,  7 Jul 2021 15:43:08 -0700
Message-Id: <20210707224310.1403944-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 0/2] infer CROSS_COMPILE from ARCH for LLVM=1 LLVM_IAS=1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get constant feedback that the command line invocation of make is too
long. CROSS_COMPILE is helpful when a toolchain has a prefix of the
target triple, or is an absolute path outside of $PATH, but it's mostly
redundant for a given ARCH.

Instead, let's infer it from ARCH, and move some flag handling into a
new file included from the top level Makefile.

Nick Desaulniers (2):
  Makefile: move initial clang flag handling into scripts/Makefile.clang
  Makefile: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1

 Documentation/kbuild/llvm.rst |  5 ++++
 MAINTAINERS                   |  1 +
 Makefile                      | 15 +----------
 scripts/Makefile.clang        | 48 +++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 14 deletions(-)
 create mode 100644 scripts/Makefile.clang


base-commit: a0e781a2a35a8dd4e6a38571998d59c6b0e32cd8
-- 
2.32.0.93.g670b81a890-goog


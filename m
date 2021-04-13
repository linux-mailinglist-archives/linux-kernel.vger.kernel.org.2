Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB11735E96C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 01:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348733AbhDMXGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 19:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhDMXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 19:06:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD655C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 16:06:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z39so17790301ybh.23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tsDZWsbqaxGn05JmQD2dRxuSvQncZTN9fT69Buh7z+4=;
        b=DxcXYtVMHdWIr2vAXpgvhdAeByrx8qgJd2N185CgNuXORT11L0mdDzJbfpCf3uNwSS
         xVkpSHd/7c9vExVtqDcdNumLnpFOkTwZqxESWIy0WRvYSC/BFKPrNQmM9LVdEf3suSVb
         ChSJgB/LknPYwXfPde3Rx30gIFUTyymO5WSyBqMHHiiTOlarXD6RxR4A3zxTz/tYflg+
         40GzMwOxhvHtA720nuZU6bCLr4UB+NxQce+7+x3pn99R3in+kgVuuHoGAiHyhOGWm8S0
         AoAUraHQ8RXUjzCkXeesaj6ou09enb5HN4Q15lMEZ79t66RoLsErmXRLzMCnPHre4xOt
         N0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tsDZWsbqaxGn05JmQD2dRxuSvQncZTN9fT69Buh7z+4=;
        b=ZiAbQkfuHBVP34m6qRQrqp1Ydxh8hh85PDaoDlVQySPqdw97T0nf+b6xh2p5qqyR6g
         9NHHU7GWtY8wDsQVBzL/C/IFm8g+K539O9AADJ7yc6jUikz+VDdR/w5fRU0qJoQzzOKI
         RaWct6oUH/VbCiGi/+7xZtMGV6HjqUX/g6mI88CmtlEheP/uLxo1TKRB1Acr2T7I6/8h
         ZrSG8pEuswPzRAnKQ1EmaZ2/MHQkP9vR8JAKCejco5wddX6RUqi/Kf4xtjNZMIZQ0Pym
         91ufswR9fKt6VPgfvg/3rUvfRQ2vTxE7PgWujYY0A1k8pyyYs91FCiBvaybshA1tBVsv
         5WlA==
X-Gm-Message-State: AOAM532CA5yXrELletpC5OnVcxi2v5xoE2V3TIjiv7OKvSgoVzn7sx8K
        WVX1LPrzDofAg4aXYCpyVrS48pnLHkaOEZwTQJg=
X-Google-Smtp-Source: ABdhPJyLVwYW4Q5CPKZU6gSM4hE0yiNSxnWn2wcOdYrFM5VJ+oHrXrzLfBcTwQ4ZR2p39db8IxcR3S8iHsf0UaZrfJc=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:bccd:9a37:f0c6:9934])
 (user=ndesaulniers job=sendgmr) by 2002:a25:7410:: with SMTP id
 p16mr23895098ybc.515.1618355176694; Tue, 13 Apr 2021 16:06:16 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:06:06 -0700
Message-Id: <20210413230609.3114365-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH] arm64: vdso32: drop -no-integrated-as flag
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     vincenzo.frascino@arm.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bill Wendling <morbo@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang can assemble these files just fine; this is a relic from the top
level Makefile conditionally adding this.

To test building:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
  CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 LLVM_IAS=1 \
  defconfig arch/arm64/kernel/vdso32/

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/kernel/vdso32/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 789ad420f16b..7812717f8b79 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -15,7 +15,7 @@ COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
 
 CC_COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
 CC_COMPAT_CLANG_FLAGS += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE_COMPAT))
-CC_COMPAT_CLANG_FLAGS += -no-integrated-as -Qunused-arguments
+CC_COMPAT_CLANG_FLAGS += -Qunused-arguments
 ifneq ($(COMPAT_GCC_TOOLCHAIN),)
 CC_COMPAT_CLANG_FLAGS += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
 endif
-- 
2.31.1.295.g9ea45b61b8-goog


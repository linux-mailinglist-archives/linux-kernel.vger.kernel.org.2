Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0665365EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhDTRpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDTRpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:45:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:44:32 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id g184-20020a3784c10000b02902e385de9adaso7289683qkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ukVJrdVkOwq7s65WfCu+IbNVo5nWb4FRanDkk1R0eWU=;
        b=B4z6VFCCM34wI/dNHB8iNWAJcaRKrLelv4wRdC6nR6+18Fdqq+xeEZEKz0SFB29iKt
         n4DxtrHy8yjB6Zhc38+bl8oPM41/9cUSz/BsuKQrdyfVQLZz0JkTA5KWExJT96tMv1zQ
         xTe5QGuLb92+STIasSkOOF2C1Zr3t+JZi+aVRqFoZltJu0/QaG7aDv0NtfoL+DlWr7aZ
         taYpGnd0hogrtfSkyITT/smMjkl0HMOuC37DR/M4yfXbfvE2IQer/mus9hqQrXCVoPJr
         q8hF2QtzbiU2gS/2XheJCfFRQ2tFtsE5XcLbQkvuP8imfggoS4Vu0dNQ/rb+0ufbSyFe
         RP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ukVJrdVkOwq7s65WfCu+IbNVo5nWb4FRanDkk1R0eWU=;
        b=MRf1bKhpZREA2lo75Vf61NO13/PE+OiI/Zq9QnIZ5JYusCg6u9in4YR9A2ARBg2XEJ
         VSh/6LTlLP3Z2AWP3z2ooGCw+lyR+KNSaSzdaNhM34q0BCyiw3GK3MG8RIRCIK5u5URp
         8x6OyXm7NPFUfGYuu2wVhPLLXiHG6K0ovdt5eV/XtmaRY8hhhDEhVenATq/CbwOD7Gb3
         4LriOSASqJFwEiQidCsNy6hLWGBzdCDSc7HSeFC8TtptZGyuQ3iNB/rLnFik9Vu8dpW6
         h/r6RUkoxuzgq1A/zG0gmb6fRVDTQrpfy35AcyCy/sjZSuLVlcPFF+QTxfIP1G62kdZ9
         EZOw==
X-Gm-Message-State: AOAM530xrfhycCW7YwlYsY3V+q9oyERiP3f2tuSwS9uNUl003cAJp7mW
        FXrzrdR8n2/sSWV0AIm28hAuDshrJsIMtJB8CO0=
X-Google-Smtp-Source: ABdhPJwvkXHKfOKDXv7TdZP/XC53bbL67xijoP5ppU23m/8I1MNeirN/r6yWOhHwD85KJE5gfUAMaZOQ/MM8J7rgQ+o=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:38ea:3e39:6c20:3a35])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:58e9:: with SMTP id
 di9mr4388482qvb.23.1618940671450; Tue, 20 Apr 2021 10:44:31 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:44:25 -0700
Message-Id: <20210420174427.230228-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3] arm64: vdso32: drop -no-integrated-as flag
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     vincenzo.frascino@arm.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang can assemble these files just fine; this is a relic from the top
level Makefile conditionally adding this. We no longer need --prefix,
--gcc-toolchain, or -Qunused-arguments flags either with this change, so
remove those too.

To test building:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
  CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 LLVM_IAS=1 \
  defconfig arch/arm64/kernel/vdso32/

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Changes V2 -> V3:
* Pick up reviewed by tags.

Changes V1 -> V2:
* Remove --prefix, --gcc-toolchain, COMPAT_GCC_TOOLCHAIN, and
  COMPAT_GCC_TOOLCHAIN_DIR as per Nathan.
* Credit Nathan with Suggested-by tag.
* Remove -Qunused-arguments.
* Update commit message.

 arch/arm64/kernel/vdso32/Makefile | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 789ad420f16b..3dba0c4f8f42 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -10,15 +10,7 @@ include $(srctree)/lib/vdso/Makefile
 
 # Same as cc-*option, but using CC_COMPAT instead of CC
 ifeq ($(CONFIG_CC_IS_CLANG), y)
-COMPAT_GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE_COMPAT)elfedit))
-COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
-
 CC_COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
-CC_COMPAT_CLANG_FLAGS += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE_COMPAT))
-CC_COMPAT_CLANG_FLAGS += -no-integrated-as -Qunused-arguments
-ifneq ($(COMPAT_GCC_TOOLCHAIN),)
-CC_COMPAT_CLANG_FLAGS += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
-endif
 
 CC_COMPAT ?= $(CC)
 CC_COMPAT += $(CC_COMPAT_CLANG_FLAGS)
-- 
2.31.1.368.gbe11c130af-goog


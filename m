Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974C3434179
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 00:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhJSWj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 18:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhJSWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 18:39:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A455C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:36:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i83-20020a252256000000b005b67a878f56so20821582ybi.17
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VYYzFbtg9v9uYxEoyPeKXiW1szMtPubg10b/PAxgSlo=;
        b=P/eAIE9t9qFsmOQDu4H456xxeFJ3Vkto2vyDtoqZjgvzOwZNlvZmPpM0Sh6JTLHncz
         CYalQVIr7MNV7ME6aicxY56kbBmtCNpLBLqSU7bDdG5t8Hh/K8cOgjDjLa41cS2Nucj/
         VTDTqMNWqbGlcGGUE0BfMB4kouEsOqF8BBpEAQKCMY8BnYZe86RWewujSOxolKk1vX/g
         UD2EJFVstgRFE/b1PYK68bSUvE7gZJCtpg+wanBc5kQTxv3bNIDNrIdpL7kJLBud7dGE
         6Dpq9f63a0mnKkV8d4VCuApFnjrG43JmEhp4N66+GrL+D1ASWMIm+c6sFd9hgWsEb/TH
         olMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VYYzFbtg9v9uYxEoyPeKXiW1szMtPubg10b/PAxgSlo=;
        b=ETvw3ATSwvWImE3ojLra/HmLAMOijcSiU6xCK7gKh+mlc3xO6qstEUWdF/PU6PbsyI
         7+6tz20lb+bdVAKuMBd7Lg/baJj9/o+cIB+UrinyrZsO0lHyb1QBFGzJEvhs9LABYbRj
         B7UGUO7HreMQyLVU/x0Kf1yw7AUUAS4LdkG+BBN70jyvQWgh/QEr5IUlwA+ZfeLX4LL+
         ueDsBSWfQL96IUmrGegFu3O4O3Q1CBNfKXHZndhIsSeCbEkkqOoKzvsTyNTLL9qf6U30
         Yyt5j4M1ufHlq4PGtjp6i5x7I+dGL/qqEV7bEmeP51vuvFAX6GoCXTWyp+wmEUsQVCzd
         FezQ==
X-Gm-Message-State: AOAM5305Z8SgW79Wt6E009AXpe24lyQlqiDZyEFEfuBKOTM90/XJYU+Z
        160bR/2Afp4xAGXozwtlpQryGEeVWt7jEEy3CGg=
X-Google-Smtp-Source: ABdhPJwkCVKrRS6V2GiMRNX/DRIW3FAv4Tj5QWfrAeg45eqOecBgUJGLb6kiJ7Qveek+Eh5VMcpw/nfY1YtIB0nY/YM=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:de0:247b:5157:7c15])
 (user=ndesaulniers job=sendgmr) by 2002:a25:bd7:: with SMTP id
 206mr41112924ybl.408.1634683018922; Tue, 19 Oct 2021 15:36:58 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:36:45 -0700
In-Reply-To: <20211019223646.1146945-1-ndesaulniers@google.com>
Message-Id: <20211019223646.1146945-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20211019223646.1146945-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634683006; l=1704;
 s=20211004; h=from:subject; bh=74hCoLStsXal7EECTyeA4v4ANHbGr/aLrzSq59yc++w=;
 b=NMtRKTwXJOcg7HCEHcr4qlyA51nWYLdppfUbMlsepaH/P2iZVOh62wivzOpTO7DmNm1ywvKsULyi
 90vwOhN3CX+banOlQxJJQe/9xRZvNfnyvhmezJeuqNJ3aHFhGagP
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 3/4] arm64: vdso32: suppress error message for 'make mrproper'
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Lucas Henneman <henneman@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the following command without arm-linux-gnueabi-gcc in
one's $PATH, the following warning is observed:

$ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 mrproper
make[1]: arm-linux-gnueabi-gcc: No such file or directory

This is because KCONFIG is not run for mrproper, so CONFIG_CC_IS_CLANG
is not set, and we end up eagerly evaluating various variables that try
to invoke CC_COMPAT.

This is a similar problem to what was observed in
commit dc960bfeedb0 ("h8300: suppress error messages for 'make clean'")

Reported-by: Lucas Henneman <henneman@google.com>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Change to suppressing via redirecting stderr to /dev/null, as per
  Masahiro.
* Add Masahiro's SB tag.
* Cite dc960bfeedb0.

 arch/arm64/kernel/vdso32/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 1407516e041e..e478cebb9891 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -38,7 +38,8 @@ cc32-disable-warning = $(call try-run,\
 # As a result we set our own flags here.
 
 # KBUILD_CPPFLAGS and NOSTDINC_FLAGS from top-level Makefile
-VDSO_CPPFLAGS := -DBUILD_VDSO -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
+VDSO_CPPFLAGS := -DBUILD_VDSO -D__KERNEL__ -nostdinc
+VDSO_CPPFLAGS += -isystem $(shell $(CC_COMPAT) -print-file-name=include 2>/dev/null)
 VDSO_CPPFLAGS += $(LINUXINCLUDE)
 
 # Common C and assembly flags
-- 
2.33.0.1079.g6e70778dc9-goog


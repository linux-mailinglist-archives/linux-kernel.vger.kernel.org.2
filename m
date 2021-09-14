Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFDE40B7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhINTNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhINTMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0ECC061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f8-20020a2585480000b02905937897e3daso239622ybn.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b0EYrut/AMnqvvjXL4pjf9dWfm7AKB9fbO85nvqHRtI=;
        b=QuRKXPpb0p4VvZqUTrg1/JtXx9DPS0drlMlV/0qcrpX0pO4U/nYSz+tYk1ujhIejkD
         KUjt5WBJGivXZVD3BvcE9T95e5Wa7b6edeRs7HcucORjEBPHg4Ms+mONomYYhr3RdO4/
         2bmnQYaMR1inGzhBsPnQcT8f8YlOuqjpuzVpyK5Su48qulySmEnyA/UV8l1dK61CbFxY
         PzmgNHjrhpO+XWMowtXmy2+8igPbHZsVzxeZoPuk7hkBIA+3opkyoq+DI1Uy/RjfYVQd
         rFdNZqvtLUI1z02q4tXaCR9r7/ktKAp/pyrZ8zwW48AMcfXgptBraDCN2VS+V0w72gIw
         yA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b0EYrut/AMnqvvjXL4pjf9dWfm7AKB9fbO85nvqHRtI=;
        b=dCVlZm46Am8wazgiHmcr986Gz3FUJ2THnG442Wt0aMkxR4bSED8qC7q2yuDyDv+rwt
         qaNPn8zqBgafur+zVNo9fTOxJKkxuHz/PFZof9uXBFNuQgC/59QMkX+Yy0evq56AdCHH
         ukgKbE/DjgGAliqodzn/cli12bCfHv17ElZjZG4PfKbjDijp/lLXWICq59SKSc5fbj0T
         Lf18J21qGptJIoc2RuEYEDOIiF5jRS/D/GlBljz5biY/6cKaMzlKlqFbj0QwWgNtUBEY
         RI0EphY6e5MFk+4U42GKUie1PP6eHVqZcB3bAL0lWScxUSw0VA485JH8PuAcp1HcMcL+
         3Hkg==
X-Gm-Message-State: AOAM533pZ7mXeu3Loy1vX7IMUW8uS6R5VAY5LrBNdrudV1naFS48G3Zr
        vvte3C5fJwCNNkGKx8B9XNlYacP/ncOQubjkNbg=
X-Google-Smtp-Source: ABdhPJxhp4NW539pWSgPnc//mdohgsLEl+VSRPA2sl17a4iU7q0uCjSiZtcbjOB2t0939rAsaF/3vGW+4CRTzpwXxMg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a25:5205:: with SMTP id
 g5mr923777ybb.292.1631646686506; Tue, 14 Sep 2021 12:11:26 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:45 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 16/16] x86, build: Allow CONFIG_CFI_CLANG to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled with
Clang >= 13.

Link: https://bugs.llvm.org/show_bug.cgi?id=51588
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4e001bbbb425..0df0285d3ed4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -107,6 +107,7 @@ config X86
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_CFI_CLANG		if X86_64 && CLANG_VERSION >= 130000
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
-- 
2.33.0.309.g3052b89438-goog


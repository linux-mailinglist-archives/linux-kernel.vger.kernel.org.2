Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AFA42C880
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbhJMSTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbhJMSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A7C06176A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q193-20020a252aca000000b005ba63482993so4169026ybq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bp3ABDDgGwr3SY/OCgowm1/nKIVkQbAiUY3zLKH0TlA=;
        b=CwWuzSnFxrYxEv0Fp0YrTp19JtWf77FbwTQs8L6Nkq3+pVyvBV6Y7QPEsV4mh66WIJ
         mR/qFptNy+di87Blo3ChbU6zgxgRrj7Z9QgbTzO8JRwasz0FjtzLNyxKj6fq1/SYgahX
         AE902txzN1yewvW/w6xkX8STZqWyQ/QDfgsZtzy2dRyN9C5LVjYpEMaz5juQcvrD5isX
         r8lgww4TUkpAlXEVscYQ+eS4wi4Dx/i/67gPRrS3cfHzDueXe+G76IqdqgVR0wEkXqL/
         JRiZRTMSjicfTL9n/DXZNohwew6sYwqugUv7MhWLxXbCtMm7EFHlrGVES7eS545f+za7
         nlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bp3ABDDgGwr3SY/OCgowm1/nKIVkQbAiUY3zLKH0TlA=;
        b=Q6JvWjjIwQ+g2HlzUq5GJVcJC237UQtH62ST0JR04w7sXw1Ee9SAsXxQX8zmsCszGn
         jLAcHXcKlJyEJpa5CqLkUpwOwFBI0wp+nnJWnaETYJJCRxbT8EAHX3via9h6gPm7b5GZ
         /4qcvsgxM2Moro04mOPakX904ckPPhL5ixPiPC8WLzbUlIY5qTxRbuSuPzW1A2Dw7YCU
         /eFui5YZEPKwaLhlF93dZTJhVXJ71EySXadw5otF8uLx72bRfpufIfIPFmCQAI6J9hO1
         OIl3LIajZopsIZ9OUpmnAdbN6SKB+svizfHe/XI5iwwujKVsRUA3TeyRfZ4lK9w/QeKQ
         ogYg==
X-Gm-Message-State: AOAM533zAHsC7Mk32IyFXDTnG8OUSAxX+CfcMxF4QwMfpGQGN6l1Gatq
        PytUr8Td4lsw1k/BUFF88jPvFJXZbbfjhK9A+O4=
X-Google-Smtp-Source: ABdhPJzoR3GLOEpEKtTU8VGRiZfNb9xCjpMaPAcosv/2rRhjgnQm0qVaU7QQM3DX8l9jr7DGuPM3D9dR8KqT+B895sI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:2a91:: with SMTP id
 q139mr1022079ybq.146.1634149047393; Wed, 13 Oct 2021 11:17:27 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:54 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=samitolvanen@google.com;
 h=from:subject; bh=BaJ7/ZIJcIP+wd0i0W7/Cog2IQO5qIM0klmqJZMRzdo=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKZnAo7lb91pIF3JG0Qog3RUnHirC/3yX5EkWqC
 3Gdl6pOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimQAKCRBMtfaEi7xW7hTyC/
 4wtirzSzsYbg5wzUXWYXKwI7/yzC/KMDsWGtxk7RJ9EdvTtBMMXtdGUJ8crX7rzHuJOYTU3MANPFGg
 NZEspwGqDQhBDfsGnOBcdptcfiJBDl2hl6/E9ekRPjeGf6vE7R+yQ8Tr2sGg5CvmKwiSP2tV8TvHiD
 YUPNTS1o+xdNtQibQGvz1tVqaFLbtmdqiL0oFE+sKP+17cBqJEdny+19LxSRX8T6I/9ofamEuzMWaI
 KFbfZB1VLYAc11GhDd9muu9loYxFA56z0rpX4uUEI3M24kCHp96V+eD9oB4ATydGi9/6JVCqy2kLHT
 raxiUboQdJbySP9CpuqRtkDkTv9mbsLhxzSN+VgI3PDg8P7ghvHHqEdsz+6aa2e/SFLBURmaA8VFXo
 KeHFvN3tQu6AkVQLbXcJJCj6Cz0fU0aszDyOnO6uk6QomHiiwXjVVdsxdulgwpDpJWpGMwaAmQaeVW
 PlLB6WoktALL9iT5B8BKKIZ19h7zxGHjY3iuk3uPcqxZA=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 11/15] x86, relocs: Ignore __typeid__ relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The R_X86_64_8 __typeid__* relocations are for constants the compiler
generates for indirect call type checking with CONFIG_CFI_CLANG. They
can be ignored during relocation generation.

Signed-off-by: Kees Cook <keescook@chromium.org>
[ Sami: clarified the commit message ]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/tools/relocs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 27c82207d387..5304a6037924 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -51,6 +51,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__typeid__|"
 	"__crc_)",
 
 /*
@@ -811,6 +812,12 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			    symname);
 		break;
 
+	case R_X86_64_8:
+		if (!shn_abs || !is_reloc(S_ABS, symname))
+			die("Non-whitelisted %s relocation: %s\n",
+				rel_type(r_type), symname);
+		break;
+
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
-- 
2.33.0.1079.g6e70778dc9-goog


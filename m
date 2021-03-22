Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E8334532A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 00:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhCVXpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 19:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCVXon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:44:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E985C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 16:44:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v6so875165ybk.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=4TMeCx7PwkG6nkmerFyzBkQS77hoZyQHillLYYdKYwA=;
        b=ph9FImDeVUGo3wuAvsPknHMCieqw2hI3/S+q6n50uflOiaEPNBe05uDAE7kFNn4jMk
         bslhQ5oTGPupwdTdkV/X4CWSAWZirDWwqsjuNeu1542GMRSQb8PitcUzfvaAFU5g1lJQ
         pj548mJ2Vvk4voGR+Rr9A4K9nn28lc96/a2P2BHykDzRmge8cLScVku+RrHRvHL7oOO2
         8VNXsbf2d3RI8mEIczmdtbXvPf+PDHsmhbpmPn8fyE9xzZXBvDde+aun+eH0wFCJmUbM
         Aq/cYKz6Cd3wTMJOPdskSN954OkOLReBmESUMsTbUjs1lpwGtRrWpKxWknY1Gj83HVP6
         Y8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=4TMeCx7PwkG6nkmerFyzBkQS77hoZyQHillLYYdKYwA=;
        b=IUkjfnwI8tLcxEoISSi3p1drQU4iteoj8tvta3xaBF3SlSy7148qHCu4FvFjt1YWww
         t3lIvpUMDfAjGBYLE+HIuJIsWphWilqi9Gm94RLHzvrBPmSUFaFmeaB6jIVue0xXk27V
         9ZFhNNtfW00tLs8WcwnkuMg2fmaR7sEi4hzMLI2WCxn+3+EhkUEDBYtl5RgIsGfnUFim
         zsoEEZ4WRIzzY8A98fEfATyZ42orG+Xqfy9lo3YdyPiQ00BqffCnPzWk+prUciXkCrPN
         kVRZYzs80G4ZktKGUSS/iQH6llVZKT/p8kMHIRpP4JQacZ+EA73YnTEtFPpdcyEzyp0X
         zDsQ==
X-Gm-Message-State: AOAM530BB91rBqf+u8sJGQk1L8FGQLdSilerM1c42ZqZGuxWg7YUVQlA
        wlU2+8nQ1jtTOaJnHBOtoMqS0tRj+ac=
X-Google-Smtp-Source: ABdhPJy38OJf6LX4jPY+m0QdjvwUm91MQnViGYuxQ93DIeIZAiF70Dd9jP8muOYkt0Z7zH1quXZvTCyfo6g=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f8cd:ad3d:e69f:e006])
 (user=seanjc job=sendgmr) by 2002:a25:745:: with SMTP id 66mr1404929ybh.195.1616456681283;
 Mon, 22 Mar 2021 16:44:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 22 Mar 2021 16:44:38 -0700
Message-Id: <20210322234438.502582-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] kbuild: Merge module sections if and only if CONFIG_LTO_CLANG
 is enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge module sections only when using Clang LTO.  With gcc-10, merging
sections does not appear to update the symbol tables for the module,
e.g. 'readelf -s' shows the value that a symbol would have had, if
sections were not merged.

The stale symbol table breaks gdb's function disassambler, and presumably
other things, e.g.

  gdb -batch -ex "file arch/x86/kvm/kvm.ko" -ex "disassemble kvm_init"

reads the wrong bytes and dumps garbage.

Fixes: dd2776222abb ("kbuild: lto: merge module sections")
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

This is obviously the quick and dirty approach to fixing the problem,
presumably there is a way to actually update the symbols, but that is far,
far outside my area of expertise.

IIUC how the disassemblers work, the section headers are correctly updated,
e.g. objdump displays the correct info, and even gdb's disassembler shows
the "correct" offset, it's just the symbol tables that are out of whack.

An earlier version of the LTO series did have exactly this #ifdef, but
it was dropped when no one objected to Kees' suggestion to unconditionally
merge sections.  https://lkml.kernel.org/r/202010141548.47CB1BC@keescook

 scripts/module.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 168cd27e6122..3580c6d02957 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -25,6 +25,7 @@ SECTIONS {
 	 * -ffunction-sections, which increases the size of the final module.
 	 * Merge the split sections in the final binary.
 	 */
+#ifdef CONFIG_LTO_CLANG
 	.bss : {
 		*(.bss .bss.[0-9a-zA-Z_]*)
 		*(.bss..L*)
@@ -41,6 +42,7 @@ SECTIONS {
 	}
 
 	.text : { *(.text .text.[0-9a-zA-Z_]*) }
+#endif
 }
 
 /* bring in arch-specific sections */
-- 
2.31.0.rc2.261.g7f71774620-goog


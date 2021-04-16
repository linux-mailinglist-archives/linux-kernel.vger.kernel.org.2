Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641C2362984
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbhDPUkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343909AbhDPUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942DFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f7so7507399ybp.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kUjWBT9A/msvknG/cBSgVzJVzGCrFgBKQbJ1Wr5vaYY=;
        b=HWvfsSkFKcVS3GXzWZGlVPwe/U6VSnnLVtNnq9itoc5ZhNefPUwxkiyXJCUJ5yFG/1
         YhFdMCfzR+5s2w/vxcgc0o4SZl6bVC7wvQB5BzwXQz+1ss13GAE3Vtd65Y4zyY/rAzYA
         4dlbGfJrwsjubvOmqz7AAGrv8BivEv0XF5XpWSZLEPfK0XCU4+Kien6N+M2cLrcqA/Hq
         J+5C+kh7umgtKCslhjK6a6P8EftqVKJFIGJEbcgxxmdrDnW7miCL0rS8XrbMw1i3+cOU
         2teO18lNpxs6edMFlkNQSR5PfY/9l/ArhaBHdUPgaK4SHNEj04G0rtCULGAoAw1QUaTG
         EBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kUjWBT9A/msvknG/cBSgVzJVzGCrFgBKQbJ1Wr5vaYY=;
        b=bUndn4yPnJOqZs5lOnY5ekxKqmsRpnos4CNBGwPq3RwXflh6OvCdhKT3UADnkQa71m
         vT8FNU8N4VcB3tHRTqEHiUA78WM7V5no1vGJtkf8u2RCJZc5vrbrc6TUkY3meC9Pn4u7
         9PY/RDO207CMKY2JgsPSLZLYrGdmi7mQEaFVTtXZQ9Rh8hc8uBmOijs2XAtuInM6JwV5
         IzYPL/AasRMJqP9l8ixavGjSolZoyp+1J2J5730LWVpRaManEnG6/YER4Y5L9L9wNHUT
         I4rFWPdBcQ1Jf6kViYENqwNCrzuz5+8f06nE3aEvPgnpXhYSN5xRwFD2MpCnSmIrPVWL
         TiUw==
X-Gm-Message-State: AOAM531BqUl6ERnWVBnAbPmZcn+UckiJB5qo2rjbLVmOKHeZcH8Sz2ud
        uWI4uwOTPlEzSuWjHAJ5LlmJC+bc45v0RIDJO98=
X-Google-Smtp-Source: ABdhPJwEdJHNHT5PAP3B3QWdIgcQCAtMECPZ/qV3N3SLx4cq652X4cWMT0J9smvuBPU7Y9rSHsPWY9fZ/gjEGVI8EeQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a25:ba85:: with SMTP id
 s5mr1478504ybg.336.1618605547874; Fri, 16 Apr 2021 13:39:07 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:40 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 11/15] x86, relocs: Ignore __typeid__ relocations
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

From: Kees Cook <keescook@chromium.org>

The __typeid__* symbols aren't actually relocations, so they can be
ignored during relocation generation.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/tools/relocs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 04c5a44b9682..78516ccea0c8 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -48,6 +48,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__typeid__|"
 	"__crc_)",
 
 /*
@@ -808,6 +809,12 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
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
2.31.1.368.gbe11c130af-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC441E09F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353071AbhI3SID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353103AbhI3SHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:45 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B8C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:06:02 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e5-20020ac84905000000b002a69dc43859so12493784qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=36JGoOQwhp84OMbqBWPfqbJksyq4Ee1GRSA1czJSFhs=;
        b=cB77Vb/CwICfRwD2mkh0raoM//6noNAFP5BtwePcoVGM1nyAlCfVJtKF35wL1pMwev
         D2GqltNZ1bhq+hRH8UnFSweflcXsS95Ir8dZ3rY6OVAjnMt/R0W1UR6ctQPtg/gcIBa9
         y8KQaYC2G05aBR5jrnIWIZ3huUYLx77QQT5hlGs/UVeG0GqNpK2l8DTtd4cNHYI81Vw3
         zwyXCy6a/HqwSqBa9p+Vi89JXE5Vy18KuamIGkTDlZ/7kQWptK+0iRY5d9Fkqgkci/3a
         srPd+GRRzz57/fZCNOzWknSmGYqJ1fzF0HmWIqUaS3MZQa3RmMT3xGN54NzMRyKTJiRj
         eUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=36JGoOQwhp84OMbqBWPfqbJksyq4Ee1GRSA1czJSFhs=;
        b=kkFP0X7wJm9TCwhqnscrlxgVPobKBqSHXM/2ls2aw2jOqcIkU5aW6VbWGkztOu87pP
         fzGjRZUKnATfqs662lDVU67atJ18blCDSj6HELUZUFFYxL8WOU9C79/ELlc3mxL4PzXL
         vacRp7dg7BfGCc//2F8gbInViUVPA04GxwJYfEdl+KmifndxkIkUpAdvuwZQYdeJjE1/
         aS+VMnbw+ZaIZmZ/GnTHoznbnE1YkTrEou4GxL2FTbfvvwYjVQiW3XwOBaIb4Z5A+nOl
         suIUOfyAR7qcQo4nYw+DBo+KUelGRjkAexx7rOSuUolSimJil0oZ5zCRz26Nxno8JKk7
         BLnQ==
X-Gm-Message-State: AOAM532AnabzCab7h0xQrUweJ3urZQDC2Wk80Hy3cWAxFRRr8oDwBd7/
        wX5kvh653xjwDHdvTtU8ogiOhUES9+wNfAa3YyU=
X-Google-Smtp-Source: ABdhPJzH+nWTE6A+qxvqzNs/xyKJE6Qfj8m4/ETPnnzMgQrPSxiF3nkVfaZaM0P8d+oy0XInEzgoA4qs0F4Eos30P9A=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1022:: with SMTP id
 k2mr5344731qvr.53.1633025161554; Thu, 30 Sep 2021 11:06:01 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:27 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 11/15] x86, relocs: Ignore __typeid__ relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
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
2.33.0.800.g4c38ced690-goog


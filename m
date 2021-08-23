Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E3F3F4F21
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhHWROn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhHWRO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A756C061760
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w200-20020a25c7d10000b02905585436b530so17032931ybe.21
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vRXS84bbJsUYBdo6NrPKOtGxl8FaD7rd6BPrYrnkXmM=;
        b=bIfEQab0ztkAIlL/xRfn6eVYhJL2L+v0DkKAC8N8G3UMfmdGyNTZYuZTCInyENzt1h
         HQGcVJs2tfEjOA8KETf0IlsWZwd0kWg1SOECL5mxpeJQD4Y7+X3nzE57BjzOj8fEMSUM
         mmF3qFDK4e9lIEXkiiHpg1ZFjI7/cjU7hkuKI7vehXhlq67DGHreEZ+ghgTmyMqUXNGf
         fmKC4OWXelFPk6v8hAtJhSE2QnCts7WompYRJfoAU1BRx6J4VJlXDBBFFKdpai1Szyvc
         1XlVAo3pc6wfat6tbEQk/sz9L+sUtpRFxpOB+zYCv88sDJ9O/WXmyM2oiWjh0/HUewH4
         j6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vRXS84bbJsUYBdo6NrPKOtGxl8FaD7rd6BPrYrnkXmM=;
        b=eRr6EfhOg2eMn1dibDeNcR0Funhqbbogr73MS3WFtbCr9+uXkkch5baV5xiAx7CdD3
         Vwvx367WVYWQwsNfkLZbKfU3t6GSKMwb7W2VyECz+szm6vTvGdWR/qtOLAhEzrC8/K87
         0WfUY+hdbVBp0IiTx3jse0tOo/et3zhgQJU96BklP4Y4e/B4EXebfRcN6qqp0kl3pSyr
         JUQCWpHyiJ2fG+fEFaUslJGjxKHBlUvc+nqd3QpNNtYf75FYpUX9CM1EbdEocgpsDHMN
         HxU38uk7L/i7pwPfqY+A7LfW3LyygyYlos6Kikvc5pvG7evHuGkjP3/gNJJshZkBooZQ
         cSbg==
X-Gm-Message-State: AOAM532XGc3GZD20ogV9HR019PzBgLfUtJC+DD/oJheJdhdwrueUgo/g
        CWJJKmOh6eT0PeOXGXD9tFCSgOyFx5VZSvsXUXk=
X-Google-Smtp-Source: ABdhPJyjtX9cXBMbDaPB4aYRDFhd+jDhg4GxlUeGGU8eWpH4EUhCxiyYud6++fKmMaIrRAYPpL5TYTaxYN7lCR1LEHk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a25:9a84:: with SMTP id
 s4mr45327262ybo.416.1629738824799; Mon, 23 Aug 2021 10:13:44 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:14 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 10/14] x86, relocs: Ignore __typeid__ relocations
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
index 9ba700dc47de..fbc57cc00914 100644
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
2.33.0.rc2.250.ged5fa647cd-goog


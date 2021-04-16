Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6F6362988
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhDPUkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343938AbhDPUj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B393FC061343
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v2so7517537ybc.17
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZVSi0+WBJd8cK80BxQ4Osd57SVpFSIT5lMOEx2WBOew=;
        b=b41bDVDJUgY/qmasSTsJuDALMyRKA0DquCDzT5YifV4psrwpRjIE5VqspQws2ol5jn
         mrX51iabMpAK3R8k61X0UplwjTLmDu6yT5/7dmJSNcMpoAeBzwgWl28wQzjmDKk1E7IP
         x1vcjYAP3urux/XhJ6MXq38mVThhrHqGeOlnQ/EaPIny+LP6TdRu1EC/j+CcDLbnokCA
         n5cz5zYxFWJEE6xxZij4vS0empLBUFmEy8aXeEolzwVa0Mz3ntE2Ox0NEstpix12KO6R
         BW1Dz6PBLKNJ+bPORL3EVHS1ggmEfMJ0ilQ/c/pNHTkPumDF625dTGsEJFL6vm647Dgr
         EOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZVSi0+WBJd8cK80BxQ4Osd57SVpFSIT5lMOEx2WBOew=;
        b=c4w5Mg4WdyvU8gYt/yQRWQPgZ70M4WH6C7NzsDaNY0f435NQH4e1/9sQL1F7J9Oo1z
         MVGft8cjNFeYi8jlqTx/L6jBAMM5+fMx251MdSJwQaW3+ydbenZUcvxHfZCKkEWEidOI
         R/gUWMVL9WQe9VvxhXqLcYf4GUN3Jq/OnfGMaewfaor0XkPd+0RDnTyTSz5XveVWKqj+
         +yNSHSSgOt/ILLQ2bI3ui2J4CVFpqHBYBqjg83IgUf3d6E3D6/smYLJSzs58Zt2eFZgu
         SvRJrtCASXZ4jMHU2Jf11338clz4iCi644sZ9BDFI2rT/Lp817OD2LWNlgEDFl7izJdg
         T56Q==
X-Gm-Message-State: AOAM533wUkXsDckPROsNZR4sfmEhU+x/7pk7ZgO6wuuDC+B7oPQCgGsS
        tHREQufDQ+3lGqo2Ugg15hiouYKHyGWfzlpR/AI=
X-Google-Smtp-Source: ABdhPJwp4jV6Uc3XHwPdhaTYb8BA7WByxBbaC9LJGrPzkVX6yoMku4z3I0Vqt531iRR6rqD41CVsz7MEVhSflzBTG8Q=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a25:6885:: with SMTP id
 d127mr1406777ybc.378.1618605555941; Fri, 16 Apr 2021 13:39:15 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:44 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 15/15] x86, build: Allow CONFIG_CFI_CLANG to be selected
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

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bf69d07e46b8..81d2dc568e56 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -106,6 +106,7 @@ config X86
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_LTO_CLANG		if X86_64
 	select ARCH_SUPPORTS_LTO_CLANG_THIN	if X86_64
+	select ARCH_SUPPORTS_CFI_CLANG		if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
-- 
2.31.1.368.gbe11c130af-goog


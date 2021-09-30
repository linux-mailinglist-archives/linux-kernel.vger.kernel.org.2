Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF041E09B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353088AbhI3SHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353083AbhI3SHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD75C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:05:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso9721323ybj.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tPhQgqpAKPBQUxwOrEtJBlsTaM2q8Clcy13gCpSQvzI=;
        b=DArh49XlDsWw110GeI4zxBAHoJ8q7ew7MQMlgVAwRtWh7bUKmPZfZ7aXH7ujHia2uw
         HEnHzF6kVSmrR7TmAje3meeaPs7TWUj5rVnFZwTdr25/8j+pGDf59ZYj+3roFewtIGs/
         cB5pd1eXeFShrPHnoMPzs7oGq46vacp6Lw7jmxzPenkQ3SB55sqHk5fgT1qFUDzsDYio
         XUK86TrTKe8WETWjwDLexToijeo42Ji0hwIOCJ00XTXo43J4d2Pzfw/nC/bPLCih+7td
         Zh9jihr7INO9ZOmeUJsTe4QKzPECqLF9Tyi0ml0jLQFMF2QaRwgvYHM+V5QM1iKFjZP6
         A3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tPhQgqpAKPBQUxwOrEtJBlsTaM2q8Clcy13gCpSQvzI=;
        b=ke5SH5nWJhRg8NNxKtiz7V3KmQPXlJa10fXfBaN+llYgFHZiTJKHy5z7FLg5rfml4G
         lPy+nuM0fvx+IvT3amw4Kl6iaCNLN0mP21OwbWDEGCzpqrzfI3/3lPbGrXson5bHoqWO
         bOnxMOhL0nvyE0bgtwaX91Mee/BB6BBnKwbPy9ulRbVmCSG+m/o2BMK4VQ1QtWlZeeQu
         p7Ul00xWYJCs6sXkyA3SYCx4+2VyKvRHmEB16KlmVxozEU+/ykQ5hSdHJrZzWdYC3ENX
         3IY5OgLi0OtYTE741ArOWxtLhxGRd43hQe6b3HAFGyu2v3n3ePfNcgiTPimknzpKzhW0
         FU5Q==
X-Gm-Message-State: AOAM532onpe4RG6Ul5/95QmMaDuGppQ4cS1C7VG6iVnJcQOA5Aube8o8
        i0sClgH01uPppkerpxdoNt5Yl9GgxbnaOHV3hQY=
X-Google-Smtp-Source: ABdhPJzd8xBuekl5w0YEWpM/wXNrKDJYF8cvGNaiEGRWRb966n+l0RkGQPKD+VnEBRebQwkRbBbjmfvH313kcdqx/Zw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a25:5093:: with SMTP id
 e141mr690151ybb.171.1633025152132; Thu, 30 Sep 2021 11:05:52 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:23 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 07/15] lkdtm: Disable UNSET_SMEP with CFI
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

Disable the UNSET_SMEP test when CONFIG_CFI_CLANG is enabled as
jumping to a call gadget would always trip CFI instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 4282b625200f..6e8677852262 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -367,7 +367,7 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 
 void lkdtm_UNSET_SMEP(void)
 {
-#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML) && !IS_ENABLED(CONFIG_CFI_CLANG)
 #define MOV_CR4_DEPTH	64
 	void (*direct_write_cr4)(unsigned long val);
 	unsigned char *insn;
-- 
2.33.0.800.g4c38ced690-goog


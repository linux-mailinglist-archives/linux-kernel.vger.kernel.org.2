Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E83F4F16
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhHWROX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhHWROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70EDC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 83-20020a251956000000b0059948f541cbso4137073ybz.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k0Gm7u8L5tSmKVW+xlotholGa6yE9iw0uF/tHV2p52o=;
        b=TefnZXsw1ovvynSraGlA1+As/q+9xVcCWyqpliHonvceW0VLYAx3sHV+wdbEQip7lT
         iM5QchjhV6rqHETKec7PF3/RImK94FljwLXzqSwhmxMMZzWqBgPU3RmtvbGsvFX/kQcs
         IjWfGPaxtlqqYBA9FY4jYD7leJMhO2e7VEtxJDdEy53fDXTlZwiXZfqufANNMF8Aqn1q
         HGuqbVqmWADNt5bqD5J7zQZYtnljw7wx2N723QjvftDxWCSDxGmV0j9LaVB+hGANmDIq
         ylQRAbOgPHhcp4GqoR60aXUyGlMriolzJODHNkhV2QmBQNNJbYvJQSiRBxVckimJGDkz
         yKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k0Gm7u8L5tSmKVW+xlotholGa6yE9iw0uF/tHV2p52o=;
        b=mnfmnRBjQV1nJm4dgu6CMiaOIvRGbFTme6Pl1KSuGyV0jNbxQpy8SHa4aFwozh5DLc
         ZyiWxAG6PurMCsCxZzSYHpf798qN3GyU4PF2zmt0xoX11nJuOfBqwVZ7Yuh5i9D07PHZ
         qK7Gcjt4aMKoqYbrN4Uwhe6OeZg0vn/ky9/unMzOF7NL6Ez1tSVukGZqrt7Ou2oEUZVa
         FsaeCMKHUBvw3H5GYhFYuR4ugfb7DYe6Mz9HkTJRIypEmLiwH8NTBXaNLRBH3qRvIFMR
         +iemWyTP4OYGzgqxGTeQQPE2jIPEXx4F06A7w0xS/Q/OVUkRoIR0xFCcGLQLaJDCt8Ta
         SXYQ==
X-Gm-Message-State: AOAM530LEWxwZcexu06oNaEYR761n6A6uqKnv86lY+St5mOgZs/39gms
        MvROfRLD+xLVuAy7EVOw+Qo9wvr8NCTDngidVIs=
X-Google-Smtp-Source: ABdhPJyx/GQSOWYSoc1Zbdbw/tpxR1dF+HznFS7w34jPMlo0rvu3YqqIMH8KRsr/ZDfW4oKqcK49kJ0r/p8Q4qeFtaM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a25:2b85:: with SMTP id
 r127mr44980616ybr.232.1629738812933; Mon, 23 Aug 2021 10:13:32 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:09 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 05/14] lkdtm: Disable UNSET_SMEP with CFI
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

Disable the UNSET_SMEP test when CONFIG_CFI_CLANG is enabled as
jumping to a call gadget would always trip CFI instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/misc/lkdtm/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 88c218a9f8b3..bc3e54e580ab 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -366,7 +366,7 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 
 void lkdtm_UNSET_SMEP(void)
 {
-#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML) && !IS_ENABLED(CONFIG_CFI_CLANG)
 #define MOV_CR4_DEPTH	64
 	void (*direct_write_cr4)(unsigned long val);
 	unsigned char *insn;
-- 
2.33.0.rc2.250.ged5fa647cd-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D154599AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhKWBZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 20:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhKWBZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 20:25:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CFAC061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:22:38 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m27so86340542lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8ragH9mrm78TEDc0slgjQMbYNAP4RfkPoqdokFyY0M=;
        b=gfBDsWIanJ4lntlpU0kRxpVEtGJaAoE8tLJZOqujLHDpncY1+KCBbXa5xSZVMPBXSF
         +wrIbQ5lHISJMpRz3GRVtKQCvS2q4ISxgMdW42j9pqz8TUlC3YgSFcmM6rC+VbFwgDBw
         7+Ds3rNvr83cgCk1RW8Ycm4Y0P9MgqB7wkCWu3zwAvcd7vUu3AU8FmcgcvdV0MPRjLKl
         D96MBYhrEy8YxkqBESOKaB11jXWv45LUZgpsS6X7qUDeHCxBZ3nhgfufJQvd3S27qJTU
         3a9AmBn+toS6g1EL1AEoWlFmL5smibo7eGvup3uIJlMhxTseJgHrfh+8+KJHlKcIz3wA
         pqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8ragH9mrm78TEDc0slgjQMbYNAP4RfkPoqdokFyY0M=;
        b=WuqUu00s00SLJhj0ageRC8ITdau90vcT4jOt1MGsEftcCup+RxoQuMYwGkDJwBT43s
         b2FxTtTSbG7BoqJA5ZKptk+jKLXswp+01SA/41x+hGB8NTH3G8gktDa37NmIuHbn5wk0
         KHOc3Bdm1jfE8a0L4FYvnT7tQH6GqctuzXlu3wXSEi0JJx+qXaYWdKr0sQ7O96OaNvT8
         JRiYI0bSsXjmBwoxk7gxuVAGjo0UHf1F84MKGifK7Mce5pCYYYppwzXCWJZ5e7uAZcNB
         0Edbji2ziihO032hzZ9IhZzRfa2hH2owq9QZ9Bkf/JvU4xz+2CDPGgGo5wWuTd/q7vv+
         os9g==
X-Gm-Message-State: AOAM533Km83yfAWnmegT13eWJZ+agrg5HS4bvhUvT+pA8PcSpZbo2NQ2
        rKOMPdU5JYgH0jSbKs1yyFU=
X-Google-Smtp-Source: ABdhPJx0Y12MI9ulk8sLJ4yflVREAsPfIxaw+Yr5tbSFwPQfshDmCtKusvpnWyTbwe6SEQVOFrL8IQ==
X-Received: by 2002:a05:6512:33c9:: with SMTP id d9mr745890lfg.615.1637630556379;
        Mon, 22 Nov 2021 17:22:36 -0800 (PST)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yct-z7s--tg8y8t-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:50fd:36ff:fe05:e039])
        by smtp.gmail.com with ESMTPSA id c15sm1304038lfb.40.2021.11.22.17.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 17:22:36 -0800 (PST)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Bill Wendling <wcw@google.com>, Joe Perches <joe@perches.com>
Subject: [RFC PATCH 2/2] pgo: Make module.lds.S linker script to merge __llvm_prf_ sections.
Date:   Tue, 23 Nov 2021 03:21:37 +0200
Message-Id: <20211123012138.160532-3-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123012138.160532-1-jarmo.tiitto@gmail.com>
References: <20211123012138.160532-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler leaves many duplicate instances of __llvm_prf_* sections
in final module objects and they confuse the kernel module loader.
Fix this by providing module.lds.S linker script that merges the split
sections like vmlinux.lds.S currently does.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
I'm not sure the linker script is entirely correct and
it propably needs more work.
---
 scripts/module.lds.S | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 04c5685c25cf..83ca5825c0c3 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -60,6 +60,39 @@ SECTIONS {
 		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
 	}
 #endif
+#ifdef CONFIG_PGO_CLANG
+	/*
+	 * With CONFIG_PGO_CLANG the compiler may split __llvm_prf_xxx
+	 * objects into multiple sections. Merge them in final .ko object.
+	 * However leave .rela__llvm_prf_data sections as-is
+	 * since they are needed by the module loader.
+	 */
+	__llvm_prf_data : AT(ADDR(__llvm_prf_data)) {
+		__llvm_prf_data_start = .;
+		KEEP(*(SORT(__llvm_prf_data)))
+		__llvm_prf_data_end = .;
+	}
+	__llvm_prf_cnts : AT(ADDR(__llvm_prf_cnts)) {
+		__llvm_prf_cnts_start = .;
+		KEEP(*(SORT(__llvm_prf_cnts)))
+		__llvm_prf_cnts_end = .;
+	}
+	__llvm_prf_names : AT(ADDR(__llvm_prf_names)) {
+		__llvm_prf_names_start = .;
+		KEEP(*(SORT(__llvm_prf_names)))
+		__llvm_prf_names_end = .;
+	}
+	__llvm_prf_vals : AT(ADDR(__llvm_prf_vals)) {
+		__llvm_prf_vals_start = .;
+		KEEP(*(SORT(__llvm_prf_vals)))
+		__llvm_prf_vals_end = .;
+	}
+	__llvm_prf_vnds : AT(ADDR(__llvm_prf_vnds)) {
+		__llvm_prf_vnds_start = .;
+		KEEP(*(SORT(__llvm_prf_vnds)))
+		__llvm_prf_vnds_end = .;
+	}
+#endif
 }
 
 /* bring in arch-specific sections */
-- 
2.34.0


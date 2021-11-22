Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB34459876
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhKVXgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhKVXgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:36:36 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:33:29 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 28so16571807pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=w8ragH9mrm78TEDc0slgjQMbYNAP4RfkPoqdokFyY0M=;
        b=RdemdDv+PT6TI1EX1hWhyDA/C3BTBe1Hx8jjvlzhLqBa7o0fxPjjqbGbA/oUaJ8TIi
         iPYE0fRiZdNUTvBdfzBKtR1rtBhkEdS/8eWk1geuIwNht+dSaPAjToulFypUNjVioFfV
         6hPiyOWNl9VZkuLOjY8A9zueAu0Bra+nJFp74dOJUKkji3dXMx6GNgdqY46JSFKKaNE0
         VVPO8v7DHMfpJVJOyy1rNiNxOaCGqov6+yqpNuaveLBtc1XIb6cCBZ2fJbtdVgS2oBuQ
         rxzRwyxanuIRpUG3QwXK9fLC0MhB53rSk6CgH+e16gW26yC7Ava1Ly0QjaBKKWQsjRyQ
         eGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8ragH9mrm78TEDc0slgjQMbYNAP4RfkPoqdokFyY0M=;
        b=MFu97Cvr0XaS8vvpmn65v7Gg1Bu+tBKpDP2TTH8nnyNo2VkDoojwhgo4tha/d+JjZ0
         o0ZY8Qn13NSzPtpDP+JkZ6M6ew9iAiNPvXfR0v6FVuejwKzVAwjbe/sQk+DSAWTQlNaV
         ewuLUI9uR3itiPllLuxS+2LQhrcXvcn3xY5zJwXjGE2rVFLi2ggGAQLCLjh3U7Nk5OFn
         qApV6pkl8WQsX4SeGgvUQh8vQNqqUMaO/0ZDSACjqwf45D6+NRIif5wqje4OqIL87gqF
         Hv9q31cS/Rr/HtbSSiUXyXhV7gtoxMEJPxuiIXtEV6I1XTIHKan/5bbYz7KkxLNpMLRk
         uFQg==
X-Gm-Message-State: AOAM532YEAP4dbfErCZmJBHR4JE6ZQYX0Z5n4ynMuxh216EhvqPqro1q
        cW8VGGLFXqrv6SVK/shvdNM=
X-Google-Smtp-Source: ABdhPJya3pIPigeQ6yYs+xMnOjIgz/Uw07fleQjtz1sYUJQv+qWdAyZzE/qKHGL+HEudV2/gl9CbBQ==
X-Received: by 2002:aa7:8b07:0:b0:4a4:d003:92a9 with SMTP id f7-20020aa78b07000000b004a4d00392a9mr471462pfd.61.1637624009257;
        Mon, 22 Nov 2021 15:33:29 -0800 (PST)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yct-z7s--tg8y8t-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:50fd:36ff:fe05:e039])
        by smtp.gmail.com with ESMTPSA id y6sm10195837pfi.154.2021.11.22.15.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:33:28 -0800 (PST)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jessica Yu <jeyu@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] pgo: Make module.lds.S linker script to merge __llvm_prf_ sections.
Date:   Tue, 23 Nov 2021 01:33:05 +0200
Message-Id: <20211122233306.155968-3-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122233306.155968-1-jarmo.tiitto@gmail.com>
References: <20211122233306.155968-1-jarmo.tiitto@gmail.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006A739BDF7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFDRGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:06:10 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:36474 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:06:09 -0400
Received: by mail-lf1-f54.google.com with SMTP id v22so13760482lfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zOR/sU+r9oeeOAL1RpTyfw06sLPCoIho67jVt49xNeE=;
        b=nuzaLCUWD4kthdV6uLQJO5zTwQ2Blcg5YOSTOm+VzlJO6Tgpc94dSYKRtgNkMvjUo8
         oJzKPLd9h6+ziMpFsqa99Q6Tp/c4RTNKXMuryWxSJZNHbN1gJreyXLIbm+8k7lmlzXpm
         5sifSvuaUfmmRPcqE0M/+cXtlgPxg9g24SFCrbcdNTaGicKV0cpEAsczPbwd9IZyY2ww
         z+n95miiH0SxTRFEkqHvUdJnhcOVD4OssNGbt25MpxbfwfZyB7lOwFQej8YU6GkvQTL1
         +Uv0Um+Hs8xpSJ7GRnsvZS8RxyD8TkKXOPNopiod9Gk+RX3b8w0wiE6bQQYm8woeGw9C
         L8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zOR/sU+r9oeeOAL1RpTyfw06sLPCoIho67jVt49xNeE=;
        b=RwWUK7PLFnUp9VF6VzHT7S3Ar2aSHQBaoVS+kZ0pWfzG3RhNrJbk+6vzvo2oozdva+
         Ku0LsOvw+Cp9USlmSQSFODY11Oyx5getiiNgVTvUbpL8EdIQDLK/pKyIWIfpZjfKKW/7
         yQJ94Uvf6WWVmbkXyKKNGOvMvwNtJebj4mV8QtHbwqj8HtBDs/zLRuwDEatOCl/gThfc
         GVxZGPdC+MxA8Ql1RA4Ga5V+gGGVb8c0z1lPctkuOEm2vUpq4pTBwMAoKDS2GSiavyeb
         KbxC/kwptnm0bb5O0o2fAA+PvNIQae3Pw+XVaxAAf857DmY9HMWFNIiUYCN4XWqSVymi
         PGMg==
X-Gm-Message-State: AOAM530AFgMPpMbt91lUqBa7M7SJeNTk+gp6g3DtUlPxsIwq3QSdsOTM
        qUnwvRRzxuW0hNYH9izpJm44Bjps6WTSzn6y
X-Google-Smtp-Source: ABdhPJyYII91WffG3Ly7m3rZX/hX+Y5SEVDIh7KIlGxKtwflEHI3WG2OTc2KUTLW5TmHiSgFAFjeWg==
X-Received: by 2002:a19:58f:: with SMTP id 137mr3305399lff.188.1622826202418;
        Fri, 04 Jun 2021 10:03:22 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4ycc2b7s--vdqzfy-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:42b0:76ff:fe23:6d08])
        by smtp.gmail.com with ESMTPSA id q184sm817310ljb.54.2021.06.04.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:03:21 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [PATCH v3 1/1] pgo: Fix allocate_node() v2
Date:   Fri,  4 Jun 2021 19:58:20 +0300
Message-Id: <20210604165819.7947-1-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When clang instrumentation eventually calls allocate_node()
the struct llvm_prf_data *p argument tells us from what section
we should reserve the vnode: It either points into vmlinux's
core __llvm_prf_data section or some loaded module's
__llvm_prf_data section.

But since we don't have access to corresponding
__llvm_prf_vnds section(s) for any module, the function
should return just NULL and ignore any profiling attempts
from modules for now.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
Based on Kees and others feedback here is v3 patch
that clarifies why the current checks in allocate_node()
are flawed. I did fair amount of KGDB time on it.

The commit is based on kees/for-next/clang/features tree,
hopefully this is ok. Should I have based it on linux-next
instead?

I grep -R'd where the memory_contains() can be found and it is only
found in #include <asm-generic/sections.h>

I cross my fingers and await if this is my first accepted patch. :-)
---
 kernel/pgo/instrument.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
index 0e07ee1b17d9..c69b4f7ebaad 100644
--- a/kernel/pgo/instrument.c
+++ b/kernel/pgo/instrument.c
@@ -18,6 +18,7 @@
 
 #define pr_fmt(fmt)	"pgo: " fmt
 
+#include <asm-generic/sections.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
@@ -55,17 +56,21 @@ void prf_unlock(unsigned long flags)
 static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
 						 u32 index, u64 value)
 {
-	if (&__llvm_prf_vnds_start[current_node + 1] >= __llvm_prf_vnds_end)
-		return NULL; /* Out of nodes */
-
-	current_node++;
-
-	/* Make sure the node is entirely within the section */
-	if (&__llvm_prf_vnds_start[current_node] >= __llvm_prf_vnds_end ||
-	    &__llvm_prf_vnds_start[current_node + 1] > __llvm_prf_vnds_end)
+	const int max_vnds = prf_vnds_count();
+
+	/*
+	 * Check that p is within vmlinux __llvm_prf_data section.
+	 * If not, don't allocate since we can't handle modules yet.
+	 */
+	if (!memory_contains(__llvm_prf_data_start,
+		__llvm_prf_data_end, p, sizeof(*p)))
 		return NULL;
 
-	return &__llvm_prf_vnds_start[current_node];
+	if (WARN_ON_ONCE(current_node >= max_vnds))
+		return NULL; /* Out of nodes */
+
+	/* reserve vnode for vmlinux */
+	return &__llvm_prf_vnds_start[current_node++];
 }
 
 /*

base-commit: 5d0cda65918279ada060417c5fecb7e86ccb3def
-- 
2.31.1


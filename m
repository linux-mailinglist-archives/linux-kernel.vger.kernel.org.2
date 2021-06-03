Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7939A266
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFCNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:43:56 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37696 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhFCNnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:43:55 -0400
Received: by mail-lf1-f44.google.com with SMTP id f11so8860315lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hNbuwVCZ+C+A91GjVTfRrYyB2m5hEsern9MfCM1f69Y=;
        b=Um/NnAYIVDGEVpkG9oUzlGAuXt2pMWqP+jguiv9Koq9Zv3gxb44POA96fMA2MGxwsL
         k0DTFKgeWVAJBsSDsEKdhmqmSP4vi2qT1OejNHBwHPT6/UIqIJDJ1jBV+OEORGIRiMW4
         cOCgFqANYYuu9XV8KAwJLyiMmWlOm3aNaUij3WZ6wK0aAq08A/ll+M1i65QWinbuhEjr
         pCuc29hs86cCbnf7M6YUG3RbaKgoZ1pEA1AXXiX5LOg75Wnudf7QZpPoIsCBndkgbma+
         x+fgA5ZhL8wDy/YQZBbPNuFsTTbBJbze4S0UZgnxGFY4UJ7uweg8Y6HP7faidkLUhjAc
         rMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hNbuwVCZ+C+A91GjVTfRrYyB2m5hEsern9MfCM1f69Y=;
        b=SZ4jK6M/DdYQopLplw/Fni7JcIjDuzJL0EEdm0XaLktKeJZIs4XKoBsZYAmoqfZzAR
         RqEY66lSgFEaZyAMFwwI4Eh9aZ2sQBBHKhSBYpZWk2oifOdGvgk3OKCgc5GczwFkjPrI
         GdR9VCi+5EkOn0ogZkBd/Uc8wBI/Zp2fJ4IHK8a2DWn6UcH7RFVAsB0bIV0QPVEXZf/0
         8atjcgOnXrFIIWnsn5rYBFDJw0Ta03YOv6IiyurM3/S26MLcW9n5VrcdczJKCivA9DLt
         ZSzAdsE8GzFsiuCVm2T3WgpXptrFE9hrQAlcCX89gYvDaPT14S8FTyNbI7RbjGVVF463
         gXIQ==
X-Gm-Message-State: AOAM530yPJopsXDXXFhb2oyw/j6/lPI0MVda/x/gUrzLdmibwX+4U2dE
        yNM7kt+DVghyTkvjBJ/aQt0=
X-Google-Smtp-Source: ABdhPJyD9rQrA/peCDanigOUTFzH1CS9PzPzRoHXK9X0BcfFgrxwEEA9uiBGRHZP6scDdkZm9Ls6/A==
X-Received: by 2002:a19:8181:: with SMTP id c123mr15119652lfd.533.1622727670314;
        Thu, 03 Jun 2021 06:41:10 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yb9bh06yk5jm2qt-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:3d09:bda0:2327:559b])
        by smtp.gmail.com with ESMTPSA id a1sm322079lff.215.2021.06.03.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 06:41:09 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [PATCH v2 1/1] pgo: Fix allocate_node() v2
Date:   Thu,  3 Jun 2021 16:38:52 +0300
Message-Id: <20210603133853.5383-1-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on Kees and others feedback here is v2 patch
that clarifies why the current checks in allocate_node()
are flawed. I did fair amount of KGDB time on it.

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
 kernel/pgo/instrument.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
index 0e07ee1b17d9..afe9982b07a3 100644
--- a/kernel/pgo/instrument.c
+++ b/kernel/pgo/instrument.c
@@ -23,6 +23,7 @@
 #include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <asm-generic/sections.h>
 #include "pgo.h"
 
 /*
@@ -55,17 +56,19 @@ void prf_unlock(unsigned long flags)
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
+	/* Check that p is within vmlinux __llvm_prf_data section.
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


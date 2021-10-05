Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6242239B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhJEKem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbhJEKek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:34:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C053DC061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:32:49 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r201so13434097pgr.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0e/7+5SzXQlLpgEzunZbHUeI6qjzjZ1gfmuGHDew4tU=;
        b=RUzoPnosbqWC5sLgAzQZvUdX5QkKXIYSDStLRafwbiSwjDAzbVh0n78R1nwOSB/oPJ
         qtxROiWMbDXiFn9qqmMENe0iZmMnEvQYZ5ji3e8nhmoKDmO8GS7hSOoAXQG13ob78yZZ
         H6CR+Yvu/Q74Aw3WqZvSEJM68AZYSXTB/Xx5KOFqcjYADqM2OnFltIyOQ0lMJA6KiyJI
         SsC6Lvt7EJhtj6orghHUCvDBnfpVUJinA8z5lXOb5j1CIdUYasEGFrfRbbpnFdT6eJTF
         V3s7wA3/ugkn71nV/YMOl1bHdPwduqHZvcu1Qgbf8O9HGH3NhUXbXibzu5S3JhN+ayqk
         gjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0e/7+5SzXQlLpgEzunZbHUeI6qjzjZ1gfmuGHDew4tU=;
        b=WakiV2BK1OUulCaMUlOECDY/fbWlr0TndQRILidq1EKnEylHWapV0ctHhkjoD2H9+F
         JbzqaASP5+Uqh7p0Y/hfCih2z2Z7jrmiIRyU4ilPtfnCG/Bkpd7Ga8GA1NCcIPnJMh8K
         RTe9/sxLzrWUgi2LDsI0s3jU/UgkRXugD479U6mBH9XQVkfalVChI7liNTxCnabWjErI
         kVswifChEb59VQQexa5qMmeetVsYU0c2yOK4Q96VxInfdpKCu6x0JiyNQJASR8TjCO0f
         p9wXyfDTCAOdGZ8bD2XTTZ5xKmhbnZ0EeW/oJrugq9GM0Joy9KC+PimTrDzzW+sN7WI4
         RjEw==
X-Gm-Message-State: AOAM532UWjCOzSdVfEoqlX3Bha8kb1nVb0H/LpFEZPNF4vhu4LIXjNQD
        dydC+xe9aSoDe7XUVHSprC1p1hOy+y+s01vv
X-Google-Smtp-Source: ABdhPJwEfwXg2t1YeKsh5A7Ps3+TPUG5Trd060oPzJmzViQVLTbj0Y3kNNN2tK6cmP21KovOIuAVYw==
X-Received: by 2002:aa7:8116:0:b0:44b:e0d1:25e9 with SMTP id b22-20020aa78116000000b0044be0d125e9mr31039841pfi.53.1633429969060;
        Tue, 05 Oct 2021 03:32:49 -0700 (PDT)
Received: from localhost.localdomain ([223.178.212.101])
        by smtp.gmail.com with ESMTPSA id s7sm12853639pgc.60.2021.10.05.03.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 03:32:48 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, samitolvanen@google.com, ben.dai@unisoc.com,
        mark.rutland@arm.com, nathan@kernel.org, keescook@chromium.org,
        daniel.thompson@linaro.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] arm64: ftrace: use function_nocfi for _mcount as well
Date:   Tue,  5 Oct 2021 16:02:08 +0530
Message-Id: <20211005103208.2763305-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 800618f955a9 ("arm64: ftrace: use function_nocfi for ftrace_call")
only fixed address of ftrace_call but address of _mcount needs to be
fixed as well. Use function_nocfi() to get the actual address of _mcount
function as with CONFIG_CFI_CLANG, the compiler replaces function pointers
with jump table addresses which breaks dynamic ftrace as the address of
_mcount is replaced with the address of _mcount.cfi_jt.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 91fa4baa1a93..347b0cc68f07 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -15,7 +15,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #else
-#define MCOUNT_ADDR		((unsigned long)_mcount)
+#define MCOUNT_ADDR		((unsigned long)function_nocfi(_mcount))
 #endif
 
 /* The BL at the callsite's adjusted rec->ip */
-- 
2.17.1


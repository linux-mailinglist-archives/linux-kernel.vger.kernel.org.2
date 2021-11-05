Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA0446701
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhKEQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhKEQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:32:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E7CC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:29:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p16so19832816lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MN4Fk7CkJVCmNEab/XLa1e5EYDL4RIMnp+86qrVvnUE=;
        b=HEStputohMMdoPj00/j0ebywSZpcViafg3PCxGzvOoTIVVZ5Npq4m0yMrLBeVhSu2c
         QVACQWtNl/WwMeMDt4sn2uRwTJlFj8FskFc7ddCDxXGlfFnm6gfwx9vaV6AlCDWzL6t5
         rbs1q2Qsrizw0x6FfHkccp3gJxfg7RuV/AaCnZjs81z0ONCOIs7LSF18mbcDPFq1vvss
         Txa5KEjCmnU4RM198XwuWE7U1FI8VqC/lhE+2K+KFL+vDwgGAcg8dCGuGzDGurm4x3A/
         IKMD0HeWSK7HpNE0tN8p+hjASN7k+MoQibXXOeErFy1UhUkdEBBDOJg6p/sf3AutMQ8D
         WjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MN4Fk7CkJVCmNEab/XLa1e5EYDL4RIMnp+86qrVvnUE=;
        b=QSMQPU9kTzCOdeQ3xrUrSo7QL83LYd+XaYoAXinN4mLulrW0Edws3UUeE0jJ1jnoyQ
         dsJHISwpdnNT12ZxD3ptBYSJz8vkErILMk7lhqWz5SqpGg6LQXA2zDUcZHiRo6yZTt5L
         W7uxp/7VdiBxzBexSrAlBjScQvZwGfArXAMad8rcDnVB8cB8K89vQiBfHuXOmSqVo1Aa
         KOO6SWD8EiICgD4BIvznsV1Zqn1msumQLkOQzPt8aM84YfP2DDsnJdMWBuaoObpXDZ1i
         083AkJQKFzDVPm85oumJpA4siVncdzLx6T1Hoh4wRtJGsTtStOB0/bu+hLvDUv7RQjlj
         W0gg==
X-Gm-Message-State: AOAM531ABJtdcyfsWRSvDf8RFvCN51ZIWHkW0ECPL+3paQZs8YhPvoef
        D3FIt0XcJVwBTpc9TGEaVaWgtQ==
X-Google-Smtp-Source: ABdhPJwgor9aGLH7GIOLGnUGmxF24CLFUbUBxn/Q15DzlweL/ck79/uYTaIZ8yRIUFnZPgy05GHUqw==
X-Received: by 2002:ac2:4e68:: with SMTP id y8mr56775071lfs.348.1636129782878;
        Fri, 05 Nov 2021 09:29:42 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id bt20sm877495lfb.47.2021.11.05.09.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:29:42 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: mqueue|vDSO: fix convert pointer warnings
Date:   Fri,  5 Nov 2021 17:29:40 +0100
Message-Id: <20211105162940.3319021-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building selftests, mqueue and vDSO the following shows up:

warning: passing 'int *' to parameter of type 'unsigned int *' converts between pointers to integer types with different sign [-Wpointer-sign]

warning: passing 'const char *' to parameter of type 'const unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]

The code looked OK so what normally are done are, adding the compiler
directive to hide the warnings '-Wno-pointer-sign'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/mqueue/Makefile | 2 +-
 tools/testing/selftests/vDSO/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mqueue/Makefile b/tools/testing/selftests/mqueue/Makefile
index 8a58055fc1f5..814907b6344f 100644
--- a/tools/testing/selftests/mqueue/Makefile
+++ b/tools/testing/selftests/mqueue/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -O2
+CFLAGS += -O2 -Wno-pointer-sign
 LDLIBS = -lrt -lpthread -lpopt
 
 TEST_GEN_PROGS := mq_open_tests mq_perf_tests
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index d53a4d8008f9..2a60233ba2fb 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,7 +12,7 @@ TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
 
-CFLAGS := -std=gnu99
+CFLAGS := -std=gnu99 -Wno-pointer-sign
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
 LDFLAGS_vdso_test_correctness := -ldl
 ifeq ($(CONFIG_X86_32),y)
-- 
2.33.0


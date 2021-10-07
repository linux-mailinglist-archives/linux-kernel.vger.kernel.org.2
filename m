Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB9D425CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbhJGT7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 15:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhJGT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:59:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C9DC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 12:57:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so29674883lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGor7P/MIIDgun+i6pgA/MAZ+H3uPhOwk6A6sZ0hHBg=;
        b=R21iyWGzTKdQqmMBYI2znBis9JMYix+KD+eQYwhHITr+sbTfzNgUKiXduLLARgrn4l
         TqxZuEYBstH7BalmGfU2HAdusajKhPsuPSBvzJKOpqxYrJDFEkw9mr4BtJ9qS+0pOh7w
         xCeUb/H937PWeZGJGy5WjbIsVyRMHY12UoH/cqReszvmjbXE1jkHRVafTnW3n2KaK0sF
         k5tPFpFjFqKR2FOGYFGMBjRby63e4yvkiUKvZ/8Lt1L7S+Qqfaf1HPjGmr5gI37oAO/J
         /aXxZiq8VqsdDL28ZH4ABKneC77tXtDR4PKwDvzPMru+4cRJd4UDVW6CNqyPpA7YJPv2
         88Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGor7P/MIIDgun+i6pgA/MAZ+H3uPhOwk6A6sZ0hHBg=;
        b=4NhfCuUupMv/PHeB8IbW1fiJt/AopIrjk/59zWFhmCL06+5mEX+3v3uJdPdlWWai3o
         pNeVKOvAD3jIPwQ9M0nhXlwe97dZbOqpTP7rb1CTwLTce/jGeZpVu5KLUHlKUWw0XrYX
         gRXw9nktw220voB0lLbKrNMPp+KQz+mvOjWKSxYFk+G/1FgpNYN1eC4A1g4yTpm3F6d5
         bN6m3aEQp8fMeMcSJ/9ovtseMFwlJLSoBrvEt8gNZiDJuIU5B8xJacw3auTb4whJfZDv
         jn37nI+oQtM9KzQF0C+JHoKCL9fnrm9N/M7YJxVkn9qbicrKsVLshR/Ann/kxyI1phCn
         Exwg==
X-Gm-Message-State: AOAM533mh1XqGhQHt42aNm0MwozXbim1wz2f+W90xkAPamHfKG8sbu98
        9gHCM2kSlUvrSgjUxqq+ZFxelw==
X-Google-Smtp-Source: ABdhPJxdKUQ7lvhSAIpU8tyzVwN7scOF7NKER+x/zyBHDMQhvXRLE1KitpZP2CT/OyZGGgTxzSjtXA==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr6546011ljg.158.1633636676165;
        Thu, 07 Oct 2021 12:57:56 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id d26sm26925lfi.154.2021.10.07.12.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:57:55 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm64: asm: vdso: gettimeofday: export common variables
Date:   Thu,  7 Oct 2021 21:57:54 +0200
Message-Id: <20211007195754.678124-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with sparse enabled 'C=1' the following
warnings can be seen:

arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning: symbol '__kernel_clock_gettime' was not declared. Should it be static?
arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning: symbol '__kernel_gettimeofday' was not declared. Should it be static?
arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning: symbol '__kernel_clock_getres' was not declared. Should it be static?

Rework so the variables are exported, since these variables are
created and used in vdso/vgettimeofday.c, also used in vdso.lds.S.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/include/asm/vdso/gettimeofday.h | 7 +++++++
 arch/arm64/kernel/vdso/vgettimeofday.c     | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index 4f7a629df81f..da8dfb119c30 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -12,6 +12,13 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
+extern int __kernel_clock_gettime(clockid_t clock,
+				  struct __kernel_timespec *ts);
+extern int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
+				 struct timezone *tz);
+extern int __kernel_clock_getres(clockid_t clock_id,
+				 struct __kernel_timespec *res);
+
 static __always_inline
 int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 			  struct timezone *_tz)
diff --git a/arch/arm64/kernel/vdso/vgettimeofday.c b/arch/arm64/kernel/vdso/vgettimeofday.c
index 4236cf34d7d9..1a44d1e32746 100644
--- a/arch/arm64/kernel/vdso/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso/vgettimeofday.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018 ARM Limited
  *
  */
+#include <asm/vdso/gettimeofday.h>
 
 int __kernel_clock_gettime(clockid_t clock,
 			   struct __kernel_timespec *ts)
-- 
2.33.0


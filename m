Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6361B43634C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhJUNsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhJUNsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:48:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F47C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:45:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t184so345932pgd.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=koUrUpf8/lWFSVycc73OYER9/wNi0PLyGr7jK5BVrkE=;
        b=VjYlFYBFcBY4Xf9hmTEBkgkmnvg8mfNqcDq3fEUxO5+UegVAxYVvGBBJircBFhWdoe
         MUyXt116AIC80z9y4TuxxMXXx+dh3gDh3EIJOTPTSx/bPec2VyGePhDz9RvuX/qBV+3s
         7G+1Xf/zPB3OXGgfAc+1j+rgDWbRtcDmTRmzzgW9lpIpt+DPemN9l+jLluJUoJDVig6X
         DUIL4TbY3lSiinMS43t7gW5dMkcj9LL/OS3+4dEJxar6iJr3EpGIO0INmN019BtEgdzD
         0pYZyrcaSTOmiipMDJRFH58htob4krdZ8wd2GvDlN1+/PkUEl7KVtnQKWd9Z1mN22ea3
         gqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=koUrUpf8/lWFSVycc73OYER9/wNi0PLyGr7jK5BVrkE=;
        b=uZRQC86iQZ53n95sOXZ4mK5J3WLUH0JXq7YAwzQcZGJ5aPAOcDaaMhgAo59LTSqP78
         2DjEvt5ecytfNLqcgVfpdBCja2CnJUWlynq1uS3sc5TtXFi8/cumLA6JHHEUc/hRV5ye
         ymjGioUbgOkByrBfcNLHWWevtRNmt6RG2vw9Ixj2t7nReM1XGFRBMM1/kATkTitRoUja
         gqTDQyy4MwBOLvVVLdTDn6z58QnyIF1mJV6AwYtLkzuMqmcyUEJHJXhhzA669v7fdk1u
         b5NZ3M6n/DWZwus3kGvcvhxy/jW7J962T+DJzEtrhbm0+mr08tSxQJwKCgzlJIuU1yZk
         t8Ng==
X-Gm-Message-State: AOAM533rkt6lehFRN/hIvFeXpW8NT0vu86QPRpLbPRpJ6E5cgcj7KG2k
        UIG4lY1M3tC1ob5c1cY6DWpSqQ==
X-Google-Smtp-Source: ABdhPJwvgZgAy8cV8JcLrX7e83ZSIgNJ+0e7SgDaeSbYMx5rKqLga2ogThAEQvXS3l2rwnBM8gwfzA==
X-Received: by 2002:a62:6d86:0:b0:448:152d:83a4 with SMTP id i128-20020a626d86000000b00448152d83a4mr5805089pfc.38.1634823951886;
        Thu, 21 Oct 2021 06:45:51 -0700 (PDT)
Received: from localhost ([103.127.241.129])
        by smtp.gmail.com with ESMTPSA id e12sm6021827pfl.67.2021.10.21.06.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:45:51 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [RFCv1 3/4] arm64: Introduce functions for controlling PID tracing
Date:   Thu, 21 Oct 2021 21:45:29 +0800
Message-Id: <20211021134530.206216-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021134530.206216-1-leo.yan@linaro.org>
References: <20211021134530.206216-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce two functions contextidr_enable() and contextidr_disable(),
which can be used by kernel modules to turn on or off PID tracing in
contextidr register.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/include/asm/mmu_context.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index e1f33616f83a..0c1669db19a1 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -37,6 +37,16 @@ static inline void contextidr_thread_switch(struct task_struct *next)
 	isb();
 }
 
+static inline void contextidr_enable(void)
+{
+	static_branch_inc(&contextidr_in_use);
+}
+
+static inline void contextidr_disable(void)
+{
+	static_branch_dec(&contextidr_in_use);
+}
+
 /*
  * Set TTBR0 to reserved_pg_dir. No translations will be possible via TTBR0.
  */
-- 
2.25.1


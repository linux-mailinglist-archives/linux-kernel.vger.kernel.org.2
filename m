Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B25C43634A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhJUNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhJUNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:48:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC2C061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:45:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so579928pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4YhQIiG/VVRYQyoXQKHZiWpfOu0OLjbGvCY/d59nFU=;
        b=HlmJX7TRx4UG0ncPN6Qe3EXnk2ZF9DqLFJphH7uq5N7ZIMVDkvlFe3OwfVkzv+jOUX
         nEDYcNKn4FiMGpSyH9MwVHOjHjmj/xJwjp42QY85oyBxzOp3Lfi+oyWc4CCwbsr/h1VR
         ZZ5f7OSp4EysK8w2Ca20O+4hNrZOXf2w4wqak+Z1N/vLht/egXfxz5WzI9ZalH/lUvC+
         nTVD9dOb5T+i2eO4DGb3yPVbHOT2JcUv4xEZ/LSjuG+2BUNPjSk4+GZK6l+QMLfHUw7D
         agQLiL+7qyQzFutls43OjUocmcdw64gKS0AWCnKD47K7Pp7YDIOW73Lxd6Kl0f+KTK+C
         UJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4YhQIiG/VVRYQyoXQKHZiWpfOu0OLjbGvCY/d59nFU=;
        b=qZjsqoFxIHCSiszQochZs0V4ROd1Que2FJoLXu2fc+DvDtfemoNeYiJqLMmOKTTlyU
         eMyPiO6D12PIYNTWV5xcpsquB66KpQsoNaC8YHHC6FTEaIxJbiROrttbNfrEDgSw/x5N
         MiI9Krv3ZDJFkzpEx3yc3Kk1Yp6oC+qipLm06LKYPhGdstlLheeLz05ZWAQZJes9cS9u
         jY9V2rQBMELWe3+38fD+/7qnwgDQFTKDsijfc6Zho9JJqE7PCIbwKmf2frJmeCR4Pt2T
         t3+j1Sjp5D/0ROd/F2Bkk/uJieXk3c5BX+SpwsL64d9GhNraTKeHDshUblqaT6+UQdFz
         Dnmw==
X-Gm-Message-State: AOAM533sQszuitaeoieEl7SvYgmYarUcemruc+H1NDVlwdkgFbTRs5Qk
        r+RHFMazcxAUsreh69xgXxMm/Q==
X-Google-Smtp-Source: ABdhPJwvwIGLuEN95nh+Hdt3OX1LVT7d/V/k3x5/tuTpUkDCBpOM1BJzR/hzpYqZkA7GOoyte5YkgA==
X-Received: by 2002:a17:902:b213:b0:13e:cd44:b4b5 with SMTP id t19-20020a170902b21300b0013ecd44b4b5mr5250651plr.18.1634823948002;
        Thu, 21 Oct 2021 06:45:48 -0700 (PDT)
Received: from localhost ([103.127.241.129])
        by smtp.gmail.com with ESMTPSA id g16sm1370633pfv.192.2021.10.21.06.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:45:47 -0700 (PDT)
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
Subject: [RFCv1 2/4] arm64: entry: Always apply workaround for contextidr_el1
Date:   Thu, 21 Oct 2021 21:45:28 +0800
Message-Id: <20211021134530.206216-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021134530.206216-1-leo.yan@linaro.org>
References: <20211021134530.206216-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After introducing static key as the switch for tracing PID into
contextidr_el1, the kernel can dynamically turn on the static key to
use PID tracing to contextidr_el1.  This means even the config
CONFIG_PID_IN_CONTEXTIDR is not selected, the kernel still can use
contextidr_el1.

When erratum 84571 is detected, the workaround should be always
applied on contextidr_el1, particularly if the static key is enabled
dynamically.

This patch would introduce minor overload by one extra instruction for
accessing system register contextidr_el1 and it only impacts platform
which erratum 84571.  So it's expected to not cause any significant
regression.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/entry.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index bc6d5a970a13..c41a4cfff527 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -356,12 +356,8 @@ alternative_else_nop_endif
 
 #ifdef CONFIG_ARM64_ERRATUM_845719
 alternative_if ARM64_WORKAROUND_845719
-#ifdef CONFIG_PID_IN_CONTEXTIDR
 	mrs	x29, contextidr_el1
 	msr	contextidr_el1, x29
-#else
-	msr contextidr_el1, xzr
-#endif
 alternative_else_nop_endif
 #endif
 3:
-- 
2.25.1


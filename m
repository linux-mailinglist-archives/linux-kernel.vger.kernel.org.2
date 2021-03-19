Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43D5341951
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCSKC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhCSKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:25 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4DC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:24 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k68so33545958qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4ECUgkoGREkKZOm9t4R+RTCdTGWy+OUrTPPjtPvrKJ0=;
        b=Kj+I8XUSYAKjeGpLxIgkzojVoc6Q8aAjQUqoardRlMXHKkE1x3Hp6aM8/W0NWM3wS6
         x07KjsT3mubuXhnLmeMXsPrp95J27xOrKgqQaicqp04hJjOUrQbl4wZ1d3l2EuE97uNA
         KFdgzB6H1vfbT0rsB22AEOJFCzusxBM9LzoPnaWfcjUp3azDpVTiPRIxfaOg1PKXBhaH
         bYUn792zhUYnV0jBul2s5F4ZYllrirEigoIZnTFRQCrRyv492wSQXt/AYK5VB5/4OyuC
         x/WjFtLj0nEM7wDemTUmCdSj2rgipSR0u85xE4dOQwbcN0r87clqymHWiUiL4b06S1qy
         UjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4ECUgkoGREkKZOm9t4R+RTCdTGWy+OUrTPPjtPvrKJ0=;
        b=AEHnVIZ2kVv4hgZSgkbpiQPhfi59WhgzOFM/+6Gqo9rBhvtixW+RV87cyi1oZ/1oQ3
         6Dp/3wfAwkE7PbJvEr4Wos+VJ4aozN8XXi9kV0H/Tbwf9hPI1lmKyK3jPBZqKaiN3Vgo
         BZ+UfsJq9hWcZH0XEpiRQMsc3nMWYbQ9a9Q3qiQeuieVSF7nCx9p8g8QcEcMPABkZQBl
         8RkBGRb6Wp5kO2qJMNsjnPN2cz1vfh6uo0iHkzTUYZYbY1yVaP7UYAwG3ymXGbQTNEz7
         tc65jvxr8speP1DuBpBy03E6ZBiVT61mUv0rb4vEEOvxRInOaO2+Qt9Et7fnxxL+KkSY
         Wk/g==
X-Gm-Message-State: AOAM532ZtyLW48Pe+vjjImOsf8xwdm1nJ41WZDOsS3FnUaHTKPC/XKM/
        RDihp/NUplFVp43Sp0eQSpDT9jNtn5Iw
X-Google-Smtp-Source: ABdhPJwN/h3k2TuK4CzLkm34ikKDRS783RduDg48Qy26uhc+DzE4q7IWFs4e3z0EnUvFZoGZQ4HMayCWmea/
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:d7d2:: with SMTP id
 g18mr8356263qvj.42.1616148143759; Fri, 19 Mar 2021 03:02:23 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:24 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-17-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 16/38] arm64: asm: Provide set_sctlr_el2 macro
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon need to turn the EL2 stage 1 MMU on and off in nVHE
protected mode, so refactor the set_sctlr_el1 macro to make it usable
for that purpose.

Acked-by: Will Deacon <will@kernel.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/assembler.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ca31594d3d6c..fb651c1f26e9 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -676,11 +676,11 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	.endm
 
 /*
- * Set SCTLR_EL1 to the passed value, and invalidate the local icache
+ * Set SCTLR_ELx to the @reg value, and invalidate the local icache
  * in the process. This is called when setting the MMU on.
  */
-.macro set_sctlr_el1, reg
-	msr	sctlr_el1, \reg
+.macro set_sctlr, sreg, reg
+	msr	\sreg, \reg
 	isb
 	/*
 	 * Invalidate the local I-cache so that any instructions fetched
@@ -692,6 +692,14 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	isb
 .endm
 
+.macro set_sctlr_el1, reg
+	set_sctlr sctlr_el1, \reg
+.endm
+
+.macro set_sctlr_el2, reg
+	set_sctlr sctlr_el2, \reg
+.endm
+
 /*
  * Check whether to yield to another runnable task from kernel mode NEON code
  * (which runs with preemption disabled).
-- 
2.31.0.rc2.261.g7f71774620-goog


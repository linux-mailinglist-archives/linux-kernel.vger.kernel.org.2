Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCAB334617
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhCJR67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhCJR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:28 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2403C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:27 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id e29so8314132wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7ThSG/RVLlh/DBRky56NDH1ajIaqy925wlZsTYsbYqw=;
        b=JEuYpJoMd4eciXRQGFuNKzbOmm8jGRXPcoKh/AeoZEfNeJ8pnd2yQE6JjHaW0xAyCa
         pitaJDGhocf+iS6Ix5s83gf0SdJs18Bt+3rQeBC1COJjUlE/pWqLmZGpYl4Y3Q008Xxz
         +KdxiZRuiY9IFxXtfadfJLEllXYm2dMSI1zsnCLjKK//Z68dcq7eoQguhGhmu8QBcbSo
         zzqFqyy0UmFXIphK/sSFENn1hVHMx3C6eW9CGE2mWa11W4GEHDVuzldvjqZ4ksKH3Gay
         m69aD9AQuVq3EYAST0FylU3iVNlhbgm1upS9OevLd1cZJCy4YWWktRZC6J9ZOco8M96R
         DPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7ThSG/RVLlh/DBRky56NDH1ajIaqy925wlZsTYsbYqw=;
        b=oTeyYMtXkm/4WdhQq+YpRT5HAgDUxybpV5MxI34iqJWBgxLq6+WCRtPuj227mmbsgN
         kjYUAchDx/Ryisiar9snW4aUfvfPjr+NBllhlj+XEbcTAyxzkRuuLPz0o+REQCFP00zM
         2uHvReH/4KGgn4AYC8SP0Q74eZ75jFzvtVTh2EjYi6/lTNd71DT5z0kCVNPu2f3tq5xG
         2MggPiYyrGnMBHLaSM9bqUV2ZBUl+jbeTerCl3/uHai+aB+cJtIPUg9/SiysyeRhwMZF
         FRABufUoUnkhc/VlOxylWEH2fiZ5RWAwp3WZjDufPM6FdYNkQnhNxtuPNlGw+NMgzvDU
         6C2g==
X-Gm-Message-State: AOAM530MKdMRgvj1t/AjQH2a7nQxfkw+xYAEdkAtDtYmudAC9RDAvKTD
        nyEORyW1kLkYal+SeiqXnmguh6SlRe5f
X-Google-Smtp-Source: ABdhPJyE9VwVGP/miD0PZ3GZDCYZcaB5M6aMqWesnLSzh0vu9I8m1MWCHPX7MchrOCygw+09qd4prsL24INh
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:214d:: with SMTP id
 v13mr4574201wml.7.1615399106500; Wed, 10 Mar 2021 09:58:26 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:32 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-16-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 15/34] arm64: asm: Provide set_sctlr_el2 macro
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon need to turn the EL2 stage 1 MMU on and off in nVHE
protected mode, so refactor the set_sctlr_el1 macro to make it usable
for that purpose.

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
2.30.1.766.gb4fecdf3b7-goog


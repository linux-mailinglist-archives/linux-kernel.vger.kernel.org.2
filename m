Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1733BEF0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbhCOOv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbhCOOgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:48 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0145DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:15 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id m17so2910355wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4ECUgkoGREkKZOm9t4R+RTCdTGWy+OUrTPPjtPvrKJ0=;
        b=ubKVY94FZBxte3JOLscmnNINlz5Nath/F12j0Cj6ICBvQmZcfxjvhk6cq9NMCBiB8h
         849RZc1HpGcF9S9YCX8dNdvQ0ekSiBbJKhiL6Qp2tDk3YQfK1H5WKrScnbp++ztGk/es
         yo7w9oFa4El4KU8zHQuYK/qoqZWhCN+gCza5SCjh2fR4Cmz8QRIXEHo3meb6rHTxu4hn
         6fc4AIskyZcoV1LAKAGm1UUhFfOEQdFD/fRlfyc9r749cSxliO7lk39yFAOIHx3cRZ23
         ilI4MKg6XcHIcO4MFihwQvA7hwUKHnGgxUEFA/ti9wuelBrWwrTPxSlGppQbg5MlFyH4
         AFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4ECUgkoGREkKZOm9t4R+RTCdTGWy+OUrTPPjtPvrKJ0=;
        b=kOLpaAgAYM8miMBtkeu4+SGYdxbWcth9hA4bPlGt8Mje28NlJSZTwatdUmMLCQwqF0
         yazXaTrNGH1gz+ypTC+iCnWkdoBnA9kdUPbSUjZigU/1hynaZfswfTb/5KXarqseCG6M
         bXXF/YQFUzlK7NDch5g8TVH3pvNJ/rkm1cuPIhhzHODeU4UT12MHGqzJbIfIwUGKqzjW
         +bUB5rAgsPoFLYdlJvIl7j56qDINI4nkkmn+Y8H5tUoC0JkAwEHNVlwZKNCmO5ICjD/G
         LH4g3wOGqouY36yLzT+hQRNQLBvUXB8nvyQMAtOy/TFfO5BgHPlLdHRSmadCT0/t3hIE
         MBdQ==
X-Gm-Message-State: AOAM531JwiImYmPwenJDIlxxKUjI+f5r8qpbeTy1eAwz9QT2GpZdP4/0
        SVPowc5eCxY28CgXehCa75jG+9Mk/mk/
X-Google-Smtp-Source: ABdhPJzYehOnz8tCTfBHour34wAjOBD226lW09MVR9xTEXwscem/T/fZ6V3Usp4MMihrNAsA/4FgAQyZpAB1
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:6a05:: with SMTP id
 f5mr14281wmc.184.1615818973676; Mon, 15 Mar 2021 07:36:13 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:16 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-17-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 16/36] arm64: asm: Provide set_sctlr_el2 macro
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


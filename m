Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A069E3345FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhCJR62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbhCJR6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:15 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E7CC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:15 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id i5so8317911wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T621CrLzDVvHMT7g1JI2svAdR9qKxB9zRXJEq9CxOEU=;
        b=Hbvsvxu6NLISPbrvhiFxE7FXEqAU0Mv8t9SPVam60nUlEefn0BFRgckh6OphPN/n34
         mMAxbCfp63tyHccY0qa/f3Jpc86iiuTI1qKtqv9p3GgGY0jIRmo2YehbRMB+bwHX+rkd
         FciY30zEjHtG42uGSiQAnecMzyOeKipqkx91RsUlvsIu/qkCtj/fVmS6EDgNmYhAdE64
         CHNIzVWY6jaAli+IqjdG8DYNqiV3kcGDigjdAxVcu9mjVlx/FgYwRvHQ/HN8W8Ksp+tD
         UGCShyNHhI0MSaxMWGIBO2OuJLu9etYsd6zmBCTOBQlY6AXhHDojB8xnAR2EeHwTlARr
         WvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T621CrLzDVvHMT7g1JI2svAdR9qKxB9zRXJEq9CxOEU=;
        b=jFyq+HubEbvB+gZBB2N6lVZtQdSoqqBX0fDerq1SNrHSG09OOfoGh6Vp0btrlzXqLz
         VsFVWVItdi96x0L3Oei4lCaMYWOzQzS4gsqV95ETrVdniv42oEBB5YdJStBy8bPaEKJc
         2scLNv8wen53eNpbG/HHIU26UhdvgmpqPsV3UYrB4B7uD0bjVpDugdK/2ggzne5NJY2M
         DH387H8jCmdsKkhnsZ9PoiDPjViQsnqi/hrIjO97zOXwe7iX4rk4ZFpRFSYogE3ZwDYF
         LYFm41Gxz3LECDisJWNZK8Yehq6A7+6QJSOxMtCp4Yh0KEbQGXpL1UHXL+rDptFn2ZQm
         K2lA==
X-Gm-Message-State: AOAM532pIiheLZdFEyqKykSZnTsBvVBzNsb1F6btY8qzc0b+f68P2CgE
        FaiHMonQnaJ8kPITqSdX6QgBRNsLbZXX
X-Google-Smtp-Source: ABdhPJxqfINpp6EENtOEj1k9D5Kyx0lGUnntW+YAdT5CBabTaE0ejM3PwJv5r9lDZwF+U+rCzWRzTGC22KfH
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:ed13:: with SMTP id
 l19mr4406714wmh.83.1615399093776; Wed, 10 Mar 2021 09:58:13 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:26 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-10-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 09/34] KVM: arm64: Allow using kvm_nvhe_sym() in hyp code
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

In order to allow the usage of code shared by the host and the hyp in
static inline library functions, allow the usage of kvm_nvhe_sym() at
EL2 by defaulting to the raw symbol name.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/hyp_image.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index 78cd77990c9c..b4b3076a76fb 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -10,11 +10,15 @@
 #define __HYP_CONCAT(a, b)	a ## b
 #define HYP_CONCAT(a, b)	__HYP_CONCAT(a, b)
 
+#ifndef __KVM_NVHE_HYPERVISOR__
 /*
  * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_,
  * to separate it from the kernel proper.
  */
 #define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
+#else
+#define kvm_nvhe_sym(sym)	sym
+#endif
 
 #ifdef LINKER_SCRIPT
 
-- 
2.30.1.766.gb4fecdf3b7-goog


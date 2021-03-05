Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECDA32F491
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 21:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCEUVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 15:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhCEUV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 15:21:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EA1C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 12:21:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s187so3687404ybs.22
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 12:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ulCKWwAgru14Pv0YBVciE6nHg3ZbaOajNEmz/MDhZ0E=;
        b=sUy/MKxPm0e0JaDZ61ZMVYmchygwUzsxZVRFhQ7ZB6rmk6BwKXl14SNbFoDUTOKgFa
         0ZKz2GEdT6lCTv01QXUfs5j8jrrEPZnjznZ5fha2ou4kuOABBQfjF8z70CrDys7tlVir
         3gH/EzvBcog9XTOaiVntPn9TJh0HdgKMRTYaEO86WDpFDX0uwo5S3c/KCefXmBFLTzLm
         i5NmOaBz7F/XIIWrZsaxhcpEb/dhSAGbBDiZYbh8quMAQGNavxnkkzMF+sGatxLHj9AC
         qKVBGb0/X80WMyGrAzKqxERNLhvZyx7tJI0leqSAdxwM+FfRUXZZ5xYLZX+NP18/qMl1
         yNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ulCKWwAgru14Pv0YBVciE6nHg3ZbaOajNEmz/MDhZ0E=;
        b=EBVhs2tmme67JKMxmAE6WH11HoszqZ7ny5d1RCNIwnMcxQReXpCGYRg9+60XQmkqVj
         bKmTXP8LO61Nz5ukiYBaREMwRTcnkldFTreaGaggEv7LCU1jARrAMr4i3CpUpWmX6IXJ
         MlA8H7gYcxsetRDxgS8BBjLXcqGH0jlAvUM3Gbf5K1vFwk4FHH0rVQ1famf2jcFmGk9p
         ylHW1Sps/dQq1JFKIN9uWupDLI+1VXy1YnVqj2YSzh6KPQwBr/IwxOuuysCymVwWhPM5
         Rqz3gTZKqkstlw+70s/fr+nY6OfJHf7hwPRFpyMQgTCNev4MlKz8HHewegR5NmRIHZPF
         +1EQ==
X-Gm-Message-State: AOAM531KrSfScMqWPEyYsEU/CWlnCdELAryH+ylB8PItnjguP94FI7XY
        FapFTu9uJnYcOE+4/4lA71eZl/QUKS74IzcpINc=
X-Google-Smtp-Source: ABdhPJzugclOPUcMl5rWpXYbl208BWEimx+fJTo5zFfMCx70e7i5TD/OVFvRhSrWZ4lMnOshHJ+EWZ1oZ8vlNNhorTs=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:1d29:d678:6e3a:704d])
 (user=samitolvanen job=sendgmr) by 2002:a25:8706:: with SMTP id
 a6mr15467374ybl.158.1614975687742; Fri, 05 Mar 2021 12:21:27 -0800 (PST)
Date:   Fri,  5 Mar 2021 12:21:24 -0800
Message-Id: <20210305202124.3768527-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] KVM: arm64: Don't use cbz/adr with external symbols
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allmodconfig + CONFIG_LTO_CLANG_THIN=y fails to build due to following
linker errors:

  ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21CC):
  relocation R_AARCH64_CONDBR19 out of range: 2031220 is not in
  [-1048576, 1048575]; references hyp_panic
  >>> defined in vmlinux.o

  ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21E0):
  relocation R_AARCH64_ADR_PREL_LO21 out of range: 2031200 is not in
  [-1048576, 1048575]; references hyp_panic
  >>> defined in vmlinux.o

This is because with LTO, the compiler ends up placing hyp_panic()
more than 1MB away from __guest_enter(). Use an unconditional branch
and adr_l instead to fix the issue.

Link: https://github.com/ClangBuiltLinux/linux/issues/1317
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kvm/hyp/entry.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index b0afad7a99c6..c62265951467 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -85,8 +85,10 @@ SYM_INNER_LABEL(__guest_exit_panic, SYM_L_GLOBAL)
 
 	// If the hyp context is loaded, go straight to hyp_panic
 	get_loaded_vcpu x0, x1
-	cbz	x0, hyp_panic
+	cbnz	x0, 1f
+	b	hyp_panic
 
+1:
 	// The hyp context is saved so make sure it is restored to allow
 	// hyp_panic to run at hyp and, subsequently, panic to run in the host.
 	// This makes use of __guest_exit to avoid duplication but sets the
@@ -94,7 +96,7 @@ SYM_INNER_LABEL(__guest_exit_panic, SYM_L_GLOBAL)
 	// current state is saved to the guest context but it will only be
 	// accurate if the guest had been completely restored.
 	adr_this_cpu x0, kvm_hyp_ctxt, x1
-	adr	x1, hyp_panic
+	adr_l	x1, hyp_panic
 	str	x1, [x0, #CPU_XREG_OFFSET(30)]
 
 	get_vcpu_ptr	x1, x0

base-commit: 280d542f6ffac0e6d65dc267f92191d509b13b64
-- 
2.30.1.766.gb4fecdf3b7-goog


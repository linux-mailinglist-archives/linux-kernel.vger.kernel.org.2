Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903D9373295
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhEDW5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhEDW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:57:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080CAC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:56:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p64-20020a2529430000b02904f838e5bd13so155806ybp.20
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JDoF7khHkinszP5smkSo8+XAp6qKNroETO9tW1b2TdE=;
        b=i2JyeXQRot8X/vhn9uTs++6+PmUcnU4f2IFX1t2D7rVHijEpmywexMjJJ+fn9saw2e
         ma+YeG+VkQr1uB5oIWigPizpGQy9tF5sWVw4dLaW/ey52LSMVMgCid+ae0CAsHBWtiwp
         53x/zzzBc+MO4zL7FjLzAXsSdIPVS7XSXIoMZQokWkeoJyAt+y8RNH50pHB1CbDC1tEl
         QSlkm43DN0U4nJqDS6kVFBUAOBurjYo0NiWcADDxM0Xn6454vev4GgKgyNUdCBqX3UzQ
         k2YY4k/SVbbIENL3cgL5sgdrTevySfX3QX1CERkXRatpVz8XqaXJPVxaaF/T+DdMjqYV
         oPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JDoF7khHkinszP5smkSo8+XAp6qKNroETO9tW1b2TdE=;
        b=SZku5K1cTpPA3kW2z1bFrna9iZwNJGzmHAWAqaDpO7eh26sSonfVJOB2GB6yaGjCEe
         kRioDP6EKa1Z83fMXwlN6MJXsibBwpKxGQ94cfZES/lk/8aOru56VaCmmgQxGTY+81p5
         mCJIoUFGHYwkXN1bswbVmKeJzsavQgAvsolh4cEYWbNMKniwg/SRu/bUtRJDYwt6U1TG
         LXcIIHOuoJCikwDZnKFHYE/xQkByUNaVUC3RE0U+tU6mBLWZ94kzOHL0THDNkOgNmgfE
         QbE6jKs9aCeH5KJUGHWXe7kZwzkxRpX0V1kKtDzI27smgiUvbnEjWH+2MpdXYpCN4MGn
         LVQA==
X-Gm-Message-State: AOAM531u2P8xARiwo4aKvwhEajf+Pro0ekDV045dpVvgtlL5ADwREZDB
        Ae35jqtsvBYKuEPPCuNdcpSrzA1LG5E=
X-Google-Smtp-Source: ABdhPJxkfPSGkAkj4q5Xz2q7YiWVYP6kdn8ZN3N+m+rRnFH+LShhEzfOCoCMpiEModvJ7kFXl6HuOblnG1Q=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:a25:ce02:: with SMTP id x2mr19004016ybe.189.1620169002277;
 Tue, 04 May 2021 15:56:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 15:56:31 -0700
In-Reply-To: <20210504225632.1532621-1-seanjc@google.com>
Message-Id: <20210504225632.1532621-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210504225632.1532621-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 1/2] x86/cpu: Initialize MSR_TSC_AUX if RDTSCP *or* RDPID is supported
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize MSR_TSC_AUX with CPU node information if RDTSCP or RDPID is
supported.  This fixes a bug where vdso_read_cpunode() will read garbage
via RDPID if RDPID is supported but RDTSCP is not.  While no known CPU
supports RDPID but not RDTSCP, both Intel's SDM and AMD's APM allow for
RDPID to exist without RDTSCP, e.g. it's technically a legal CPU model
for a virtual machine.

Note, technically MSR_TSC_AUX could be initialized if and only if RDPID
is supported since RDTSCP is currently not used to retrieve the CPU node.
But, the cost of the superfluous WRMSR is negigible, whereas leaving
MSR_TSC_AUX uninitialized is just asking for future breakage if someone
decides to utilize RDTSCP.

Fixes: a582c540ac1b ("x86/vdso: Use RDPID in preference to LSL when available")
Cc: stable@vger.kernel.org
Cc: Reiji Watanabe <reijiw@google.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ab640abe26b6..1e576cc831c1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1850,7 +1850,7 @@ static inline void setup_getcpu(int cpu)
 	unsigned long cpudata = vdso_encode_cpunode(cpu, early_cpu_to_node(cpu));
 	struct desc_struct d = { };
 
-	if (boot_cpu_has(X86_FEATURE_RDTSCP))
+	if (boot_cpu_has(X86_FEATURE_RDTSCP) || boot_cpu_has(X86_FEATURE_RDPID))
 		write_rdtscp_aux(cpudata);
 
 	/* Store CPU and node number in limit. */
-- 
2.31.1.527.g47e6f16901-goog


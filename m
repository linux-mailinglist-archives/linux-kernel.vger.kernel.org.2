Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241BF373313
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhEEA2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhEEA2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:28:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406E8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 17:27:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id b1-20020a0c9b010000b02901c4bcfbaa53so451194qve.19
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 17:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=8VmneownvRiBDOCyf/WT7mY7HGmlZaT0ZagzLkVER4s=;
        b=oCd8B3F/UTfILVZUWrdLF+pvd1RlR9XDTo0h1qVI77FIpxJAIO9Ax/Pf/N/ForhSVT
         Lg2OnnPEQKxO4nWBNJItIW0g1iTulDZhJBd2AaSsv04wsyRO5qWG+0y0DYBJKbV6OmIt
         pAZShJlD2PTHdfyGQr9XPJQHQPLBKVf169EbsPHljD+FbaMSIgR2281C2tdIvgJVlfI4
         XsBKeHNBiqKq+PxaEufgDGPJXd/NefLz4JP0NZcG8soX3Sj/sgKdv4QuRDey31dbNMts
         alNKy9IMUiodV2xKOKxRln2Tpg6nKI+8tdHaX7/Um1sgVEuADXhXUoCFG83/O6ZkifdJ
         kTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=8VmneownvRiBDOCyf/WT7mY7HGmlZaT0ZagzLkVER4s=;
        b=phuDWd/bEHmpWgYC7wO6CHkSc+3K1eJi80cs9sozr4OIv3EzG6BsU9X79erc+VJyot
         MZ4B1pD5XI+zakhJY9zMJ2T8fArmsy2+QzU1f97QNMFkYpdaV54cEPcrfnQN9yN//ph5
         DZTPjd3ErNuHF0t3XWtel26fMd0Mb9RKiwzEAZbYHa9RGpkPBALs/yQ22bIALtzzTLOY
         fV5ckL7cfuoeOl2D/LTnTQrbs93WnoSq3ZutX7uD8zx34qGR7LlIRASANcmdXS3wW5ct
         cQ0msODciOzgW8nXBGPOpfQHeYSHpwWcWZnhfTUh0lvAyGXSz2kQxF7lPnS5IUq1ILf4
         3gCw==
X-Gm-Message-State: AOAM533Sv73yNcp8SpzQkTG0Xvu9C10zMqTjpwgJXnEfor4ebJrELdaN
        oz4Iho97X8VzulyqlNdGZ8GR6RObO94=
X-Google-Smtp-Source: ABdhPJw4PT82bVQOoqQY5MU7nnhRBtlemwIy3I3yaq3UJcUJb7h7xsmWHPyDKHEcnKjivOsuFN2ql6b7YYk=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:ad4:4908:: with SMTP id bh8mr28611423qvb.55.1620174469407;
 Tue, 04 May 2021 17:27:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 17:27:29 -0700
In-Reply-To: <20210505002735.1684165-1-seanjc@google.com>
Message-Id: <20210505002735.1684165-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210505002735.1684165-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v4 2/8] context_tracking: Move guest exit vtime accounting to
 separate helpers
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michael Tokarev <mjt@tls.msk.ru>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Provide separate vtime accounting functions for guest exit instead of
open coding the logic within the context tracking code.  This will allow
KVM x86 to handle vtime accounting slightly differently when using
tick-based accounting.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Cc: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/context_tracking.h | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index b8c7313495a7..4f4556232dcf 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -137,15 +137,20 @@ static __always_inline void context_tracking_guest_exit(void)
 		__context_tracking_exit(CONTEXT_GUEST);
 }
 
-static __always_inline void guest_exit_irqoff(void)
+static __always_inline void vtime_account_guest_exit(void)
 {
-	context_tracking_guest_exit();
-
-	instrumentation_begin();
 	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_exit(current);
 	else
 		current->flags &= ~PF_VCPU;
+}
+
+static __always_inline void guest_exit_irqoff(void)
+{
+	context_tracking_guest_exit();
+
+	instrumentation_begin();
+	vtime_account_guest_exit();
 	instrumentation_end();
 }
 
@@ -166,12 +171,17 @@ static __always_inline void guest_enter_irqoff(void)
 
 static __always_inline void context_tracking_guest_exit(void) { }
 
-static __always_inline void guest_exit_irqoff(void)
+static __always_inline void vtime_account_guest_exit(void)
 {
-	instrumentation_begin();
-	/* Flush the guest cputime we spent on the guest */
 	vtime_account_kernel(current);
 	current->flags &= ~PF_VCPU;
+}
+
+static __always_inline void guest_exit_irqoff(void)
+{
+	instrumentation_begin();
+	/* Flush the guest cputime we spent on the guest */
+	vtime_account_guest_exit();
 	instrumentation_end();
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
-- 
2.31.1.527.g47e6f16901-goog


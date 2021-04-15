Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CB5361556
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhDOWVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbhDOWVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:21:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA01C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u128so3935392ybf.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=2rHkFHcKdsKtPlphUZSPjmFsPrJ5FQMml9mM0e4W7Zc=;
        b=Sdv8k1IdZLOeBzPcIHjmgwJvr30lVQhykx0hvcsxfUl49I6CdmrwLkVbh3hV+Ki+lU
         9FgNVGTL6AhKmBPLLJsOtFvFnVAmd9es66AmtmX93zsZySZKpzLCQcstWKqR18p9xu1V
         A4SAYuvwFCZj+IFvJs55MwqCJ3rSkkS8OincKBNAMhgM9zYj7ywd9/eNQQk8yr2ATmah
         fXun1sJdo3rL8im+W9tt+twTRmtH/ASLsnxpA84IpCEoOfjOfsRXmg8gMsxVBKugvghq
         /EQcpFNjuzdNG9gjvw1gOUYvKGfYWCL1jr88Kg0XSNlF0/0+spGD+TtUWO2AwUlYXQst
         i2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=2rHkFHcKdsKtPlphUZSPjmFsPrJ5FQMml9mM0e4W7Zc=;
        b=kMaFEZKFrFJcb3dq4Ln6qo0PSz7ba7i7ch8q9Wl6CYK7mEK4ybR2nLPdouYx35IZvD
         yBXBkJQ2NP98Mex16Lu1FyMMPPfj2bWKWWc5apoM0VqKSdaqnZpmv+0/K2G2Cna3gGC7
         JKT7Nl0MgC6yC+L5ijrsV/HMEnP8TYYoH8YawTzVbov/DUhLZNXgYiVZ7e/GFMU/8Nl+
         PCVCWrKYEepX05WcpfY8Zb1dw1KCbaIs7Sl5apXNlYNIKJaQDsiLuSTaZJyCyOJEZxJb
         hfbXUl9nN/HMqFSgyLiJ8ot0gNmthjhHejGacDPZqztCvKZykMo1kOkrE9U2uB0F5ZMO
         /sOg==
X-Gm-Message-State: AOAM533ry+GpcrJSLZF6KZbQ7cns/Otgn/xmzprlRamPAdnPnIrtAZIF
        yHql0w3fGJvNbXgiuuq+REavuKyJYPw=
X-Google-Smtp-Source: ABdhPJxt/mukU9KkDXUa7r3vWCK3xUAeHdvtmdgfysot73ik6ImSoiiXCJDED9AESLevjYuAltjuZtEJn5U=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:6c93:ada0:6bbf:e7db])
 (user=seanjc job=sendgmr) by 2002:a25:e6c7:: with SMTP id d190mr6937056ybh.394.1618525275978;
 Thu, 15 Apr 2021 15:21:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 15 Apr 2021 15:20:58 -0700
In-Reply-To: <20210415222106.1643837-1-seanjc@google.com>
Message-Id: <20210415222106.1643837-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210415222106.1643837-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 1/9] context_tracking: Move guest exit context tracking to
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
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Provide separate context tracking helpers for guest exit, the standalone
helpers will be called separately by KVM x86 in later patches to fix
tick-based accounting.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/context_tracking.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index bceb06498521..200d30cb3a82 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -131,10 +131,15 @@ static __always_inline void guest_enter_irqoff(void)
 	}
 }
 
-static __always_inline void guest_exit_irqoff(void)
+static __always_inline void context_tracking_guest_exit_irqoff(void)
 {
 	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
+}
+
+static __always_inline void guest_exit_irqoff(void)
+{
+	context_tracking_guest_exit_irqoff();
 
 	instrumentation_begin();
 	if (vtime_accounting_enabled_this_cpu())
@@ -159,6 +164,8 @@ static __always_inline void guest_enter_irqoff(void)
 	instrumentation_end();
 }
 
+static __always_inline void context_tracking_guest_exit_irqoff(void) { }
+
 static __always_inline void guest_exit_irqoff(void)
 {
 	instrumentation_begin();
-- 
2.31.1.368.gbe11c130af-goog


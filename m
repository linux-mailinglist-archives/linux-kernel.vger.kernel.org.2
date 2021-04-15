Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0178361558
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbhDOWVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhDOWVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:21:44 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF395C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:18 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ch4-20020a05621413e4b029019a62faaea4so2778592qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=CDwOh0IaNcX9UTyCuJ5raB5qoSEoFUMF7dTqu9Of2Ts=;
        b=lCEbzxTsjVC2q/MVHl7FRpujXgUXcFG8C46zRmpuIcruXU/6VkHbQYSNS+tYU/BApW
         DHoFCG1brARGrYVwHDCVJfZYQLaWOr4nEHaLOF6dpBzWtcjIxL3lSWY8+PLlRl4Fxafu
         5h+9VSGPVxUZjEk+KQy1w1ihTt7dQiu5iiOg6+WH/DBehbWOJ/OJB5xmPlG56fLNSAZH
         IMjKH6L4HjImCvJSnXXtkkLMp1SvoD3eMpjgzAIeXYeYDIO2FVOjIbgKX0SQWguccYRJ
         W0lnPa9n+A+yWuhLsRrCB6q9KrAe+fTDw3TXY66O1oyudFe4loCqxDB1cL+NpzVvU9O8
         Ao2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=CDwOh0IaNcX9UTyCuJ5raB5qoSEoFUMF7dTqu9Of2Ts=;
        b=tJFMwwzTx4B+XbWCn/cA1VbcmIc2z7W9I48PrFLoVfdCpcsDbhaZqWG5AwamVFQQOF
         vxdRkKYUXSSDCZG6vKyrPhbV/Dsh0PkP/sE8Fq8OO0IEnuMrTbnoXKad4pquBkad1zuy
         60J+eeCrlWQOidvLLgr9a6P/c0yxFnIRh/A3wklrvEhqsNwLxDZo36KK1NBjMXBWnQRW
         MjBrfzu+VrU2zCrW3n1gLpHew7H3jIjFJ6bUtckw69jp7xDJo4Z+SnS/NwEwnnXB2U+8
         DicwgwxY3S1b35gIQtseD0VgQzm/k8VlsRQEvAwaXz5KjZ7fuP9u3iscom0Vcv0Aclo+
         6ykg==
X-Gm-Message-State: AOAM530yva1GLdZJe0IQfW2jB8pFldfarkSvnqqi/OkV/kF/AGKCLHoh
        zD0ULf55uwd82QhuzwNeoZ/GSojc+PE=
X-Google-Smtp-Source: ABdhPJzhT3ylCOgQVx7Kp/AL3/m97MEii6C75poeS9pzETAxvcMrJInW9ZuTQ08c+KJWL/31kAbTYAM0VHA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:6c93:ada0:6bbf:e7db])
 (user=seanjc job=sendgmr) by 2002:a0c:e444:: with SMTP id d4mr5446587qvm.51.1618525277964;
 Thu, 15 Apr 2021 15:21:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 15 Apr 2021 15:20:59 -0700
In-Reply-To: <20210415222106.1643837-1-seanjc@google.com>
Message-Id: <20210415222106.1643837-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210415222106.1643837-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 2/9] context_tracking: Move guest exit vtime accounting to
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

Provide separate vtime accounting functions for guest exit instead of
open coding the logic within the context tracking code.  This will allow
KVM x86 to handle vtime accounting slightly differently when using
tick-based accounting.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/context_tracking.h | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 200d30cb3a82..7cf03a8e5708 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -137,15 +137,20 @@ static __always_inline void context_tracking_guest_exit_irqoff(void)
 		__context_tracking_exit(CONTEXT_GUEST);
 }
 
-static __always_inline void guest_exit_irqoff(void)
+static __always_inline void vtime_account_guest_exit(void)
 {
-	context_tracking_guest_exit_irqoff();
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
+	context_tracking_guest_exit_irqoff();
+
+	instrumentation_begin();
+	vtime_account_guest_exit();
 	instrumentation_end();
 }
 
@@ -166,12 +171,17 @@ static __always_inline void guest_enter_irqoff(void)
 
 static __always_inline void context_tracking_guest_exit_irqoff(void) { }
 
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
2.31.1.368.gbe11c130af-goog


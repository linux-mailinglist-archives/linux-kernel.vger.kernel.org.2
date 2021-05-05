Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58602373311
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhEEA2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhEEA2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:28:43 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E911C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 17:27:48 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id e4-20020a37b5040000b02902df9a0070efso8763811qkf.18
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 17:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xZt4efxZ5O1fki+F06zzqnkjNwRMCCexS8Z/OWGzDKY=;
        b=RCPr67vEGY5CUjwXRYFJ17bNaPnTkB+YC/NFD/g6gSMqXJo1KpoKNbc8ioAry3aOo5
         wT+5bW4ukEcbzXmpBO6Nofhx0N2lf4tDuOdo5Q85UU/5Ac2aMBtx3lRG7ypI2J1Vg4sM
         bewxeC0g6/dJ3Puc+L9MGhCugukS6LvFPriOzSQOo4HuTnHPx6Gz5JmtM4BJxAEg75XU
         qmFX77Jq9Qtzaa3+3CniWDGR9P6Yo6lYxGZKAf9loV1nK5k10yCPOKBEUJDqeGL6L5dQ
         yWGkfNtzVRUdOoo1J91pz9qPhUVuTJ96FALUsSej1OTblQKUzoCHSuHJF1p4RBDmSbB2
         18FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xZt4efxZ5O1fki+F06zzqnkjNwRMCCexS8Z/OWGzDKY=;
        b=Ac3lh5rETab5fBD2OR8KjCQsVYYlrpbzO7t4S0mBK3xtNhT4pFZmh/WiNmNsEPpblt
         xTpSx00pQ3EBCGnH7vZLFWeqQJs0O/204/Fz3cL8MKDV06BMCkkVqwD2oVaie9vG0j+9
         9WFibwMQlIx8aNvRUITAmfRtUM9YcAqWO4xfW/9U3EO93uUJnExxhFw1FTNRT7JnZfdc
         OPTMVKOKaANRLMDmfgkySfJ1yt6mjSuUIamQ7HyolxD6WIx6I8CDwaWJElY2AuwlWzKy
         huyXjukrrfEplSFDz7afUVtxbQtnb5HJYhApj33w0Lel6dQiCthruFa93Jpl2VHAo0tz
         hnkw==
X-Gm-Message-State: AOAM532hBXGzi+Ge8Bl3NSRBT09r3H2yCkgNgSSZDnu7R8GmI8Hjl0Qz
        svQgvVRrNAlxGTbsQQ3SVXAhuJC3KD0=
X-Google-Smtp-Source: ABdhPJy1pcjP5q/y8aPXnwQ3sVhGewgpWMslaYXIyaqZg7im31538j5Ml+LRQ3OlWvuxy8r5Vd7WnmuVGHo=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:a05:6214:176f:: with SMTP id
 et15mr28001756qvb.61.1620174467444; Tue, 04 May 2021 17:27:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 17:27:28 -0700
In-Reply-To: <20210505002735.1684165-1-seanjc@google.com>
Message-Id: <20210505002735.1684165-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210505002735.1684165-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v4 1/8] context_tracking: Move guest exit context tracking to
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

Provide separate context tracking helpers for guest exit, the standalone
helpers will be called separately by KVM x86 in later patches to fix
tick-based accounting.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/context_tracking.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index bceb06498521..b8c7313495a7 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -131,10 +131,15 @@ static __always_inline void guest_enter_irqoff(void)
 	}
 }
 
-static __always_inline void guest_exit_irqoff(void)
+static __always_inline void context_tracking_guest_exit(void)
 {
 	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
+}
+
+static __always_inline void guest_exit_irqoff(void)
+{
+	context_tracking_guest_exit();
 
 	instrumentation_begin();
 	if (vtime_accounting_enabled_this_cpu())
@@ -159,6 +164,8 @@ static __always_inline void guest_enter_irqoff(void)
 	instrumentation_end();
 }
 
+static __always_inline void context_tracking_guest_exit(void) { }
+
 static __always_inline void guest_exit_irqoff(void)
 {
 	instrumentation_begin();
-- 
2.31.1.527.g47e6f16901-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFF636B047
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhDZJJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhDZJJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:09:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F39C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:08:35 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j7so30238455pgi.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ze/d40V9r4jheKthRdtDHEg05bx8WqXy096MFG21BNk=;
        b=ZEW/ctj1rqE5BI7PZyNweAk4hCGwOn1XeB1UK3EInZuZ+KOoZj+FZniUs0eawFNTb3
         piyAhNUq9Pt8NKjOGRjvXBUPiX9qxN9duDSUduOf6L6+VgKTaOlJcE4N0Fwb0qughoZE
         OAeozLRUZfPsZt//DGi8umsGUs0nsnU1cT4gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ze/d40V9r4jheKthRdtDHEg05bx8WqXy096MFG21BNk=;
        b=tDxau98xN1SfJIaMq6TeB4W7Zm3NoHkHeHkj0ndbQgSkOkQLmYt4WVU2/nCbeZnwNG
         643sF4Jp/Rl21tyQ7+lMKepTOaqc8OFLM8eYAH97g9AT8ZYr+oZoRLrn1yqcXamKMylk
         ismVczNXNrtaXYTZk0pOIdXnrg5zWducI4javvuWFDY2LUtwWni2nHmi6brfCFBk9Ost
         dVCC4QGESm328N5eH3v3ynGiHHUDqhSdZyihtQHEKHVFizXrhG3EPiequ+hlKJ6IdpJy
         jjDxh2eTZxuFu/UAgKTxN1wFiDmmvRyGkxyjsClmZNybnabWdCkIS4Q83NDQy5qx6oJg
         ranQ==
X-Gm-Message-State: AOAM533AfPFP4ARekZnziR3jgMnMs+QZ6xnr3w2dZjq6dPeTeyum300L
        UseLN2BwKRaBJtMmpTyuJ0qGjQ==
X-Google-Smtp-Source: ABdhPJyaxGiniEDS09BITbtGyjkgjq743HWx/3/pq/SXK/DWtL+tSMT3yuzIQODND9+YCVlEcaq/bg==
X-Received: by 2002:a63:a47:: with SMTP id z7mr15779744pgk.350.1619428114657;
        Mon, 26 Apr 2021 02:08:34 -0700 (PDT)
Received: from localhost (160.131.236.35.bc.googleusercontent.com. [35.236.131.160])
        by smtp.gmail.com with UTF8SMTPSA id 22sm14650977pjl.31.2021.04.26.02.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 02:08:34 -0700 (PDT)
From:   Hikaru Nishida <hikalium@chromium.org>
To:     kvm@vger.kernel.org
Cc:     suleiman@google.com, Hikaru Nishida <hikalium@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC PATCH 3/6] x86/kvm: Add CONFIG_KVM_VIRT_SUSPEND_TIMING
Date:   Mon, 26 Apr 2021 18:06:42 +0900
Message-Id: <20210426090644.2218834-4-hikalium@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210426090644.2218834-1-hikalium@chromium.org>
References: <20210426090644.2218834-1-hikalium@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config option can be used to enable virtual suspend time injection
support on kvm hosts.

Signed-off-by: Hikaru Nishida <hikalium@chromium.org>
---

 arch/x86/kvm/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index a788d5120d4d..6cb6795726a2 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -119,4 +119,17 @@ config KVM_MMU_AUDIT
 	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
 	 auditing of KVM MMU events at runtime.
 
+config KVM_VIRT_SUSPEND_TIMING
+	bool "Virtual suspend time injection"
+	depends on KVM=y
+	default n
+	help
+	 This option makes the host's suspension reflected on the guest's clocks.
+	 In other words, guest's CLOCK_MONOTONIC will stop and
+	 CLOCK_BOOTTIME keeps running during the host's suspension.
+	 This feature will only be effective when both guest and host enable
+	 this option.
+
+	 If unsure, say N.
+
 endif # VIRTUALIZATION
-- 
2.31.1.498.g6c1eba8ee3d-goog


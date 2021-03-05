Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD89C32DF88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 03:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCECQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 21:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCECQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 21:16:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F91C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 18:16:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u17so867695ybi.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 18:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=XCuZlcex++tlORTWddHh341Mae7tA0syCjmGbmGPn9g=;
        b=qWBQmAwlMgMgF4FtEbl6VOjLqoWiCkJFNktt9fpqeco2hKyqjvgv9fgentVlBECwVy
         qwATzdmr4c7yY4EhBm4HboriqczFqV4Il+hRoYSxJn0FmVuvZUAn8RO/oJCAVx7/MuMs
         T5bvw+xjZnjoAKG0HwtUzo84urtfEO1d0PNPSqfyenZWbXhLayyU9y9dJ2hhdnTMBKSa
         BC69jOdx39bVmd4E3TVQodre8QBR0cutRcrNfzOZdZhAfGbyjOMlqBTS8xlj4ZvUyXDB
         H4hCm/0aM/uWQUlRd9Q3x/qM68r5m5dhxjxPyJXC4UZiGdXF4U7iGeWAAmzbMyCnxyJ8
         X+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=XCuZlcex++tlORTWddHh341Mae7tA0syCjmGbmGPn9g=;
        b=ZCAvuxAdw+1iBTJj901Cbipv39kCqXEk4Xm3Klfv0bjG4FW6u7yO46pUk3hAzkmWgp
         A8atPEFTDW3ejm2rOVRzkHNOLcInFtPWYtNJmiQljWFzB5N822LSrBfCcNZ59VgFRb5/
         VC3qRCPtNcFNc0Uh+oSs0kDO0YLcs0HrTs6c2ZZtNDsCMztU7c+LiYZnK6w0GU5WIBt7
         mxyPaD3rx+SJTtVmvjXznEEt49lzC9bMyy3fUobgoxGVxM6EUrglH6LUlfBtDBw8YgKg
         w539rZGMIxAOTVQQmKSAe4DCLlTDxvV0Ff5T/aBmu6SrtF1IKbew8L9O31Dc99ncAAhB
         ut6A==
X-Gm-Message-State: AOAM5316iYEkhA28J9c1GwALXP13HJpKulS1owgM/9hxDm+jTiNNZQQH
        aWPwRxd8JQXms/SghYrihvbS/pmFCnI=
X-Google-Smtp-Source: ABdhPJw6kqqgn6lrO6/hWAaUSPFDGUSNlB+6yvYlFi8u2jKAW9fWp2mYtsqAFS5R4iAcL7UPxV2InPNUHg8=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:9857:be95:97a2:e91c])
 (user=seanjc job=sendgmr) by 2002:a25:9c02:: with SMTP id c2mr9890875ybo.402.1614910600122;
 Thu, 04 Mar 2021 18:16:40 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Mar 2021 18:16:37 -0800
Message-Id: <20210305021637.3768573-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] KVM: SVM: Connect 'npt' module param to KVM's internal 'npt_enabled'
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly connect the 'npt' param to the 'npt_enabled' variable so that
runtime adjustments to npt_enabled are reflected in sysfs.  Move the
!PAE restriction to a runtime check to ensure NPT is forced off if the
host is using 2-level paging, and add a comment explicitly stating why
NPT requires a 64-bit kernel or a kernel with PAE enabled.

Opportunistically switch the param to octal permissions.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 54610270f66a..0ee74321461e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -115,13 +115,6 @@ static const struct svm_direct_access_msrs {
 	{ .index = MSR_INVALID,				.always = false },
 };
 
-/* enable NPT for AMD64 and X86 with PAE */
-#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
-bool npt_enabled = true;
-#else
-bool npt_enabled;
-#endif
-
 /*
  * These 2 parameters are used to config the controls for Pause-Loop Exiting:
  * pause_filter_count: On processors that support Pause filtering(indicated
@@ -170,9 +163,12 @@ module_param(pause_filter_count_shrink, ushort, 0444);
 static unsigned short pause_filter_count_max = KVM_SVM_DEFAULT_PLE_WINDOW_MAX;
 module_param(pause_filter_count_max, ushort, 0444);
 
-/* allow nested paging (virtualized MMU) for all guests */
-static int npt = true;
-module_param(npt, int, S_IRUGO);
+/*
+ * Use nested page tables by default.  Note, NPT may get forced off by
+ * svm_hardware_setup() if it's unsupported by hardware or the host kernel.
+ */
+bool npt_enabled = true;
+module_param_named(npt, npt_enabled, bool, 0444);
 
 /* allow nested virtualization in KVM/SVM */
 static int nested = true;
@@ -988,12 +984,17 @@ static __init int svm_hardware_setup(void)
 			goto err;
 	}
 
+	/*
+	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
+	 * NPT isn't supported if the host is using 2-level paging since host
+	 * CR4 is unchanged on VMRUN.
+	 */
+	if (!IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_X86_PAE))
+		npt_enabled = false;
+
 	if (!boot_cpu_has(X86_FEATURE_NPT))
 		npt_enabled = false;
 
-	if (npt_enabled && !npt)
-		npt_enabled = false;
-
 	kvm_configure_mmu(npt_enabled, get_max_npt_level(), PG_LEVEL_1G);
 	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
 
-- 
2.30.1.766.gb4fecdf3b7-goog


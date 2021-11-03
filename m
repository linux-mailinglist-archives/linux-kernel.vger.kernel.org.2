Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62656444853
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 19:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhKCSgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 14:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhKCSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:36:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0285C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 11:33:53 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id n22-20020a6563d6000000b0029261ffde9bso1860289pgv.22
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OlHAqqU2TheCKRbtoKErhWOTUsWwfnc35tms2ZBHd5Q=;
        b=kh9+dLdjtxAPihCGtfVuX/FN1/EC0cmISDZJ1SAjQZrt2KWL6jL5YvrHCbdsFFT8ph
         CC3/JoqRSQp1BmmqW8DNC5w8IL6g0uXSqPaPChgT3Sgr3YOYCBtQ2NLv2V+zgy7C9l4g
         gHOD2S4ivcsnDHqD1/lzbGkYAgAJXtMXNH3ajmNE8K30/KeX9Kp5mAR3J383w3yuBOAx
         BwTgomWiAbY8a3sa9Sc0QvbYOU9llKxJEUJP20JWVUpohQ+576iXpQ8RMp4cvkY5DPCE
         dSStnvIvy4FCjbnzoTYgpFffdjV3lZT45/XE9iRkfv+42jRnu+Po8S1+6z1C59kOrXJG
         c3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OlHAqqU2TheCKRbtoKErhWOTUsWwfnc35tms2ZBHd5Q=;
        b=AUlrf+wFOogF63Ax1uLan6uvIQniQ3hVqFpcZNdrftc91G2/NzjMk0npNnRv6N0GSP
         iOn5wH8ZEWv+JHnLpzJJPHphHOkvfxTv7MMl0QJHfc+NI1SvlSEGoKJ3G/Fj1/+2kF3i
         9qqIdciCB7/xCskttUQ+6gk1zXhudmt2Xx9qqf7d5vbkeW4Y/ONTFtzp+LA6wyp+JpxW
         /r3703FURVwbQfm9c9MUTx1J/F78blnsJqTpKx5+9xXM1H5jnPzpnW+4YlBKfmQ78xd4
         pD8BlaxkrU4W5pzU60Tz1P1T8tCD+V2NmLPG4Hg1Uq+ujR2UehXOEUEn+6XBTGeejWIb
         JxGQ==
X-Gm-Message-State: AOAM531oD4nT8y3TCLUcUkR7G3kOPNdKFGUQzB7eYZFbz7S9mXep6HqL
        108OSIEyq7MmEVV9whjEMgUjRM0WIjCo
X-Google-Smtp-Source: ABdhPJydw8wL5wpiEWFxnBPPsArRY1Rud9a1UMXMzjKks9ifhZxNcejfeX53ueIDLpjfSsggZ/sF/FlCnLkf
X-Received: from vipinsh.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:36b0])
 (user=vipinsh job=sendgmr) by 2002:a17:903:1207:b0:13d:b9b1:ead7 with SMTP id
 l7-20020a170903120700b0013db9b1ead7mr39915184plh.63.1635964433179; Wed, 03
 Nov 2021 11:33:53 -0700 (PDT)
Date:   Wed,  3 Nov 2021 18:32:32 +0000
In-Reply-To: <20211103183232.1213761-1-vipinsh@google.com>
Message-Id: <20211103183232.1213761-3-vipinsh@google.com>
Mime-Version: 1.0
References: <20211103183232.1213761-1-vipinsh@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 2/2] KVM: Move INVPCID type check from vmx and svm to the
 common kvm_handle_invpcid()
From:   Vipin Sharma <vipinsh@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, jmattson@google.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check will be done in switch statement of kvm_handle_invpcid(),
used by both VMX and SVM. It also removes (type > 3) check.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/svm/svm.c | 5 -----
 arch/x86/kvm/vmx/vmx.c | 5 -----
 arch/x86/kvm/x86.c     | 3 ++-
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 21bb81710e0f..ccbf96876ec6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3119,11 +3119,6 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
 	type = svm->vmcb->control.exit_info_2;
 	gva = svm->vmcb->control.exit_info_1;
 
-	if (type > 3) {
-		kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
-
 	return kvm_handle_invpcid(vcpu, type, gva);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e41d207e3298..a3bb9854f4d2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5505,11 +5505,6 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 	gpr_index = vmx_get_instr_info_reg2(vmx_instruction_info);
 	type = kvm_register_read(vcpu, gpr_index);
 
-	if (type > 3) {
-		kvm_inject_gp(vcpu, 0);
-		return 1;
-	}
-
 	/* According to the Intel instruction reference, the memory operand
 	 * is read even if it isn't needed (e.g., for type==all)
 	 */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ac83d873d65b..134585027e92 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12443,7 +12443,8 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
 		return kvm_skip_emulated_instruction(vcpu);
 
 	default:
-		BUG(); /* We have already checked above that type <= 3 */
+		kvm_inject_gp(vcpu, 0);
+		return 1;
 	}
 }
 EXPORT_SYMBOL_GPL(kvm_handle_invpcid);
-- 
2.33.1.1089.g2158813163f-goog


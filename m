Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2A444B220
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhKIRr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbhKIRrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:47:24 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0984AC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 09:44:38 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id i3-20020a170902c94300b0014287dc7dcbso3315747pla.16
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 09:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3dSOMYowFmLGHL/9NT4zbRgDO3sEDt3CzFQDAO9NWgk=;
        b=SObRjv/OhHv0ur9cwKHlMrW4qPTrppoQnwfJzoOSb+z5vBnzFs24Qo4WHK0N5B/D1f
         0jr+e59SrrS2GpYHgQr2UhsUXkVtUD3fUNKKtStgYmE62BgETzYJVZgn+nGM4EUQW5Tk
         nT7w9cKsVRwkxV3vVhtBYa65QUs+uUE9FQyWeS5Ru5e/l1GNtMoc8NnU1xbOlghpw5Vp
         yQ9GzjlmSJJRflFIDh3uJFls5gFN5pGMZMxXzhtvTwSBQfKmi0+21K6Dg22NHZtQ4epd
         saQKLParOtNg87FdMLaCP/zT7D/LgcCAKJNgI76AJ+1sIX5O97ZldhuodjRIkw1VMQBV
         G2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3dSOMYowFmLGHL/9NT4zbRgDO3sEDt3CzFQDAO9NWgk=;
        b=aJ78WsxPfbxRqtt6zSQQ6R1za9MCvCkxwmDChxaSkAfzHJ2lUpd+TgMu8MjLQiN9OX
         9i6fcm6txvE4lntiuVsVgGg6J2oC4uX8L5+y1NXsD+H0i0r+yZQoh1HpP79lf76/s1ee
         JMVnRQLdclfZcm6be5Ha6Wl0dnrBKVXkP2XrUw6AwLxewbtoS8OM3FkujO/ZMjRU/lS6
         tDtoSg/QOM5dnj/UhJ2lIkldnM+CYiaWSSD7TbPMYZAcQ2jP3PH2T17KG8KcMMlDpUyY
         MiOaZ3ZbrRB6mEHcBYQHV1XCfBIBnMeeYdPyICB+To7deskxPvc3m4CNxiLZoi6IDXZN
         s7Sw==
X-Gm-Message-State: AOAM533aM49JQI+1jPDzSAmDQvRhkh727ANlVZZ6O1XpnhxJxlvIQhcL
        u6q4ilfVjsmUTn8doD7A0anqDHOibPbE
X-Google-Smtp-Source: ABdhPJyE5IYejljYQWvewvDju+mOIcTWCplOjKcPhZmhCnDPFJOZ2vkepEEZAEdcspVGrpHnJGbjN1oo5GIK
X-Received: from vipinsh.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:36b0])
 (user=vipinsh job=sendgmr) by 2002:a17:902:c407:b0:142:28fe:668e with SMTP id
 k7-20020a170902c40700b0014228fe668emr8947697plk.31.1636479877545; Tue, 09 Nov
 2021 09:44:37 -0800 (PST)
Date:   Tue,  9 Nov 2021 17:44:26 +0000
In-Reply-To: <20211109174426.2350547-1-vipinsh@google.com>
Message-Id: <20211109174426.2350547-3-vipinsh@google.com>
Mime-Version: 1.0
References: <20211109174426.2350547-1-vipinsh@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v4 2/2] KVM: Move INVPCID type check from vmx and svm to the
 common kvm_handle_invpcid()
From:   Vipin Sharma <vipinsh@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, jmattson@google.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle #GP on INVPCID due to an invalid type in the common switch
statement instead of relying on the callers (VMX and SVM) to manually
validate the type.

Unlike INVVPID and INVEPT, INVPCID is not explicitly documented to check
the type before reading the operand from memory, so deferring the
type validity check until after that point is architecturally allowed.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
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
2.34.0.rc0.344.g81b53c2807-goog


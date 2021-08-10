Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C6E3E7E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 19:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhHJRUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhHJRU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:20:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8995C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:20:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a188-20020a25cac50000b029055d47682463so21862120ybg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=KD5isecR2ayOZ7sSUv+6jIJgcoLLIi/ZTy8rQvhmOJs=;
        b=iwDUVJklIU+Ex0Ll5jbpvI1jDKGBJfV1OBz1a9FrsAIY9PMkbCLu4CK0VPZox67IzD
         zZhKkVO+d1VQrzUEPJGREuxFY7DmVoIiZQoG+R7ldW6spkNbLKkH09EBw2Ir0r/OLwUK
         HiwTtr3b+ygbZUacNV0ioNoxfGmHvj2VrIcY/u/O5l0hqkFSmBUbJlF6nrUeqSbjRbQ5
         4rmuJtO99ENwvpfv2oUflLuKtcV1vTCmA86I55MzfQMv7fL+7llOKaSKWAcrs+uvYiFD
         z7H2m7dKZOzF7LN6ZYWyEG/DLqvNxWc9CPCYkGmFSLsCpL2HPDaYfIJdP3rq48VWyKYA
         dvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=KD5isecR2ayOZ7sSUv+6jIJgcoLLIi/ZTy8rQvhmOJs=;
        b=sw2wh2AFiUryqv523VwufWAgQI2Sfi79VjrDGpKv56foq48v6SSBf9VgUoSFHjGunD
         810R+JRefM5ArKxavBPTM3U7awSAfwYYPxPGSkFpkvfSpcGPQh4ZRG6bN+3kZF50oqH0
         GgEyME9/5Xsywf9ILwWsn33J67QQ/IWHOPtFxGkyGcuMYgtl16/Jk2t1X+6bH/wtCjI9
         65eAfl+De1vRhpxoLEq9SW2fQFH3GQqW03XWynxpZqKrnXAsAugzTCHlb6vTtA2CQbGL
         66NcRx32/AIHiFz5qTEHEt9cWZtugFuGOy/WKl1wr9X2MX24gJWMhDL9nPmDgKSbyFX6
         qUiA==
X-Gm-Message-State: AOAM530lR/N8r3foFCPABhn4xTqDcZvJJEfHk52Ka4HS4IR+aeSNCOfo
        sH/5lri3DT57AC5i1kzNaMObNFudO20=
X-Google-Smtp-Source: ABdhPJyPy2ugPjpRbfm0U1WHWPiE5cgPEbgDUjQIDOBkCtUfbHf1TCqnIhuAPlFWFGWM1nswc/dDfVwP16k=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:de69:b19a:1af5:866d])
 (user=seanjc job=sendgmr) by 2002:a25:db0c:: with SMTP id g12mr37051943ybf.6.1628616004152;
 Tue, 10 Aug 2021 10:20:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 10 Aug 2021 10:19:49 -0700
In-Reply-To: <20210810171952.2758100-1-seanjc@google.com>
Message-Id: <20210810171952.2758100-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210810171952.2758100-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 1/4] KVM: VMX: Use current VMCS to query WAITPKG support for
 MSR emulation
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the secondary_exec_controls_get() accessor in vmx_has_waitpkg() to
effectively get the controls for the current VMCS, as opposed to using
vmx->secondary_exec_controls, which is the cached value of KVM's desired
controls for vmcs01 and truly not reflective of any particular VMCS.

While the waitpkg control is not dynamic, i.e. vmcs01 will always hold
the same waitpkg configuration as vmx->secondary_exec_controls, the same
does not hold true for vmcs02 if the L1 VMM hides the feature from L2.
If L1 hides the feature _and_ does not intercept MSR_IA32_UMWAIT_CONTROL,
L2 could incorrectly read/write L1's virtual MSR instead of taking a #GP.

Fixes: 6e3ba4abcea5 ("KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 0ecc41189292..4f151175d45a 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -521,7 +521,7 @@ static inline struct vmcs *alloc_vmcs(bool shadow)
 
 static inline bool vmx_has_waitpkg(struct vcpu_vmx *vmx)
 {
-	return vmx->secondary_exec_control &
+	return secondary_exec_controls_get(vmx) &
 		SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE;
 }
 
-- 
2.32.0.605.g8dce9f2422-goog


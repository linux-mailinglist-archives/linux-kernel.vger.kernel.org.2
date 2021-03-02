Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6C32ADC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360009AbhCBWGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1835987AbhCBTfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614713633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/JK2s2xEZw2nmKFZ13Xg5oUW1gG+YkwapoDCumdhRA=;
        b=XcxLJPzj4MntpemjkDDiLphzzWSvoeucQ5R2eVPxzOkFJ164JZ1N410ERjMpib3Xyow0Qw
        +SrFZBidGCLftTP7rivvzURDcvqavl8Oxl5G6pM5TsQgg29VwYQmsbrTYSs4oJxwZLUFvM
        TpXWtyz3oFwJ4tHzoZiy/Ul03fjxWuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-LSnU2yvNN8axFpr0Z1Z4eA-1; Tue, 02 Mar 2021 14:33:51 -0500
X-MC-Unique: LSnU2yvNN8axFpr0Z1Z4eA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AAA91005501;
        Tue,  2 Mar 2021 19:33:50 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3454E60CC5;
        Tue,  2 Mar 2021 19:33:50 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com
Subject: [PATCH 10/23] KVM: x86: Move nVMX's consistency check macro to common code
Date:   Tue,  2 Mar 2021 14:33:30 -0500
Message-Id: <20210302193343.313318-11-pbonzini@redhat.com>
In-Reply-To: <20210302193343.313318-1-pbonzini@redhat.com>
References: <20210302193343.313318-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

Move KVM's CC() macro to x86.h so that it can be reused by nSVM.
Debugging VM-Enter is as painful on SVM as it is on VMX.

Rename the more visible macro to KVM_NESTED_VMENTER_CONSISTENCY_CHECK
to avoid any collisions with the uber-concise "CC".

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210204000117.3303214-12-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 8 +-------
 arch/x86/kvm/x86.h        | 8 ++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bcca0b80e0d0..fdd80dd8e781 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -21,13 +21,7 @@ module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
 static bool __read_mostly nested_early_check = 0;
 module_param(nested_early_check, bool, S_IRUGO);
 
-#define CC(consistency_check)						\
-({									\
-	bool failed = (consistency_check);				\
-	if (failed)							\
-		trace_kvm_nested_vmenter_failed(#consistency_check, 0);	\
-	failed;								\
-})
+#define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
 /*
  * Hyper-V requires all of these, so mark them as supported even though
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 39eb04887141..ee6e01067884 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -8,6 +8,14 @@
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
 
+#define KVM_NESTED_VMENTER_CONSISTENCY_CHECK(consistency_check)		\
+({									\
+	bool failed = (consistency_check);				\
+	if (failed)							\
+		trace_kvm_nested_vmenter_failed(#consistency_check, 0);	\
+	failed;								\
+})
+
 #define KVM_DEFAULT_PLE_GAP		128
 #define KVM_VMX_DEFAULT_PLE_WINDOW	4096
 #define KVM_DEFAULT_PLE_WINDOW_GROW	2
-- 
2.26.2



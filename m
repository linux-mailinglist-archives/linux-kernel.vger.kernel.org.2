Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA97C3A326B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFJRsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:48:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3944DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 10:46:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z3-20020a17090a4683b029015f6c19f126so4254784pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=npvYPdo+ovjaaLetvI24CjlELW8jh9ZY/+gEZUAZto4=;
        b=b2CfgZT+sCaVhK01cDEyze2k672fRxI2/nC9KJD6mjgmZDx0wXgC7w8wkpXRFj3sw8
         tp8f9VmYBbwvmop4BKquwVQrrGQXaL2MfJ7MwrD2/aw6jeTGfHIiJN1v7IS+GoVhfMtf
         7Fhj2u9tjuzA+AJCbZNZ1ds4TheXpiGD7c9V1A/+YP+aPre7ypaO8A+D2Srw79I4jtGf
         rP/2YO1Pt4ho2YytPPzhF07V2OW2MlQdlWibTz5fGSkLjHducQp5UM0VuF1s66ZZHlX7
         Lc7BtlxuPUof5A/OrZy5VQzogyuGSbZZEfmtJte1uRgtEDGLJpOzkJRpJk/9dmtWB6Nx
         cbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=npvYPdo+ovjaaLetvI24CjlELW8jh9ZY/+gEZUAZto4=;
        b=LSLRn8NaG7A/Mlq7uTXBPdVLEh257Mdysfb27XZdVM54Mdnl+RAywau/g9SDBaeBfb
         +ip+1OYcOM4ctZ7oZYAUNGnTE0jcntOzeC14acfnuHt+eRsyDQVEpvlIBgfRK4RL3+6J
         ZeF99EJHfisYVSMm9wl+/QmVtBe3pUDhIOigXFd9Knwb11wCL44eVYwapap/BM3OJg1Q
         dxw8nJMoJITepV9q5sZqKst/V1ZtJt14k0/1qrpvQPCHr5cruDC3WZfVbrkwMtcrbZI/
         TXwcsk5unSnuOuZkDDwTwp+cgjZfo6Rwx3lz691vT7W75a5ZGX1mPVJ9sykk+BMlHSZI
         uwVA==
X-Gm-Message-State: AOAM532/umCltmFfGLMC4T6aoxAwuOijwQ7FXqgyTgaBLr71iwN8JCu5
        FImAMgCnUBH2CAcOXnFLr29dmxAs9DgUiw==
X-Google-Smtp-Source: ABdhPJxArp6iWEZuuwuFJCVgzw61I/tPIpsRjxBCSOpislYR1Exj211/ys9XjlGPl+3Pu0TqkUAQwg8r+L9UVg==
X-Received: from alperct.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:466b])
 (user=alpergun job=sendgmr) by 2002:a17:90a:2a08:: with SMTP id
 i8mr4659321pjd.122.1623347182655; Thu, 10 Jun 2021 10:46:22 -0700 (PDT)
Date:   Thu, 10 Jun 2021 17:46:04 +0000
Message-Id: <20210610174604.2554090-1-alpergun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] KVM: SVM: Call SEV Guest Decommission if ASID binding fails
From:   Alper Gun <alpergun@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alper Gun <alpergun@google.com>,
        stable@vger.kernel.org, Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send SEV_CMD_DECOMMISSION command to PSP firmware if ASID binding
fails. If a failure happens after  a successful LAUNCH_START command,
a decommission command should be executed. Otherwise, guest context
will be unfreed inside the AMD SP. After the firmware will not have
memory to allocate more SEV guest context, LAUNCH_START command will
begin to fail with SEV_RET_RESOURCE_LIMIT error.

The existing code calls decommission inside sev_unbind_asid, but it is
not called if a failure happens before guest activation succeeds. If
sev_bind_asid fails, decommission is never called. PSP firmware has a
limit for the number of guests. If sev_asid_binding fails many times,
PSP firmware will not have resources to create another guest context.

Cc: stable@vger.kernel.org
Fixes: 59414c989220 ("KVM: SVM: Add support for KVM_SEV_LAUNCH_START command")
Reported-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Alper Gun <alpergun@google.com>
---
 arch/x86/kvm/svm/sev.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e0ce5da97fc2..8d36f0c73071 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -199,9 +199,19 @@ static void sev_asid_free(struct kvm_sev_info *sev)
 	sev->misc_cg = NULL;
 }
 
-static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
+static void sev_decommission(unsigned int handle)
 {
 	struct sev_data_decommission decommission;
+
+	if (!handle)
+		return;
+
+	decommission.handle = handle;
+	sev_guest_decommission(&decommission, NULL);
+}
+
+static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
+{
 	struct sev_data_deactivate deactivate;
 
 	if (!handle)
@@ -214,9 +224,7 @@ static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
 	sev_guest_deactivate(&deactivate, NULL);
 	up_read(&sev_deactivate_lock);
 
-	/* decommission handle */
-	decommission.handle = handle;
-	sev_guest_decommission(&decommission, NULL);
+	sev_decommission(handle);
 }
 
 static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
@@ -341,8 +349,10 @@ static int sev_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	/* Bind ASID to this guest */
 	ret = sev_bind_asid(kvm, start.handle, error);
-	if (ret)
+	if (ret) {
+		sev_decommission(start.handle);
 		goto e_free_session;
+	}
 
 	/* return handle to userspace */
 	params.handle = start.handle;
-- 
2.32.0.272.g935e593368-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796A440B8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhINUIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhINUIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:08:02 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D6C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:06:45 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 1-20020a630e41000000b002528846c9f2so145708pgo.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ON+OppL5/OgNlba0Dbq0Mz8w7RQ1qvQulVb/hw2bToI=;
        b=qPH9a0sWvm3uX1rkmTHgMFMLKFhqXFMqpNyQPlUxRqwX2MMEkhCDSn8q+ViSmHeJ6h
         dnu6Nb5jtjwf9+YjXGyhFy8qwZzOucEQhsS51Q8SGKZADKcdrVtJhjt5N5Y3XUwjJhud
         neuD+tcxsZUOW4YxIgGOfnMRL4BJb/dpjxAExbVJEamqf7pG2em1iHFL7qvD4jp+o/pq
         laWrp/xyYRa3RSh/NHHJcI+BuEIGBM7YHF7CX1rOhG8kM9u0hRjV5FiVUiuaQskWY0pt
         miW0zjtHEVRg3+cxjG9Hr3y6uQfG6kNVFlyUBpEffbZxSTM0UkVJba1u3wRVSuvWjeo3
         pBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ON+OppL5/OgNlba0Dbq0Mz8w7RQ1qvQulVb/hw2bToI=;
        b=PI2LF5pBEbvaQ/VrAC5S9gD7T07r3yg9Q46LG9gjB6PyXtgQfw1MIqo7rX5DxqslE7
         WlqsrimSeBgMauBz5PMu23Xs3XpvC/T2CrqH+0qCltg46iQDkcAmuzRj0KH9vLzFyD1v
         XHdef0V8QUs3nrFvSFyKu2hbYLLHkAUHqncFKqz1jllmwHYX2Ps/yzvN2tklKlixGbwQ
         pcffKR5pzIXsqSdPDe2A3JGFUUN5SmDG82PAcaX+esNny+/1O48U90rKUMzcvrNuewwI
         Mb/k7vGlfpyTBJrwdLBkgwjPWgEPJkydAO+U0RACAUENU0NX/hLYliWbtuObp2u9YgMn
         ojKw==
X-Gm-Message-State: AOAM530+kcFgh1eScNsYXJwSOZ4dU0BCtSK/plx/1ZJrV8XQjVRZjc43
        BU874mHxRmHo2Ra2f7RQLN31QtRI0A0=
X-Google-Smtp-Source: ABdhPJz0gOgLHGvJtjv+by2R9hTkmBQUYbxEW1DGzC7AiHk+sIANx3xv/0zO30MRaCYTWMChaSogixwQ6g0=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:b358:1f40:79d5:ab23])
 (user=pgonda job=sendgmr) by 2002:a17:90b:3909:: with SMTP id
 ob9mr4023845pjb.75.1631650004482; Tue, 14 Sep 2021 13:06:44 -0700 (PDT)
Date:   Tue, 14 Sep 2021 13:06:39 -0700
Message-Id: <20210914200639.3305617-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH] KVM: SEV: Acquire vcpu mutex when updating VMSA
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds mutex guard to the VMSA updating code. Also adds a check to skip a
vCPU if it has already been LAUNCH_UPDATE_VMSA'd which should allow
userspace to retry this ioctl until all the vCPUs can be successfully
LAUNCH_UPDATE_VMSA'd. Because this operation cannot be undone we cannot
unwind if one vCPU fails.

Fixes: ad73109ae7ec ("KVM: SVM: Provide support to launch and run an SEV-ES guest")

Signed-off-by: Peter Gonda <pgonda@google.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/svm/sev.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 75e0b21ad07c..9a2ebd0328ca 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -598,22 +598,29 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
-	struct sev_data_launch_update_vmsa vmsa;
+	struct sev_data_launch_update_vmsa vmsa = {0};
 	struct kvm_vcpu *vcpu;
 	int i, ret;
 
 	if (!sev_es_guest(kvm))
 		return -ENOTTY;
 
-	vmsa.reserved = 0;
-
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		struct vcpu_svm *svm = to_svm(vcpu);
 
+		ret = mutex_lock_killable(&vcpu->mutex);
+		if (ret)
+			goto out_unlock;
+
+		/* Skip to the next vCPU if this one has already be updated. */
+		ret = sev_es_sync_vmsa(svm);
+		if (svm->vcpu.arch.guest_state_protected)
+			goto unlock;
+
 		/* Perform some pre-encryption checks against the VMSA */
 		ret = sev_es_sync_vmsa(svm);
 		if (ret)
-			return ret;
+			goto out_unlock;
 
 		/*
 		 * The LAUNCH_UPDATE_VMSA command will perform in-place
@@ -629,12 +636,19 @@ static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		ret = sev_issue_cmd(kvm, SEV_CMD_LAUNCH_UPDATE_VMSA, &vmsa,
 				    &argp->error);
 		if (ret)
-			return ret;
+			goto out_unlock;
 
 		svm->vcpu.arch.guest_state_protected = true;
+
+unlock:
+		mutex_unlock(&vcpu->mutex);
 	}
 
 	return 0;
+
+out_unlock:
+	mutex_unlock(&vcpu->mutex);
+	return ret;
 }
 
 static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
-- 
2.33.0.464.g1972c5931b-goog


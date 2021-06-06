Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFB939CC31
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 04:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhFFCM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 22:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhFFCM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 22:12:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30707C061767
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 19:10:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u7so6711800plq.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 19:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dEHi0nLGv5PfBaxyr6DdBRy0QUGk/obWt0c36R9kJV8=;
        b=EJy8zAGmJkYV43CiZRUYsGQFoP605zrn/Ann+QB5tZGDLciBJIhh7RLqXjXilWC5o1
         54HFislHjIwa2sLCN69oTR9sOKZXYxJiWh3Vx7kbP/gtfiGh26MHEPBhsuvMJiNfh7s6
         gXbGyZ6gcCB/B4UKfY5JQuCb1aOhv70MZn6yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dEHi0nLGv5PfBaxyr6DdBRy0QUGk/obWt0c36R9kJV8=;
        b=BLcLlnIiMlR923cTxDHY9Wv95iUk2hVbgXw0qcgY40yjyaQ6FmIO/oFARFMPEXNZqM
         5JvRdlHnfeDYCpqhfd+L8ZqBpxyUU9li9QZDN1csa01AJXZtQOzvsMq7Ah00174JC0d+
         ESSI72G4vK7CMXNW8kdaPkGAMBJnE2bnIlMRfGkHTlMDc4Boqlj29Ml4C/NivDz/Nfub
         Az5xID6uBKDbo1id/2zMCn5z7Mxugokn/DZNnOSpZG7hpqNA5r+3B7UQskuOFbqA7lKS
         r4zMn/iTNL2MHEm3SLLO6Dz+ZHiKQkTr0N9hGnhukvbwDbKebgk42CGzVmik9gi1d9DO
         yv+A==
X-Gm-Message-State: AOAM532G6my/9nQzCic+DHhuWYDF2rPRM/XFoUorTGL4153mMJy78kaY
        jhYmLW+G67izNqsnV4Xkp4sypA==
X-Google-Smtp-Source: ABdhPJzRznPqp1FH5GFT4MorUkuBHJ6PF3pdo16Sw5uSMHWrRpmmlQmpTJXS2XKoUpDhLfMQzXyfEw==
X-Received: by 2002:a17:902:548:b029:10f:30af:7d5f with SMTP id 66-20020a1709020548b029010f30af7d5fmr10598403plf.22.1622945454788;
        Sat, 05 Jun 2021 19:10:54 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:c87a:995:bf9d:93bb])
        by smtp.gmail.com with ESMTPSA id v15sm5586327pgf.26.2021.06.05.19.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 19:10:54 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 2/2] kvm: x86: implement KVM PM-notifier
Date:   Sun,  6 Jun 2021 11:10:45 +0900
Message-Id: <20210606021045.14159-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
In-Reply-To: <20210606021045.14159-1-senozhatsky@chromium.org>
References: <20210606021045.14159-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement PM hibernation/suspend prepare notifiers so that KVM
can reliably set PVCLOCK_GUEST_STOPPED on VCPUs and properly
suspend VMs.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 arch/x86/kvm/Kconfig |  1 +
 arch/x86/kvm/x86.c   | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index fb8efb387aff..ac69894eab88 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -43,6 +43,7 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_VFIO
 	select SRCU
+	select HAVE_KVM_PM_NOTIFIER if PM
 	help
 	  Support hosting fully virtualized guest machines using hardware
 	  virtualization extensions.  You will need a fairly recent
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b594275d49b5..af1ab527a0cb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -58,6 +58,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/mem_encrypt.h>
 #include <linux/entry-kvm.h>
+#include <linux/suspend.h>
 
 #include <trace/events/kvm.h>
 
@@ -5615,6 +5616,41 @@ static int kvm_vm_ioctl_set_msr_filter(struct kvm *kvm, void __user *argp)
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
+static int kvm_arch_suspend_notifier(struct kvm *kvm)
+{
+	struct kvm_vcpu *vcpu;
+	int i, ret = 0;
+
+	mutex_lock(&kvm->lock);
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!vcpu->arch.pv_time_enabled)
+			continue;
+
+		ret = kvm_set_guest_paused(vcpu);
+		if (ret) {
+			kvm_err("Failed to pause guest VCPU%d: %d\n",
+				vcpu->vcpu_id, ret);
+			break;
+		}
+	}
+	mutex_unlock(&kvm->lock);
+
+	return ret ? NOTIFY_BAD : NOTIFY_DONE;
+}
+
+int kvm_arch_pm_notifier(struct kvm *kvm, unsigned long state)
+{
+	switch (state) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+		return kvm_arch_suspend_notifier(kvm);
+	}
+
+	return NOTIFY_DONE;
+}
+#endif /* CONFIG_HAVE_KVM_PM_NOTIFIER */
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
-- 
2.32.0.rc1.229.g3e70b5a671-goog

